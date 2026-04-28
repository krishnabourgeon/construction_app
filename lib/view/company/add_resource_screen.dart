import 'package:construction_app/widgets/app_theme.dart';
import 'package:flutter/material.dart';

class AddResourceScreen extends StatefulWidget {
  final String resourceType;
  final String stageName;
  final String? subStageName;
  final String siteName;
 
  const AddResourceScreen({
    super.key,
    required this.resourceType,
    required this.stageName,
    this.subStageName,
    required this.siteName,
  });
 
  @override
  State<AddResourceScreen> createState() => _AddResourceScreenState();
}
 
class _AddResourceScreenState extends State<AddResourceScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _qtyController = TextEditingController();
  final _priceController = TextEditingController();
  final _amountController = TextEditingController();
  final _supplierController = TextEditingController();
  String _selectedUnit = 'Bag';
 
  @override
  void dispose() {
    _nameController.dispose();
    _qtyController.dispose();
    _priceController.dispose();
    _amountController.dispose();
    _supplierController.dispose();
    super.dispose();
  }
 
  void _calculateTotal() {
    final qty = double.tryParse(_qtyController.text) ?? 0;
    final price = double.tryParse(_priceController.text) ?? 0;
    setState(() {
      _amountController.text = (qty * price).toStringAsFixed(2);
    });
  }
 
  @override
  Widget build(BuildContext context) {
    final isMaterial = widget.resourceType == 'Material';
    final path = widget.subStageName != null
        ? '${widget.stageName} › ${widget.subStageName}'
        : widget.stageName;
 
    return Scaffold(
      appBar: AppBar(
        title: Text('Add ${widget.resourceType}'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(12),
          children: [
            // Context tag
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: isMaterial ? const Color(0xFFFEF3C7) : const Color(0xFFFEE2E2),
                borderRadius: BorderRadius.circular(9),
              ),
              child: Row(
                children: [
                  Text(
                    isMaterial ? '📦' : '👷',
                    style: const TextStyle(fontSize: 14),
                  ),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      path,
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                        color: isMaterial ? const Color(0xFFB45309) : const Color(0xFFB91C1C),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
 
            if (isMaterial) ..._buildMaterialFields() else ..._buildLabourFields(),
 
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('${widget.resourceType} saved successfully!')),
                  );
                  Navigator.pop(context);
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFF59E0B),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 13),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                textStyle: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700),
              ),
              child: Text('Save ${widget.resourceType}'),
            ),
            const SizedBox(height: 8),
            OutlinedButton(
              onPressed: () => Navigator.pop(context),
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 11),
                side: const BorderSide(color: Color(0xFFE5E7EB)),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                textStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
              ),
              child: const Text('Cancel'),
            ),
          ],
        ),
      ),
    );
  }
 
  List<Widget> _buildMaterialFields() {
    return [
      Card(
        color: AppColors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Material Name *', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600)),
              const SizedBox(height: 5),
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  hintText: 'e.g. Cement, Sand, Steel Bars',
                  filled: true,
                  fillColor: Color(0xFFF9FAFB),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide(color: Color(0xFFE5E7EB)),
                  ),
                  contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 9),
                ),
                validator: (v) => v!.isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: 10),
              const Text('Quantity & Unit *', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600)),
              const SizedBox(height: 5),
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: TextFormField(
                      controller: _qtyController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        hintText: '0',
                        filled: true,
                        fillColor: Color(0xFFF9FAFB),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(color: Color(0xFFE5E7EB)),
                        ),
                        contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 9),
                      ),
                      onChanged: (_) => _calculateTotal(),
                      validator: (v) => v!.isEmpty ? 'Required' : null,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      value: _selectedUnit,
                      items: ['Bag', 'Kg', 'Ton', 'Nos', 'Load', 'Sq.ft', 'Cu.ft', 'Litre']
                          .map((u) => DropdownMenuItem(value: u, child: Text(u)))
                          .toList(),
                      onChanged: (v) => setState(() => _selectedUnit = v!),
                      decoration: const InputDecoration(
                        filled: true,
                        fillColor: Color(0xFFF9FAFB),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(color: Color(0xFFE5E7EB)),
                        ),
                        contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 9),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              const Text('Price per Unit (₹) *', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600)),
              const SizedBox(height: 5),
              TextFormField(
                controller: _priceController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  hintText: '0.00',
                  filled: true,
                  fillColor: Color(0xFFF9FAFB),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide(color: Color(0xFFE5E7EB)),
                  ),
                  contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 9),
                ),
                onChanged: (_) => _calculateTotal(),
                validator: (v) => v!.isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: 10),
              const Text('Total Amount', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600)),
              const SizedBox(height: 5),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFFFEF9C3),
                  border: Border.all(color: const Color(0xFFFDE047), width: 1.5),
                  borderRadius: BorderRadius.circular(10),
                ),
                alignment: Alignment.centerRight,
                child: Text(
                  '₹ ${_amountController.text.isEmpty ? "0.00" : _amountController.text}',
                  style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: Color(0xFF854D0E)),
                ),
              ),
              const SizedBox(height: 10),
              const Text('Supplier', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600)),
              const SizedBox(height: 5),
              TextFormField(
                controller: _supplierController,
                decoration: const InputDecoration(
                  hintText: 'Supplier name (optional)',
                  filled: true,
                  fillColor: Color(0xFFF9FAFB),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide(color: Color(0xFFE5E7EB)),
                  ),
                  contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 9),
                ),
              ),
            ],
          ),
        ),
      ),
    ];
  }
 
  List<Widget> _buildLabourFields() {
    return [
      Card(
        color: AppColors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Number of Labour *', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600)),
              const SizedBox(height: 5),
              // DropdownButtonFormField<String>(
              //   value: _selectedLabourType,
              //   items: ['Mason', 'Mason (Head)', 'Helper', 'Steel Bender', 'Carpenter', 'Electrician', 'Plumber', 'Painter', 'Contractor']
              //       .map((t) => DropdownMenuItem(value: t, child: Text(t)))
              //       .toList(),
              //   onChanged: (v) => setState(() => _selectedLabourType = v!),
              //   decoration: const InputDecoration(
              //     filled: true,
              //     fillColor: Color(0xFFF9FAFB),
              //     border: OutlineInputBorder(
              //       borderRadius: BorderRadius.all(Radius.circular(10)),
              //       borderSide: BorderSide(color: Color(0xFFE5E7EB)),
              //     ),
              //     contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 9),
              //   ),
              // ),
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  hintText: 'Number of Labour',
                  filled: true,
                  fillColor: Color(0xFFF9FAFB),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide(color: Color(0xFFE5E7EB)),
                  ),
                  contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 9),
                ),
              ),
              const SizedBox(height: 10),
              const Text('Number of days', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600)),
              const SizedBox(height: 5),
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  hintText: 'Number of days',
                  filled: true,
                  fillColor: Color(0xFFF9FAFB),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide(color: Color(0xFFE5E7EB)),
                  ),
                  contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 9),
                ),
              ),
              const SizedBox(height: 10),
              const Text('Amount (₹) *', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600)),
              const SizedBox(height: 5),
              TextFormField(
                controller: _priceController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  hintText: '0.00',
                  filled: true,
                  fillColor: Color(0xFFF9FAFB),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide(color: Color(0xFFE5E7EB)),
                  ),
                  contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 9),
                ),
                validator: (v) => v!.isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: 10),
              const Text('Remarks', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600)),
              const SizedBox(height: 5),
              TextFormField(
                maxLines: 3,
                decoration: const InputDecoration(
                  hintText: 'Payment details, work scope, notes…',
                  filled: true,
                  fillColor: Color(0xFFF9FAFB),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide(color: Color(0xFFE5E7EB)),
                  ),
                  contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 9),
                ),
              ),
            ],
          ),
        ),
      ),
    ];
  }
}