// import 'package:construction_app/provider/company_provider.dart';
// import 'package:construction_app/services/app_config.dart';
// import 'package:construction_app/view/company/payment_list_screen.dart';
// import 'package:construction_app/view/company/site_list_screen.dart';
// import 'package:construction_app/view/company/report_screen.dart';
// import 'package:construction_app/view/company/user_screen.dart';
// import 'package:construction_app/view/company/widgets/trial_banner_widget.dart';
// import 'package:construction_app/view/login_screen.dart';
// import 'package:construction_app/widgets/app_theme.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:provider/provider.dart';

// String _getInitials(String? name) {
//   if (name == null || name.trim().isEmpty) return 'U';
//   List<String> names = name.trim().split(RegExp(r'\s+'));
//   String initials = "";
//   if (names.length > 1) {
//     initials = names[0][0] + names[1][0];
//   } else if (names.isNotEmpty) {
//     initials = names[0][0];
//   }
//   return initials.toUpperCase();
// }

// class DashboardScreen extends StatelessWidget {
//   final Function(int)? onNavigate;
//   const DashboardScreen({super.key, this.onNavigate});

//   @override
//   Widget build(BuildContext context) {
//     final now = DateTime.now();
//     final days = [
//       'Monday',
//       'Tuesday',
//       'Wednesday',
//       'Thursday',
//       'Friday',
//       'Saturday',
//       'Sunday',
//     ];
//     final months = [
//       'Jan',
//       'Feb',
//       'Mar',
//       'Apr',
//       'May',
//       'Jun',
//       'Jul',
//       'Aug',
//       'Sep',
//       'Oct',
//       'Nov',
//       'Dec',
//     ];
//     final dateStr =
//         '${days[now.weekday - 1]}, ${now.day} ${months[now.month - 1]} ${now.year}';

//     return Scaffold(
//       backgroundColor: AppColors.greyBg,
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             // Header
//             Container(
//               width: double.infinity,
//               color: AppColors.navy,
//               padding: EdgeInsets.only(
//                 top: MediaQuery.of(context).padding.top + 20,
//                 bottom: 36,
//                 left: 22,
//                 right: 22,
//               ),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         'Hello, ${AppConfig.userName ?? "User"} 👋',
//                         style: GoogleFonts.poppins(
//                           fontSize: 13,
//                           color: AppColors.greyLight,
//                         ),
//                       ),
//                       const SizedBox(height: 4),
//                       Text(
//                         'RealLine Constructions',
//                         style: GoogleFonts.poppins(
//                           fontSize: 20,
//                           fontWeight: FontWeight.w600,
//                           color: AppColors.white,
//                         ),
//                       ),
//                       const SizedBox(height: 2),
//                       Text(
//                         dateStr,
//                         style: GoogleFonts.poppins(
//                           fontSize: 11,
//                           color: const Color(0xFF6B7280),
//                         ),
//                       ),
//                     ],
//                   ),
//                   Column(
//                     children: [
//                       GestureDetector(
//                         onTap: () {
//                           _showLogoutDialog(context);
//                         },
//                         child: Container(
//                           width: 80,
//                           height: 44,
//                           decoration: BoxDecoration(
//                             color: AppColors.white,
//                             borderRadius: BorderRadius.circular(14),
//                           ),
//                           child: Center(
//                             child: Text(
//                               "Logout",
//                               style: GoogleFonts.poppins(
//                                 fontSize: 15,
//                                 fontWeight: FontWeight.w600,
//                                 color: AppColors.dark,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                       const SizedBox(height: 10),
//                       GestureDetector(
//                         // onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) =>
//                         // const ProfileScreen()
//                         // )),
//                         child: Container(
//                           width: 44,
//                           height: 44,
//                           decoration: BoxDecoration(
//                             color: AppColors.amber,
//                             borderRadius: BorderRadius.circular(14),
//                           ),
//                           child: Center(
//                             child: Text(
//                               _getInitials(AppConfig.userName),
//                               style: GoogleFonts.poppins(
//                                 fontSize: 15,
//                                 fontWeight: FontWeight.w700,
//                                 color: AppColors.dark,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//             const SizedBox(height: 16),
//             const TrialBannerWidget(),
//             // Cards
//             Padding(
//               padding: const EdgeInsets.fromLTRB(16, 20, 16, 0),
//               child: Column(
//                 children: [
//                   const SizedBox(height: 10),
//                   _DashCard(
//                     onTap: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(builder: (_) => const UserScreen()),
//                       );
//                       //onNavigate?.call(1);
//                     },
//                     //count: sampleUsers.length.toString(),
//                     label: 'Supervisor',
//                     //subLabel: 'Supervisors & staff',
//                     bgColor: Color(0xFF4F46E5),
//                     countColor: AppColors.white,
//                     labelColor: AppColors.white,
//                     subColor: const Color(0xFFC7D2FE),
//                     icon: Icons.group_rounded,
//                     iconBgColor: Colors.white12,
//                   ),
//                   const SizedBox(height: 24),

//                   _DashCard(
//                     onTap: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(builder: (_) => const SitesScreen()),
//                       );
//                       //onNavigate?.call(2);
//                     },
//                     //count: sampleSites.length.toString(),
//                     label: 'My Sites',
//                     //subLabel: '${sampleSites.where((s) => s.status == "Active").length} active  ·  ${sampleSites.where((s) => s.status == "Completed").length} completed',
//                     bgColor: AppColors.amber,
//                     countColor: AppColors.dark,
//                     labelColor: AppColors.dark,
//                     subColor: const Color(0xFF44301A),
//                     icon: Icons.domain_rounded,
//                     iconBgColor: Colors.black12,
//                   ),
//                   const SizedBox(height: 14),

//                   _DashCard(
//                     onTap: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (_) => const ReportsScreen(),
//                         ),
//                       );
//                     },
//                     // count: sampleLabour.length.toString(),
//                     label: 'Report',
//                     // subLabel: 'This month',
//                     bgColor: AppColors.navy,
//                     countColor: AppColors.white,
//                     labelColor: AppColors.white,
//                     subColor: AppColors.greyLight,
//                     icon: Icons.people_alt_rounded,
//                     iconBgColor: Colors.white12,
//                   ),
//                   const SizedBox(height: 14),

//                   Row(
//                     children: [
//                       Expanded(
//                         child: _DashCard(
//                           onTap: () {
//                             Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                 builder: (_) =>
//                                     const PaymentListScreen(paymentType: 1),
//                               ),
//                             );
//                           },
//                           // count: sampleMaterials.length.toString(),
//                           label: 'Payments',
//                           // subLabel: 'Across all sites',
//                           bgColor: AppColors.orange,
//                           countColor: AppColors.white,
//                           labelColor: AppColors.white,
//                           subColor: AppColors.orangeLight,
//                           icon: Icons.payment_outlined,
//                           iconBgColor: Colors.white12,
//                         ),
//                       ),
//                       const SizedBox(width: 14),

//                       Expanded(
//                         child: _DashCard(
//                           onTap: () {
//                             Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                 builder: (_) =>
//                                     const PaymentListScreen(paymentType: 2),
//                               ),
//                             );
//                           },
//                           //count: sampleUsers.length.toString(),
//                           label: 'Receipts',
//                           // subLabel: 'Supervisors & staff',
//                           bgColor: const Color(0xFF4F46E5),
//                           countColor: AppColors.white,
//                           labelColor: AppColors.white,
//                           subColor: const Color(0xFFC7D2FE),
//                           icon: Icons.receipt_long_rounded,
//                           iconBgColor: Colors.white12,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   void _showLogoutDialog(BuildContext context) {
//     showDialog(
//       context: context,
//       barrierDismissible: false,
//       builder: (ctx) {
//         return AlertDialog(
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(16),
//           ),
//           title: Row(
//             children: [
//               Icon(Icons.logout, color: AppColors.amber),
//               const SizedBox(width: 8),
//               Text(
//                 "Logout",
//                 style: GoogleFonts.poppins(
//                   fontWeight: FontWeight.w600,
//                   fontSize: 16,
//                 ),
//               ),
//             ],
//           ),
//           content: Text(
//             "Are you sure you want to logout?",
//             style: GoogleFonts.poppins(fontSize: 13),
//           ),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.pop(ctx);
//               },
//               child: Text(
//                 "Cancel",
//                 style: GoogleFonts.poppins(color: AppColors.grey),
//               ),
//             ),
//             // ElevatedButton(
//             //   onPressed: () async {
//             //     Navigator.pop(ctx); // close dialog first

//             //     final provider = context.read<CompanyProvider>();

//             //     await provider.logout((error) {
//             //       ScaffoldMessenger.of(context).showSnackBar(
//             //         SnackBar(
//             //           content: Text(error),
//             //           backgroundColor: AppColors.red,
//             //         ),
//             //       );
//             //     });

//             //     if (!context.mounted) return;

//             //     if (provider.errorToast == null) {
//             //       // ✅ Success Snackbar
//             //       ScaffoldMessenger.of(context).showSnackBar(
//             //         SnackBar(
//             //           content: Text(
//             //             "Logged out successfully",
//             //             style: GoogleFonts.poppins(fontSize: 13),
//             //           ),
//             //           backgroundColor: AppColors.green,
//             //           behavior: SnackBarBehavior.floating,
//             //         ),
//             //       );

//             //       // ✅ Navigate (change to LoginScreen if needed)
//             //       Navigator.pushAndRemoveUntil(
//             //         context,
//             //         MaterialPageRoute(builder: (_) => const LoginScreen()),
//             //         (route) => false,
//             //       );
//             //     }
//             //   },
//             //   style: ElevatedButton.styleFrom(
//             //     backgroundColor: AppColors.amber,
//             //     foregroundColor: AppColors.dark,
//             //     shape: RoundedRectangleBorder(
//             //       borderRadius: BorderRadius.circular(10),
//             //     ),
//             //   ),
//             //   child: Text(
//             //     "Logout",
//             //     style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
//             //   ),
//             // ),
//             InkWell(
//               onTap: () async {
//                     Navigator.pop(ctx); // close dialog first

//                 final provider = context.read<CompanyProvider>();

//                 await provider.logout((error) {
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     SnackBar(
//                       content: Text(error),
//                       backgroundColor: AppColors.red,
//                     ),
//                   );
//                 });

//                 if (!context.mounted) return;

//                 if (provider.errorToast == null) {
//                   // ✅ Success Snackbar
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     SnackBar(
//                       content: Text(
//                         "Logged out successfully",
//                         style: GoogleFonts.poppins(fontSize: 13),
//                       ),
//                       backgroundColor: AppColors.green,
//                       behavior: SnackBarBehavior.floating,
//                     ),
//                   );

//                   // ✅ Navigate (change to LoginScreen if needed)
//                   Navigator.pushAndRemoveUntil(
//                     context,
//                     MaterialPageRoute(builder: (_) => const LoginScreen()),
//                     (route) => false,
//                   );
//                 }
//               },
//               child: Container(
//                 padding: EdgeInsets.symmetric(vertical: 12,horizontal: 4),
//                 height: 50,
//                 width: 80,
//                 alignment: Alignment.center,
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(10),
//                   color: AppColors.amber
//                 ),
//                 child: Text("Logout",style:GoogleFonts.poppins(color:AppColors.white),),
//               ),
//             )
//           ],
//         );
//       },
//     );
//   }
// }

// class _DashCard extends StatelessWidget {
//   final String label;
//   final Color bgColor;
//   final Color countColor;
//   final Color labelColor;
//   final Color subColor;
//   final Color iconBgColor;
//   final IconData icon;
//   final VoidCallback onTap;

//   const _DashCard({
//     required this.label,
//     required this.bgColor,
//     required this.countColor,
//     required this.labelColor,
//     required this.subColor,
//     required this.iconBgColor,
//     required this.icon,
//     required this.onTap,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: onTap,
//       child: Container(
//         width: double.infinity,
//         padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 20),
//         decoration: BoxDecoration(
//           color: bgColor,
//           borderRadius: BorderRadius.circular(22),
//         ),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   FittedBox(
//                     fit: BoxFit.scaleDown,
//                     alignment: Alignment.centerLeft,
//                     child: Text(
//                       label,
//                       style: GoogleFonts.poppins(
//                         fontSize: 16,
//                         fontWeight: FontWeight.w500,
//                         color: labelColor,
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 3),
//                 ],
//               ),
//             ),
//             const SizedBox(width: 8),
//             Container(
//               width: 44,
//               height: 44,
//               decoration: BoxDecoration(
//                 color: iconBgColor,
//                 borderRadius: BorderRadius.circular(16),
//               ),
//               child: Icon(icon, color: countColor, size: 24),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }



import 'dart:math';
import 'package:construction_app/provider/company_provider.dart';
import 'package:construction_app/services/app_config.dart';
import 'package:construction_app/view/company/payment_list_screen.dart';
import 'package:construction_app/view/company/site_list_screen.dart';
import 'package:construction_app/view/company/report_screen.dart';
import 'package:construction_app/view/company/user_screen.dart';
import 'package:construction_app/view/company/widgets/trial_banner_widget.dart';
import 'package:construction_app/view/login_screen.dart';
import 'package:construction_app/widgets/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

// ─────────────────────────────────────────────────────────────────────────────
// Helpers
// ─────────────────────────────────────────────────────────────────────────────

String _getInitials(String? name) {
  if (name == null || name.trim().isEmpty) return 'U';
  final parts = name.trim().split(RegExp(r'\s+'));
  if (parts.length >= 2) return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
  return parts[0][0].toUpperCase();
}

String _greeting() {
  final h = DateTime.now().hour;
  if (h < 12) return 'Good Morning';
  if (h < 17) return 'Good Afternoon';
  return 'Good Evening';
}

String _dateString() {
  const days = ['Monday','Tuesday','Wednesday','Thursday','Friday','Saturday','Sunday'];
  const months = ['Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'];
  final n = DateTime.now();
  return '${days[n.weekday - 1]}, ${n.day} ${months[n.month - 1]} ${n.year}';
}

// ─────────────────────────────────────────────────────────────────────────────
// Dashboard Screen
// ─────────────────────────────────────────────────────────────────────────────

class DashboardScreen extends StatefulWidget {
  final Function(int)? onNavigate;
  const DashboardScreen({super.key, this.onNavigate});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animController;
  late Animation<double> _fadeAnim;
  late Animation<Offset> _slideAnim;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..forward();
    _fadeAnim = CurvedAnimation(parent: _animController, curve: Curves.easeOut);
    _slideAnim = Tween<Offset>(
      begin: const Offset(0, 0.05),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _animController, curve: Curves.easeOutCubic));
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.greyBg,
      body: Column(
        children: [
          // ── Sticky header ──────────────────────────────────────────────
          _Header(onLogout: () => _showLogoutDialog(context)),

          // ── Scrollable body ────────────────────────────────────────────
          Expanded(
            child: FadeTransition(
              opacity: _fadeAnim,
              child: SlideTransition(
                position: _slideAnim,
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.fromLTRB(16, 20, 16, 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Trial banner
                      const TrialBannerWidget(),
                      const SizedBox(height: 22),

                      // Section label
                      _SectionLabel(label: 'QUICK ACCESS'),
                      const SizedBox(height: 14),

                      // Big cards (Supervisor, Sites, Report)
                      _AnimatedCard(delay: 0.0, child: _BigDashCard(
                        label: 'Supervisor',
                        icon: Icons.supervised_user_circle_rounded,
                        gradient: const [Color(0xFF4F46E5), Color(0xFF6366F1)],
                        iconBg: Colors.white12,
                        labelColor: Colors.white,
                        onTap: () => Navigator.push(context,
                          MaterialPageRoute(builder: (_) => const UserScreen())),
                      )),
                      const SizedBox(height: 12),

                      _AnimatedCard(delay: 0.08, child: _BigDashCard(
                        label: 'My Sites',
                        icon: Icons.domain_rounded,
                        gradient: const [Color(0xFFF59E0B), Color(0xFFD97706)],
                        iconBg: Colors.black12,
                        labelColor: AppColors.dark,
                        onTap: () => Navigator.push(context,
                          MaterialPageRoute(builder: (_) => const SitesScreen())),
                      )),
                      const SizedBox(height: 12),

                      _AnimatedCard(delay: 0.16, child: _BigDashCard(
                        label: 'Reports',
                        icon: Icons.bar_chart_rounded,
                        gradient: const [Color(0xFF1A1A2E), Color(0xFF2D2D4E)],
                        iconBg: Colors.white12,
                        labelColor: Colors.white,
                        onTap: () => Navigator.push(context,
                          MaterialPageRoute(builder: (_) => const ReportsScreen())),
                      )),
                      const SizedBox(height: 12),

                      // ── Two-column quick cards ─────────────────────────
                      _AnimatedCard(
                        delay: 0.24,
                        child: Row(
                          children: [
                            Expanded(
                              child: _SmallDashCard(
                                label: 'Payments',
                                icon: Icons.payment_rounded,
                                gradient: const [Color(0xFFEA580C), Color(0xFFC2410C)],
                                onTap: () => Navigator.push(context,
                                  MaterialPageRoute(builder: (_) =>
                                    const PaymentListScreen(paymentType: 1))),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: _SmallDashCard(
                                label: 'Receipts',
                                icon: Icons.receipt_long_rounded,
                                gradient: const [Color(0xFF4F46E5), Color(0xFF6366F1)],
                                onTap: () => Navigator.push(context,
                                  MaterialPageRoute(builder: (_) =>
                                    const PaymentListScreen(paymentType: 2))),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ── Logout dialog ─────────────────────────────────────────────────────────
  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: const EdgeInsets.symmetric(horizontal: 32),
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(22),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.12),
                blurRadius: 40,
                offset: const Offset(0, 16),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: AppColors.amberLight,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Icon(Icons.logout_rounded,
                    color: AppColors.amber, size: 28),
              ),
              const SizedBox(height: 16),
              Text('Sign Out?',
                  style: GoogleFonts.poppins(
                      fontSize: 18, fontWeight: FontWeight.w700,
                      color: AppColors.dark)),
              const SizedBox(height: 6),
              Text('Are you sure you want to sign out\nfrom RealLine?',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                      fontSize: 13, color: AppColors.grey, height: 1.5)),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(ctx),
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: AppColors.border),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                      ),
                      child: Text('Cancel',
                          style: GoogleFonts.poppins(
                              fontSize: 14, fontWeight: FontWeight.w600,
                              color: AppColors.grey)),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () async {
                        Navigator.pop(ctx);
                        final provider =
                            context.read<CompanyProvider>();
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
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Signed out successfully',
                                  style: GoogleFonts.poppins(fontSize: 13)),
                              backgroundColor: AppColors.green,
                              behavior: SnackBarBehavior.floating,
                            ),
                          );
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const LoginScreen()),
                            (route) => false,
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.amber,
                        foregroundColor: AppColors.dark,
                        elevation: 0,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                      ),
                      child: Text('Sign Out',
                          style: GoogleFonts.poppins(
                              fontSize: 14, fontWeight: FontWeight.w700)),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Header widget
// ─────────────────────────────────────────────────────────────────────────────

class _Header extends StatelessWidget {
  final VoidCallback onLogout;
  const _Header({required this.onLogout});

  @override
  Widget build(BuildContext context) {
    final top = MediaQuery.of(context).padding.top;

    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF1A1A2E), Color(0xFF2D2D4E)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Stack(
        children: [
          // ── dot-grid texture ───────────────────────────────────────
          Positioned.fill(child: CustomPaint(painter: _DotGridPainter())),

          // ── ambient blobs ──────────────────────────────────────────
          Positioned(
            top: -40, right: -40,
            child: Container(
              width: 160, height: 160,
              decoration: BoxDecoration(
                color: AppColors.amber.withOpacity(0.08),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            bottom: -30, left: -30,
            child: Container(
              width: 120, height: 120,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.03),
                shape: BoxShape.circle,
              ),
            ),
          ),

          // ── content ────────────────────────────────────────────────
          Padding(
            padding: EdgeInsets.fromLTRB(22, top + 20, 22, 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Left: greeting + name + date
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${_greeting()}, ${(AppConfig.userName ?? 'User').split(' ').first} 👋',
                            style: GoogleFonts.poppins(
                              fontSize: 12.5,
                              color: AppColors.greyLight,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'RealLine',
                            style: GoogleFonts.poppins(
                              fontSize: 22,
                              fontWeight: FontWeight.w800,
                              color: Colors.white,
                              letterSpacing: -0.4,
                            ),
                          ),
                          Text(
                            'CONSTRUCTIONS',
                            style: GoogleFonts.poppins(
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFF6366F1),
                              letterSpacing: 2.5,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Row(
                            children: [
                              const Icon(Icons.calendar_today_outlined,
                                  size: 11, color: Color(0xFF6B7280)),
                              const SizedBox(width: 4),
                              Text(
                                _dateString(),
                                style: GoogleFonts.poppins(
                                  fontSize: 11,
                                  color: const Color(0xFF6B7280),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    // Right: logout + avatar
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        // Logout chip
                        GestureDetector(
                          onTap: onLogout,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.09),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: Colors.white.withOpacity(0.12),
                              ),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(Icons.logout_rounded,
                                    size: 14, color: Colors.white),
                                const SizedBox(width: 6),
                                Text(
                                  'Logout',
                                  style: GoogleFonts.poppins(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),

                        // Avatar
                        Container(
                          width: 46,
                          height: 46,
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [AppColors.amber, Color(0xFFD97706)],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(14),
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.amber.withOpacity(0.45),
                                blurRadius: 14,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Center(
                            child: Text(
                              _getInitials(AppConfig.userName),
                              style: GoogleFonts.poppins(
                                fontSize: 16,
                                fontWeight: FontWeight.w800,
                                color: AppColors.navy,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Section label
// ─────────────────────────────────────────────────────────────────────────────

class _SectionLabel extends StatelessWidget {
  final String label;
  const _SectionLabel({required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 3, height: 16,
          decoration: BoxDecoration(
            color: AppColors.amber,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 8),
        Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 11,
            fontWeight: FontWeight.w700,
            color: AppColors.greyLight,
            letterSpacing: 1.5,
          ),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Big dashboard card (Supervisor / Sites / Reports)
// ─────────────────────────────────────────────────────────────────────────────

class _BigDashCard extends StatefulWidget {
  final String label;
  final IconData icon;
  final List<Color> gradient;
  final Color iconBg;
  final Color labelColor;
  final VoidCallback onTap;

  const _BigDashCard({
    required this.label,
    required this.icon,
    required this.gradient,
    required this.iconBg,
    required this.labelColor,
    required this.onTap,
  });

  @override
  State<_BigDashCard> createState() => _BigDashCardState();
}

class _BigDashCardState extends State<_BigDashCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _tapCtrl;
  late Animation<double> _scaleAnim;

  @override
  void initState() {
    super.initState();
    _tapCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 120),
      lowerBound: 0.96,
      upperBound: 1.0,
    )..value = 1.0;
    _scaleAnim = _tapCtrl;
  }

  @override
  void dispose() {
    _tapCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => _tapCtrl.reverse(),
      onTapUp: (_) {
        _tapCtrl.forward();
        widget.onTap();
      },
      onTapCancel: () => _tapCtrl.forward(),
      child: ScaleTransition(
        scale: _scaleAnim,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: widget.gradient,
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(22),
            boxShadow: [
              BoxShadow(
                color: widget.gradient[0].withOpacity(0.35),
                blurRadius: 18,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Stack(
            children: [
              // Background blobs
              Positioned(
                right: -16, top: -16,
                child: Container(
                  width: 80, height: 80,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.07),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              Positioned(
                right: 24, bottom: -24,
                child: Container(
                  width: 60, height: 60,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.04),
                    shape: BoxShape.circle,
                  ),
                ),
              ),

              // Content
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.label,
                        style: GoogleFonts.poppins(
                          fontSize: 17,
                          fontWeight: FontWeight.w700,
                          color: widget.labelColor,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Text(
                            'Tap to view',
                            style: GoogleFonts.poppins(
                              fontSize: 11.5,
                              color: widget.labelColor.withOpacity(0.55),
                            ),
                          ),
                          const SizedBox(width: 4),
                          Icon(
                            Icons.arrow_forward_rounded,
                            size: 12,
                            color: widget.labelColor.withOpacity(0.55),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: widget.iconBg,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Icon(
                      widget.icon,
                      color: widget.labelColor,
                      size: 26,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Small dashboard card (Payments / Receipts)
// ─────────────────────────────────────────────────────────────────────────────

class _SmallDashCard extends StatefulWidget {
  final String label;
  final IconData icon;
  final List<Color> gradient;
  final VoidCallback onTap;

  const _SmallDashCard({
    required this.label,
    required this.icon,
    required this.gradient,
    required this.onTap,
  });

  @override
  State<_SmallDashCard> createState() => _SmallDashCardState();
}

class _SmallDashCardState extends State<_SmallDashCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _tapCtrl;

  @override
  void initState() {
    super.initState();
    _tapCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 120),
      lowerBound: 0.96,
      upperBound: 1.0,
    )..value = 1.0;
  }

  @override
  void dispose() {
    _tapCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => _tapCtrl.reverse(),
      onTapUp: (_) {
        _tapCtrl.forward();
        widget.onTap();
      },
      onTapCancel: () => _tapCtrl.forward(),
      child: ScaleTransition(
        scale: _tapCtrl,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: widget.gradient,
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(22),
            boxShadow: [
              BoxShadow(
                color: widget.gradient[0].withOpacity(0.35),
                blurRadius: 16,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Stack(
            children: [
              Positioned(
                right: -10, bottom: -10,
                child: Container(
                  width: 64, height: 64,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.07),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 42,
                    height: 42,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(13),
                    ),
                    child: Icon(widget.icon, color: Colors.white, size: 22),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    widget.label,
                    style: GoogleFonts.poppins(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Row(
                    children: [
                      Text(
                        'View all',
                        style: GoogleFonts.poppins(
                          fontSize: 11,
                          color: Colors.white.withOpacity(0.55),
                        ),
                      ),
                      const SizedBox(width: 3),
                      Icon(Icons.arrow_forward_rounded,
                          size: 11,
                          color: Colors.white.withOpacity(0.55)),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Staggered animation wrapper
// ─────────────────────────────────────────────────────────────────────────────

class _AnimatedCard extends StatefulWidget {
  final Widget child;
  final double delay;
  const _AnimatedCard({required this.child, required this.delay});

  @override
  State<_AnimatedCard> createState() => _AnimatedCardState();
}

class _AnimatedCardState extends State<_AnimatedCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _fade;
  late Animation<Offset> _slide;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _fade = CurvedAnimation(parent: _ctrl, curve: Curves.easeOut);
    _slide = Tween<Offset>(
      begin: const Offset(0, 0.12),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeOutCubic));

    Future.delayed(
      Duration(milliseconds: (widget.delay * 1000).toInt() + 300),
      () { if (mounted) _ctrl.forward(); },
    );
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => FadeTransition(
        opacity: _fade,
        child: SlideTransition(position: _slide, child: widget.child),
      );
}

// ─────────────────────────────────────────────────────────────────────────────
// Dot grid painter
// ─────────────────────────────────────────────────────────────────────────────

class _DotGridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.05)
      ..style = PaintingStyle.fill;
    const spacing = 24.0;
    const r = 1.2;
    for (double x = spacing; x < size.width; x += spacing) {
      for (double y = spacing; y < size.height; y += spacing) {
        canvas.drawCircle(Offset(x, y), r, paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}