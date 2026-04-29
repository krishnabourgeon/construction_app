import 'package:construction_app/models/models.dart';
import 'package:construction_app/widgets/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AddLabourScreen extends StatefulWidget {
  final SubStageWithResources subStage;
  final Function(SubStageLabour)? onLabourAdded;
 
  const AddLabourScreen({
    super.key,
    required this.subStage,
    this.onLabourAdded,
  });
 
  @override
  State<AddLabourScreen> createState() => _AddLabourScreenState();
}
 
class _AddLabourScreenState extends State<AddLabourScreen> {
  final _formKey = GlobalKey<FormState>();
  final _noOfLaboursCtrl = TextEditingController();
  final _noOfDaysCtrl = TextEditingController();
  final _amountCtrl = TextEditingController();
  final _remarksCtrl = TextEditingController();
  final _dateCtrl = TextEditingController();
  String _selectedType = 'Mason';
 
  final _labourTypes = [
    'Mason',
    'Helper',
    'Electrician',
    'Plumber',
    'Carpenter',
    'Painter',
    'Steel Bender',
    'Contractor'
  ];
 
  @override
  void initState() {
    super.initState();
    _dateCtrl.text = _formatDate(DateTime.now());
  }
 
  @override
  void dispose() {
    _noOfLaboursCtrl.dispose();
    _noOfDaysCtrl.dispose();
    _amountCtrl.dispose();
    _remarksCtrl.dispose();
    _dateCtrl.dispose();
    super.dispose();
  }
 
  String _formatDate(DateTime date) {
    final months = [
      'Jan','Feb','Mar','Apr','May','Jun',
      'Jul','Aug','Sep','Oct','Nov','Dec'
    ];
    return '${date.day.toString().padLeft(2, '0')} ${months[date.month - 1]} ${date.year}';
  }
 
  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
      builder: (ctx, child) => Theme(
        data: Theme.of(ctx).copyWith(
          colorScheme: const ColorScheme.light(primary: AppColors.red),
        ),
        child: child!,
      ),
    );
    if (picked != null) {
      setState(() {
        _dateCtrl.text = _formatDate(picked);
      });
    }
  }
 
  void _save() async {
    if (!_formKey.currentState!.validate()) return;
 
    final labour = SubStageLabour(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      subStageId: widget.subStage.id,
      labourType: _selectedType,
      //workerName: _workerNameCtrl.text.trim(),
      amount: double.parse(_amountCtrl.text),
      remarks: _remarksCtrl.text.trim(),
      dateAdded: _dateCtrl.text,
    );
 
    // Call your API here to save the labour
    // await yourApiService.addLabour(labour);
 
    if (widget.onLabourAdded != null) {
      widget.onLabourAdded!(labour);
    }
 
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Labour added ✓',
            style: GoogleFonts.poppins(fontSize: 13)),
        backgroundColor: AppColors.green,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
    Navigator.pop(context);
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
                      Text(widget.subStage.name,
                          style: GoogleFonts.poppins(
                              fontSize: 11, color: AppColors.greyLight)),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Text('Add Labour',
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: AppColors.white,
                    )),
                const SizedBox(height: 8),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: AppColors.redLight,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.groups,
                          size: 14, color: AppColors.red),
                      const SizedBox(width: 5),
                      Text('For: ${widget.subStage.name}',
                          style: GoogleFonts.poppins(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              color: AppColors.red)),
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
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: AppColors.border, width: 1.5),
                  ),
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildLabel('Number of Labours*'),
                      const SizedBox(height: 6),
                      // DropdownButtonFormField<String>(
                      //   value: _selectedType,
                      //   items: _labourTypes
                      //       .map((t) => DropdownMenuItem(
                      //             value: t,
                      //             child: Text(t,
                      //                 style: GoogleFonts.poppins(fontSize: 13)),
                      //           ))
                      //       .toList(),
                      //   onChanged: (v) => setState(() => _selectedType = v!),
                      //   decoration: _inputDecoration(''),
                      //   icon: const Icon(Icons.keyboard_arrow_down,
                      //       color: AppColors.grey, size: 20),
                      // ),
                       TextFormField(
                        controller: _noOfLaboursCtrl,
                        style: GoogleFonts.poppins(fontSize: 13),
                        decoration: _inputDecoration('e.g. 100'),
                      ),
                      const SizedBox(height: 14),
 
                      _buildLabel('Number of Days*'),
                      const SizedBox(height: 6),
                       TextFormField(
                        controller: _noOfDaysCtrl,
                        style: GoogleFonts.poppins(fontSize: 13),
                        decoration: _inputDecoration('e.g. 100'),
                      ),
                      const SizedBox(height: 14),
 
                      _buildLabel('Amount (₹) *'),
                      const SizedBox(height: 6),
                      TextFormField(
                        controller: _amountCtrl,
                        style: GoogleFonts.poppins(fontSize: 13),
                        decoration: _inputDecoration('0.00'),
                        keyboardType: const TextInputType.numberWithOptions(decimal: true),
                        validator: (v) => v!.isEmpty ? 'Required' : null,
                      ),
                      const SizedBox(height: 14),
 
                      _buildLabel('Remarks'),
                      const SizedBox(height: 6),
                      TextFormField(
                        controller: _remarksCtrl,
                        style: GoogleFonts.poppins(fontSize: 13),
                        decoration:
                            _inputDecoration('Payment details, work scope...'),
                        maxLines: 3,
                      ),
                      const SizedBox(height: 14),
 
                      _buildLabel('Date *'),
                      const SizedBox(height: 6),
                      TextFormField(
                        controller: _dateCtrl,
                        style: GoogleFonts.poppins(fontSize: 13),
                        decoration: _inputDecoration('DD Mon YYYY').copyWith(
                          suffixIcon: const Icon(Icons.calendar_today,
                              size: 18, color: AppColors.grey),
                        ),
                        readOnly: true,
                        onTap: _pickDate,
                        validator: (v) => v!.isEmpty ? 'Required' : null,
                      ),
                      const SizedBox(height: 20),
 
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: _save,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.red,
                            foregroundColor: AppColors.white,
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)),
                            elevation: 0,
                          ),
                          child: Text('Save Labour',
                              style: GoogleFonts.poppins(
                                  fontSize: 14, fontWeight: FontWeight.w700)),
                        ),
                      ),
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
        borderSide: const BorderSide(color: AppColors.red, width: 1.5),
      ),
      hintStyle: GoogleFonts.poppins(fontSize: 12, color: AppColors.greyLight),
    );
  }
}