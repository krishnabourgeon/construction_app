// import 'package:construction_app/view/company/widgets/site_card.dart';
// import 'package:construction_app/widgets/app_theme.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';

// class SupervisorDetailScreen extends StatelessWidget {
//   final Map<String, dynamic> supervisor;
 
//   const SupervisorDetailScreen({super.key, required this.supervisor});
 
//   @override
//   Widget build(BuildContext context) {
//     // TODO: Fetch detailed data from API
//     final sites = [
//       {
//         'name': 'Sunrise Residency',
//         'status': 'Active',
//         'budget': 4500000.0,
//         'spent': 2880000.0,
//         'received': 3200000.0,
//       },
//       {
//         'name': 'Green Valley Villas',
//         'status': 'Completed',
//         'budget': 7800000.0,
//         'spent': 7800000.0,
//         'received': 7500000.0,
//       },
//     ];
 
//     return Scaffold(
//       backgroundColor: AppColors.greyBg,
//       body: Column(
//         children: [
//           _buildHeader(context, supervisor['name'], 'Supervisor Performance'),
          
//           // Summary Cards
//           Padding(
//             padding: const EdgeInsets.all(16),
//             child: Column(
//               children: [
//                 Row(
//                   children: [
//                     Expanded(
//                       child: _SummaryCard(
//                         label: 'Total Budget',
//                         value: _formatAmt(supervisor['totalBudget']),
//                         color: AppColors.blue,
//                       ),
//                     ),
//                     const SizedBox(width: 10),
//                     Expanded(
//                       child: _SummaryCard(
//                         label: 'Total Spent',
//                         value: _formatAmt(supervisor['totalSpent']),
//                         color: AppColors.orange,
//                       ),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 10),
//                 Row(
//                   children: [
//                     Expanded(
//                       child: _SummaryCard(
//                         label: 'Total Received',
//                         value: _formatAmt(supervisor['totalReceived']),
//                         color: AppColors.green,
//                       ),
//                     ),
//                     const SizedBox(width: 10),
//                     Expanded(
//                       child: _SummaryCard(
//                         label: 'Active Sites',
//                         value: '${supervisor['activeSites']}',
//                         color: AppColors.amber,
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
 
//           // Sites List
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 16),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text('Assigned Sites',
//                     style: GoogleFonts.poppins(
//                       fontSize: 14,
//                       fontWeight: FontWeight.w600,
//                       color: AppColors.dark,
//                     )),
//                 TextButton.icon(
//                   onPressed: () {
//                     // TODO: Generate PDF report
//                   },
//                   icon: const Icon(Icons.file_download, size: 16),
//                   label: const Text('Export PDF'),
//                   style: TextButton.styleFrom(
//                     foregroundColor: AppColors.blue,
//                   ),
//                 ),
//               ],
//             ),
//           ),
 
//           Expanded(
//             child: ListView.builder(
//               padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
//               itemCount: sites.length,
//               itemBuilder: (_, i) {
//                 final site = sites[i];
//                 return Container(
//                   margin: const EdgeInsets.only(bottom: 10),
//                   decoration: BoxDecoration(
//                     color: AppColors.white,
//                     borderRadius: BorderRadius.circular(12),
//                     border: Border.all(color: AppColors.border, width: 1.5),
//                   ),
//                   padding: const EdgeInsets.all(12),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text(site['name'] as String,
//                               style: GoogleFonts.poppins(
//                                 fontSize: 13,
//                                 fontWeight: FontWeight.w600,
//                                 color: AppColors.dark,
//                               )),
//                           StatusBadge(status: site['status'] as String),
//                         ],
//                       ),
//                       const SizedBox(height: 8),
//                       Row(
//                         children: [
//                           Expanded(
//                             child: _MiniStat(
//                               label: 'Budget',
//                               value: _formatAmt(site['budget']),
//                               color: AppColors.blue,
//                             ),
//                           ),
//                           Expanded(
//                             child: _MiniStat(
//                               label: 'Spent',
//                               value: _formatAmt(site['spent']),
//                               color: AppColors.orange,
//                             ),
//                           ),
//                           Expanded(
//                             child: _MiniStat(
//                               label: 'Received',
//                               value: _formatAmt(site['received']),
//                               color: AppColors.green,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ],
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



// class SupervisorDetailScreen extends StatelessWidget {
//   final Map<String, dynamic> supervisor;
 
//   const SupervisorDetailScreen({super.key, required this.supervisor});
 
//   @override
//   Widget build(BuildContext context) {
//     // TODO: Fetch detailed data from API
//     final sites = [
//       {
//         'name': 'Sunrise Residency',
//         'status': 'Active',
//         'budget': 4500000.0,
//         'spent': 2880000.0,
//         'received': 3200000.0,
//       },
//       {
//         'name': 'Green Valley Villas',
//         'status': 'Completed',
//         'budget': 7800000.0,
//         'spent': 7800000.0,
//         'received': 7500000.0,
//       },
//     ];
 
//     return Scaffold(
//       backgroundColor: AppColors.greyBg,
//       body: Column(
//         children: [
//           _buildHeader(context, supervisor['name'], 'Supervisor Performance'),
          
//           // Summary Cards
//           Padding(
//             padding: const EdgeInsets.all(16),
//             child: Column(
//               children: [
//                 Row(
//                   children: [
//                     Expanded(
//                       child: _SummaryCard(
//                         label: 'Total Budget',
//                         value: _formatAmt(supervisor['totalBudget']),
//                         color: AppColors.blue,
//                       ),
//                     ),
//                     const SizedBox(width: 10),
//                     Expanded(
//                       child: _SummaryCard(
//                         label: 'Total Spent',
//                         value: _formatAmt(supervisor['totalSpent']),
//                         color: AppColors.orange,
//                       ),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 10),
//                 Row(
//                   children: [
//                     Expanded(
//                       child: _SummaryCard(
//                         label: 'Total Received',
//                         value: _formatAmt(supervisor['totalReceived']),
//                         color: AppColors.green,
//                       ),
//                     ),
//                     const SizedBox(width: 10),
//                     Expanded(
//                       child: _SummaryCard(
//                         label: 'Active Sites',
//                         value: '${supervisor['activeSites']}',
//                         color: AppColors.amber,
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
 
//           // Sites List
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 16),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text('Assigned Sites',
//                     style: GoogleFonts.poppins(
//                       fontSize: 14,
//                       fontWeight: FontWeight.w600,
//                       color: AppColors.dark,
//                     )),
//                 TextButton.icon(
//                   onPressed: () {
//                     // TODO: Generate PDF report
//                   },
//                   icon: const Icon(Icons.file_download, size: 16),
//                   label: const Text('Export PDF'),
//                   style: TextButton.styleFrom(
//                     foregroundColor: AppColors.blue,
//                   ),
//                 ),
//               ],
//             ),
//           ),
 
//           Expanded(
//             child: ListView.builder(
//               padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
//               itemCount: sites.length,
//               itemBuilder: (_, i) {
//                 final site = sites[i];
//                 return Container(
//                   margin: const EdgeInsets.only(bottom: 10),
//                   decoration: BoxDecoration(
//                     color: AppColors.white,
//                     borderRadius: BorderRadius.circular(12),
//                     border: Border.all(color: AppColors.border, width: 1.5),
//                   ),
//                   padding: const EdgeInsets.all(12),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text(site['name'],
//                               style: GoogleFonts.poppins(
//                                 fontSize: 13,
//                                 fontWeight: FontWeight.w600,
//                                 color: AppColors.dark,
//                               )),
//                           _StatusBadge(status: site['status']),
//                         ],
//                       ),
//                       const SizedBox(height: 8),
//                       Row(
//                         children: [
//                           Expanded(
//                             child: _MiniStat(
//                               label: 'Budget',
//                               value: _formatAmt(site['budget']),
//                               color: AppColors.blue,
//                             ),
//                           ),
//                           Expanded(
//                             child: _MiniStat(
//                               label: 'Spent',
//                               value: _formatAmt(site['spent']),
//                               color: AppColors.orange,
//                             ),
//                           ),
//                           Expanded(
//                             child: _MiniStat(
//                               label: 'Received',
//                               value: _formatAmt(site['received']),
//                               color: AppColors.green,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ],
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
 
// // ══════════════════════════════════════════════════════════════════════════════
// // SITE DETAIL REPORT SCREEN
// // ══════════════════════════════════════════════════════════════════════════════
 
// class SiteDetailReportScreen extends StatelessWidget {
//   final Map<String, dynamic> site;
 
//   const SiteDetailReportScreen({super.key, required this.site});
 
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.greyBg,
//       body: Column(
//         children: [
//           _buildHeader(context, site['name'], 'Detailed Financial Report'),
          
//           Expanded(
//             child: SingleChildScrollView(
//               padding: const EdgeInsets.all(16),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   // Financial Summary
//                   Container(
//                     decoration: BoxDecoration(
//                       gradient: const LinearGradient(
//                         colors: [Color(0xFF3B82F6), Color(0xFF1D4ED8)],
//                       ),
//                       borderRadius: BorderRadius.circular(14),
//                     ),
//                     padding: const EdgeInsets.all(16),
//                     child: Column(
//                       children: [
//                         _buildWhiteStat('Estimated Budget',
//                             _formatAmt(site['estimatedAmount'])),
//                         const Divider(color: Colors.white24, height: 20),
//                         _buildWhiteStat('Total Spent',
//                             _formatAmt(site['totalSpent'])),
//                         const Divider(color: Colors.white24, height: 20),
//                         _buildWhiteStat('Total Received',
//                             _formatAmt(site['totalReceived'])),
//                         const Divider(color: Colors.white24, height: 20),
//                         _buildWhiteStat(
//                           'Balance',
//                           _formatAmt(site['totalReceived'] - site['totalSpent']),
//                           valueColor: (site['totalReceived'] - site['totalSpent']) >= 0
//                               ? AppColors.greenLight
//                               : AppColors.redLight,
//                         ),
//                       ],
//                     ),
//                   ),
//                   const SizedBox(height: 16),
 
//                   // Material & Labour Breakdown
//                   Text('Expense Breakdown',
//                       style: GoogleFonts.poppins(
//                         fontSize: 14,
//                         fontWeight: FontWeight.w600,
//                         color: AppColors.dark,
//                       )),
//                   const SizedBox(height: 10),
//                   Row(
//                     children: [
//                       Expanded(
//                         child: Container(
//                           padding: const EdgeInsets.all(14),
//                           decoration: BoxDecoration(
//                             color: AppColors.amberLight,
//                             borderRadius: BorderRadius.circular(12),
//                             border: Border.all(
//                                 color: AppColors.amberDark, width: 1.5),
//                           ),
//                           child: Column(
//                             children: [
//                               const Icon(Icons.inventory_2,
//                                   color: AppColors.amberDark, size: 28),
//                               const SizedBox(height: 6),
//                               Text('Materials',
//                                   style: GoogleFonts.poppins(
//                                       fontSize: 11,
//                                       fontWeight: FontWeight.w600,
//                                       color: AppColors.amberDark)),
//                               const SizedBox(height: 2),
//                               Text(_formatAmt(site['materialSpent']),
//                                   style: GoogleFonts.poppins(
//                                     fontSize: 15,
//                                     fontWeight: FontWeight.w700,
//                                     color: AppColors.amberDark,
//                                   )),
//                             ],
//                           ),
//                         ),
//                       ),
//                       const SizedBox(width: 12),
//                       Expanded(
//                         child: Container(
//                           padding: const EdgeInsets.all(14),
//                           decoration: BoxDecoration(
//                             color: AppColors.greenLight,
//                             borderRadius: BorderRadius.circular(12),
//                             border: Border.all(
//                                 color: AppColors.green, width: 1.5),
//                           ),
//                           child: Column(
//                             children: [
//                               const Icon(Icons.groups,
//                                   color: AppColors.green, size: 28),
//                               const SizedBox(height: 6),
//                               Text('Labour',
//                                   style: GoogleFonts.poppins(
//                                       fontSize: 11,
//                                       fontWeight: FontWeight.w600,
//                                       color: AppColors.green)),
//                               const SizedBox(height: 2),
//                               Text(_formatAmt(site['labourSpent']),
//                                   style: GoogleFonts.poppins(
//                                     fontSize: 15,
//                                     fontWeight: FontWeight.w700,
//                                     color: AppColors.green,
//                                   )),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 16),
 
//                   // Stages Progress
//                   Text('Project Progress',
//                       style: GoogleFonts.poppins(
//                         fontSize: 14,
//                         fontWeight: FontWeight.w600,
//                         color: AppColors.dark,
//                       )),
//                   const SizedBox(height: 10),
//                   Container(
//                     padding: const EdgeInsets.all(14),
//                     decoration: BoxDecoration(
//                       color: AppColors.white,
//                       borderRadius: BorderRadius.circular(12),
//                       border: Border.all(color: AppColors.border, width: 1.5),
//                     ),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceAround,
//                       children: [
//                         _ProgressCircle(
//                           label: 'Completed',
//                           value: site['completedStages'],
//                           total: site['stages'],
//                           color: AppColors.green,
//                         ),
//                         _ProgressCircle(
//                           label: 'In Progress',
//                           value: site['stages'] - site['completedStages'],
//                           total: site['stages'],
//                           color: AppColors.orange,
//                         ),
//                         _ProgressCircle(
//                           label: 'Budget Used',
//                           value: ((site['totalSpent'] / site['estimatedAmount']) *
//                                   100)
//                               .toInt(),
//                           total: 100,
//                           color: AppColors.blue,
//                           suffix: '%',
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//       floatingActionButton: FloatingActionButton.extended(
//         onPressed: () => _generatePDFReport(context, site),
//         backgroundColor: AppColors.blue,
//         icon: const Icon(Icons.picture_as_pdf),
//         label: Text('Export PDF',
//             style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
//       ),
//     );
//   }
 
//   Widget _buildWhiteStat(String label, String value,
//       {Color? valueColor}) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Text(label,
//             style: GoogleFonts.poppins(
//                 fontSize: 13,
//                 color: Colors.white.withOpacity(0.9),
//                 fontWeight: FontWeight.w500)),
//         Text(value,
//             style: GoogleFonts.poppins(
//               fontSize: 15,
//               fontWeight: FontWeight.w700,
//               color: valueColor ?? AppColors.white,
//             )),
//       ],
//     );
//   }
// }
 
// // ══════════════════════════════════════════════════════════════════════════════
// // CONSOLIDATED REPORT SCREEN
// // ══════════════════════════════════════════════════════════════════════════════
 
// class ConsolidatedReportScreen extends StatelessWidget {
//   const ConsolidatedReportScreen({super.key});
 
//   @override
//   Widget build(BuildContext context) {
//     // TODO: Fetch company-wide data from API
//     return Scaffold(
//       backgroundColor: AppColors.greyBg,
//       body: Column(
//         children: [
//           _buildHeader(context, 'Consolidated Report',
//               'Company-wide financial overview'),
          
//           Expanded(
//             child: SingleChildScrollView(
//               padding: const EdgeInsets.all(16),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   // Overall Stats
//                   _buildStatCard('Total Projects', '12', Icons.domain,
//                       AppColors.blue),
//                   const SizedBox(height: 10),
//                   _buildStatCard('Active Sites', '7', Icons.construction,
//                       AppColors.orange),
//                   const SizedBox(height: 10),
//                   _buildStatCard('Total Budget', '₹45.2Cr',
//                       Icons.account_balance_wallet, AppColors.green),
//                   const SizedBox(height: 10),
//                   _buildStatCard('Total Spent', '₹28.5Cr', Icons.trending_down,
//                       AppColors.red),
//                   const SizedBox(height: 10),
//                   _buildStatCard('Total Received', '₹32.1Cr',
//                       Icons.trending_up, AppColors.purple),
//                   const SizedBox(height: 20),
 
//                   // Charts placeholder
//                   Container(
//                     height: 200,
//                     decoration: BoxDecoration(
//                       color: AppColors.white,
//                       borderRadius: BorderRadius.circular(14),
//                       border: Border.all(color: AppColors.border, width: 1.5),
//                     ),
//                     child: Center(
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           const Icon(Icons.bar_chart,
//                               size: 48, color: AppColors.greyLight),
//                           const SizedBox(height: 10),
//                           Text('Charts & Analytics',
//                               style: GoogleFonts.poppins(
//                                   fontSize: 13, color: AppColors.grey)),
//                           Text('Coming soon',
//                               style: GoogleFonts.poppins(
//                                   fontSize: 11, color: AppColors.greyLight)),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
 
//   Widget _buildStatCard(
//       String label, String value, IconData icon, Color color) {
//     return Container(
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: AppColors.white,
//         borderRadius: BorderRadius.circular(12),
//         border: Border.all(color: AppColors.border, width: 1.5),
//       ),
//       child: Row(
//         children: [
//           Container(
//             padding: const EdgeInsets.all(12),
//             decoration: BoxDecoration(
//               color: color.withOpacity(0.1),
//               borderRadius: BorderRadius.circular(10),
//             ),
//             child: Icon(icon, color: color, size: 24),
//           ),
//           const SizedBox(width: 14),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(label,
//                     style: GoogleFonts.poppins(
//                         fontSize: 12, color: AppColors.grey)),
//                 Text(value,
//                     style: GoogleFonts.poppins(
//                       fontSize: 18,
//                       fontWeight: FontWeight.w700,
//                       color: AppColors.dark,
//                     )),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
 
// // ══════════════════════════════════════════════════════════════════════════════
// // HELPER WIDGETS
// // ══════════════════════════════════════════════════════════════════════════════
 
// Widget _buildHeader(BuildContext context, String title, String subtitle) {
//   return Container(
//     decoration: const BoxDecoration(
//       gradient: LinearGradient(
//         begin: Alignment.topLeft,
//         end: Alignment.bottomRight,
//         colors: [Color(0xFF1A1A2E), Color(0xFF16213E)],
//       ),
//     ),
//     padding: EdgeInsets.only(
//       top: MediaQuery.of(context).padding.top + 12,
//       bottom: 16,
//       left: 16,
//       right: 16,
//     ),
//     child: Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         GestureDetector(
//           onTap: () => Navigator.pop(context),
//           child: Row(
//             children: [
//               const Icon(Icons.arrow_back_ios_new,
//                   size: 14, color: AppColors.greyLight),
//               const SizedBox(width: 5),
//               Text('Reports',
//                   style: GoogleFonts.poppins(
//                       fontSize: 11, color: AppColors.greyLight)),
//             ],
//           ),
//         ),
//         const SizedBox(height: 10),
//         Text(title,
//             style: GoogleFonts.poppins(
//               fontSize: 18,
//               fontWeight: FontWeight.w700,
//               color: AppColors.white,
//             )),
//         const SizedBox(height: 2),
//         Text(subtitle,
//             style: GoogleFonts.poppins(fontSize: 11, color: AppColors.grey)),
//       ],
//     ),
//   );
// }
 
// class _StatusBadge extends StatelessWidget {
//   final String status;
//   const _StatusBadge({required this.status});
 
//   @override
//   Widget build(BuildContext context) {
//     Color bg, fg;
//     switch (status) {
//       case 'Active':
//         bg = AppColors.greenLight;
//         fg = AppColors.green;
//         break;
//       case 'Completed':
//         bg = AppColors.blueLight;
//         fg = AppColors.blue;
//         break;
//       case 'On Hold':
//         bg = AppColors.orangeLight;
//         fg = AppColors.orange;
//         break;
//       default:
//         bg = AppColors.greyBg;
//         fg = AppColors.grey;
//     }
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//       decoration: BoxDecoration(
//         color: bg,
//         borderRadius: BorderRadius.circular(8),
//       ),
//       child: Text(status,
//           style: GoogleFonts.poppins(
//               fontSize: 10, fontWeight: FontWeight.w600, color: fg)),
//     );
//   }
// }
 
// class _MiniStat extends StatelessWidget {
//   final String label;
//   final String value;
//   final Color color;
 
//   const _MiniStat(
//       {required this.label, required this.value, required this.color});
 
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.center,
//       children: [
//         Text(label,
//             style:
//                 GoogleFonts.poppins(fontSize: 10, color: AppColors.greyLight)),
//         const SizedBox(height: 2),
//         Text(value,
//             style: GoogleFonts.poppins(
//               fontSize: 12,
//               fontWeight: FontWeight.w700,
//               color: color,
//             )),
//       ],
//     );
//   }
// }
 
// class _SummaryCard extends StatelessWidget {
//   final String label;
//   final String value;
//   final Color color;
 
//   const _SummaryCard(
//       {required this.label, required this.value, required this.color});
 
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.all(14),
//       decoration: BoxDecoration(
//         color: color.withOpacity(0.1),
//         borderRadius: BorderRadius.circular(12),
//         border: Border.all(color: color.withOpacity(0.3), width: 1.5),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(label,
//               style: GoogleFonts.poppins(fontSize: 11, color: AppColors.grey)),
//           const SizedBox(height: 4),
//           Text(value,
//               style: GoogleFonts.poppins(
//                 fontSize: 16,
//                 fontWeight: FontWeight.w700,
//                 color: color,
//               )),
//         ],
//       ),
//     );
//   }
// }
 
// class _ProgressCircle extends StatelessWidget {
//   final String label;
//   final int value;
//   final int total;
//   final Color color;
//   final String suffix;
 
//   const _ProgressCircle({
//     required this.label,
//     required this.value,
//     required this.total,
//     required this.color,
//     this.suffix = '',
//   });
 
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Stack(
//           alignment: Alignment.center,
//           children: [
//             SizedBox(
//               width: 60,
//               height: 60,
//               child: CircularProgressIndicator(
//                 value: total > 0 ? value / total : 0,
//                 backgroundColor: AppColors.greyBg,
//                 valueColor: AlwaysStoppedAnimation(color),
//                 strokeWidth: 6,
//               ),
//             ),
//             Text('$value$suffix',
//                 style: GoogleFonts.poppins(
//                   fontSize: 15,
//                   fontWeight: FontWeight.w700,
//                   color: color,
//                 )),
//           ],
//         ),
//         const SizedBox(height: 6),
//         Text(label,
//             style: GoogleFonts.poppins(
//                 fontSize: 10, color: AppColors.grey, height: 1.2),
//             textAlign: TextAlign.center),
//       ],
//     );
//   }
// }
 
// String _formatAmt(double v) {
//   if (v >= 10000000) return '₹${(v / 10000000).toStringAsFixed(1)}Cr';
//   if (v >= 100000) return '₹${(v / 100000).toStringAsFixed(1)}L';
//   if (v >= 1000) return '₹${(v / 1000).toStringAsFixed(1)}K';
//   return '₹${v.toStringAsFixed(0)}';
// }
 
// // ══════════════════════════════════════════════════════════════════════════════
// // PDF GENERATION
// // ══════════════════════════════════════════════════════════════════════════════
 
// Future<void> _generatePDFReport(
//     BuildContext context, Map<String, dynamic> site) async {
//   final pdf = pw.Document();
 
//   pdf.addPage(
//     pw.Page(
//       build: (pw.Context context) {
//         return pw.Column(
//           crossAxisAlignment: pw.CrossAxisAlignment.start,
//           children: [
//             pw.Text('Site Financial Report',
//                 style:
//                     pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold)),
//             pw.SizedBox(height: 10),
//             pw.Text(site['name'], style: const pw.TextStyle(fontSize: 18)),
//             pw.SizedBox(height: 20),
//             pw.Divider(),
//             pw.SizedBox(height: 10),
//             _pdfRow('Estimated Budget',
//                 _formatAmt(site['estimatedAmount'])),
//             _pdfRow('Total Spent', _formatAmt(site['totalSpent'])),
//             _pdfRow('Total Received', _formatAmt(site['totalReceived'])),
//             _pdfRow('Balance',
//                 _formatAmt(site['totalReceived'] - site['totalSpent'])),
//             pw.SizedBox(height: 20),
//             pw.Divider(),
//             pw.SizedBox(height: 10),
//             pw.Text('Expense Breakdown',
//                 style:
//                     pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold)),
//             pw.SizedBox(height: 10),
//             _pdfRow('Materials', _formatAmt(site['materialSpent'])),
//             _pdfRow('Labour', _formatAmt(site['labourSpent'])),
//           ],
//         );
//       },
//     ),
//   );
 
//   await Printing.layoutPdf(
//       onLayout: (PdfPageFormat format) async => pdf.save());
// }
 
// pw.Widget _pdfRow(String label, String value) {
//   return pw.Padding(
//     padding: const pw.EdgeInsets.symmetric(vertical: 4),
//     child: pw.Row(
//       mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
//       children: [
//         pw.Text(label),
//         pw.Text(value, style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
//       ],
//     ),
//   );
// }