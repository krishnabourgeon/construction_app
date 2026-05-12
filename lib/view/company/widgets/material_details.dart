import 'package:construction_app/models/get_materials_model.dart';
import 'package:construction_app/widgets/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MaterialDetails extends StatelessWidget {
  final List<GetMaterials> materials;
 
  const MaterialDetails({super.key, required this.materials});
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.greyBg,
      appBar: AppBar(
        title: Text('Material Details', style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
        backgroundColor: const Color(0xFF6D28D9),
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: materials.isEmpty
          ? Center(
              child: Text('No materials found', style: GoogleFonts.poppins(color: AppColors.grey)),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: materials.length,
              itemBuilder: (context, index) {
                final material = materials[index];
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
                          color: AppColors.amberLight,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(Icons.inventory_2, size: 24, color: AppColors.amberDark),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(material.materialName,
                                style: GoogleFonts.poppins(
                                    fontSize: 16, fontWeight: FontWeight.w600, color: AppColors.dark)),
                            const SizedBox(height: 4),
                            Text('${material.qty} Unit(s) × ₹${material.price}',
                                style: GoogleFonts.poppins(fontSize: 14, color: AppColors.grey)),
                            Text(
                                '${material.addedDate.day}/${material.addedDate.month}/${material.addedDate.year}',
                                style: GoogleFonts.poppins(fontSize: 14, color: AppColors.grey)),
                          ],
                        ),
                      ),
                      Text('₹${material.amount}',
                          style: GoogleFonts.poppins(
                              fontSize: 16, fontWeight: FontWeight.w700, color: AppColors.orange)),
                    ],
                  ),
                );
              },
            ),
    );
  }
}