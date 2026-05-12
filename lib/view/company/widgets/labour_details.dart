import 'package:construction_app/models/get_labours_model.dart';
import 'package:construction_app/widgets/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class LabourDetails extends StatelessWidget {
  final List<LabourData> labours;

  const LabourDetails({super.key, required this.labours});

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('dd MMM yyyy');
    return Scaffold(
      backgroundColor: AppColors.greyBg,
      appBar: AppBar(
        title: Text('Labour Details', style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
        backgroundColor: const Color(0xFF6D28D9),
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: labours.isEmpty
          ? Center(
              child: Text('No labour entries found', style: GoogleFonts.poppins(color: AppColors.grey)),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: labours.length,
              itemBuilder: (context, index) {
                final labour = labours[index];
                return Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 45,
                        height: 45,
                        decoration: BoxDecoration(
                          color: AppColors.redLight,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(Icons.groups, size: 24, color: AppColors.red),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${labour.noOfLabours} Labours",
                              style: GoogleFonts.poppins(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: AppColors.dark,
                              ),
                            ),
                            const SizedBox(height: 4),
                            if (labour.noOfDays != null)
                              Text(
                                "${labour.noOfDays} Days",
                                style: GoogleFonts.poppins(fontSize: 14, color: AppColors.grey),
                              ),
                            if (labour.remarks != null && labour.remarks!.isNotEmpty)
                              Text(
                                labour.remarks!,
                                style: GoogleFonts.poppins(fontSize: 14, color: AppColors.greyLight),
                              ),
                            if (labour.addedDate != null)
                              Text(
                                dateFormat.format(labour.addedDate!),
                                style: GoogleFonts.poppins(fontSize: 14, color: AppColors.greyLight),
                              ),
                          ],
                        ),
                      ),
                      Text(
                        '₹${labour.amount}',
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: AppColors.orange,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
