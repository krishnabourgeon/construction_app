// import 'package:construction_app/widgets/app_theme.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';

// class StageWiseReportsScreen extends StatelessWidget {
//   const StageWiseReportsScreen({super.key});
 
//   @override
//   Widget build(BuildContext context) {
//     // TODO: Fetch from API with site filter
//     return Scaffold(
//       backgroundColor: AppColors.greyBg,
//       body: Column(
//         children: [
//           _buildHeader(context, 'Stage-wise Reports',
//               'Materials & labour breakdown'),
          
//           // Site selector
//           Container(
//             color: AppColors.white,
//             padding: const EdgeInsets.all(16),
//             child: DropdownButtonFormField<String>(
//               value: 'all',
//               decoration: InputDecoration(
//                 labelText: 'Select Site',
//                 filled: true,
//                 fillColor: AppColors.greyFill,
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(10),
//                   borderSide: const BorderSide(color: AppColors.border),
//                 ),
//               ),
//               items: const [
//                 DropdownMenuItem(value: 'all', child: Text('All Sites')),
//                 DropdownMenuItem(
//                     value: '1', child: Text('Sunrise Residency')),
//                 DropdownMenuItem(
//                     value: '2', child: Text('Metro Commercial Plaza')),
//               ],
//               onChanged: (v) {
//                 // TODO: Filter stages by site
//               },
//             ),
//           ),
 
//           Expanded(
//             child: ListView(
//               padding: const EdgeInsets.all(16),
//               children: [
//                 _StageReportCard(
//                   stage: {
//                     'name': 'Foundation Work',
//                     'siteName': 'Sunrise Residency',
//                     'status': 'Done',
//                     'totalSpent': 320000.0,
//                     'materialSpent': 200000.0,
//                     'labourSpent': 120000.0,
//                     'materialCount': 8,
//                     'labourCount': 5,
//                   },
//                 ),
//                 const SizedBox(height: 12),
//                 _StageReportCard(
//                   stage: {
//                     'name': 'Column & Slab',
//                     'siteName': 'Sunrise Residency',
//                     'status': 'Active',
//                     'totalSpent': 580000.0,
//                     'materialSpent': 420000.0,
//                     'labourSpent': 160000.0,
//                     'materialCount': 12,
//                     'labourCount': 8,
//                   },
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
 
// class _StageReportCard extends StatelessWidget {
//   final Map<String, dynamic> stage;
 
//   const _StageReportCard({required this.stage});
 
//   @override
//   Widget build(BuildContext context) {
//     final totalSpent = stage['totalSpent'] as double;
//     final materialSpent = stage['materialSpent'] as double;
//     final labourSpent = stage['labourSpent'] as double;
//     final materialPercent = (materialSpent / totalSpent * 100);
//     final labourPercent = (labourSpent / totalSpent * 100);
 
//     return Container(
//       decoration: BoxDecoration(
//         color: AppColors.white,
//         borderRadius: BorderRadius.circular(14),
//         border: Border.all(color: AppColors.border, width: 1.5),
//       ),
//       padding: const EdgeInsets.all(14),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(stage['name'],
//                         style: GoogleFonts.poppins(
//                           fontSize: 14,
//                           fontWeight: FontWeight.w600,
//                           color: AppColors.dark,
//                         )),
//                     const SizedBox(height: 2),
//                     Text(stage['siteName'],
//                         style: GoogleFonts.poppins(
//                             fontSize: 11, color: AppColors.grey)),
//                   ],
//                 ),
//               ),
//               _StatusBadge(status: stage['status']),
//             ],
//           ),
//           const SizedBox(height: 12),
//           Container(
//             padding: const EdgeInsets.all(12),
//             decoration: BoxDecoration(
//               color: const Color(0xFFFEF9C3),
//               borderRadius: BorderRadius.circular(10),
//               border: Border.all(color: const Color(0xFFFDE047)),
//             ),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Text('Total Spent: ',
//                     style: GoogleFonts.poppins(
//                         fontSize: 12, color: const Color(0xFF854D0E))),
//                 Text(_formatAmt(totalSpent),
//                     style: GoogleFonts.poppins(
//                       fontSize: 15,
//                       fontWeight: FontWeight.w700,
//                       color: const Color(0xFF854D0E),
//                     )),
//               ],
//             ),
//           ),
//           const SizedBox(height: 12),
          
//           // Materials
//           Row(
//             children: [
//               Container(
//                 width: 32,
//                 height: 32,
//                 decoration: BoxDecoration(
//                   color: AppColors.amberLight,
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//                 child: const Icon(Icons.inventory_2,
//                     size: 16, color: AppColors.amberDark),
//               ),
//               const SizedBox(width: 10),
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text('Materials (${stage['materialCount']})',
//                             style: GoogleFonts.poppins(
//                                 fontSize: 12,
//                                 fontWeight: FontWeight.w600,
//                                 color: AppColors.dark)),
//                         Text(_formatAmt(materialSpent),
//                             style: GoogleFonts.poppins(
//                               fontSize: 13,
//                               fontWeight: FontWeight.w700,
//                               color: AppColors.orange,
//                             )),
//                       ],
//                     ),
//                     const SizedBox(height: 4),
//                     Row(
//                       children: [
//                         Expanded(
//                           child: ClipRRect(
//                             borderRadius: BorderRadius.circular(4),
//                             child: LinearProgressIndicator(
//                               value: materialPercent / 100,
//                               backgroundColor: AppColors.greyBg,
//                               valueColor: const AlwaysStoppedAnimation(
//                                   AppColors.amberDark),
//                               minHeight: 5,
//                             ),
//                           ),
//                         ),
//                         const SizedBox(width: 8),
//                         Text('${materialPercent.toStringAsFixed(0)}%',
//                             style: GoogleFonts.poppins(
//                                 fontSize: 10, color: AppColors.grey)),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//           const SizedBox(height: 10),
          
//           // Labour
//           Row(
//             children: [
//               Container(
//                 width: 32,
//                 height: 32,
//                 decoration: BoxDecoration(
//                   color: AppColors.greenLight,
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//                 child: const Icon(Icons.groups,
//                     size: 16, color: AppColors.green),
//               ),
//               const SizedBox(width: 10),
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text('Labour (${stage['labourCount']})',
//                             style: GoogleFonts.poppins(
//                                 fontSize: 12,
//                                 fontWeight: FontWeight.w600,
//                                 color: AppColors.dark)),
//                         Text(_formatAmt(labourSpent),
//                             style: GoogleFonts.poppins(
//                               fontSize: 13,
//                               fontWeight: FontWeight.w700,
//                               color: AppColors.orange,
//                             )),
//                       ],
//                     ),
//                     const SizedBox(height: 4),
//                     Row(
//                       children: [
//                         Expanded(
//                           child: ClipRRect(
//                             borderRadius: BorderRadius.circular(4),
//                             child: LinearProgressIndicator(
//                               value: labourPercent / 100,
//                               backgroundColor: AppColors.greyBg,
//                               valueColor: const AlwaysStoppedAnimation(
//                                   AppColors.green),
//                               minHeight: 5,
//                             ),
//                           ),
//                         ),
//                         const SizedBox(width: 8),
//                         Text('${labourPercent.toStringAsFixed(0)}%',
//                             style: GoogleFonts.poppins(
//                                 fontSize: 10, color: AppColors.grey)),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }
 