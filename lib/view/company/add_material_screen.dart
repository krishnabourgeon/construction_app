import 'dart:async';
import 'package:construction_app/models/get_categories_model.dart';
import 'package:construction_app/models/get_sub_stages.dart';
import 'package:construction_app/models/models.dart';
import 'package:construction_app/provider/company_provider.dart';
import 'package:construction_app/services/provider_helper_class.dart';
import 'package:construction_app/widgets/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class AddMaterialScreen extends StatefulWidget {
  final SubStage subStages;
  //final Function()? onMaterialAdded;

  const AddMaterialScreen({
    super.key,
    required this.subStages,
    //this.onMaterialAdded,
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
  int? _selectedCategoryId;
  int? _selectedUnitId;
  int? _selectedSupplierId;
  Timer? _debounce;
  
  // Autocomplete state
  final FocusNode _nameFocusNode = FocusNode();
  final LayerLink _layerLink = LayerLink();
  bool _showSuggestions = false;
  List<String> _filteredSuggestions = [];
  
  // List of locally added material names (to complement API results)
  final List<String> _locallyAddedNames = [];
  
  // final _units = ['Bag', 'Kg', 'Ton', 'Nos', 'Load', 'Sq.ft', 'Cu.ft', 'Litre'];

  double get _totalAmount {
    final qty = double.tryParse(_qtyCtrl.text) ?? 0;
    final price = double.tryParse(_priceCtrl.text) ?? 0;
    return qty * price;
  }

  @override
  void initState() {
    super.initState();
    _dateCtrl.text = _formatDate(DateTime.now());
    
    // Listen to text changes for autocomplete
    _nameCtrl.addListener(_onNameChanged);
    
    // Listen to focus changes
    _nameFocusNode.addListener(() {
      if (!_nameFocusNode.hasFocus) {
        setState(() => _showSuggestions = false);
      }
    });
    
    Future.microtask(() {
      context.read<CompanyProvider>().getCategories(null);
      context.read<CompanyProvider>().getMaterialNames(null, "");
      context.read<CompanyProvider>().getUnits(null);
      context.read<CompanyProvider>().getSupplier(null);
    });
  }
  
  void _onNameChanged() {
    final query = _nameCtrl.text.trim();
    
    if (query.isEmpty) {
      if (_debounce?.isActive ?? false) _debounce!.cancel();
      setState(() {
        _filteredSuggestions = [];
        _showSuggestions = false;
      });
      return;
    }

    // Show suggestions menu immediately (for "Add New" option)
    setState(() {
      _showSuggestions = true;
      _updateSuggestions(query); // Filter existing local/cached names
    });
    
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      context.read<CompanyProvider>().getMaterialNames(null, query).then((_) {
        if (mounted) {
          _updateSuggestions(query);
        }
      });
    });
  }

  void _updateSuggestions(String query) {
    final apiNames = context.read<CompanyProvider>().materialNamesList.map((e) => e.name).toList();
    final allNames = {...apiNames, ..._locallyAddedNames}.toList();
    
    final filtered = allNames
        .where((name) => name.toLowerCase().contains(query.toLowerCase()))
        .toList();
    
    setState(() {
      _filteredSuggestions = filtered;
      _showSuggestions = (filtered.isNotEmpty || query.length >= 1) && _nameFocusNode.hasFocus;
    });
  }
  
  void _selectSuggestion(String suggestion) {
    _nameCtrl.text = suggestion;
    setState(() => _showSuggestions = false);
    // Move focus to next field
    FocusScope.of(context).nextFocus();
  }
  
  void _showAddNewMaterialDialog() {
    final newMaterialCtrl = TextEditingController(text: _nameCtrl.text.trim());
    
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColors.amberLight,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(Icons.add_circle_outline, color: AppColors.amberDark, size: 20),
            ),
            const SizedBox(width: 10),
            Text('Add New Material',
                style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w600)),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Material not in the list? Add it now.',
                style: GoogleFonts.poppins(fontSize: 12, color: AppColors.grey)),
            const SizedBox(height: 14),
            TextField(
              controller: newMaterialCtrl,
              autofocus: true,
              style: GoogleFonts.poppins(fontSize: 13),
              decoration: InputDecoration(
                labelText: 'Material Name',
                filled: true,
                fillColor: AppColors.greyFill,
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
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel', style: GoogleFonts.poppins(color: AppColors.grey)),
          ),
          ElevatedButton(
            onPressed: () {
              final newName = newMaterialCtrl.text.trim();
              if (newName.isNotEmpty) {
                setState(() {
                  // Add to local list if not already there
                  final apiNames = context.read<CompanyProvider>().materialNamesList.map((e) => e.name).toList();
                  if (!apiNames.contains(newName) && !_locallyAddedNames.contains(newName)) {
                    _locallyAddedNames.add(newName);
                  }
                  _nameCtrl.text = newName;
                  _showSuggestions = false;
                });
                
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('"$newName" added ✓',
                        style: GoogleFonts.poppins(fontSize: 12)),
                    backgroundColor: AppColors.green,
                    behavior: SnackBarBehavior.floating,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    duration: const Duration(seconds: 2),
                  ),
                );
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.amber,
              foregroundColor: AppColors.dark,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            ),
            child: Text('Add Material', style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
          ),
        ],
      ),
    );
  }
 
  @override
  void dispose() {
    _nameCtrl.dispose();
    _qtyCtrl.dispose();
    _priceCtrl.dispose();
    _supplierCtrl.dispose();
    _dateCtrl.dispose();
    _nameFocusNode.dispose();
    _debounce?.cancel();
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
    if (_selectedCategoryId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a category')),
      );
      return;
    }
     if (_selectedUnitId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a unit')),
      );
      return;
    }
    if (_selectedSupplierId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a supplier')),
      );
      return;
    }
 
    final provider = context.read<CompanyProvider>();
    
    // Mapping units to IDs (assuming 1-indexed based on the list)
    // final unitId = _units.indexOf(_selectedUnit) + 1;
 
    await provider.addMaterials(
      siteId: widget.subStages.siteId,
      substageId: widget.subStages.id,
      name: _nameCtrl.text.trim(),
      quantity: int.tryParse(_qtyCtrl.text) ?? 0,
      unitId: _selectedUnitId!,
      price: int.tryParse(_priceCtrl.text) ?? 0,
      totalAmount: _totalAmount.toInt(),
      supplierId: _selectedSupplierId!, // Defaulting for now
      addedDate: DateTime.now(),
      categoryId: _selectedCategoryId!,
      onFailure: (errorMessage) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(errorMessage), backgroundColor: AppColors.red),
        );
      },
    );
 
    if (!mounted) return;
    
    if (provider.loaderState == LoaderState.loaded && provider.errorToast == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Material added ✓', style: GoogleFonts.poppins(fontSize: 13)),
          backgroundColor: AppColors.green,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
      );
      Navigator.pop(context);
    }
  }
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.greyBg,
      body: Stack(
        children: [
          Column(
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
                              size: 20, color: AppColors.greyLight),
                          const SizedBox(width: 5),
                          Text(widget.subStages.substage,
                              style: GoogleFonts.poppins(
                                  fontSize: 15, color: AppColors.greyLight)),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text('Add Material',
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: AppColors.white,
                        )),
                    const SizedBox(height: 10),
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
                              size: 16, color: AppColors.amberDark),
                          const SizedBox(width: 5),
                          Text('For: ${widget.subStages.substage}',
                              style: GoogleFonts.poppins(
                                  fontSize: 15,
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
                          _buildLabel('Category *'),
                          const SizedBox(height: 6),
                          Consumer<CompanyProvider>(
                            builder: (context, provider, child) {
                              return DropdownButtonFormField<int>(
                                value: _selectedCategoryId,
                                style: GoogleFonts.poppins(fontSize: 13, color: AppColors.dark),
                                decoration: _inputDecoration('Select Category'),
                                items: provider.categoriesList.map((Catergories category) {
                                  return DropdownMenuItem<int>(
                                    value: category.id,
                                    child: Text(category.name, 
                                        style: GoogleFonts.poppins(fontSize: 13)),
                                  );
                                }).toList(),
                                onChanged: (int? value) {
                                  setState(() {
                                    _selectedCategoryId = value;
                                  });
                                },
                                validator: (v) => v == null ? 'Required' : null,
                              );
                            },
                          ),
                          const SizedBox(height: 14),

                          // ── Material Name with Autocomplete ─────────────────
                          _buildLabel('Material Name *'),
                          const SizedBox(height: 6),
                          
                          CompositedTransformTarget(
                            link: _layerLink,
                            child: TextFormField(
                              controller: _nameCtrl,
                              focusNode: _nameFocusNode,
                              style: GoogleFonts.poppins(fontSize: 13),
                              decoration: _inputDecoration('Type to search...').copyWith(
                                suffixIcon: _nameCtrl.text.isNotEmpty
                                    ? IconButton(
                                        icon: const Icon(Icons.clear, size: 18, color: AppColors.grey),
                                        onPressed: () {
                                          _nameCtrl.clear();
                                          setState(() => _showSuggestions = false);
                                        },
                                      )
                                    : const Icon(Icons.search, size: 18, color: AppColors.greyLight),
                              ),
                              validator: (v) => v!.isEmpty ? 'Required' : null,
                            ),
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
                                    Consumer<CompanyProvider>(
                                      builder: (context, provider, child) {
                                        
                                      return DropdownButtonFormField<int>(
                                        value: _selectedUnitId,
                                        isExpanded: true,
                                        style: GoogleFonts.poppins(fontSize: 13, color: AppColors.dark),
                                        items: provider.unitsList.map((u) {
                                          return DropdownMenuItem<int>(
                                            value: u.id,
                                            child: Text(u.shortName,
                                                style: GoogleFonts.poppins(
                                                    fontSize: 13),
                                                overflow: TextOverflow.ellipsis),
                                          );
                                        }).toList(),
                                        onChanged: (v) =>
                                            setState(() => _selectedUnitId = v),
                                        decoration: _inputDecoration('Unit'),
                                        icon: const Icon(Icons.keyboard_arrow_down,
                                            color: AppColors.grey, size: 18),
                                      );
                                      },
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
     
                          _buildLabel('Supplier *'),
                          const SizedBox(height: 6),
                          // TextFormField(
                          //   controller: _supplierCtrl,
                          //   style: GoogleFonts.poppins(fontSize: 13),
                          //   decoration: _inputDecoration('Supplier name'),
                          // ),
                          Consumer<CompanyProvider>(
                            builder: (context, provider, child) {
                                        
                              return DropdownButtonFormField<int>(
                                value: _selectedSupplierId,
                                isExpanded: true,
                                style: GoogleFonts.poppins(fontSize: 13, color: AppColors.dark),
                                items: provider.suppliersList.map((u) {
                                return DropdownMenuItem<int>(
                                  value: u.id,
                                  child: Text(u.name,
                                  style: GoogleFonts.poppins(
                                  fontSize: 13),
                                  overflow: TextOverflow.ellipsis),
                                );
                              }).toList(),
                              onChanged: (v) =>
                                setState(() => _selectedSupplierId = v),
                              decoration: _inputDecoration('Supplier'),
                              icon: const Icon(Icons.keyboard_arrow_down,
                              color: AppColors.grey, size: 18),
                              );
                            },
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
          
          // ── OVERLAY SUGGESTIONS DROPDOWN ──────────────────────────────
          if (_showSuggestions)
            CompositedTransformFollower(
              link: _layerLink,
              showWhenUnlinked: false,
              offset: const Offset(0, 55), // Offset to appear below the field
              child: Material(
                elevation: 8,
                borderRadius: BorderRadius.circular(10),
                shadowColor: Colors.black.withOpacity(0.3),
                child: Container(
                  width: MediaQuery.of(context).size.width - 56, // Account for padding
                  constraints: const BoxConstraints(maxHeight: 250),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: AppColors.border, width: 1),
                  ),
                  child: ListView(
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    children: [
                      // Existing suggestions
                      if (_filteredSuggestions.isNotEmpty)
                        ..._filteredSuggestions.map((suggestion) => InkWell(
                          onTap: () => _selectSuggestion(suggestion),
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                            decoration: const BoxDecoration(
                              border: Border(bottom: BorderSide(color: AppColors.borderLight)),
                            ),
                            child: Row(
                              children: [
                                const Icon(Icons.inventory_2_outlined, 
                                    size: 16, color: AppColors.grey),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Text(suggestion,
                                      style: GoogleFonts.poppins(fontSize: 13, color: AppColors.dark)),
                                ),
                                const Icon(Icons.arrow_forward_ios, 
                                    size: 12, color: AppColors.greyLight),
                              ],
                            ),
                          ),
                        )),
                      
                      // Add new material option
                      if (_nameCtrl.text.trim().length >= 1)
                        InkWell(
                          onTap: () {
                            setState(() => _showSuggestions = false);
                            _showAddNewMaterialDialog();
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                            decoration: BoxDecoration(
                              color: AppColors.amberLight.withOpacity(0.3),
                              borderRadius: _filteredSuggestions.isEmpty 
                                  ? BorderRadius.circular(10) 
                                  : const BorderRadius.only(
                                      bottomLeft: Radius.circular(10),
                                      bottomRight: Radius.circular(10),
                                    ),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(4),
                                  decoration: BoxDecoration(
                                    color: AppColors.amberLight,
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: const Icon(Icons.add_circle, 
                                      size: 14, color: AppColors.amberDark),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Text(
                                    _filteredSuggestions.isEmpty 
                                        ? 'Add "${_nameCtrl.text.trim()}" as new material'
                                        : 'Add as new material',
                                    style: GoogleFonts.poppins(
                                        fontSize: 12, 
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.amberDark),
                                  ),
                                ),
                              ],
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
      hintStyle: GoogleFonts.poppins(fontSize: 10, color: AppColors.greyLight),
    );
  }
}