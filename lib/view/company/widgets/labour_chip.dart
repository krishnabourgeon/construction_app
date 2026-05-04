import 'package:construction_app/models/get_labours_model.dart';
import 'package:construction_app/widgets/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class LabourCard extends StatelessWidget {
  final Labour labour;
  final VoidCallback onDelete;
 
  const LabourCard({super.key, required this.labour, required this.onDelete});
 
  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('dd MMM yyyy');
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border, width: 1.5),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: AppColors.redLight,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(Icons.groups, size: 20, color: AppColors.red),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("${labour.noOfLabours} Labours",
                    style: GoogleFonts.poppins(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: AppColors.dark)),
                const SizedBox(height: 2),
                if (labour.noOfDays != null)
                  Text("${labour.noOfDays} Days",
                      style: GoogleFonts.poppins(
                          fontSize: 15, color: AppColors.grey)),
                if (labour.remarks != null && labour.remarks!.isNotEmpty)
                  Text(labour.remarks!,
                      style: GoogleFonts.poppins(
                          fontSize: 15, color: AppColors.greyLight)),
                if (labour.addedDate != null)
                  Text(dateFormat.format(labour.addedDate!),
                      style: GoogleFonts.poppins(
                          fontSize: 15, color: AppColors.greyLight)),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text('₹${labour.amount}',
                  style: GoogleFonts.poppins(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: AppColors.orange)),
              // const SizedBox(height: 4),
              // GestureDetector(
              //   onTap: () {
              //     showDialog(
              //       context: context,
              //       builder: (_) => AlertDialog(
              //         shape: RoundedRectangleBorder(
              //             borderRadius: BorderRadius.circular(16)),
              //         title: Text('Delete Labour',
              //             style: GoogleFonts.poppins(
              //                 fontSize: 15, fontWeight: FontWeight.w600)),
              //         content: Text('Remove this entry?',
              //             style: GoogleFonts.poppins(fontSize: 13)),
              //         actions: [
              //           TextButton(
              //             onPressed: () => Navigator.pop(context),
              //             child: Text('Cancel',
              //                 style: GoogleFonts.poppins(
              //                     color: AppColors.grey)),
              //           ),
              //           TextButton(
              //             onPressed: () {
              //               Navigator.pop(context);
              //               onDelete();
              //             },
              //             child: Text('Delete',
              //                 style: GoogleFonts.poppins(
              //                     color: AppColors.red,
              //                     fontWeight: FontWeight.w600)),
              //           ),
              //         ],
              //       ),
              //     );
              //   },
              //   child: Icon(Icons.delete_outline,
              //       size: 18, color: AppColors.red.withOpacity(0.6)),
              // ),
            ],
          ),
        ],
      ),
    );
  }
}