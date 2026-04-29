import 'package:construction_app/view/company/add_substages_screen.dart';
import 'package:construction_app/widgets/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EditStageScreen extends StatefulWidget {
  final String stageName;
  final String stageDesc;
  final String stageStatus;
  final List<String> subStages;
  final Function(String name, String desc, String status, List<String> subs)?
      onStageSaved;
 
  const EditStageScreen({
    super.key,
    required this.stageName,
    required this.stageDesc,
    required this.stageStatus,
    this.subStages = const [],
    this.onStageSaved,
  });
 
  @override
  State<EditStageScreen> createState() => _EditStageScreenState();
}
 
class _EditStageScreenState extends State<EditStageScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameCtrl;
  late TextEditingController _descCtrl;
  late String _selectedStatus;
  late List<String> _subStages;
 
  final _statusOptions = ['Not Started', 'Active', 'Done'];
 
  @override
  void initState() {
    super.initState();
    _nameCtrl = TextEditingController(text: widget.stageName);
    _descCtrl = TextEditingController(text: widget.stageDesc);
    _selectedStatus = widget.stageStatus;
    _subStages = List.from(widget.subStages);
  }
 
  @override
  void dispose() {
    _nameCtrl.dispose();
    _descCtrl.dispose();
    super.dispose();
  }
 
  void _save() {
    if (!_formKey.currentState!.validate()) return;
    Navigator.pop(context);
    if (widget.onStageSaved != null) {
      widget.onStageSaved!(
        _nameCtrl.text.trim(),
        _descCtrl.text.trim(),
        _selectedStatus,
        _subStages,
      );
    }
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Stage updated ✓',
            style: GoogleFonts.poppins(fontSize: 13)),
        backgroundColor: AppColors.green,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        duration: const Duration(seconds: 2),
      ),
    );
  }
 
  void _removeSub(int index) {
    setState(() {
      _subStages.removeAt(index);
    });
  }
 
  // void _addSubStage() {
  //   // Navigator.push(
  //   //   context,
  //   //   MaterialPageRoute(
  //   //     builder: (_) => 
  //       // AddSubStageScreen(
  //       //   stageName: _nameCtrl.text.isNotEmpty
  //       //       ? _nameCtrl.text
  //       //       : widget.stageName,
  //       //       // siteId: widget.siteId,
  //       //       // stageId: widget.stageId,
  //       //   onSubStagesSaved: (newSubs) {
  //       //     setState(() {
  //       //       for (final sub in newSubs) {
  //       //         _subStages.add(sub['name']!);
  //       //       }
  //       //     });
  //       //     Navigator.pop(context);
  //       //   },
  //       // ),
  //     ),
  //   );
  // }
 
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
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Row(
                    children: [
                      const Icon(Icons.arrow_back_ios_new,
                          size: 14, color: AppColors.greyLight),
                      const SizedBox(width: 5),
                      Text('Working Stages',
                          style: GoogleFonts.poppins(
                              fontSize: 11, color: AppColors.greyLight)),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Text('Edit Stage',
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: AppColors.white,
                    )),
                const SizedBox(height: 4),
                Text(widget.stageName,
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
                          _buildLabel('Stage Name *'),
                          const SizedBox(height: 6),
                          TextFormField(
                            controller: _nameCtrl,
                            style: GoogleFonts.poppins(fontSize: 13),
                            decoration: _inputDecoration(''),
                            validator: (v) =>
                                v!.isEmpty ? 'Name is required' : null,
                          ),
                          const SizedBox(height: 14),
                          _buildLabel('Description'),
                          const SizedBox(height: 6),
                          TextFormField(
                            controller: _descCtrl,
                            style: GoogleFonts.poppins(fontSize: 13),
                            decoration: _inputDecoration(''),
                            maxLines: 3,
                          ),
                          const SizedBox(height: 14),
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
 
                    // Sub-stages section
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Sub-stages',
                                  style: GoogleFonts.poppins(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.dark,
                                  )),
                              GestureDetector(
                                //onTap: _addSubStage,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 5),
                                  decoration: BoxDecoration(
                                    color: AppColors.purpleLight,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Row(
                                    children: [
                                      const Icon(Icons.add,
                                          size: 14, color: AppColors.purple),
                                      const SizedBox(width: 3),
                                      Text('Add',
                                          style: GoogleFonts.poppins(
                                              fontSize: 11,
                                              fontWeight: FontWeight.w700,
                                              color: AppColors.purple)),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          if (_subStages.isEmpty)
                            Text('No sub-stages yet. Tap Add to create one.',
                                style: GoogleFonts.poppins(
                                    fontSize: 11, color: AppColors.greyLight))
                          else
                            ..._subStages.asMap().entries.map((entry) {
                              final i = entry.key;
                              final name = entry.value;
                              return Container(
                                margin: const EdgeInsets.only(bottom: 8),
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: AppColors.greyFill,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                      color: AppColors.borderLight, width: 1),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Text(name,
                                          style: GoogleFonts.poppins(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500,
                                              color: AppColors.dark)),
                                    ),
                                    GestureDetector(
                                      onTap: () => _removeSub(i),
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8, vertical: 3),
                                        decoration: BoxDecoration(
                                          color: AppColors.redLight,
                                          borderRadius:
                                              BorderRadius.circular(6),
                                        ),
                                        child: Text('Remove',
                                            style: GoogleFonts.poppins(
                                                fontSize: 10,
                                                fontWeight: FontWeight.w600,
                                                color: AppColors.red)),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }),
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
                        child: Text('Save Changes',
                            style: GoogleFonts.poppins(
                                fontSize: 14, fontWeight: FontWeight.w700)),
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