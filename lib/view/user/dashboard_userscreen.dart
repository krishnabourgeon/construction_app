import 'package:construction_app/models/models.dart';
import 'package:construction_app/widgets/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DashboardUserScreen extends StatelessWidget {
  const DashboardUserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final days = ['Monday','Tuesday','Wednesday','Thursday','Friday','Saturday','Sunday'];
    final months = ['Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'];
    final dateStr = '${days[now.weekday - 1]}, ${now.day} ${months[now.month - 1]} ${now.year}';

    return Scaffold(
      backgroundColor: AppColors.greyBg,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // ── Header ────────────────────────────────────────────────────
            Container(
              width: double.infinity,
              color: AppColors.navy,
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).padding.top + 20,
                bottom: 36,
                left: 22,
                right: 22,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Hello, Rajan 👋',
                        style: GoogleFonts.poppins(
                            fontSize: 13, color: AppColors.greyLight),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'BuildCo Constructions',
                        style: GoogleFonts.poppins(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: AppColors.white,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        dateStr,
                        style: GoogleFonts.poppins(
                            fontSize: 11, color: const Color(0xFF6B7280)),
                      ),
                    ],
                  ),
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      color: AppColors.amber,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Center(
                      child: Text(
                        'RK',
                        style: GoogleFonts.poppins(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: AppColors.dark,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // ── Three main cards ──────────────────────────────────────────
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 20, 16, 0),
              child: Column(
                children: [
                  // Sites card
                  _DashCard(
                    count: sampleSites.length.toString(),
                    label: 'Total Sites',
                    subLabel: '${sampleSites.where((s) => s.status == 'Active').length} active  ·  ${sampleSites.where((s) => s.status == 'Completed').length} completed',
                    bgColor: AppColors.amber,
                    countColor: AppColors.dark,
                    labelColor: AppColors.dark,
                    subColor: const Color(0xFF44301A),
                    iconColor: AppColors.dark,
                    icon: Icons.domain_rounded,
                    iconBgColor: Colors.black12,
                  ),
                  const SizedBox(height: 14),

                  // Labour card
                  _DashCard(
                    count: sampleLabour.length.toString(),
                    label: 'Labour Entries',
                    subLabel: 'This month',
                    bgColor: AppColors.navy,
                    countColor: AppColors.white,
                    labelColor: AppColors.white,
                    subColor: AppColors.greyLight,
                    iconColor: AppColors.white,
                    icon: Icons.people_alt_rounded,
                    iconBgColor: Colors.white12,
                  ),
                  const SizedBox(height: 14),

                  // Materials card
                  _DashCard(
                    count: sampleMaterials.length.toString(),
                    label: 'Materials',
                    subLabel: 'Across all sites',
                    bgColor: AppColors.orange,
                    countColor: AppColors.white,
                    labelColor: AppColors.white,
                    subColor: AppColors.orangeLight,
                    iconColor: AppColors.white,
                    icon: Icons.inventory_2_rounded,
                    iconBgColor: Colors.white12,
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Reusable Dashboard Card ───────────────────────────────────────────────────

class _DashCard extends StatelessWidget {
  final String count;
  final String label;
  final String subLabel;
  final Color bgColor;
  final Color countColor;
  final Color labelColor;
  final Color subColor;
  final Color iconColor;
  final Color iconBgColor;
  final IconData icon;

  const _DashCard({
    required this.count,
    required this.label,
    required this.subLabel,
    required this.bgColor,
    required this.countColor,
    required this.labelColor,
    required this.subColor,
    required this.iconColor,
    required this.iconBgColor,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 22),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(22),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                count,
                style: GoogleFonts.poppins(
                  fontSize: 44,
                  fontWeight: FontWeight.w700,
                  color: countColor,
                  height: 1,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                label,
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: labelColor,
                ),
              ),
              const SizedBox(height: 3),
              Text(
                subLabel,
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  color: subColor,
                ),
              ),
            ],
          ),
          Container(
            width: 68,
            height: 68,
            decoration: BoxDecoration(
              color: iconBgColor,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Icon(icon, color: iconColor, size: 36),
          ),
        ],
      ),
    );
  }
}
