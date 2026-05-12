// import 'package:construction_app/models/total_spent_detail_model.dart';
// import 'package:construction_app/widgets/app_theme.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:intl/intl.dart';

// class LabourExpenseCard extends StatelessWidget {
//   final TotalLabours labour;

//   const LabourExpenseCard({super.key, required this.labour});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: const EdgeInsets.only(bottom: 10),
//       padding: const EdgeInsets.all(12),
//       decoration: BoxDecoration(
//         color: AppColors.white,
//         borderRadius: BorderRadius.circular(12),
//         border: Border.all(color: AppColors.border, width: 1.5),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           // 🔹 Title + Amount
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Expanded(
//                 child: Text(
//                   '${labour.noOfLabours} Labours × ${labour.noOfDays} Days',
//                   style: GoogleFonts.poppins(
//                     fontSize: 15,
//                     fontWeight: FontWeight.w600,
//                     color: AppColors.dark,
//                   ),
//                 ),
//               ),
//               Text(
//                 _formatAmt(double.parse(labour.amount)),
//                 style: GoogleFonts.poppins(
//                   fontSize: 14,
//                   fontWeight: FontWeight.w700,
//                   color: AppColors.orange,
//                 ),
//               ),
//             ],
//           ),

//           const SizedBox(height: 6),

//           // 🔹 Stage + Substage (overflow safe)
//           Row(
//             children: [
//               Flexible(
//                 child: Container(
//                   padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
//                   decoration: BoxDecoration(
//                     color: AppColors.purpleLight,
//                     borderRadius: BorderRadius.circular(4),
//                   ),
//                   child: Text(
//                     labour.stageName,
//                     style: GoogleFonts.poppins(
//                       fontSize: 13,
//                       fontWeight: FontWeight.w600,
//                       color: AppColors.purple,
//                     ),
//                   ),
//                 ),
//               ),

//               if (labour.substageName.isNotEmpty) ...[
//                 const SizedBox(width: 6),
//                 const Icon(Icons.arrow_forward, size: 10, color: AppColors.grey),
//                 const SizedBox(width: 6),

//                 Expanded(
//                   child: Text(
//                     labour.substageName,
//                     style: GoogleFonts.poppins(
//                       fontSize: 13,
//                       color: AppColors.grey,
//                     ),
//                   ),
//                 ),
//               ],
//             ],
//           ),

//           const SizedBox(height: 6),

//           // 🔹 Remarks
//           if (labour.remarks != null && labour.remarks.toString().isNotEmpty) ...[
//             Text(
//               labour.remarks.toString(),
//               style: GoogleFonts.poppins(
//                 fontSize: 13,
//                 color: AppColors.greyLight,
//               ),
//             ),
//             const SizedBox(height: 4),
//           ],

//           // 🔹 Date
//           if (labour.addedDate != null && labour.addedDate.toString() != 'null')
//             Text(
//               DateFormat('dd MMM yyyy').format(
//                   DateTime.tryParse(labour.addedDate.toString()) ??
//                       DateTime.now()),
//               style: GoogleFonts.poppins(
//                 fontSize: 13,
//                 color: AppColors.greyLight,
//               ),
//             ),
//         ],
//       ),
//     );
//   }
// }

// String _formatAmt(double v) {
//   if (v >= 10000000) return '₹${(v / 10000000).toStringAsFixed(1)}Cr';
//   if (v >= 100000) return '₹${(v / 100000).toStringAsFixed(1)}L';
//   if (v >= 1000) return '₹${(v / 1000).toStringAsFixed(1)}K';
//   return '₹${v.toStringAsFixed(0)}';
// }

// // import 'package:construction_app/models/total_spent_detail_model.dart';
// // import 'package:construction_app/widgets/app_theme.dart';
// // import 'package:flutter/material.dart';
// // import 'package:google_fonts/google_fonts.dart';
// // import 'package:intl/intl.dart';

// // class LabourExpenseCard extends StatelessWidget {
// //   final TotalLabours labour;

// //   const LabourExpenseCard({super.key, required this.labour});

// //   @override
// //   Widget build(BuildContext context) {
// //     return Padding(
// //       padding: const EdgeInsets.all(12),
// //       child: SingleChildScrollView(
// //         scrollDirection: Axis.horizontal,
// //         physics: const BouncingScrollPhysics(),
// //         child: Container(
// //           // margin: const EdgeInsets.only(bottom: 10),
// //           // padding: const EdgeInsets.all(12),
// //           decoration: BoxDecoration(
// //             color: AppColors.white,
// //             borderRadius: BorderRadius.circular(12),
// //             border: Border.all(color: AppColors.border, width: 1.5),
// //           ),
// //           child: DataTable(
// //             headingRowColor: MaterialStateProperty.all(const Color(0xFF16213E)),
// //             headingTextStyle: GoogleFonts.poppins(
// //               color: Colors.white,
// //               fontWeight: FontWeight.w600,
// //               fontSize: 14,
// //             ),
// //             dataTextStyle: GoogleFonts.poppins(
// //               fontSize: 13,
// //               color: Colors.black87,
// //             ),
// //             columnSpacing: 24,
// //             horizontalMargin: 16,
// //             dividerThickness: 1,
// //             border: TableBorder(
// //               top: BorderSide(color: Colors.grey.shade300),
// //               bottom: BorderSide(color: Colors.grey.shade300),
// //               left: BorderSide(color: Colors.grey.shade300),
// //               right: BorderSide(color: Colors.grey.shade300),
// //               horizontalInside: BorderSide(color: Colors.grey.shade300),
// //               verticalInside: BorderSide(color: Colors.grey.shade300),
// //             ),

// //             columns: const [
// //               DataColumn(label: Text('Stage')),
// //               DataColumn(label: Text('Substage')),
// //               DataColumn(label: Text('Qty')),
// //               DataColumn(label: Text('Rate')),
// //               DataColumn(label: Text('Total')),
// //               DataColumn(label: Text('Date')),
// //               DataColumn(label: Text('Remarks')),
// //             ],
// //             rows: [
// //               DataRow(
// //                 cells: [
// //                   DataCell(Text(labour.stageName)),
// //                   DataCell(Text(labour.substageName)),
// //                   DataCell(Text(labour.noOfLabours.toString())),
// //                   DataCell(Text(labour.noOfDays.toString())),
// //                   DataCell(Text(_formatAmt(double.parse(labour.amount)))),
// //                   DataCell(
// //                     Text(
// //                       DateFormat('dd MMM yyyy').format(
// //                         DateTime.tryParse(labour.addedDate.toString()) ??
// //                             DateTime.now(),
// //                       ),
// //                     ),
// //                   ),
// //                   DataCell(Text(labour.remarks ?? '')),
// //                 ],
// //               ),
// //             ],
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// // }

// // String _formatAmt(double v) {
// //   if (v >= 10000000) return '₹${(v / 10000000).toStringAsFixed(1)}Cr';
// //   if (v >= 100000) return '₹${(v / 100000).toStringAsFixed(1)}L';
// //   if (v >= 1000) return '₹${(v / 1000).toStringAsFixed(1)}K';
// //   return '₹${v.toStringAsFixed(0)}';
// // }

import 'package:construction_app/models/total_spent_detail_model.dart';
import 'package:construction_app/widgets/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class LabourExpenseCard extends StatelessWidget {
  final TotalLabours labour;

  const LabourExpenseCard({super.key, required this.labour});

  @override
  Widget build(BuildContext context) {
    final totalAmount = double.parse(labour.amount);

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.border, width: 1.5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Header Section ──
          Container(
            padding: const EdgeInsets.all(14),
            decoration: const BoxDecoration(
              color: Color(0xFFDCFCE7),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(13),
                topRight: Radius.circular(13),
              ),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    Icons.groups,
                    color: AppColors.green,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),
                // Expanded(
                //   child: Column(
                //     crossAxisAlignment: CrossAxisAlignment.start,
                //     children: [
                //       Text('LABOUR PAYMENT',
                //           style: GoogleFonts.poppins(
                //             fontSize: 10,
                //             fontWeight: FontWeight.w700,
                //             color: AppColors.green,
                //             letterSpacing: 0.5,
                //           )),
                //       const SizedBox(height: 2),
                //       Text(labour.,
                //           style: GoogleFonts.poppins(
                //             fontSize: 15,
                //             fontWeight: FontWeight.w600,
                //             color: AppColors.dark,
                //           )),
                //     ],
                //   ),
                // ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: AppColors.orange, width: 1.5),
                  ),
                  child: Text(
                    _formatAmt(totalAmount),
                    style: GoogleFonts.poppins(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: AppColors.orange,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // ── Details Grid ──
          Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              children: [
                // Location Info
                _InfoRow(
                  // icon: Icons.location_on_outlined,
                  // iconColor: AppColors.purple,
                  // iconBg: AppColors.purpleLight,
                  // label: 'Location',
                  value: labour.stageName,
                  sublabel: labour.substageName.isNotEmpty
                      ? labour.substageName
                      : null,
                ),

                const SizedBox(height: 12),
                const Divider(height: 1, color: AppColors.borderLight),
                const SizedBox(height: 12),

                // Work Details
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColors.greyFill,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      // Number of labours
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'WORKERS',
                              style: GoogleFonts.poppins(
                                fontSize: 9,
                                fontWeight: FontWeight.w600,
                                color: AppColors.grey,
                                letterSpacing: 0.5,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                const Icon(
                                  Icons.person,
                                  size: 16,
                                  color: AppColors.green,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  '${labour.noOfLabours}',
                                  style: GoogleFonts.poppins(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.dark,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      Container(width: 1, height: 40, color: AppColors.border),

                      // Number of days
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'DAYS',
                                style: GoogleFonts.poppins(
                                  fontSize: 9,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.grey,
                                  letterSpacing: 0.5,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.calendar_today,
                                    size: 14,
                                    color: AppColors.blue,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    '${labour.noOfDays}',
                                    style: GoogleFonts.poppins(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w700,
                                      color: AppColors.dark,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),

                      const Icon(Icons.close, size: 16, color: AppColors.grey),
                    ],
                  ),
                ),

                const SizedBox(height: 12),

                // Date & Remarks
                if (labour.addedDate != null)
                  _MiniInfoChip(
                    icon: Icons.event,
                    label: DateFormat('dd MMM yyyy').format(
                      DateTime.tryParse(labour.addedDate.toString()) ??
                          DateTime.now(),
                    ),
                    color: AppColors.blue,
                  ),

                if (labour.remarks != null &&
                    labour.remarks.toString().isNotEmpty) ...[
                  const SizedBox(height: 10),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFF7ED),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: const Color(0xFFFED7AA)),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(
                          Icons.note_outlined,
                          size: 14,
                          color: Color(0xFFEA580C),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            labour.remarks.toString(),
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              color: const Color(0xFF9A3412),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ══════════════════════════════════════════════════════════════════════════════
// HELPER WIDGETS
// ══════════════════════════════════════════════════════════════════════════════

class _InfoRow extends StatelessWidget {
  final IconData? icon;
  final Color? iconColor;
  final Color? iconBg;
  final String? label;
  final String value;
  final String? sublabel;

  const _InfoRow({
    this.icon,
    this.iconColor,
    this.iconBg,
    this.label,
    required this.value,
    this.sublabel,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (icon != null) ...[
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: iconBg,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, size: 16, color: iconColor),
          ),
          const SizedBox(width: 12),
        ],
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (label != null) ...[
                Text(
                  label!.toUpperCase(),
                  style: GoogleFonts.poppins(
                    fontSize: 9,
                    fontWeight: FontWeight.w600,
                    color: AppColors.grey,
                    letterSpacing: 0.5,
                  ),
                ),
                const SizedBox(height: 2),
              ],
              Text(
                value,
                style: GoogleFonts.poppins(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: AppColors.dark,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              if (sublabel != null) ...[
                const SizedBox(height: 2),
                Row(
                  children: [
                    const Icon(
                      Icons.arrow_forward,
                      size: 10,
                      color: AppColors.grey,
                    ),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        sublabel!,
                        style: GoogleFonts.poppins(
                          fontSize: 11,
                          color: AppColors.grey,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}

class _MiniInfoChip extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;

  const _MiniInfoChip({
    required this.icon,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: color),
          const SizedBox(width: 6),
          Expanded(
            child: Text(
              label,
              style: GoogleFonts.poppins(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: color,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}

// ══════════════════════════════════════════════════════════════════════════════
// HELPER FUNCTIONS
// ══════════════════════════════════════════════════════════════════════════════

String _formatAmt(double v) {
  if (v >= 10000000) return '₹${(v / 10000000).toStringAsFixed(1)}Cr';
  if (v >= 100000) return '₹${(v / 100000).toStringAsFixed(1)}L';
  if (v >= 1000) return '₹${(v / 1000).toStringAsFixed(1)}K';
  return '₹${v.toStringAsFixed(0)}';
}
