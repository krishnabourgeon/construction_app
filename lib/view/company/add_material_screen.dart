import 'package:construction_app/models/models.dart';
import 'package:construction_app/widgets/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AddMaterialScreen extends StatefulWidget {
  final SubStageWithResources subStage;
  final Function(SubStageMaterial)? onMaterialAdded;
 
  const AddMaterialScreen({
    super.key,
    required this.subStage,
    this.onMaterialAdded,
  });
 
  @override
  State<AddMaterialScreen> createState() => _AddMaterialScreenState();
}
 
class _AddMaterialScreenState extends State<AddMaterialScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();
  final _qtyCtrl = TextEditingController();
  final _priceCtrl = TextEditingController();
  final _supplierCtrl = TextEditingController();
  final _dateCtrl = TextEditingController();
  String _selectedUnit = 'Bag';
 
  final _units = ['Bag', 'Kg', 'Ton', 'Nos', 'Load', 'Sq.ft', 'Cu.ft', 'Litre'];
 
  double get _totalAmount {
    final qty = double.tryParse(_qtyCtrl.text) ?? 0;
    final price = double.tryParse(_priceCtrl.text) ?? 0;
    return qty * price;
  }
 
  @override
  void initState() {
    super.initState();
    _dateCtrl.text = _formatDate(DateTime.now());
  }
 
  @override
  void dispose() {
    _nameCtrl.dispose();
    _qtyCtrl.dispose();
    _priceCtrl.dispose();
    _supplierCtrl.dispose();
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
          colorScheme: const ColorScheme.light(primary: AppColors.amber),
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
 
    final material = SubStageMaterial(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      subStageId: widget.subStage.id,
      materialName: _nameCtrl.text.trim(),
      quantity: double.parse(_qtyCtrl.text),
      unit: _selectedUnit,
      pricePerUnit: double.parse(_priceCtrl.text),
      totalAmount: _totalAmount,
      supplier: _supplierCtrl.text.trim(),
      dateAdded: _dateCtrl.text,
    );
 
    // Call your API here to save the material
    // await yourApiService.addMaterial(material);
 
    if (widget.onMaterialAdded != null) {
      widget.onMaterialAdded!(material);
    }
 
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Material added ✓',
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
                Text('Add Material',
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
                    color: AppColors.amberLight,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.inventory_2,
                          size: 14, color: AppColors.amberDark),
                      const SizedBox(width: 5),
                      Text('For: ${widget.subStage.name}',
                          style: GoogleFonts.poppins(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              color: AppColors.amberDark)),
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


                      _buildLabel('Material Name *'),
                      const SizedBox(height: 6),
                      TextFormField(
                        controller: _nameCtrl,
                        style: GoogleFonts.poppins(fontSize: 13),
                        decoration: _inputDecoration('e.g. Cement, Steel'),
                        validator: (v) => v!.isEmpty ? 'Required' : null,
                      ),
                      const SizedBox(height: 14),
 
                      Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildLabel('Quantity *'),
                                const SizedBox(height: 6),
                                TextFormField(
                                  controller: _qtyCtrl,
                                  style: GoogleFonts.poppins(fontSize: 13),
                                  decoration: _inputDecoration('0'),
                                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                                  validator: (v) => v!.isEmpty ? 'Required' : null,
                                  onChanged: (_) => setState(() {}),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildLabel('Unit *'),
                                const SizedBox(height: 6),
                                DropdownButtonFormField<String>(
                                  value: _selectedUnit,
                                  items: _units
                                      .map((u) => DropdownMenuItem(
                                            value: u,
                                            child: Text(u,
                                                style: GoogleFonts.poppins(
                                                    fontSize: 13)),
                                          ))
                                      .toList(),
                                  onChanged: (v) =>
                                      setState(() => _selectedUnit = v!),
                                  decoration: _inputDecoration(''),
                                  icon: const Icon(Icons.keyboard_arrow_down,
                                      color: AppColors.grey, size: 18),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 14),
 
                      _buildLabel('Price per Unit (₹) *'),
                      const SizedBox(height: 6),
                      TextFormField(
                        controller: _priceCtrl,
                        style: GoogleFonts.poppins(fontSize: 13),
                        decoration: _inputDecoration('0.00'),
                        keyboardType: const TextInputType.numberWithOptions(decimal: true),
                        validator: (v) => v!.isEmpty ? 'Required' : null,
                        onChanged: (_) => setState(() {}),
                      ),
                      const SizedBox(height: 14),
 
                      _buildLabel('Total Amount (Auto)'),
                      const SizedBox(height: 6),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 13),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFEF9C3),
                          border: Border.all(color: const Color(0xFFFDE047)),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          '₹ ${_totalAmount.toStringAsFixed(2)}',
                          textAlign: TextAlign.right,
                          style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFF854D0E)),
                        ),
                      ),
                      const SizedBox(height: 14),
 
                      _buildLabel('Supplier'),
                      const SizedBox(height: 6),
                      TextFormField(
                        controller: _supplierCtrl,
                        style: GoogleFonts.poppins(fontSize: 13),
                        decoration: _inputDecoration('Supplier name'),
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
                            backgroundColor: AppColors.amber,
                            foregroundColor: AppColors.dark,
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)),
                            elevation: 0,
                          ),
                          child: Text('Save Material',
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
        borderSide: const BorderSide(color: AppColors.amber, width: 1.5),
      ),
      hintStyle: GoogleFonts.poppins(fontSize: 12, color: AppColors.greyLight),
    );
  }
}
 
