import 'package:construction_app/models/get_payment_model.dart';
import 'package:construction_app/models/sitesbycompanies.dart';
import 'package:construction_app/provider/company_provider.dart';
import 'package:construction_app/services/provider_helper_class.dart';
import 'package:construction_app/services/shared_preference_helper.dart';
import 'package:construction_app/view/company/add_payment_screen.dart';
import 'package:construction_app/widgets/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class PaymentListScreen extends StatefulWidget {
  final int paymentType;

  const PaymentListScreen({super.key, required this.paymentType});

  @override
  State<PaymentListScreen> createState() => _PaymentListScreenState();
}

class _PaymentListScreenState extends State<PaymentListScreen> {
  SitesbyCompany? selectedSite;

  DateTime? fromDate;
  DateTime? toDate;

  @override
  void initState() {
    super.initState();

    Future.microtask(() async {
      final provider = context.read<CompanyProvider>();
      final companyId = await SharedPreferenceHelper.getCompanyId();

      /// Load Sites
      await provider.sitesbycompanies(companyId: companyId);

      /// Load Payments for the first site by default
      if (provider.sitesList.isNotEmpty) {
        setState(() {
          selectedSite = provider.sitesList.first;
        });
        provider.getPayments(
          siteId: selectedSite!.id,
          paymentType: widget.paymentType,
          fromDate: fromDate?.toString() ?? "",
          toDate: toDate?.toString() ?? "",
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<CompanyProvider>();
    final payments = _applyFilter(provider.paymentsList);

    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Colors.black,
      //   title: Text(widget.paymentType == 1 ? "Payments" : "Receipts"),
      // ),
      body: Column(
        children: [
          Container(
            color: AppColors.navy,
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top + 16,
              bottom: 20,
              left: 20,
              right: 20,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                onPressed: () {
                  Navigator.pop(context);

                  // OR navigate directly
                  // Navigator.pushReplacement(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (_) => const DashboardScreen(),
                  //   ),
                  // );
                },
                  icon: const Icon(
                    Icons.arrow_back_ios_new_rounded,
                    color: AppColors.white,
                    size: 20,
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Manage',
                        style: GoogleFonts.poppins(
                          fontSize: 15,
                          color: AppColors.greyLight,
                        ),
                      ),
                      Text(
                        widget.paymentType == 1 ? "Payments" : "Receipts",
                        style: GoogleFonts.poppins(
                          fontSize: 22,
                          fontWeight: FontWeight.w600,
                          color: AppColors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () async {
                    final result = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            AddPaymentScreen(paymentType: widget.paymentType),
                      ),
                    );
                    if (result == true && selectedSite != null) {
                      context.read<CompanyProvider>().getPayments(
                        siteId: selectedSite!.id,
                        paymentType: widget.paymentType,
                        fromDate: fromDate?.toString() ?? "",
                        toDate: toDate?.toString() ?? "",
                      );
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.amber,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.add, size: 18, color: AppColors.dark),
                        const SizedBox(width: 4),
                        Text(
                          widget.paymentType == 1
                              ? "Add Payment"
                              : "Add Receipt",
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: AppColors.dark,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          /// =========================
          /// FILTER SECTION
          /// =========================
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                /// SITE DROPDOWN
                DropdownButtonFormField<SitesbyCompany>(
                  value: selectedSite,
                  hint: const Text("Select Site"),
                  items: provider.sitesList.map((site) {
                    return DropdownMenuItem(
                      value: site,
                      child: Text(site.sitename),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() => selectedSite = value);

                    if (value != null) {
                      provider.getPayments(
                        siteId: value.id,
                        paymentType: widget.paymentType,
                        fromDate: fromDate?.toString() ?? "",
                        toDate: toDate?.toString() ?? "",
                      );
                    }
                  },
                  decoration: _inputDecoration(),
                ),

                const SizedBox(height: 10),

                /// DATE FILTER
                Row(
                  children: [
                    Expanded(child: _dateBtn("From Date", true)),
                    const SizedBox(width: 10),
                    Expanded(child: _dateBtn("To Date", false)),
                  ],
                ),
              ],
            ),
          ),

          /// =========================
          /// LIST
          /// =========================
          Expanded(
            child: provider.loaderState == LoaderState.loading
                ? const Center(child: CircularProgressIndicator())
                : payments.isEmpty
                ? const Center(child: Text("No data found"))
                : ListView.builder(
                    padding: const EdgeInsets.all(12),
                    itemCount: payments.length,
                    itemBuilder: (_, i) {
                      return _paymentCard(payments[i]);
                    },
                  ),
          ),
        ],
      ),
    );
  }

  /// =========================
  /// DATE BUTTON
  /// =========================
  Widget _dateBtn(String label, bool isFrom) {
    return InkWell(
      onTap: () async {
        final picked = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(2020),
          lastDate: DateTime.now(),
        );

        if (picked != null) {
          setState(() {
            if (isFrom) {
              fromDate = picked;
            } else {
              toDate = picked;
            }
          });
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          isFrom
              ? (fromDate == null
                    ? "From Date"
                    : fromDate.toString().split(" ")[0])
              : (toDate == null ? "To Date" : toDate.toString().split(" ")[0]),
        ),
      ),
    );
  }

  /// =========================
  /// FILTER LOGIC
  /// =========================
  List<GetPayment> _applyFilter(List<GetPayment> list) {
    return list.where((p) {
      final matchFrom = fromDate == null || !p.paymentDate.isBefore(fromDate!);

      final matchTo = toDate == null || !p.paymentDate.isAfter(toDate!);

      return matchFrom && matchTo;
    }).toList();
  }

  /// =========================
  /// CARD (KEEP YOUR DESIGN HERE)
  /// =========================
  // Widget _paymentCard(GetPayment p) {

  //   return Container(
  //     margin: const EdgeInsets.only(bottom: 10),
  //     padding: const EdgeInsets.all(12),
  //     decoration: BoxDecoration(
  //       color: Colors.white,
  //       borderRadius: BorderRadius.circular(8),
  //       border: Border.all(),
  //     ),
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         /// TOP ROW
  //         Row(
  //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //           children: [
  //             Text(
  //               "₹${p.amount}",
  //               style: const TextStyle(
  //                 fontWeight: FontWeight.bold,
  //                 fontSize: 16,
  //               ),
  //             ),
  //             Text(
  //               p.paymentTypeLabel,
  //               style: TextStyle(
  //                 color: widget.paymentType == 1 ? Colors.red : Colors.green,
  //                 fontWeight: FontWeight.bold,
  //               ),
  //             ),
  //           ],
  //         ),

  //         const SizedBox(height: 6),

  //         _row("Site", p.siteName),
  //         _row("Stage", p.stageName),
  //         _row("Mode", p.paymentMode ?? "N/A"),
  //         _row("Date", DateFormat('dd MMM yyyy').format(p.paymentDate)),
  //         const SizedBox(height: 6),

  //         Text(p.remarks ?? "", style: const TextStyle(color: Colors.grey)),
  //       ],
  //     ),
  //   );
  // }


  Widget _paymentCard(GetPayment p) {
  final isReceipt = widget.paymentType == 2;

  return Container(
    margin: const EdgeInsets.only(bottom: 10),
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: AppColors.border),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// TOP ROW
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "₹${p.amount}",
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w700,
                fontSize: 16,
                color: AppColors.dark,
              ),
            ),
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: (isReceipt ? AppColors.green : AppColors.red)
                        .withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    p.paymentTypeLabel,
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: isReceipt ? AppColors.green : AppColors.red,
                    ),
                  ),
                ),

                // ── Delete button (receipts only) ──────────────
                if (isReceipt) ...[
                  const SizedBox(width: 8),
                  GestureDetector(
                    onTap: () => _confirmDelete(p),
                    child: Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        color: AppColors.red.withOpacity(0.08),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(
                        Icons.delete_outline_rounded,
                        size: 18,
                        color: AppColors.red,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ],
        ),

        const SizedBox(height: 12),
        const Divider(height: 1),
        const SizedBox(height: 10),

        _row("Site",  p.siteName),
        _row("Stage", p.stageName),
        _row("Ledger", p.ledgername),
        _row("Mode",  p.paymentMode ?? "N/A"),
        _row("Date",  DateFormat('dd MMM yyyy').format(p.paymentDate)),

        if (p.remarks != null && p.remarks!.isNotEmpty) ...[
          const SizedBox(height: 8),
          Text(
            p.remarks!,
            style: GoogleFonts.poppins(
                fontSize: 12, color: AppColors.grey),
          ),
        ],
      ],
    ),
  );
}


void _confirmDelete(GetPayment p) {
  showDialog(
    context: context,
    builder: (_) => Dialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20)),
      backgroundColor: AppColors.white,
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Icon
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: AppColors.red.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.delete_outline_rounded,
                color: AppColors.red,
                size: 30,
              ),
            ),
            const SizedBox(height: 16),

            Text(
              'Delete Receipt?',
              style: GoogleFonts.poppins(
                fontSize: 17,
                fontWeight: FontWeight.w700,
                color: AppColors.dark,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Are you sure you want to delete the receipt of ₹${p.amount}? This action cannot be undone.',
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                  fontSize: 13, color: AppColors.grey),
            ),
            const SizedBox(height: 24),

            Row(
              children: [
                // Cancel
                Expanded(
                  child: GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      height: 46,
                      decoration: BoxDecoration(
                        color: AppColors.greyBg,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: AppColors.border),
                      ),
                      child: Center(
                        child: Text(
                          'Cancel',
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: AppColors.dark,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),

                // Delete
                Expanded(
                  child: GestureDetector(
                    onTap: () async {
                      Navigator.pop(context); // close dialog
                      final provider = context.read<CompanyProvider>();

                      await provider.deleteReceipt(
                        receiptId: p.id,
                        onSuccess: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Receipt deleted',
                                  style: GoogleFonts.poppins(fontSize: 13)),
                              backgroundColor: AppColors.green,
                              behavior: SnackBarBehavior.floating,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                          );
                          // Refresh list
                          if (selectedSite != null) {
                            provider.getPayments(
                              siteId: selectedSite!.id,
                              paymentType: widget.paymentType,
                              fromDate: fromDate?.toString() ?? "",
                              toDate: toDate?.toString() ?? "",
                            );
                          }
                        },
                        onFailure: (msg) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(msg,
                                  style: GoogleFonts.poppins(fontSize: 13)),
                              backgroundColor: AppColors.red,
                              behavior: SnackBarBehavior.floating,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                          );
                        },
                      );
                    },
                    child: Container(
                      height: 46,
                      decoration: BoxDecoration(
                        color: AppColors.red,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                        child: Text(
                          'Delete',
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: AppColors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}

  Widget _row(String k, String v) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(k, style: const TextStyle(color: Colors.grey)),
        Text(v),
      ],
    );
  }

  InputDecoration _inputDecoration() {
    return InputDecoration(
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
    );
  }
}
