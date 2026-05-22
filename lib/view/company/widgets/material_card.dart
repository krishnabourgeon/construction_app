import 'package:construction_app/models/get_materials_model.dart';
import 'package:construction_app/view/company/edit_material_screen.dart';
import 'package:construction_app/widgets/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MaterialCard extends StatelessWidget {
  final GetMaterials material;
  final VoidCallback onDelete;
 
  const MaterialCard({super.key, required this.material, required this.onDelete});
 
  @override
  Widget build(BuildContext context) {
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
              color: AppColors.amberLight,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(Icons.inventory_2,
                size: 20, color: AppColors.amberDark),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(material.materialName,
                    style: GoogleFonts.poppins(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: AppColors.dark)),
                const SizedBox(height: 2),
                Text(
                    '${material.qty} Unit(s) × ₹${material.price}',
                    style: GoogleFonts.poppins(
                        fontSize: 15, color: AppColors.grey)),
                // if (material.supplierId != 0) // Basic fallback for supplier
                //   Text('Supplier ID: ${material.supplierId}',
                //       style: GoogleFonts.poppins(
                //           fontSize: 13, color: AppColors.greyLight)),
                Text('${material.addedDate.day}/${material.addedDate.month}/${material.addedDate.year}',
                    style: GoogleFonts.poppins(
                        fontSize: 15, color: AppColors.grey)),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text('₹${material.amount}',
                  style: GoogleFonts.poppins(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: AppColors.orange)),
              const SizedBox(height: 6),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EditMaterialScreen(material: material),
                    ),
                  );
                },
                child: Icon(Icons.edit,
                    size: 18, color: AppColors.blue.withOpacity(0.6)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}