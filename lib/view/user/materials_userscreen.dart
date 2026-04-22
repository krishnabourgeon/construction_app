import 'package:construction_app/models/models.dart';
import 'package:construction_app/widgets/app_theme.dart';
import 'package:construction_app/widgets/common_widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ── Materials List Screen ─────────────────────────────────────────────────────

class MaterialsUserScreen extends StatefulWidget {
  const MaterialsUserScreen({super.key});

  @override
  State<MaterialsUserScreen> createState() => _MaterialsUserScreenState();
}

class _MaterialsUserScreenState extends State<MaterialsUserScreen> {
  String _search = '';

  List<MaterialModel> get _filtered => sampleMaterials
      .where((m) =>
          m.materialName.toLowerCase().contains(_search.toLowerCase()) ||
          m.siteName.toLowerCase().contains(_search.toLowerCase()) ||
          m.supplier.toLowerCase().contains(_search.toLowerCase()))
      .toList();

  double get _totalAmount =>
      _filtered.fold(0, (sum, m) => sum + m.amount);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.greyBg,
      body: Column(
        children: [
          // Header
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
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Inventory',
                        style: GoogleFonts.poppins(
                            fontSize: 11, color: AppColors.greyLight)),
                    Text('Materials',
                        style: GoogleFonts.poppins(
                          fontSize: 22,
                          fontWeight: FontWeight.w600,
                          color: AppColors.white,
                        )),
                  ],
                ),
                GestureDetector(
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const AddMaterialUserScreen())),
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                    decoration: BoxDecoration(
                      color: AppColors.amber,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.add, size: 16, color: AppColors.dark),
                        const SizedBox(width: 4),
                        Text('Add',
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: AppColors.dark,
                            )),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Search
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
            child: TextField(
              onChanged: (v) => setState(() => _search = v),
              style: GoogleFonts.poppins(fontSize: 13),
              decoration: InputDecoration(
                hintText: 'Search materials...',
                filled: true,
                fillColor: AppColors.white,
                prefixIcon:
                    const Icon(Icons.search, color: AppColors.grey, size: 20),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: AppColors.border),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: AppColors.border),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide:
                      const BorderSide(color: AppColors.amber, width: 2),
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 12),
              ),
            ),
          ),

          // Summary strip
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 10, 16, 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${_filtered.length} entries',
                  style: GoogleFonts.poppins(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: AppColors.grey),
                ),
                Text(
                  'Total: ${formatAmount(_totalAmount)}',
                  style: GoogleFonts.poppins(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: AppColors.orange,
                  ),
                ),
              ],
            ),
          ),

          // List
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.fromLTRB(16, 4, 16, 16),
              itemCount: _filtered.length,
              itemBuilder: (_, i) => _MaterialUserCard(material: _filtered[i]),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Material Card ─────────────────────────────────────────────────────────────

class _MaterialUserCard extends StatelessWidget {
  final MaterialModel material;

  const _MaterialUserCard({required this.material});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (_) => MaterialUserDetailScreen(material: material))),
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.border),
        ),
        child: Row(
          children: [
            // Icon
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: AppColors.blueLight,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(Icons.inventory_2_outlined,
                  color: AppColors.blue, size: 22),
            ),
            const SizedBox(width: 12),
            // Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(material.materialName,
                      style: GoogleFonts.poppins(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: AppColors.dark,
                      )),
                  const SizedBox(height: 3),
                  Text(
                    '${material.quantity.toInt()} ${material.unit} × ₹${material.price.toInt()}',
                    style: GoogleFonts.poppins(
                        fontSize: 11, color: AppColors.grey),
                  ),
                  Text(material.siteName,
                      style: GoogleFonts.poppins(
                          fontSize: 10, color: AppColors.greyLight)),
                ],
              ),
            ),
            // Amount
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '₹${material.amount.toInt()}',
                  style: GoogleFonts.poppins(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: AppColors.orange,
                  ),
                ),
                const SizedBox(height: 4),
                Text(material.addedDate,
                    style: GoogleFonts.poppins(
                        fontSize: 10, color: AppColors.greyLight)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// ── Material Detail Screen ────────────────────────────────────────────────────

class MaterialUserDetailScreen extends StatelessWidget {
  final MaterialModel material;

  const MaterialUserDetailScreen({super.key, required this.material});

  @override
  Widget build(BuildContext context) {
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
                Expanded(
                  child: Text(material.materialName,
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: AppColors.white,
                      )),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.edit_outlined,
                      color: AppColors.amber, size: 20),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.delete_outline_rounded,
                      color: Color(0xFFEF4444), size: 20),
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(color: AppColors.border),
                ),
                child: Column(
                  children: [
                    _Row('Material Name', material.materialName),
                    _Row('Site', material.siteName),
                    _Row('Quantity', '${material.quantity.toInt()} ${material.unit}'),
                    _Row('Price per Unit', '₹${material.price.toInt()}'),
                    _Row('Total Amount', '₹${material.amount.toInt()}',
                        highlight: true),
                    _Row('Supplier', material.supplier),
                    _Row('Added Date', material.addedDate),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Row extends StatelessWidget {
  final String label;
  final String value;
  final bool highlight;

  const _Row(this.label, this.value, {this.highlight = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 13),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Color(0xFFF3F4F6))),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style: GoogleFonts.poppins(fontSize: 12, color: AppColors.grey)),
          Text(value,
              style: GoogleFonts.poppins(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: highlight ? AppColors.orange : AppColors.dark,
              )),
        ],
      ),
    );
  }
}

// ── Add Material Screen ───────────────────────────────────────────────────────

class AddMaterialUserScreen extends StatefulWidget {
  const AddMaterialUserScreen({super.key});

  @override
  State<AddMaterialUserScreen> createState() => _AddMaterialUserScreenState();
}

class _AddMaterialUserScreenState extends State<AddMaterialUserScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _qtyController = TextEditingController();
  final _priceController = TextEditingController();
  final _supplierController = TextEditingController();
  final _dateController = TextEditingController();
  String? _selectedSite;
  String? _selectedUnit;
  bool _saving = false;

  final List<String> _units = ['Bag', 'Kg', 'Nos', 'Ton', 'Sq.ft', 'Litre', 'Load'];
  final List<String> _sites =
      sampleSites.map((s) => s.name).toList();

  double get _autoAmount {
    final qty = double.tryParse(_qtyController.text) ?? 0;
    final price = double.tryParse(_priceController.text) ?? 0;
    return qty * price;
  }

  void _save() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _saving = true);
    await Future.delayed(const Duration(seconds: 1));
    setState(() => _saving = false);
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Material saved!',
            style: GoogleFonts.poppins(fontSize: 13)),
        backgroundColor: AppColors.green,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
    Navigator.pop(context);
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
      _dateController.text =
          '${picked.day.toString().padLeft(2, '0')} ${['Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'][picked.month - 1]} ${picked.year}';
    }
  }

  @override
  Widget build(BuildContext context) {
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
                Text('Add Material Entry',
                    style: GoogleFonts.poppins(
                      fontSize: 17,
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Company (read only)
                      AppTextField(
                        label: 'Company',
                        hint: '',
                        controller: TextEditingController(
                            text: 'BuildCo Constructions Pvt Ltd'),
                        readOnly: true,
                      ),

                      // Site dropdown
                      AppDropdown(
                        label: 'Site *',
                        value: _selectedSite,
                        items: _sites,
                        onChanged: (v) => setState(() => _selectedSite = v),
                      ),

                      // Material name
                      AppTextField(
                        label: 'Material Name *',
                        hint: 'e.g. Cement, Steel, Sand',
                        controller: _nameController,
                        validator: (v) => v!.isEmpty ? 'Required' : null,
                      ),

                      // Qty + Unit row
                      Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: AppTextField(
                              label: 'Quantity *',
                              hint: '0',
                              controller: _qtyController,
                              keyboardType:
                                  const TextInputType.numberWithOptions(
                                      decimal: true),
                              validator: (v) =>
                                  v!.isEmpty ? 'Required' : null,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: AppDropdown(
                              label: 'Unit *',
                              value: _selectedUnit,
                              items: _units,
                              onChanged: (v) =>
                                  setState(() => _selectedUnit = v),
                            ),
                          ),
                        ],
                      ),

                      // Price
                      AppTextField(
                        label: 'Price per Unit (₹) *',
                        hint: '0.00',
                        controller: _priceController,
                        keyboardType: const TextInputType.numberWithOptions(
                            decimal: true),
                        validator: (v) => v!.isEmpty ? 'Required' : null,
                      ),

                      // Auto amount display
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Total Amount (Auto-calculated)',
                              style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.dark)),
                          const SizedBox(height: 6),
                          StatefulBuilder(
                            builder: (_, setInner) {
                              _qtyController.addListener(() => setInner(() {}));
                              _priceController
                                  .addListener(() => setInner(() {}));
                              return Container(
                                width: double.infinity,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 14),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFFEF9C3),
                                  border: Border.all(
                                      color: const Color(0xFFFDE047)),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  '₹ ${_autoAmount.toStringAsFixed(2)}',
                                  textAlign: TextAlign.right,
                                  style: GoogleFonts.poppins(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                    color: const Color(0xFF854D0E),
                                  ),
                                ),
                              );
                            },
                          ),
                          const SizedBox(height: 14),
                        ],
                      ),

                      // Supplier
                      AppTextField(
                        label: 'Supplier',
                        hint: 'Supplier name',
                        controller: _supplierController,
                      ),

                      // Date
                      AppTextField(
                        label: 'Added Date *',
                        hint: 'DD Mon YYYY',
                        controller: _dateController,
                        readOnly: true,
                        onTap: _pickDate,
                        suffixIcon: const Icon(Icons.calendar_today_outlined,
                            size: 18, color: AppColors.grey),
                        validator: (v) => v!.isEmpty ? 'Required' : null,
                      ),

                      AppButton(
                          label: 'Save Material',
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
