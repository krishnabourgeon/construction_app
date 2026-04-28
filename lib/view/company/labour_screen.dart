// import 'package:construction_app/models/models.dart';
// import 'package:construction_app/widgets/app_theme.dart';
// import 'package:construction_app/widgets/common_widgets.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';

// // ── Labour List Screen ────────────────────────────────────────────────────────

// class LabourScreen extends StatefulWidget {
//   const LabourScreen({super.key});

//   @override
//   State<LabourScreen> createState() => _LabourScreenState();
// }

// class _LabourScreenState extends State<LabourScreen> {
//   String _search = '';

//   List<LabourModel> get _filtered => sampleLabour
//       .where((l) =>
//           l.labourType.toLowerCase().contains(_search.toLowerCase()) ||
//           l.siteName.toLowerCase().contains(_search.toLowerCase()))
//       .toList();

//   double get _totalAmount => _filtered.fold(0, (s, l) => s + l.amount);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.greyBg,
//       body: Column(
//         children: [
//           // Header
//           Container(
//             color: AppColors.navy,
//             padding: EdgeInsets.only(
//               top: MediaQuery.of(context).padding.top + 16,
//               bottom: 20,
//               left: 20,
//               right: 20,
//             ),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text('Payments',
//                         style: GoogleFonts.poppins(
//                             fontSize: 11, color: AppColors.greyLight)),
//                     Text('Labour',
//                         style: GoogleFonts.poppins(
//                           fontSize: 22,
//                           fontWeight: FontWeight.w600,
//                           color: AppColors.white,
//                         )),
//                   ],
//                 ),
//                 GestureDetector(
//                   onTap: () => Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                           builder: (_) => const AddLabourScreen())),
//                   child: Container(
//                     padding:
//                         const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
//                     decoration: BoxDecoration(
//                       color: AppColors.amber,
//                       borderRadius: BorderRadius.circular(20),
//                     ),
//                     child: Row(
//                       children: [
//                         const Icon(Icons.add, size: 16, color: AppColors.dark),
//                         const SizedBox(width: 4),
//                         Text('Add',
//                             style: GoogleFonts.poppins(
//                               fontSize: 12,
//                               fontWeight: FontWeight.w600,
//                               color: AppColors.dark,
//                             )),
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),

//           // Search
//           Padding(
//             padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
//             child: TextField(
//               onChanged: (v) => setState(() => _search = v),
//               style: GoogleFonts.poppins(fontSize: 13),
//               decoration: InputDecoration(
//                 hintText: 'Search labour entries...',
//                 filled: true,
//                 fillColor: AppColors.white,
//                 prefixIcon:
//                     const Icon(Icons.search, color: AppColors.grey, size: 20),
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(12),
//                   borderSide: const BorderSide(color: AppColors.border),
//                 ),
//                 enabledBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(12),
//                   borderSide: const BorderSide(color: AppColors.border),
//                 ),
//                 focusedBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(12),
//                   borderSide:
//                       const BorderSide(color: AppColors.amber, width: 2),
//                 ),
//                 contentPadding: const EdgeInsets.symmetric(vertical: 12),
//               ),
//             ),
//           ),

//           // Summary
//           Padding(
//             padding: const EdgeInsets.fromLTRB(16, 10, 16, 4),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text('${_filtered.length} entries',
//                     style: GoogleFonts.poppins(
//                         fontSize: 12,
//                         fontWeight: FontWeight.w500,
//                         color: AppColors.grey)),
//                 Text('Total: ${formatAmount(_totalAmount)}',
//                     style: GoogleFonts.poppins(
//                         fontSize: 13,
//                         fontWeight: FontWeight.w700,
//                         color: AppColors.orange)),
//               ],
//             ),
//           ),

//           Expanded(
//             child: ListView.builder(
//               padding: const EdgeInsets.fromLTRB(16, 4, 16, 16),
//               itemCount: _filtered.length,
//               itemBuilder: (_, i) => _LabourCard(labour: _filtered[i]),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// // ── Labour Card ───────────────────────────────────────────────────────────────

// class _LabourCard extends StatelessWidget {
//   final LabourModel labour;

//   const _LabourCard({required this.labour});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: const EdgeInsets.only(bottom: 10),
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: AppColors.white,
//         borderRadius: BorderRadius.circular(16),
//         border: Border.all(color: AppColors.border),
//       ),
//       child: Row(
//         children: [
//           Container(
//             width: 44,
//             height: 44,
//             decoration: BoxDecoration(
//               color: AppColors.redLight,
//               borderRadius: BorderRadius.circular(12),
//             ),
//             child: const Icon(Icons.people_alt_outlined,
//                 color: AppColors.red, size: 22),
//           ),
//           const SizedBox(width: 12),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(labour.labourType,
//                     style: GoogleFonts.poppins(
//                         fontSize: 13,
//                         fontWeight: FontWeight.w600,
//                         color: AppColors.dark)),
//                 const SizedBox(height: 3),
//                 Text(labour.remarks,
//                     style: GoogleFonts.poppins(
//                         fontSize: 11, color: AppColors.grey)),
//                 Text(labour.siteName,
//                     style: GoogleFonts.poppins(
//                         fontSize: 10, color: AppColors.greyLight)),
//               ],
//             ),
//           ),
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.end,
//             children: [
//               Text('₹${labour.amount.toInt()}',
//                   style: GoogleFonts.poppins(
//                       fontSize: 15,
//                       fontWeight: FontWeight.w700,
//                       color: AppColors.orange)),
//               const SizedBox(height: 4),
//               Text(labour.addedDate,
//                   style: GoogleFonts.poppins(
//                       fontSize: 10, color: AppColors.greyLight)),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }

// // ── Add Labour Screen ─────────────────────────────────────────────────────────

// class AddLabourScreen extends StatefulWidget {
//   const AddLabourScreen({super.key});

//   @override
//   State<AddLabourScreen> createState() => _AddLabourScreenState();
// }

// class _AddLabourScreenState extends State<AddLabourScreen> {
//   final _formKey = GlobalKey<FormState>();
//   final _amountController = TextEditingController();
//   final _remarksController = TextEditingController();
//   final _dateController = TextEditingController();
//   String? _selectedSite;
//   String? _selectedType;
//   bool _saving = false;

//   final _labourTypes = [
//     'Mason', 'Helper', 'Electrician', 'Plumber',
//     'Carpenter', 'Painter', 'Contractor', 'Welder',
//   ];
//   final _sites = sampleSites.map((s) => s.name).toList();

//   Future<void> _pickDate() async {
//     final picked = await showDatePicker(
//       context: context,
//       initialDate: DateTime.now(),
//       firstDate: DateTime(2020),
//       lastDate: DateTime(2030),
//       builder: (ctx, child) => Theme(
//         data: Theme.of(ctx).copyWith(
//           colorScheme: const ColorScheme.light(primary: AppColors.amber),
//         ),
//         child: child!,
//       ),
//     );
//     if (picked != null) {
//       _dateController.text =
//           '${picked.day.toString().padLeft(2, '0')} ${['Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'][picked.month - 1]} ${picked.year}';
//     }
//   }

//   void _save() async {
//     if (!_formKey.currentState!.validate()) return;
//     setState(() => _saving = true);
//     await Future.delayed(const Duration(seconds: 1));
//     setState(() => _saving = false);
//     if (!mounted) return;
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text('Labour entry saved!',
//             style: GoogleFonts.poppins(fontSize: 13)),
//         backgroundColor: AppColors.green,
//         behavior: SnackBarBehavior.floating,
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//       ),
//     );
//     Navigator.pop(context);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.greyBg,
//       body: Column(
//         children: [
//           Container(
//             color: AppColors.navy,
//             padding: EdgeInsets.only(
//               top: MediaQuery.of(context).padding.top + 8,
//               bottom: 16,
//               left: 8,
//               right: 16,
//             ),
//             child: Row(
//               children: [
//                 IconButton(
//                   onPressed: () => Navigator.pop(context),
//                   icon: const Icon(Icons.arrow_back_ios_new_rounded,
//                       color: AppColors.white, size: 18),
//                 ),
//                 Text('Add Labour Entry',
//                     style: GoogleFonts.poppins(
//                       fontSize: 17,
//                       fontWeight: FontWeight.w600,
//                       color: AppColors.white,
//                     )),
//               ],
//             ),
//           ),
//           Expanded(
//             child: SingleChildScrollView(
//               padding: const EdgeInsets.all(16),
//               child: Form(
//                 key: _formKey,
//                 child: Container(
//                   padding: const EdgeInsets.all(20),
//                   decoration: BoxDecoration(
//                     color: AppColors.white,
//                     borderRadius: BorderRadius.circular(20),
//                     border: Border.all(color: AppColors.border),
//                   ),
//                   child: Column(
//                     children: [
//                       AppTextField(
//                         label: 'Company',
//                         hint: '',
//                         controller: TextEditingController(
//                             text: 'BuildCo Constructions Pvt Ltd'),
//                         readOnly: true,
//                       ),
//                       AppDropdown(
//                         label: 'Site *',
//                         value: _selectedSite,
//                         items: _sites,
//                         onChanged: (v) => setState(() => _selectedSite = v),
//                       ),
//                       AppDropdown(
//                         label: 'Labour Type *',
//                         value: _selectedType,
//                         items: _labourTypes,
//                         onChanged: (v) => setState(() => _selectedType = v),
//                       ),
//                       AppTextField(
//                         label: 'Amount (₹) *',
//                         hint: '0.00',
//                         controller: _amountController,
//                         keyboardType: const TextInputType.numberWithOptions(
//                             decimal: true),
//                         validator: (v) => v!.isEmpty ? 'Required' : null,
//                       ),
//                       AppTextField(
//                         label: 'Remarks',
//                         hint: 'Payment details, work scope...',
//                         controller: _remarksController,
//                         maxLines: 3,
//                       ),
//                       AppTextField(
//                         label: 'Added Date *',
//                         hint: 'DD Mon YYYY',
//                         controller: _dateController,
//                         readOnly: true,
//                         onTap: _pickDate,
//                         suffixIcon: const Icon(Icons.calendar_today_outlined,
//                             size: 18, color: AppColors.grey),
//                         validator: (v) => v!.isEmpty ? 'Required' : null,
//                       ),
//                       AppButton(
//                           label: 'Save Labour Entry',
//                           onPressed: _save,
//                           isLoading: _saving),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }


import 'package:construction_app/models/models.dart';
import 'package:construction_app/widgets/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ViewLabourScreen extends StatelessWidget {
  final List<Site> sites;
 
  const ViewLabourScreen({super.key, required this.sites});
 
  @override
  Widget build(BuildContext context) {
    final allLabour = <LabourEntry>[];
 
    for (var site in sites) {
      for (var stage in site.stages) {
        allLabour.addAll(stage.labour);
        for (var sub in stage.subStages) {
          allLabour.addAll(sub.labour);
        }
      }
    }
 
    allLabour.sort((a, b) => b.date.compareTo(a.date));
 
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Labour'),
      ),
      body: allLabour.isEmpty
          ? const Center(child: Text('No labour entries found'))
          : ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: allLabour.length,
              itemBuilder: (context, index) {
                final labour = allLabour[index];
                return _LabourCard(labour: labour);
              },
            ),
    );
  }
}
 
class _LabourCard extends StatelessWidget {
  final LabourEntry labour;
 
  const _LabourCard({required this.labour});
 
  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.white,
      margin: const EdgeInsets.only(bottom: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    labour.type,
                    style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Color(0xFF1C1917)),
                  ),
                ),
                Text(
                  '₹${labour.amount.toStringAsFixed(0)}',
                  style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: Color(0xFF16A34A)),
                ),
              ],
            ),
            if (labour.workerName != null) ...[
              const SizedBox(height: 4),
              Text(
                labour.workerName!,
                style: const TextStyle(fontSize: 11, color: Color(0xFF9CA3AF)),
              ),
            ],
            if (labour.remarks != null) ...[
              const SizedBox(height: 4),
              Text(
                labour.remarks!,
                style: const TextStyle(fontSize: 11, color: Color(0xFF6B7280)),
              ),
            ],
            const SizedBox(height: 6),
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: const Color(0xFFDCFCE7),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    labour.siteName,
                    style: const TextStyle(fontSize: 9, fontWeight: FontWeight.w700, color: Color(0xFF15803D)),
                  ),
                ),
                const SizedBox(width: 6),
                Text(
                  labour.subStageName != null
                      ? '${labour.stageName} › ${labour.subStageName}'
                      : labour.stageName,
                  style: const TextStyle(fontSize: 10, color: Color(0xFF9CA3AF)),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              DateFormat('dd MMM yyyy').format(labour.date),
              style: const TextStyle(fontSize: 10, color: Color(0xFF9CA3AF)),
            ),
          ],
        ),
      ),
    );
  }
}

