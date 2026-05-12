import 'package:construction_app/widgets/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MiniStat extends StatelessWidget {
  final String label;
  final String value;
  final Color color;

  const MiniStat(
      {super.key, required this.label, required this.value, required this.color});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(label,
            style:
                GoogleFonts.poppins(fontSize: 15, color: AppColors.dark)),
        const SizedBox(height: 2),
        Text(value,
            style: GoogleFonts.poppins(
              fontSize: 17,
              fontWeight: FontWeight.w700,
              color: color,
            )),
      ],
    );
  }
}
