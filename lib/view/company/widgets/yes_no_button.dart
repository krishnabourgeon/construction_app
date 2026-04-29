import 'package:construction_app/widgets/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class YesNoButton extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;
 
  const YesNoButton({super.key, 
    required this.label,
    required this.selected,
    required this.onTap,
  });
 
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: selected ? AppColors.amberLight : AppColors.greyFill,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: selected ? AppColors.amberDark : AppColors.border,
            width: 1.5,
          ),
        ),
        child: Center(
          child: Text(label,
              style: GoogleFonts.poppins(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: selected ? AppColors.amberDark : AppColors.grey,
              )),
        ),
      ),
    );
  }
}