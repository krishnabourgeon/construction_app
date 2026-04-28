import 'package:construction_app/provider/company_provider.dart';
import 'package:construction_app/widgets/app_theme.dart';
import 'package:construction_app/widgets/common_widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class AddSiteScreen extends StatefulWidget {
  const AddSiteScreen({super.key});

  @override
  State<AddSiteScreen> createState() => _AddSiteScreenState();
}

class _AddSiteScreenState extends State<AddSiteScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _contactController = TextEditingController();
  final _mobileController = TextEditingController();
  final _descController = TextEditingController();
  final _amountController = TextEditingController();
  final _startDateController = TextEditingController();
  final _endDateController = TextEditingController();
  bool _saving = false;

  DateTime? _selectedStartDate;
  DateTime? _selectedEndDate;

  Future<void> _pickDate(TextEditingController ctrl, bool isStartDate) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
      builder: (ctx, child) => Theme(
        data: Theme.of(ctx).copyWith(
          colorScheme: const ColorScheme.light(primary: AppColors.amber),
        ),
        child: child!,
      ),
    );
    if (picked != null) {
      setState(() {
        if (isStartDate) {
          _selectedStartDate = picked;
        } else {
          _selectedEndDate = picked;
        }
        ctrl.text =
            '${picked.day.toString().padLeft(2, '0')} ${['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'][picked.month - 1]} ${picked.year}';
      });
    }
  }

  void _save() async {
    if (!_formKey.currentState!.validate()) return;

    final provider = context.read<CompanyProvider>();

    if (provider.selectedSupervisorId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a supervisor')),
      );
      return;
    }

    if (_selectedStartDate == null || _selectedEndDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select both Start and Target dates')),
      );
      return;
    }

    setState(() => _saving = true);

    await provider.addSites(
      sitename: _nameController.text,
      contactperson: _contactController.text,
      mobile: _mobileController.text,
      supervisorId: provider.selectedSupervisorId!,
      startDate: _selectedStartDate!,
      tentativeCompletionDate: _selectedEndDate!,
      estimateAmount: int.tryParse(_amountController.text) ?? 0,
      description: _descController.text,
      onFailure: (errorMessage) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(errorMessage, style: GoogleFonts.poppins(fontSize: 13)),
            backgroundColor: Colors.red,
            behavior: SnackBarBehavior.floating,
          ),
        );
      },
    );

    setState(() => _saving = false);

    if (!mounted) return;

    // Check if the operation was successful (provider didn't set errorToast)
    if (provider.errorToast == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Site saved successfully!',
              style: GoogleFonts.poppins(fontSize: 13)),
          backgroundColor: AppColors.green,
          behavior: SnackBarBehavior.floating,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
      );
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<CompanyProvider>();

    return Scaffold(
      backgroundColor: AppColors.greyBg,
      body: Column(
        children: [
          Container(
            color: AppColors.navy,
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top + 8,
              bottom: 16,
              left: 8,
              right: 16,
            ),
            child: Row(
              children: [
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.arrow_back_ios_new_rounded,
                      color: AppColors.white, size: 18),
                ),
                Text('Add New Site',
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: AppColors.white,
                    )),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: _formKey,
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: AppColors.border),
                  ),
                  child: Column(
                    children: [
                      AppTextField(
                        label: 'Site Name *',
                        hint: 'e.g. Sunrise Residency Block B',
                        controller: _nameController,
                        validator: (v) =>
                            v!.isEmpty ? 'Site name is required' : null,
                      ),
                      AppTextField(
                        label: 'Contact Person *',
                        hint: 'Full name',
                        controller: _contactController,
                        validator: (v) => v!.isEmpty ? 'Required' : null,
                      ),
                      AppTextField(
                        label: 'Mobile Number *',
                        hint: '+91 00000 00000',
                        controller: _mobileController,
                        keyboardType: TextInputType.phone,
                        validator: (v) {
                          if (v!.isEmpty) return 'Mobile number is required';
                          if (v.replaceAll(RegExp(r'\D'), '').length < 10) {
                            return 'Enter a valid mobile number';
                          }
                          return null;
                        },
                      ),
                      // AppDropdown(
                      //   label: 'Supervisor *',
                      //   value: _selectedSupervisor,
                      //   items: getSupervisorList.map((e) => e.name).toList(),
                      //   onChanged: (v) =>
                      //       setState(() => _selectedSupervisor = v),
                      // ),
                      AppDropdown(
                        label: 'Supervisor *',
                        value: provider.selectedSupervisorId == null
                        ? null
                        : provider.supervisorsList
                            .firstWhere(
                              (e) => e.id == provider.selectedSupervisorId,
                            )
                            .name,
                        items: provider.supervisorsList
                        .map((e) => e.name)
                        .toList(),
                         onChanged: (v) {
                          final selected = provider.supervisorsList
                              .firstWhere((e) => e.name == v);

                          provider.selectedSupervisorId = selected.id;
                          provider.notifyListeners();
                          print("Selected ID: ${selected.id}");
                        },
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: AppTextField(
                              label: 'Start Date *',
                              hint: 'DD Mon YYYY',
                              controller: _startDateController,
                              readOnly: true,
                              onTap: () => _pickDate(_startDateController, true),
                              suffixIcon: const Icon(
                                  Icons.calendar_today_outlined,
                                  size: 18,
                                  color: AppColors.grey),
                              validator: (v) =>
                                  v!.isEmpty ? 'Required' : null,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: AppTextField(
                              label: 'Target Date *',
                              hint: 'DD Mon YYYY',
                              controller: _endDateController,
                              readOnly: true,
                              onTap: () => _pickDate(_endDateController, false),
                              suffixIcon: const Icon(
                                  Icons.calendar_today_outlined,
                                  size: 18,
                                  color: AppColors.grey),
                              validator: (v) =>
                                  v!.isEmpty ? 'Required' : null,
                            ),
                          ),
                        ],
                      ),
                      AppTextField(
                        label: 'Estimated Amount (₹) *',
                        hint: '0.00',
                        controller: _amountController,
                        keyboardType: const TextInputType.numberWithOptions(
                            decimal: true),
                        validator: (v) =>
                            v!.isEmpty ? 'Amount is required' : null,
                      ),
                      AppTextField(
                        label: 'Description',
                        hint: 'Describe the site, scope of work...',
                        controller: _descController,
                        maxLines: 3,
                      ),
                      AppButton(
                          label: 'Save Site',
                          onPressed: _save,
                          isLoading: _saving),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
