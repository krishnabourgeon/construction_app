import 'package:construction_app/models/models.dart';
import 'package:construction_app/services/app_config.dart';
import 'package:construction_app/view/company/site_list_screen.dart';
import 'package:construction_app/view/company/user_screen.dart';
import 'package:construction_app/widgets/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DashboardScreen extends StatelessWidget {
   final Function(int)? onNavigate;
  const DashboardScreen({super.key, this.onNavigate});

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
            // Header
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
                      Text('Hello, ${AppConfig.userName ?? "User"} 👋',
                          style: GoogleFonts.poppins(fontSize: 13, color: AppColors.greyLight)),
                      const SizedBox(height: 4),
                      Text('BuildCo Constructions',
                          style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.w600, color: AppColors.white)),
                      const SizedBox(height: 2),
                      Text(dateStr,
                          style: GoogleFonts.poppins(fontSize: 11, color: const Color(0xFF6B7280))),
                    ],
                  ),
                  GestureDetector(
                    // onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => 
                    // const ProfileScreen()
                    // )),
                    child: Container(
                      width: 44, height: 44,
                      decoration: BoxDecoration(color: AppColors.amber, borderRadius: BorderRadius.circular(14)),
                      child: Center(
                        child: Text('RK',
                            style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w700, color: AppColors.dark)),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Cards
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 20, 16, 0),
              child: Column(
                children: [
                  _DashCard(
                    onTap: () {
                      //Navigator.push(context, MaterialPageRoute(builder: (_) => const UserScreen()));
                      onNavigate?.call(1); 
                    },
                    //count: sampleUsers.length.toString(), 
                    label: 'Supervisor',
                    //subLabel: 'Supervisors & staff', 
                    bgColor:  Color(0xFF4F46E5),
                    countColor: AppColors.white, labelColor: AppColors.white,
                    subColor: const Color(0xFFC7D2FE), icon: Icons.group_rounded, iconBgColor: Colors.white12),
                  const SizedBox(height: 24),

                  _DashCard(
                    onTap: () {
                      //Navigator.push(context, MaterialPageRoute(builder: (_) => const SitesScreen()));
                      onNavigate?.call(2); 
                    },
                    //count: sampleSites.length.toString(),
                    label: 'Total Sites',
                    //subLabel: '${sampleSites.where((s) => s.status == "Active").length} active  ·  ${sampleSites.where((s) => s.status == "Completed").length} completed',
                    bgColor: AppColors.amber, countColor: AppColors.dark, labelColor: AppColors.dark,
                    subColor: const Color(0xFF44301A), icon: Icons.domain_rounded, iconBgColor: Colors.black12),
                  const SizedBox(height: 14),

                  // _DashCard(count: sampleLabour.length.toString(), label: 'Labour Entries',
                  //   subLabel: 'This month', bgColor: AppColors.navy,
                  //   countColor: AppColors.white, labelColor: AppColors.white,
                  //   subColor: AppColors.greyLight, icon: Icons.people_alt_rounded, iconBgColor: Colors.white12),
                  // const SizedBox(height: 14),

                  // _DashCard(count: sampleMaterials.length.toString(), label: 'Materials',
                  //   subLabel: 'Across all sites', bgColor: AppColors.orange,
                  //   countColor: AppColors.white, labelColor: AppColors.white,
                  //   subColor: AppColors.orangeLight, icon: Icons.inventory_2_rounded, iconBgColor: Colors.white12),
                  // const SizedBox(height: 14),

                  // _DashCard(count: sampleUsers.length.toString(), label: 'Users',
                  //   subLabel: 'Supervisors & staff', bgColor: const Color(0xFF4F46E5),
                  //   countColor: AppColors.white, labelColor: AppColors.white,
                  //   subColor: const Color(0xFFC7D2FE), icon: Icons.group_rounded, iconBgColor: Colors.white12),
                  // const SizedBox(height: 24),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DashCard extends StatelessWidget {
  final String label;
  final Color bgColor;
  final Color countColor;
  final Color labelColor;
  final Color subColor;
  final Color iconBgColor;
  final IconData icon;
  final VoidCallback onTap;

  const _DashCard({
   required this.label, 
    required this.bgColor, required this.countColor, required this.labelColor,
    required this.subColor, required this.iconBgColor, required this.icon, required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 22),
        decoration: BoxDecoration(color: bgColor, borderRadius: BorderRadius.circular(22)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //Text(count!, style: GoogleFonts.poppins(fontSize: 44, fontWeight: FontWeight.w700, color: countColor, height: 1)),
                //const SizedBox(height: 6),
                Text(label, style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.w500, color: labelColor)),
                const SizedBox(height: 3),
                //Text(subLabel!, style: GoogleFonts.poppins(fontSize: 12, color: subColor)),
              ],
            ),
            Container(
              width: 68, height: 68,
              decoration: BoxDecoration(color: iconBgColor, borderRadius: BorderRadius.circular(20)),
              child: Icon(icon, color: countColor, size: 36),
            ),
          ],
        ),
      ),
    );
  }
}