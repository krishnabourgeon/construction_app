import 'package:construction_app/models/add_sub_stages_body.dart';
import 'package:construction_app/provider/company_provider.dart';
import 'package:construction_app/widgets/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class AddSubStageScreen extends StatefulWidget {
  final String stageName;
  final int siteId;
  final int stageId;
  final Function(List<Map<String, String>>)? onSubStagesSaved;
 
  const AddSubStageScreen({
    super.key,
    required this.stageName,
    required this.siteId,
    required this.stageId,
    this.onSubStagesSaved,
  });
 
  @override
  State<AddSubStageScreen> createState() => _AddSubStageScreenState();
}
 
class _AddSubStageScreenState extends State<AddSubStageScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();
  final _descCtrl = TextEditingController();
  final List<Map<String, String>> _savedSubStages = [];
 
  @override
  void dispose() {
    _nameCtrl.dispose();
    _descCtrl.dispose();
    super.dispose();
  }
 
  void _saveSubStage() {
    if (!_formKey.currentState!.validate()) return;
 
    final name = _nameCtrl.text.trim();
    final desc = _descCtrl.text.trim();
 
    setState(() {
      _savedSubStages.add({'name': name, 'desc': desc});
    });
 
    _nameCtrl.clear();
    _descCtrl.clear();
 
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('"$name" sub-stage added ✓',
            style: GoogleFonts.poppins(fontSize: 13)),
        backgroundColor: AppColors.green,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        duration: const Duration(seconds: 1),
      ),
    );
  }
 
  // void _finish() {
  //   if (widget.onSubStagesSaved != null) {
  //     widget.onSubStagesSaved!(_savedSubStages);
  //   }
  // }

  void _finish() async {
  if (_savedSubStages.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Add at least one sub-stage")),
    );
    return;
  }

  final provider = context.read<CompanyProvider>();

  //  Convert UI data → API model
  final List<Substage> substageList = _savedSubStages.map((e) {
    return Substage(
      substage: e['name'] ?? '',
      description: e['desc'],
      status: 0, //  IMPORTANT (Not Started)
    );
  }).toList();

  await provider.addSubStages(
    siteId: widget.siteId,
    stageId: widget.stageId,
    substages: substageList,
    onFailure: (msg) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(msg)),
      );
    },
  );

  // optional callback
  widget.onSubStagesSaved?.call(_savedSubStages);

  Navigator.pop(context);

  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(content: Text("Sub-stages saved successfully ")),
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
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Row(
                    children: [
                      const Icon(Icons.arrow_back_ios_new,
                          size: 14, color: AppColors.greyLight),
                      const SizedBox(width: 5),
                      Text('Add Stage',
                          style: GoogleFonts.poppins(
                              fontSize: 11, color: AppColors.greyLight)),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Text('Add Sub-stages',
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: AppColors.white,
                    )),
                const SizedBox(height: 4),
                // Context tag
                Container(
                  margin: const EdgeInsets.only(top: 8),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: AppColors.purpleLight,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.layers_outlined,
                          size: 14, color: AppColors.purple),
                      const SizedBox(width: 5),
                      Text('Under Stage: ${widget.stageName}',
                          style: GoogleFonts.poppins(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              color: AppColors.purple)),
                    ],
                  ),
                ),
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
                    // Form card
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
                          _buildLabel('Sub-stage Name *'),
                          const SizedBox(height: 6),
                          TextFormField(
                            controller: _nameCtrl,
                            style: GoogleFonts.poppins(fontSize: 13),
                            decoration: _inputDecoration('e.g. Excavation'),
                            validator: (v) =>
                                v!.isEmpty ? 'Name is required' : null,
                          ),
                          const SizedBox(height: 14),
                          _buildLabel('Description'),
                          const SizedBox(height: 6),
                          TextFormField(
                            controller: _descCtrl,
                            style: GoogleFonts.poppins(fontSize: 13),
                            decoration: _inputDecoration('Short description...'),
                            maxLines: 2,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),
 
                    // Save button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _saveSubStage,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.purple,
                          foregroundColor: AppColors.white,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                          elevation: 0,
                        ),
                        child: Text(
                          _savedSubStages.isEmpty
                              ? 'Save Sub-stage'
                              : 'Save Another Sub-stage',
                          style: GoogleFonts.poppins(
                              fontSize: 14, fontWeight: FontWeight.w700),
                        ),
                      ),
                    ),
 
                    // Saved sub-stages list
                    if (_savedSubStages.isNotEmpty) ...[
                      const SizedBox(height: 16),
                      Text('Saved Sub-stages (${_savedSubStages.length})',
                          style: GoogleFonts.poppins(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: AppColors.grey)),
                      const SizedBox(height: 8),
                      ..._savedSubStages.asMap().entries.map((entry) {
                        final i = entry.key;
                        final sub = entry.value;
                        return Container(
                          margin: const EdgeInsets.only(bottom: 8),
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: AppColors.purpleLight,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                                color: AppColors.purpleMid, width: 1.5),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(sub['name']!,
                                        style: GoogleFonts.poppins(
                                            fontSize: 13,
                                            fontWeight: FontWeight.w600,
                                            color: AppColors.purple)),
                                    if (sub['desc']!.isNotEmpty)
                                      Text(sub['desc']!,
                                          style: GoogleFonts.poppins(
                                              fontSize: 11,
                                              color: AppColors.purple)),
                                    const SizedBox(height: 4),
                                    Text(widget.stageName,
                                        style: GoogleFonts.poppins(
                                            fontSize: 10,
                                            color: AppColors.purple)),
                                  ],
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 3),
                                decoration: BoxDecoration(
                                  color: AppColors.greenLight,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text('Saved ✓',
                                    style: GoogleFonts.poppins(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w700,
                                        color: AppColors.green)),
                              ),
                            ],
                          ),
                        );
                      }),
                      const SizedBox(height: 12),
                      SizedBox(
                        width: double.infinity,
                        child: OutlinedButton(
                          onPressed: _finish,
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(
                                color: AppColors.amber, width: 1.5),
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)),
                          ),
                          child: Text('Finish & Save All',
                              style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.amberDark)),
                        ),
                      ),
                    ],
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
        borderSide: const BorderSide(color: AppColors.purple, width: 1.5),
      ),
      hintStyle: GoogleFonts.poppins(fontSize: 12, color: AppColors.greyLight),
    );
  }
}