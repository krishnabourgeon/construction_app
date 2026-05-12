import 'package:construction_app/models/sitesbycompanies.dart';
import 'package:construction_app/view/company/site_wise_report_screen.dart';
import 'package:construction_app/view/company/stage_wise_reports_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:construction_app/widgets/app_theme.dart';


// ══════════════════════════════════════════════════════════════════════════════
// REPORTS HOME SCREEN
// ══════════════════════════════════════════════════════════════════════════════

class ReportsScreen extends StatelessWidget {
  final SitesbyCompany? site;
  const ReportsScreen({super.key, this.site});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.greyBg,
      body: Column(
        children: [
          // Header
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFF1A1A2E), Color(0xFF16213E)],
              ),
            ),
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top + 16,
              bottom: 20,
              left: 20,
              right: 20,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                     GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: const Icon(Icons.arrow_back_ios_new, color: AppColors.white, size: 20),
                        ),
                        const SizedBox(width: 12),
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: AppColors.amber,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(Icons.analytics_outlined,
                          color: AppColors.dark, size: 24),
                    ),
                    const SizedBox(width: 12),
                    Text('Reports',
                        style: GoogleFonts.poppins(
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                          color: AppColors.white,
                        )),
                  ],
                ),
                const SizedBox(height: 6),
                Text('Financial & Performance Analytics',
                    style: GoogleFonts.poppins(
                        fontSize: 15, color: AppColors.greyLight)),
              ],
            ),
          ),

          // Report Cards
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                const SizedBox(height: 12),
                _ReportCard(
                  title: 'Site-wise Reports',
                  subtitle: 'Budget, spent & receivables',
                  icon: Icons.domain_outlined,
                  gradient: const LinearGradient(
                    colors: [Color(0xFFF59E0B), Color(0xFFD97706)],
                  ),
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => SiteWiseReportsScreen(site: site)),
                  ),
                ),
                const SizedBox(height: 12),
                _ReportCard(
                  title: 'Stage-wise Reports',
                  subtitle: 'Materials & labour breakdown',
                  icon: Icons.layers_outlined,
                  gradient: const LinearGradient(
                    colors: [Color(0xFF10B981), Color(0xFF059669)],
                  ),
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => const StageWiseReportsScreen()),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ReportCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Gradient gradient;
  final VoidCallback onTap;

  const _ReportCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.gradient,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          gradient: gradient,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 10,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        padding: const EdgeInsets.all(18),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: AppColors.white, size: 28),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: AppColors.white,
                      )),
                  const SizedBox(height: 2),
                  Text(subtitle,
                      style: GoogleFonts.poppins(
                          fontSize: 15, color: Colors.white.withOpacity(0.8))),
                ],
              ),
            ),
            const Icon(Icons.arrow_forward_ios,
                color: AppColors.white, size: 18),
          ],
        ),
      ),
    );
  }
}
