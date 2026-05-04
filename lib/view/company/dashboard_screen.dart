import 'package:construction_app/models/models.dart';
import 'package:construction_app/provider/company_provider.dart';
import 'package:construction_app/services/app_config.dart';
import 'package:construction_app/view/company/site_list_screen.dart';
import 'package:construction_app/view/company/report_screen.dart';
import 'package:construction_app/view/company/user_screen.dart';
import 'package:construction_app/view/login_screen.dart';
import 'package:construction_app/widgets/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

String _getInitials(String? name) {
  if (name == null || name.trim().isEmpty) return 'U';
  List<String> names = name.trim().split(RegExp(r'\s+'));
  String initials = "";
  if (names.length > 1) {
    initials = names[0][0] + names[1][0];
  } else if (names.isNotEmpty) {
    initials = names[0][0];
  }
  return initials.toUpperCase();
}

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
                      Text('BuildXpert Constructions',
                          style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.w600, color: AppColors.white)),
                      const SizedBox(height: 2),
                      Text(dateStr,
                          style: GoogleFonts.poppins(fontSize: 11, color: const Color(0xFF6B7280))),
                    ],
                  ),
                  Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          _showLogoutDialog(context);
                        },
                        child: Container(
                          width: 80, height: 44,
                          decoration: BoxDecoration(color: AppColors.white, borderRadius: BorderRadius.circular(14)),
                          child: Center(
                            child: Text("Logout", style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w600, color: AppColors.dark)),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      GestureDetector(
                        // onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => 
                        // const ProfileScreen()
                        // )),
                        child: Container(
                          width: 44, height: 44,
                          decoration: BoxDecoration(color: AppColors.amber, borderRadius: BorderRadius.circular(14)),
                          child: Center(
                            child: Text(_getInitials(AppConfig.userName),
                                style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w700, color: AppColors.dark)),
                          ),
                        ),
                      ),
                    ],
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

                  _DashCard(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (_) => const ReportsScreen()));
                    },
                    // count: sampleLabour.length.toString(), 
                  label: 'Report Section',
                    // subLabel: 'This month', 
                    bgColor: AppColors.navy,
                    countColor: AppColors.white, labelColor: AppColors.white,
                    subColor: AppColors.greyLight, icon: Icons.people_alt_rounded, iconBgColor: Colors.white12),
                  const SizedBox(height: 14),

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
  void _showLogoutDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (ctx) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        title: Row(
          children: [
            Icon(Icons.logout, color: AppColors.amber),
            const SizedBox(width: 8),
            Text(
              "Logout",
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
          ],
        ),
        content: Text(
          "Are you sure you want to logout?",
          style: GoogleFonts.poppins(fontSize: 13),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
            },
            child: Text(
              "Cancel",
              style: GoogleFonts.poppins(color: AppColors.grey),
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              Navigator.pop(ctx); // close dialog first

              final provider = context.read<CompanyProvider>();

              await provider.logout((error) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(error),
                    backgroundColor: AppColors.red,
                  ),
                );
              });

              if (!context.mounted) return;

              if (provider.errorToast == null) {
                // ✅ Success Snackbar
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      "Logged out successfully",
                      style: GoogleFonts.poppins(fontSize: 13),
                    ),
                    backgroundColor: AppColors.green,
                    behavior: SnackBarBehavior.floating,
                  ),
                );

                // ✅ Navigate (change to LoginScreen if needed)
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (_) => const LoginScreen()),
                  (route) => false,
                );
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.amber,
              foregroundColor: AppColors.dark,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: Text(
              "Logout",
              style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
            ),
          ),
        ],
      );
    },
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