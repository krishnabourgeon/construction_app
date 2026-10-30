import 'package:construction_app/widgets/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProgressCircle extends StatelessWidget {
  final String label;
  final num value;
  final num total;
  final Color color;
  final String suffix;
  final int decimals;

  const ProgressCircle({
    required this.label,
    required this.value,
    required this.total,
    required this.color,
    this.suffix = '',
    this.decimals = 0,
  });

  @override
  Widget build(BuildContext context) {
    final displayValue =
        decimals > 0 ? value.toStringAsFixed(decimals) : value.toInt().toString();
    return Column(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              width: 60,
              height: 60,
              child: CircularProgressIndicator(
                value: total > 0 ? value / total : 0,
                backgroundColor: AppColors.greyBg,
                valueColor: AlwaysStoppedAnimation(color),
                strokeWidth: 6,
              ),
            ),
            Text('$displayValue$suffix',
                style: GoogleFonts.poppins(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: color,
                )),
          ],
        ),
        const SizedBox(height: 6),
        Text(label,
            style: GoogleFonts.poppins(
                fontSize: 10, color: AppColors.grey, height: 1.2),
            textAlign: TextAlign.center),
      ],
    );
  }
}