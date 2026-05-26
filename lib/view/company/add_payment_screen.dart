import 'package:construction_app/models/get_ledger_model.dart';
import 'package:construction_app/models/get_stages_model.dart';
import 'package:construction_app/models/payment_modes_model.dart';
import 'package:construction_app/models/sitesbycompanies.dart';
import 'package:construction_app/provider/company_provider.dart';
import 'package:construction_app/services/provider_helper_class.dart';
import 'package:construction_app/services/shared_preference_helper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddPaymentScreen extends StatefulWidget {
  final int paymentType; // 1 = payment, 2 = receipt

  const AddPaymentScreen({super.key, required this.paymentType});

  @override
  State<AddPaymentScreen> createState() => _AddPaymentScreenState();
}

class _AddPaymentScreenState extends State<AddPaymentScreen> {
  final TextEditingController amountController = TextEditingController();
  final TextEditingController remarksController = TextEditingController();

  DateTime selectedDate = DateTime.now();

  PaymentModes? selectedPaymentMode;
  SitesbyCompany? selectedSite;
  GetStages? selectedStage;
  Ledger? selectedLedger;

  @override
  void initState() {
    super.initState();

    Future.microtask(() async {
      context.read<CompanyProvider>().getPaymentModes(null);
      final companyId = await SharedPreferenceHelper.getCompanyId();
      if (mounted) {
        context.read<CompanyProvider>().sitesbycompanies(companyId: companyId);
        context.read<CompanyProvider>().getLedger(null);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<CompanyProvider>();
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(widget.paymentType == 1
            ? "Add Payment"
            : "Add Receipt"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(width * 0.04),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _label("Select Site"),
            provider.sitesList.isEmpty
                ? const Center(child: CircularProgressIndicator())
                : DropdownButtonFormField<SitesbyCompany>(
                    value: selectedSite,
                    hint: const Text("Select Site"),
                    items: provider.sitesList.map((site) {
                      return DropdownMenuItem(
                        value: site,
                        child: Text(site.sitename),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedSite = value;
                        selectedStage = null;
                      });
                      if (value != null) {
                        provider.getStages(siteId: value.id);
                      }
                    },
                    decoration: _inputDecoration(),
                  ),
                  const SizedBox(height: 12),
                  _label("Select Stage"),
            provider.loaderState == LoaderState.loading && selectedSite != null
                ? const Center(child: CircularProgressIndicator())
                : provider.stagesList.isEmpty && selectedSite != null
                    ? const Padding(
                        padding: EdgeInsets.symmetric(vertical: 8.0),
                        child: Text("No stage found for this site",
                            style: TextStyle(color: Colors.red)),
                      )
                    : DropdownButtonFormField<GetStages>(
                        isExpanded: true,
                        value: selectedStage,
                        hint: const Text("Select Stage"),
                        items: provider.stagesList.map((stage) {
                          return DropdownMenuItem(
                            value: stage,
                            child: Text(
                              stage.stage,
                              overflow: TextOverflow.ellipsis,
                            ),
                          );
                        }).toList(),
                        onChanged: (value) {
                      setState(() {
                        selectedStage = value;
                      });
                    },
                    decoration: _inputDecoration(),
                  ),
            const SizedBox(height: 12),
            const SizedBox(height: 12),
_label("Select Ledger"),

 provider.ledger.isEmpty
        ? const Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            child: Text(
              "No ledger found",
              style: TextStyle(color: Colors.red),
            ),
          )
        : DropdownButtonFormField<Ledger>(
            isExpanded: true,
            value: selectedLedger,
            hint: const Text("Select Ledger"),
            items: provider.ledger.map((ledger) {
              return DropdownMenuItem<Ledger>(
                value: ledger,
                child: Text(
                  ledger.name,
                  overflow: TextOverflow.ellipsis,
                ),
              );
            }).toList(),
            onChanged: (Ledger? value) {
              setState(() {
                selectedLedger = value;
              });
            },
            decoration: _inputDecoration(),
          ),

            /// AMOUNT
            _label("Amount"),
            TextField(
              controller: amountController,
              keyboardType: TextInputType.number,
              decoration: _inputDecoration(),
            ),

            const SizedBox(height: 12),

            /// PAYMENT MODE DROPDOWN (API)
            _label("Payment Mode"),
            provider.paymentModesList.isEmpty
                ? const Center(child: CircularProgressIndicator())
                : DropdownButtonFormField<PaymentModes>(
                    value: selectedPaymentMode,
                    hint: const Text("Select Payment Mode"),
                    items: provider.paymentModesList.map((mode) {
                      return DropdownMenuItem(
                        value: mode,
                        child: Text(mode.name),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedPaymentMode = value;
                      });
                    },
                    decoration: _inputDecoration(),
                  ),

            const SizedBox(height: 12),

            /// DATE
            _label("Date"),
            InkWell(
              onTap: _pickDate,
              child: Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  "${selectedDate.toLocal()}".split(" ")[0],
                ),
              ),
            ),

            const SizedBox(height: 12),

            /// REMARKS
            _label("Remarks"),
            TextField(
              controller: remarksController,
              maxLines: 3,
              decoration: _inputDecoration(),
            ),

            const SizedBox(height: 20),

            /// SAVE BUTTON
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: const EdgeInsets.all(14),
                ),
                onPressed: () {
                  _submit(provider);
                },
                child:  Consumer<CompanyProvider>(
                  builder: (context,provider,child) {
                    if(provider.loaderState == LoaderState.loading){
                      return const Center(child: CircularProgressIndicator());
                    }
                    return Text("Save");
                  }
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// ============================
  /// SUBMIT FUNCTION
  /// ============================
  void _submit(CompanyProvider provider) async {
    if (selectedSite == null) {
      _showError("Select site");
      return;
    }
    if (selectedStage == null) {
      _showError("Select stage");
      return;
    }

     if (selectedLedger == null) {
      _showError("Select ledger");
      return;
    }
    if (amountController.text.isEmpty) {
      _showError("Enter amount");
      return;
    }
    if (selectedPaymentMode == null) {
      _showError("Select payment mode");
      return;
    }

    await provider.addPayment(
      (error) {
        _showError(error);
      },
      selectedSite!.id,
      selectedStage!.id,
      selectedLedger!.id,
      selectedDate,
      int.parse(amountController.text),
      selectedPaymentMode!.id,
      remarksController.text,
      widget.paymentType,
    );

    if (mounted) {
      Navigator.pop(context, true);
    }
  }

  /// ============================
  /// DATE PICKER
  /// ============================
  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      setState(() => selectedDate = picked);
    }
  }

  /// ============================
  /// UI HELPERS
  /// ============================
  Widget _label(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Text(
        text,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }

  InputDecoration _inputDecoration() {
    return InputDecoration(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }

  void _showError(String msg) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(msg)));
  }
}