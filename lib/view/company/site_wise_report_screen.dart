// import 'package:construction_app/view/company/widgets/site_card.dart';
// import 'package:construction_app/widgets/app_theme.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';

// class SiteWiseReportsScreen extends StatelessWidget {
//   const SiteWiseReportsScreen({super.key});
 
//   @override
//   Widget build(BuildContext context) {
//     // TODO: Fetch from API
//     final sites = [
//       {
//         'id': '1',
//         'name': 'Sunrise Residency',
//         'supervisor': 'Anand Krishnan',
//         'status': 'Active',
//         'estimatedAmount': 4500000.0,
//         'totalSpent': 2880000.0,
//         'totalReceived': 3200000.0,
//         'materialSpent': 1920000.0,
//         'labourSpent': 960000.0,
//         'stages': 4,
//         'completedStages': 1,
//       },
//       {
//         'id': '2',
//         'name': 'Metro Commercial Plaza',
//         'supervisor': 'Rajan Kumar',
//         'status': 'On Hold',
//         'estimatedAmount': 12000000.0,
//         'totalSpent': 1800000.0,
//         'totalReceived': 2000000.0,
//         'materialSpent': 1200000.0,
//         'labourSpent': 600000.0,
//         'stages': 3,
//         'completedStages': 0,
//       },
//     ];
 
//     return Scaffold(
//       backgroundColor: AppColors.greyBg,
//       body: Column(
//         children: [
//           _buildHeader(context, 'Site-wise Reports', 'Financial breakdown by site'),
//           Expanded(
//             child: ListView.builder(
//               padding: const EdgeInsets.all(16),
//               itemCount: sites.length,
//               itemBuilder: (_, i) {
//                 final site = sites[i];
//                 return _SiteReportCard(
//                   site: site,
//                   onTap: () => Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (_) => SiteDetailReportScreen(site: site),
//                     ),
//                   ),
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
 
// class _SiteReportCard extends StatelessWidget {
//   final Map<String, dynamic> site;
//   final VoidCallback onTap;
 
//   const _SiteReportCard({required this.site, required this.onTap});
 
//   @override
//   Widget build(BuildContext context) {
//     final estimated = site['estimatedAmount'] as double;
//     final spent = site['totalSpent'] as double;
//     final received = site['totalReceived'] as double;
//     final balance = received - spent;
//     final spentPercent = (spent / estimated * 100).clamp(0, 100);
 
//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         margin: const EdgeInsets.only(bottom: 12),
//         decoration: BoxDecoration(
//           color: AppColors.white,
//           borderRadius: BorderRadius.circular(14),
//           border: Border.all(color: AppColors.border, width: 1.5),
//         ),
//         child: Column(
//           children: [
//             Padding(
//               padding: const EdgeInsets.all(14),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Row(
//                     children: [
//                       Expanded(
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(site['name'],
//                                 style: GoogleFonts.poppins(
//                                   fontSize: 14,
//                                   fontWeight: FontWeight.w600,
//                                   color: AppColors.dark,
//                                 )),
//                             const SizedBox(height: 4),
//                             Text('Supervisor: ${site['supervisor']}',
//                                 style: GoogleFonts.poppins(
//                                     fontSize: 11, color: AppColors.grey)),
//                           ],
//                         ),
//                       ),
//                       StatusBadge(status: site['status']),
//                     ],
//                   ),
//                   const SizedBox(height: 12),
//                   Container(
//                     padding: const EdgeInsets.all(12),
//                     decoration: BoxDecoration(
//                       color: AppColors.greyBg,
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                     child: Row(
//                       children: [
//                         Expanded(
//                           child: _MiniStat(
//                             label: 'Estimated',
//                             value: _formatAmt(estimated),
//                             color: AppColors.blue,
//                           ),
//                         ),
//                         Expanded(
//                           child: _MiniStat(
//                             label: 'Spent',
//                             value: _formatAmt(spent),
//                             color: AppColors.orange,
//                           ),
//                         ),
//                         Expanded(
//                           child: _MiniStat(
//                             label: 'Received',
//                             value: _formatAmt(received),
//                             color: AppColors.green,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   const SizedBox(height: 10),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Row(
//                         children: [
//                           Text('Balance: ',
//                               style: GoogleFonts.poppins(
//                                   fontSize: 11, color: AppColors.grey)),
//                           Text(_formatAmt(balance),
//                               style: GoogleFonts.poppins(
//                                 fontSize: 12,
//                                 fontWeight: FontWeight.w700,
//                                 color: balance >= 0
//                                     ? AppColors.green
//                                     : AppColors.red,
//                               )),
//                         ],
//                       ),
//                       Text('${site['completedStages']}/${site['stages']} stages done',
//                           style: GoogleFonts.poppins(
//                               fontSize: 11, color: AppColors.greyLight)),
//                     ],
//                   ),
//                   const SizedBox(height: 6),
//                   ClipRRect(
//                     borderRadius: BorderRadius.circular(4),
//                     child: LinearProgressIndicator(
//                       value: spentPercent / 100,
//                       backgroundColor: AppColors.greyBg,
//                       valueColor: AlwaysStoppedAnimation(
//                         spentPercent > 100
//                             ? AppColors.red
//                             : spentPercent > 90
//                                 ? AppColors.orange
//                                 : AppColors.green,
//                       ),
//                       minHeight: 6,
//                     ),
//                   ),
//                   const SizedBox(height: 4),
//                   Text('${spentPercent.toStringAsFixed(1)}% of budget utilized',
//                       style: GoogleFonts.poppins(
//                           fontSize: 10, color: AppColors.greyLight)),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }