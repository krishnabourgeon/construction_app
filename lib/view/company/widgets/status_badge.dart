import 'package:construction_app/widgets/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class _StatusBadge extends StatelessWidget {
  final String status;
  const _StatusBadge({required this.status});

  @override
  Widget build(BuildContext context) {
    Color bg, fg;
    switch (status) {
      case 'Active':
        bg = AppColors.greenLight;
        fg = AppColors.green;
        break;
      case 'Completed':
        bg = AppColors.blueLight;
        fg = AppColors.blue;
        break;
      case 'On Hold':
        bg = AppColors.orangeLight;
        fg = AppColors.orange;
        break;
      default:
        bg = AppColors.greyBg;
        fg = AppColors.grey;
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(status,
          style: GoogleFonts.poppins(
              fontSize: 11, fontWeight: FontWeight.w600, color: fg)),
    );
  }
}

