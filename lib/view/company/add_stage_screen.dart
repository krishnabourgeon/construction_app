import 'package:construction_app/provider/company_provider.dart';
import 'package:construction_app/view/company/add_substages_screen.dart';
import 'package:construction_app/view/company/widgets/yes_no_button.dart';
import 'package:construction_app/widgets/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class AddStageScreen extends StatefulWidget {
  final String siteName;
  final int siteId;
  final int? stageId;
  final Function(String name, String desc, String status, bool hasSubStages)?
      onStageSaved;
 
  const AddStageScreen({
    super.key,
    required this.siteId,
    required this.siteName,
    this.stageId,
    this.onStageSaved,
  });
 
  @override
  State<AddStageScreen> createState() => _AddStageScreenState();
}
 
class _AddStageScreenState extends State<AddStageScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();
  final _descCtrl = TextEditingController();
  String _selectedStatus = 'Pending';
  bool _wantsSubStages = false;
 
  final _statusOptions = ['Pending', 'Progress', 'Completed'];

  int getStatusValue(String status) {
  switch (status) {
    case 'Pending':
      return 0;
    case 'Progress':
      return 1;
    case 'Completed':
      return 2;
    default:
      return 0;
  }
}

int getHasSubstage(bool value) => value ? 1 : 0;
 
  @override
  void dispose() {
    _nameCtrl.dispose();
    _descCtrl.dispose();
    super.dispose();
  }
 
  // void _save() {
  //   if (!_formKey.currentState!.validate()) return;
 
  //   final name = _nameCtrl.text.trim();
  //   final desc = _descCtrl.text.trim();
 
  //   if (_wantsSubStages) {
  //     // Navigate to sub-stage screen
  //     Navigator.push(
  //       context,
  //       MaterialPageRoute(
  //         builder: (_) => AddSubStageScreen(
  //           stageName: name,
  //           onSubStagesSaved: (subStages) {
  //             // Return to site detail with stage + substages
  //             Navigator.pop(context); // close substage screen
  //             Navigator.pop(context); // close add stage screen
  //             if (widget.onStageSaved != null) {
  //               widget.onStageSaved!(name, desc, _selectedStatus, true);
  //             }
  //             _showSnackbar('Stage "$name" created with ${subStages.length} sub-stages ✓');
  //           },
  //         ),
  //       ),
  //     );
  //   } else {
  //     // Save stage without sub-stages
  //     Navigator.pop(context);
  //     if (widget.onStageSaved != null) {
  //       widget.onStageSaved!(name, desc, _selectedStatus, false);
  //     }
  //     _showSnackbar('Stage "$name" created ✓');
  //   }
  // }


  void _save() async {
    if (!_formKey.currentState!.validate()) return;

    final name = _nameCtrl.text.trim();
    final desc = _descCtrl.text.trim();
    final provider = context.read<CompanyProvider>();

    int statusValue = getStatusValue(_selectedStatus);
    int hasSubstageValue = getHasSubstage(_wantsSubStages);

    // Save the stage first to get an ID from the backend
    final int? newStageId = await provider.addStages(
      siteid: widget.siteId,
      stage: name,
      description: desc,
      status: statusValue,
      hassubstage: hasSubstageValue,
    );

    if (newStageId == null) {
      // Error handling is managed by the provider/toasts
      return;
    }

    if (_wantsSubStages) {
      // Navigate to sub-stage screen with the dynamic ID
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => AddSubStageScreen(
            stageName: name,
            siteId: widget.siteId,
            stageId: newStageId,
            onSubStagesSaved: (subStages) {
              // Return to the previous screen (likely the detail screen)
              Navigator.pop(context); // close substage screen
              Navigator.pop(context); // close add stage screen
              _showSnackbar('Stage "$name" created with ${subStages.length} sub-stages ✓');
            },
          ),
        ),
      );
    } else {
      // Success - return to the list/detail screen
      Navigator.pop(context);
      _showSnackbar('Stage "$name" created ✓');
    }
  }
 
  void _showSnackbar(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg, style: GoogleFonts.poppins(fontSize: 13)),
        backgroundColor: AppColors.green,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        duration: const Duration(seconds: 2),
      ),
    );
  }
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.greyBg,
      body: Column(
        children: [
          // ── Header ──────────────────────────────────────────────────────
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFF1A1A2E), Color(0xFF16213E)],
              ),
            ),
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top + 12,
              bottom: 16,
              left: 16,
              right: 16,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Back button
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Row(
                    children: [
                      const Icon(Icons.arrow_back_ios_new,
                          size: 15, color: AppColors.greyLight),
                      const SizedBox(width: 5),
                      Text('Working Stages',
                          style: GoogleFonts.poppins(
                              fontSize: 11, color: AppColors.greyLight)),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                // Title
                Text('Add Working Stage',
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: AppColors.white,
                    )),
                const SizedBox(height: 4),
                Text('For: ${widget.siteName}',
                    style: GoogleFonts.poppins(
                        fontSize: 11, color: AppColors.grey)),
              ],
            ),
          ),
 
          // ── Form Body ───────────────────────────────────────────────────
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(12),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Main details card
                    Container(
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: AppColors.border, width: 1.5),
                      ),
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Stage Name
                          _buildLabel('Stage Name *'),
                          const SizedBox(height: 6),
                          TextFormField(
                            controller: _nameCtrl,
                            style: GoogleFonts.poppins(fontSize: 13),
                            decoration: _inputDecoration('e.g. Foundation Work'),
                            validator: (v) =>
                                v!.isEmpty ? 'Stage name is required' : null,
                          ),
                          const SizedBox(height: 14),
 
                          // Description
                          _buildLabel('Description'),
                          const SizedBox(height: 6),
                          TextFormField(
                            controller: _descCtrl,
                            style: GoogleFonts.poppins(fontSize: 13),
                            decoration: _inputDecoration('Describe this stage...'),
                            maxLines: 3,
                          ),
                          const SizedBox(height: 14),
 
                          // Status
                          _buildLabel('Status'),
                          const SizedBox(height: 6),
                          DropdownButtonFormField<String>(
                            value: _selectedStatus,
                            items: _statusOptions
                                .map((s) => DropdownMenuItem(
                                      value: s,
                                      child: Text(s,
                                          style: GoogleFonts.poppins(
                                              fontSize: 13)),
                                    ))
                                .toList(),
                            onChanged: (v) =>
                                setState(() => _selectedStatus = v!),
                            decoration: _inputDecoration(''),
                            icon: const Icon(Icons.keyboard_arrow_down,
                                color: AppColors.grey, size: 20),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),
 
                    // Sub-stages question card
                    Container(
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: AppColors.border, width: 1.5),
                      ),
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Add sub-stages to this stage?',
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color: AppColors.dark,
                              )),
                          const SizedBox(height: 4),
                          Text(
                              'Sub-stages help break down work into smaller tasks',
                              style: GoogleFonts.poppins(
                                  fontSize: 11, color: AppColors.greyLight)),
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              Expanded(
                                child: YesNoButton(
                                  label: 'Yes',
                                  selected: _wantsSubStages,
                                  onTap: () =>
                                      setState(() => _wantsSubStages = true),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: YesNoButton(
                                  label: 'No',
                                  selected: !_wantsSubStages,
                                  onTap: () =>
                                      setState(() => _wantsSubStages = false),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
 
                    // Save button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _save,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.amber,
                          foregroundColor: AppColors.dark,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                          elevation: 0,
                        ),
                        child: Text(
                          _wantsSubStages ? 'Continue to Sub-stages' : 'Save Stage',
                          style: GoogleFonts.poppins(
                              fontSize: 14, fontWeight: FontWeight.w700),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
 
  Widget _buildLabel(String text) {
    return Text(text,
        style: GoogleFonts.poppins(
            fontSize: 11, fontWeight: FontWeight.w600, color: AppColors.dark));
  }
 
  InputDecoration _inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      filled: true,
      fillColor: AppColors.greyFill,
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: AppColors.border, width: 1.5),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: AppColors.border, width: 1.5),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: AppColors.amber, width: 1.5),
      ),
      hintStyle: GoogleFonts.poppins(fontSize: 12, color: AppColors.greyLight),
    );
  }
}