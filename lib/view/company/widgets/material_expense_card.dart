// import 'package:construction_app/models/total_spent_detail_model.dart';
// import 'package:construction_app/widgets/app_theme.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:intl/intl.dart';

// class MaterialExpenseCard extends StatelessWidget {
//   final TotalMaterials materials;

//   const MaterialExpenseCard({super.key,required this.materials});

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
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Expanded(
//                 child: Text(materials.materialName,
//                     style: GoogleFonts.poppins(
//                       fontSize: 18,
//                       fontWeight: FontWeight.w600,
//                       color: AppColors.dark,
//                     )),
//               ),
//               Text(_formatAmt(double.parse(materials.amount)),
//                   style: GoogleFonts.poppins(
//                     fontSize: 15,
//                     fontWeight: FontWeight.w700,
//                     color: AppColors.orange,
//                   )),
//             ],
//           ),
//           const SizedBox(height: 6),
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
//                     materials.stageName,
//                     // overflow: TextOverflow.ellipsis,
//                     maxLines: 2,
//                     style: GoogleFonts.poppins(
//                       fontSize: 15,
//                       fontWeight: FontWeight.w600,
//                       color: AppColors.purple,
//                     ),
//                   ),
//                 ),
//               ),

//               if (materials.substageName.isNotEmpty) ...[
//                 const SizedBox(width: 6),
//                 const Icon(Icons.arrow_forward, size: 15, color: AppColors.grey),
//                 const SizedBox(width: 6),

//                 Expanded(
//                   child: Text(
//                     materials.substageName,
//                     //overflow: TextOverflow.ellipsis,
//                     maxLines: 2,
//                     style: GoogleFonts.poppins(
//                       fontSize: 15,
//                       color: AppColors.grey,
//                     ),
//                   ),
//                 ),
//               ],
//             ],
//           ),
//           const SizedBox(height: 6),
//           Row(
//             children: [
//               Text('${materials.qty}',
//                   style: GoogleFonts.poppins(
//                       fontSize: 13, color: AppColors.dark)),
//               Text(' × ₹${materials.price}',
//                   style: GoogleFonts.poppins(
//                       fontSize: 13, color: AppColors.grey)),
//             ],
//           ),
//           const SizedBox(height: 4),
//           Text(DateFormat('dd MMM yyyy').format(materials.addedDate),
//               style: GoogleFonts.poppins(
//                   fontSize: 13, color: AppColors.greyLight)),
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

// // class MaterialExpenseCard extends StatelessWidget {
// //   final List<TotalMaterials> materials;

// //   const MaterialExpenseCard({super.key, required this.materials});

// //   @override
// //   Widget build(BuildContext context) {
// //     return Padding(
// //       padding: const EdgeInsets.all(12),
// //       child: SingleChildScrollView(
// //         scrollDirection: Axis.horizontal,
// //         physics: const BouncingScrollPhysics(),
// //         child: Container(
// //           decoration: BoxDecoration(
// //             color: AppColors.white,
// //             borderRadius: BorderRadius.circular(12),
// //             border: Border.all(color: Colors.grey.shade300, width: 1),
// //           ),
// //           child: DataTable(
// //             headingRowColor: MaterialStateProperty.all(const Color(0xFF16213E)),

// //             headingTextStyle: GoogleFonts.poppins(
// //               color: Colors.white,
// //               fontWeight: FontWeight.w600,
// //               fontSize: 13,
// //             ),

// //             dataTextStyle: GoogleFonts.poppins(
// //               fontSize: 12,
// //               color: Colors.black87,
// //             ),

// //             headingRowHeight: 55,
// //             dataRowHeight: 65,
// //             columnSpacing: 24,
// //             horizontalMargin: 16,
// //             dividerThickness: 1,

// //             border: TableBorder(
// //               top: BorderSide(color: Colors.grey.shade300),
// //               bottom: BorderSide(color: Colors.grey.shade300),
// //               left: BorderSide(color: Colors.grey.shade300),
// //               right: BorderSide(color: Colors.grey.shade300),

// //               horizontalInside: BorderSide(
// //                 color: Colors.grey.shade300,
// //                 width: 1,
// //               ),

// //               verticalInside: BorderSide(color: Colors.grey.shade300, width: 1),
// //             ),

// //             columns: const [
// //               DataColumn(label: Text('Material')),
// //               DataColumn(label: Text('Stage')),
// //               DataColumn(label: Text('Substage')),
// //               DataColumn(label: Text('Qty')),
// //               DataColumn(label: Text('Price')),
// //               DataColumn(label: Text('Amount')),
// //               DataColumn(label: Text('Date')),
// //             ],

// //             rows: materials.map((item) {
// //               return DataRow(
// //                 cells: [
// //                   DataCell(Text(item.materialName)),

// //                   DataCell(
// //                     Container(
// //                       padding: const EdgeInsets.symmetric(
// //                         horizontal: 10,
// //                         vertical: 5,
// //                       ),
// //                       decoration: BoxDecoration(
// //                         color: AppColors.purpleLight,
// //                         borderRadius: BorderRadius.circular(20),
// //                       ),
// //                       child: Text(
// //                         item.stageName,
// //                         style: GoogleFonts.poppins(
// //                           fontSize: 11,
// //                           fontWeight: FontWeight.w500,
// //                           color: AppColors.purple,
// //                         ),
// //                       ),
// //                     ),
// //                   ),

// //                   DataCell(
// //                     Text(item.substageName.isEmpty ? '-' : item.substageName),
// //                   ),

// //                   DataCell(Text(item.qty.toString())),

// //                   DataCell(Text('₹${item.price}')),

// //                   DataCell(
// //                     Text(
// //                       _formatAmt(double.tryParse(item.amount) ?? 0),
// //                       style: GoogleFonts.poppins(
// //                         fontWeight: FontWeight.w600,
// //                         color: AppColors.orange,
// //                       ),
// //                     ),
// //                   ),

// //                   DataCell(
// //                     Text(DateFormat('dd MMM yyyy').format(item.addedDate)),
// //                   ),
// //                 ],
// //               );
// //             }).toList(),
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// // }

// // String _formatAmt(double v) {
// //   if (v >= 10000000) {
// //     return '₹${(v / 10000000).toStringAsFixed(1)}Cr';
// //   }

// //   if (v >= 100000) {
// //     return '₹${(v / 100000).toStringAsFixed(1)}L';
// //   }

// //   if (v >= 1000) {
// //     return '₹${(v / 1000).toStringAsFixed(1)}K';
// //   }

// //   return '₹${v.toStringAsFixed(0)}';
// // }

import 'package:construction_app/models/total_spent_detail_model.dart';
import 'package:construction_app/widgets/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class MaterialExpenseCard extends StatelessWidget {
  final TotalMaterials materials;

  const MaterialExpenseCard({super.key, required this.materials});

  @override
  Widget build(BuildContext context) {
    final totalAmount = double.parse(materials.amount);
    final pricePerUnit = double.parse(materials.price);
    final quantity = materials.qty;

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
              color: Color(0xFFFEF9C3),
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
                    Icons.inventory_2,
                    color: AppColors.amberDark,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'MATERIAL',
                        style: GoogleFonts.poppins(
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                          color: AppColors.amberDark,
                          letterSpacing: 0.5,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        materials.materialName,
                        style: GoogleFonts.poppins(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: AppColors.dark,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
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
                  //label: 'Location',
                  value: materials.stageName,
                  sublabel: materials.substageName.isNotEmpty
                      ? materials.substageName
                      : null,
                ),

                const SizedBox(height: 12),
                const Divider(height: 1, color: AppColors.borderLight),
                const SizedBox(height: 12),

                // Calculation Row
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColors.greyFill,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      // Quantity
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'QUANTITY',
                              style: GoogleFonts.poppins(
                                fontSize: 9,
                                fontWeight: FontWeight.w600,
                                color: AppColors.grey,
                                letterSpacing: 0.5,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '${materials.qty}',
                              style: GoogleFonts.poppins(
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                                color: AppColors.dark,
                              ),
                            ),
                          ],
                        ),
                      ),

                      Container(width: 1, height: 40, color: AppColors.border),

                      // Price per unit
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'RATE/UNIT',
                                style: GoogleFonts.poppins(
                                  fontSize: 9,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.grey,
                                  letterSpacing: 0.5,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                '₹${pricePerUnit.toStringAsFixed(0)}',
                                style: GoogleFonts.poppins(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.dark,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      Container(width: 1, height: 40, color: AppColors.border),

                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 8,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'UNIT',
                                style: GoogleFonts.poppins(
                                  fontSize: 9,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.grey,
                                  letterSpacing: 0.5,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                '${materials.unitname}',
                                style: GoogleFonts.poppins(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.dark,
                                ),
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

                // Date & Supplier
                Row(
                  children: [
                    Expanded(
                      child: _MiniInfoChip(
                        icon: Icons.calendar_today,
                        label: DateFormat(
                          'dd MMM yyyy',
                        ).format(materials.addedDate),
                        color: AppColors.blue,
                      ),
                    ),
                    if (materials.suppliername != null && materials.suppliername!.isNotEmpty) ...[
                      const SizedBox(width: 8),
                      Expanded(
                        child: _MiniInfoChip(
                          icon: Icons.store,
                          label: materials.suppliername!,
                          color: AppColors.purple,
                        ),
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

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



String _formatAmt(double v) {
  if (v >= 10000000) return '₹${(v / 10000000).toStringAsFixed(1)}Cr';
  if (v >= 100000) return '₹${(v / 100000).toStringAsFixed(1)}L';
  if (v >= 1000) return '₹${(v / 1000).toStringAsFixed(1)}K';
  return '₹${v.toStringAsFixed(0)}';
}
