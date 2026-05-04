// import 'package:construction_app/widgets/app_theme.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';

// class SupervisorReportsScreen extends StatelessWidget {
//   const SupervisorReportsScreen({super.key});
 
//   @override
//   Widget build(BuildContext context) {
//     // TODO: Fetch from API
//     final supervisors = [
//       {
//         'name': 'Anand Krishnan',
//         'sites': 3,
//         'totalBudget': 12500000.0,
//         'totalSpent': 8200000.0,
//         'totalReceived': 7500000.0,
//         'activeSites': 2,
//         'completedSites': 1,
//       },
//       {
//         'name': 'Rajan Kumar',
//         'sites': 2,
//         'totalBudget': 8000000.0,
//         'totalSpent': 4500000.0,
//         'totalReceived': 5000000.0,
//         'activeSites': 1,
//         'completedSites': 1,
//       },
//       {
//         'name': 'Priya Nair',
//         'sites': 4,
//         'totalBudget': 15000000.0,
//         'totalSpent': 12000000.0,
//         'totalReceived': 11000000.0,
//         'activeSites': 3,
//         'completedSites': 1,
//       },
//     ];
 
//     return Scaffold(
//       backgroundColor: AppColors.greyBg,
//       body: Column(
//         children: [
//           _buildHeader(context, 'Supervisor Reports',
//               'Performance by supervisor'),
//           Expanded(
//             child: ListView.builder(
//               padding: const EdgeInsets.all(16),
//               itemCount: supervisors.length,
//               itemBuilder: (_, i) {
//                 final sup = supervisors[i];
//                 return _SupervisorCard(
//                   supervisor: sup,
//                   onTap: () => Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (_) =>
//                           SupervisorDetailScreen(supervisor: sup),
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
 
// class _SupervisorCard extends StatelessWidget {
//   final Map<String, dynamic> supervisor;
//   final VoidCallback onTap;
 
//   const _SupervisorCard({required this.supervisor, required this.onTap});
 
//   @override
//   Widget build(BuildContext context) {
//     final budget = supervisor['totalBudget'] as double;
//     final spent = supervisor['totalSpent'] as double;
//     final received = supervisor['totalReceived'] as double;
//     final utilizationPercent = (spent / budget * 100).clamp(0, 100);
 
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
//               child: Row(
//                 children: [
//                   Container(
//                     width: 48,
//                     height: 48,
//                     decoration: BoxDecoration(
//                       color: AppColors.blueLight,
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                     child: Center(
//                       child: Text(
//                         supervisor['name'].toString().split(' ').map((n) => n[0]).join(),
//                         style: GoogleFonts.poppins(
//                             fontSize: 15,
//                             fontWeight: FontWeight.w700,
//                             color: AppColors.blue),
//                       ),
//                     ),
//                   ),
//                   const SizedBox(width: 12),
//                   Expanded(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(supervisor['name'],
//                             style: GoogleFonts.poppins(
//                               fontSize: 14,
//                               fontWeight: FontWeight.w600,
//                               color: AppColors.dark,
//                             )),
//                         const SizedBox(height: 2),
//                         Text('${supervisor['sites']} sites assigned',
//                             style: GoogleFonts.poppins(
//                                 fontSize: 11, color: AppColors.grey)),
//                       ],
//                     ),
//                   ),
//                   const Icon(Icons.arrow_forward_ios,
//                       size: 16, color: AppColors.greyLight),
//                 ],
//               ),
//             ),
//             Container(
//               decoration: const BoxDecoration(
//                 border: Border(top: BorderSide(color: AppColors.borderLight)),
//               ),
//               padding: const EdgeInsets.all(14),
//               child: Column(
//                 children: [
//                   Row(
//                     children: [
//                       Expanded(
//                         child: _MiniStat(
//                           label: 'Budget',
//                           value: _formatAmt(budget),
//                           color: AppColors.blue,
//                         ),
//                       ),
//                       Expanded(
//                         child: _MiniStat(
//                           label: 'Spent',
//                           value: _formatAmt(spent),
//                           color: AppColors.orange,
//                         ),
//                       ),
//                       Expanded(
//                         child: _MiniStat(
//                           label: 'Received',
//                           value: _formatAmt(received),
//                           color: AppColors.green,
//                         ),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 10),
//                   Row(
//                     children: [
//                       Text('Utilization: ',
//                           style: GoogleFonts.poppins(
//                               fontSize: 11, color: AppColors.grey)),
//                       Text('${utilizationPercent.toStringAsFixed(1)}%',
//                           style: GoogleFonts.poppins(
//                               fontSize: 11,
//                               fontWeight: FontWeight.w600,
//                               color: AppColors.dark)),
//                       const SizedBox(width: 8),
//                       Expanded(
//                         child: ClipRRect(
//                           borderRadius: BorderRadius.circular(4),
//                           child: LinearProgressIndicator(
//                             value: utilizationPercent / 100,
//                             backgroundColor: AppColors.greyBg,
//                             valueColor: AlwaysStoppedAnimation(
//                               utilizationPercent > 90
//                                   ? AppColors.red
//                                   : utilizationPercent > 75
//                                       ? AppColors.orange
//                                       : AppColors.green,
//                             ),
//                             minHeight: 6,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }