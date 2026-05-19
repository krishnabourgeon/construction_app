// import 'package:construction_app/models/profile_model.dart';
// import 'package:construction_app/provider/company_provider.dart';
// import 'package:construction_app/provider/login_provider.dart';
// import 'package:construction_app/services/shared_preference_helper.dart';
// import 'package:construction_app/services/trial_services.dart';
// import 'package:construction_app/view/login_screen.dart';
// import 'package:construction_app/view/registration_screen.dart';
// import 'package:construction_app/widgets/app_theme.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:provider/provider.dart';

// class ProfileScreen extends StatefulWidget {
//   final bool isRegistered;
//   final VoidCallback? onRegistrationComplete;

//   const ProfileScreen({
//     super.key,
//     required this.isRegistered,
//     this.onRegistrationComplete,
//   });

//   @override
//   State<ProfileScreen> createState() => _ProfileScreenState();
// }

// class _ProfileScreenState extends State<ProfileScreen>
//     with SingleTickerProviderStateMixin {
//   String _userName = '';
//   String _phone = '';
//    ProfileData? _subStatus;

  

//   late AnimationController _bannerController;
//   late Animation<double> _bannerAnim;

//   @override
//   void initState() {
//     super.initState();


//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       context.read<CompanyProvider>().getProfile(null);
//     });
//     _bannerController = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 700),
//     );
//     _bannerAnim = CurvedAnimation(
//       parent: _bannerController,
//       curve: Curves.easeOutBack,
//     );
//     _loadData();
//   }

//   Future<void> _loadData() async {
//     final name = await SharedPreferenceHelper.getUserName();
//     final phone = await SharedPreferenceHelper.getPhone();
//     //final status = await TrialService.getStatus();
//     final profileData = await context.read<CompanyProvider>().getProfile(null);
//     if (!mounted) return;
//     setState(() {
//       _userName = name.isNotEmpty ? name : 'User';
//       _phone = phone;
//       _subStatus = profileData;
//     });
//     if (!widget.isRegistered) _bannerController.forward();
//   }

//   Future<void> _logout() async {
//     final confirmed = await showDialog<bool>(
//       context: context,
//       builder: (ctx) => Dialog(
//         backgroundColor: Colors.transparent,
//         child: Container(
//           padding: const EdgeInsets.all(24),
//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(20),
//           ),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Container(
//                 width: 56,
//                 height: 56,
//                 decoration: BoxDecoration(
//                   color: AppColors.redLight,
//                   borderRadius: BorderRadius.circular(16),
//                 ),
//                 child: const Icon(Icons.logout_rounded,
//                     color: AppColors.red, size: 28),
//               ),
//               const SizedBox(height: 16),
//               Text('Sign Out?',
//                   style: GoogleFonts.poppins(
//                       fontSize: 18,
//                       fontWeight: FontWeight.w700,
//                       color: AppColors.dark)),
//               const SizedBox(height: 8),
//               Text('You will need to sign in again to access your account.',
//                   textAlign: TextAlign.center,
//                   style: GoogleFonts.poppins(
//                       fontSize: 13, color: AppColors.grey, height: 1.5)),
//               const SizedBox(height: 24),
//               Row(
//                 children: [
//                   Expanded(
//                     child: OutlinedButton(
//                       onPressed: () => Navigator.pop(ctx, false),
//                       style: OutlinedButton.styleFrom(
//                         side: const BorderSide(color: AppColors.border),
//                         shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(12)),
//                         padding: const EdgeInsets.symmetric(vertical: 14),
//                       ),
//                       child: Text('Cancel',
//                           style: GoogleFonts.poppins(
//                               fontSize: 14,
//                               fontWeight: FontWeight.w600,
//                               color: AppColors.grey)),
//                     ),
//                   ),
//                   const SizedBox(width: 12),
//                   Expanded(
//                     child: ElevatedButton(
//                       onPressed: () => Navigator.pop(ctx, true),
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: AppColors.red,
//                         foregroundColor: Colors.white,
//                         elevation: 0,
//                         shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(12)),
//                         padding: const EdgeInsets.symmetric(vertical: 14),
//                       ),
//                       child: Text('Sign Out',
//                           style: GoogleFonts.poppins(
//                               fontSize: 14, fontWeight: FontWeight.w600)),
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );

//     if (confirmed == true && mounted) {
//       // Show loading indicator
//       showDialog(
//         context: context,
//         barrierDismissible: false,
//         builder: (context) => const Center(
//           child: CircularProgressIndicator(color: AppColors.amber),
//         ),
//       );

//       await Provider.of<LoginProvider>(context, listen: false).logout(
//         onSuccess: () {
//           if (mounted) {
//             Navigator.pop(context); // Close loading indicator
//             Navigator.pushAndRemoveUntil(
//               context,
//               MaterialPageRoute(builder: (_) => const LoginScreen()),
//               (route) => false,
//             );
//           }
//         },
//         onFailure: (errorMessage) {
//           if (mounted) {
//             Navigator.pop(context); // Close loading indicator
//             ScaffoldMessenger.of(context).showSnackBar(
//               SnackBar(
//                 content: Text(errorMessage),
//                 backgroundColor: AppColors.red,
//               ),
//             );
//           }
//         },
//       );
//     }
//   }

//   void _goToRegistration() {
//     Navigator.push(
//       context,
//       PageRouteBuilder(
//         pageBuilder: (_, anim, __) => const CompanyRegisterScreen(),
//         transitionsBuilder: (_, anim, __, child) => SlideTransition(
//           position: Tween<Offset>(
//             begin: const Offset(0, 1),
//             end: Offset.zero,
//           ).animate(CurvedAnimation(parent: anim, curve: Curves.easeOutCubic)),
//           child: child,
//         ),
//         transitionDuration: const Duration(milliseconds: 400),
//       ),
//     ).then((_) {
//       // After returning from registration, notify parent if completed
//       // TODO: check if registration was actually completed
//        widget.onRegistrationComplete?.call();
//     });
//   }

//   @override
//   Widget build(BuildContext context) {



//     final initials = _userName.isNotEmpty
//         ? _userName.trim().split(' ').map((w) => w[0]).take(2).join().toUpperCase()
//         : 'U';

//     return Scaffold(
//       backgroundColor: const Color(0xFFF8F9FC),
//       body: CustomScrollView(
//         slivers: [
//           // ── App bar / header ───────────────────────────────────────────
//           SliverAppBar(
//             expandedHeight: 220,
//             pinned: true,
//             backgroundColor: AppColors.navy,
//             automaticallyImplyLeading: false,
//             flexibleSpace: FlexibleSpaceBar(
//               background: Stack(
//                 children: [
//                   // Background blobs
//                   Positioned(
//                     top: -30,
//                     right: -30,
//                     child: Container(
//                       width: 160,
//                       height: 160,
//                       decoration: BoxDecoration(
//                         color: AppColors.amber.withOpacity(0.1),
//                         shape: BoxShape.circle,
//                       ),
//                     ),
//                   ),
//                   Positioned(
//                     bottom: -20,
//                     left: -40,
//                     child: Container(
//                       width: 140,
//                       height: 140,
//                       decoration: BoxDecoration(
//                         color: Colors.white.withOpacity(0.04),
//                         shape: BoxShape.circle,
//                       ),
//                     ),
//                   ),

//                   // Content
//                   SafeArea(
//                     child: Padding(
//                       padding:
//                           const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Row(
//                             children: [
//                               Text(
//                                 'Profile',
//                                 style: GoogleFonts.poppins(
//                                   fontSize: 20,
//                                   fontWeight: FontWeight.w700,
//                                   color: Colors.white,
//                                 ),
//                               ),
//                               const Spacer(),
//                               // Settings icon
//                               _HeaderIconBtn(
//                                 icon: Icons.settings_outlined,
//                                 onTap: () {},
//                               ),
//                             ],
//                           ),
//                           const SizedBox(height: 20),
//                           Row(
//                             children: [
//                               // Avatar
//                               Container(
//                                 width: 64,
//                                 height: 64,
//                                 decoration: BoxDecoration(
//                                   gradient: const LinearGradient(
//                                     colors: [
//                                       AppColors.amber,
//                                       Color(0xFFD97706)
//                                     ],
//                                     begin: Alignment.topLeft,
//                                     end: Alignment.bottomRight,
//                                   ),
//                                   shape: BoxShape.circle,
//                                   boxShadow: [
//                                     BoxShadow(
//                                       color: AppColors.amber.withOpacity(0.4),
//                                       blurRadius: 16,
//                                       offset: const Offset(0, 4),
//                                     ),
//                                   ],
//                                 ),
//                                 child: Center(
//                                   child: Text(
//                                     initials,
//                                     style: GoogleFonts.poppins(
//                                       fontSize: 22,
//                                       fontWeight: FontWeight.w800,
//                                       color: AppColors.navy,
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                               const SizedBox(width: 16),
//                               Expanded(
//                                 child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Text(
//                                       _userName.isNotEmpty
//                                           ? _userName
//                                           : 'Loading...',
//                                       style: GoogleFonts.poppins(
//                                         fontSize: 18,
//                                         fontWeight: FontWeight.w700,
//                                         color: Colors.white,
//                                       ),
//                                     ),
//                                     const SizedBox(height: 4),
//                                     if (_phone.isNotEmpty)
//                                       Row(
//                                         children: [
//                                           const Icon(Icons.phone_outlined,
//                                               size: 12,
//                                               color: AppColors.greyLight),
//                                           const SizedBox(width: 4),
//                                           Text(
//                                             '+91 $_phone',
//                                             style: GoogleFonts.poppins(
//                                               fontSize: 12,
//                                               color: AppColors.greyLight,
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                     const SizedBox(height: 6),
//                                     // Subscription badge
//                                     _SubBadge(status: _subStatus),
//                                   ],
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),

//           // ── Body ──────────────────────────────────────────────────────
//           SliverToBoxAdapter(
//             child: Column(
//               children: [
//                 const SizedBox(height: 20),

//                 // ── Incomplete Registration Banner (shows if not registered)
//                 if (!widget.isRegistered)
//                   ScaleTransition(
//                     scale: _bannerAnim,
//                     child: _RegistrationBanner(onTap: _goToRegistration),
//                   ),

//                 // ── Account section ────────────────────────────────────
//                 _SectionTitle(title: 'Account'),
//                 _ProfileCard(
//                   children: [
//                     _ProfileTile(
//                       icon: Icons.business_outlined,
//                       iconColor: AppColors.amber,
//                       iconBg: AppColors.amberLight,
//                       title: 'Company Profile',
//                       subtitle: widget.isRegistered
//                           ? 'View & edit company details'
//                           : 'Not registered yet',
//                       trailing: widget.isRegistered
//                           ? null
//                           : Container(
//                               padding: const EdgeInsets.symmetric(
//                                   horizontal: 8, vertical: 3),
//                               decoration: BoxDecoration(
//                                 color: AppColors.amberLight,
//                                 borderRadius: BorderRadius.circular(6),
//                               ),
//                               child: Text('Pending',
//                                   style: GoogleFonts.poppins(
//                                       fontSize: 10,
//                                       fontWeight: FontWeight.w700,
//                                       color: AppColors.amberDark)),
//                             ),
//                       onTap: widget.isRegistered ? () {} : _goToRegistration,
//                     ),
//                     _Divider(),
//                     _ProfileTile(
//                       icon: Icons.lock_outline_rounded,
//                       iconColor: AppColors.blue,
//                       iconBg: AppColors.blueLight,
//                       title: 'Change Password',
//                       subtitle: 'Update your login password',
//                       onTap: () {},
//                     ),
//                     _Divider(),
//                     _ProfileTile(
//                       icon: Icons.notifications_outlined,
//                       iconColor: const Color(0xFF7C3AED),
//                       iconBg: AppColors.purpleLight,
//                       title: 'Notifications',
//                       subtitle: 'Manage alert preferences',
//                       onTap: () {},
//                     ),
//                   ],
//                 ),

//                 // ── Subscription section ───────────────────────────────
//                 _SectionTitle(title: 'Subscription'),
//                 _ProfileCard(
//                   children: [
//                     _ProfileTile(
//                       icon: Icons.workspace_premium_outlined,
//                       iconColor: AppColors.amber,
//                       iconBg: AppColors.amberLight,
//                       title: 'Current Plan',
//                       subtitle: _subStatus?.subscription.plan ?? 'Loading...',
//                       trailing: _subStatus != null
//                           ? _DaysLeftChip(status: _subStatus!)
//                           : null,
//                       onTap: () {},
//                     ),
//                     _Divider(),
//                     // _ProfileTile(
//                     //   icon: Icons.receipt_long_outlined,
//                     //   iconColor: AppColors.green,
//                     //   iconBg: AppColors.greenLight,
//                     //   title: 'Billing & Invoices',
//                     //   subtitle: 'View payment history',
//                     //   onTap: () {},
//                     // ),
//                   ],
//                 ),

//                 // ── App section ────────────────────────────────────────
//                 _SectionTitle(title: 'App'),
//                 _ProfileCard(
//                   children: [
//                     _ProfileTile(
//                       icon: Icons.help_outline_rounded,
//                       iconColor: const Color(0xFF0891B2),
//                       iconBg: const Color(0xFFCFFAFE),
//                       title: 'Help & Support',
//                       subtitle: 'FAQs, contact us',
//                       onTap: () {},
//                     ),
//                     _Divider(),
//                     _ProfileTile(
//                       icon: Icons.privacy_tip_outlined,
//                       iconColor: AppColors.grey,
//                       iconBg: AppColors.greyBg,
//                       title: 'Privacy Policy',
//                       subtitle: 'How we use your data',
//                       onTap: () {},
//                     ),
//                     _Divider(),
//                     _ProfileTile(
//                       icon: Icons.info_outline_rounded,
//                       iconColor: AppColors.grey,
//                       iconBg: AppColors.greyBg,
//                       title: 'App Version',
//                       subtitle: _subStatus?.app?.version ?? '',
//                       showArrow: false,
//                       onTap: null,
//                     ),
//                   ],
//                 ),

//                 // ── Logout button ──────────────────────────────────────
//                 Padding(
//                   padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
//                   child: InkWell(
//                     onTap: _logout,
//                     borderRadius: BorderRadius.circular(16),
//                     child: Container(
//                       width: double.infinity,
//                       padding: const EdgeInsets.symmetric(vertical: 16),
//                       decoration: BoxDecoration(
//                         color: AppColors.redLight,
//                         borderRadius: BorderRadius.circular(16),
//                         border: Border.all(
//                             color: AppColors.red.withOpacity(0.2),
//                             width: 1.5),
//                       ),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           const Icon(Icons.logout_rounded,
//                               color: AppColors.red, size: 20),
//                           const SizedBox(width: 10),
//                           Text(
//                             'Sign Out',
//                             style: GoogleFonts.poppins(
//                               fontSize: 15,
//                               fontWeight: FontWeight.w700,
//                               color: AppColors.red,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),

//                 const SizedBox(height: 24),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     _bannerController.dispose();
//     super.dispose();
//   }
// }

// // ══════════════════════════════════════════════════════════════════════════════
// // INCOMPLETE REGISTRATION BANNER
// // ══════════════════════════════════════════════════════════════════════════════

// class _RegistrationBanner extends StatefulWidget {
//   final VoidCallback onTap;
//   const _RegistrationBanner({required this.onTap});

//   @override
//   State<_RegistrationBanner> createState() => _RegistrationBannerState();
// }

// class _RegistrationBannerState extends State<_RegistrationBanner>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _shimmerController;
//   late Animation<double> _shimmerAnim;

//   @override
//   void initState() {
//     super.initState();
//     _shimmerController = AnimationController(
//       vsync: this,
//       duration: const Duration(seconds: 2),
//     )..repeat();
//     _shimmerAnim = _shimmerController;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: widget.onTap,
//       child: Container(
//         margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
//         decoration: BoxDecoration(
//           gradient: const LinearGradient(
//             colors: [AppColors.navy, Color(0xFF2D2D4E)],
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//           ),
//           borderRadius: BorderRadius.circular(20),
//           boxShadow: [
//             BoxShadow(
//               color: AppColors.navy.withOpacity(0.3),
//               blurRadius: 20,
//               offset: const Offset(0, 6),
//             ),
//           ],
//         ),
//         child: Stack(
//           children: [
//             // Shimmer overlay
//             Positioned.fill(
//               child: AnimatedBuilder(
//                 animation: _shimmerAnim,
//                 builder: (_, __) => ClipRRect(
//                   borderRadius: BorderRadius.circular(20),
//                   child: ShaderMask(
//                     shaderCallback: (rect) {
//                       return LinearGradient(
//                         begin: Alignment(-2 + _shimmerAnim.value * 4, 0),
//                         end: Alignment(-1 + _shimmerAnim.value * 4, 0),
//                         colors: [
//                           Colors.transparent,
//                           Colors.white.withOpacity(0.04),
//                           Colors.transparent,
//                         ],
//                       ).createShader(rect);
//                     },
//                     child: Container(
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.circular(20),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ),

//             // Content
//             Padding(
//               padding: const EdgeInsets.all(18),
//               child: Row(
//                 children: [
//                   // Icon
//                   Container(
//                     width: 52,
//                     height: 52,
//                     decoration: BoxDecoration(
//                       gradient: const LinearGradient(
//                         colors: [AppColors.amber, Color(0xFFD97706)],
//                         begin: Alignment.topLeft,
//                         end: Alignment.bottomRight,
//                       ),
//                       borderRadius: BorderRadius.circular(15),
//                       boxShadow: [
//                         BoxShadow(
//                           color: AppColors.amber.withOpacity(0.35),
//                           blurRadius: 12,
//                           offset: const Offset(0, 4),
//                         ),
//                       ],
//                     ),
//                     child: const Icon(
//                       Icons.domain_add_rounded,
//                       color: AppColors.navy,
//                       size: 26,
//                     ),
//                   ),
//                   const SizedBox(width: 16),

//                   // Text
//                   Expanded(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Row(
//                           children: [
//                             Flexible(
//                               child: Text(
//                                 'Complete Registration',
//                                 style: GoogleFonts.poppins(
//                                   fontSize: 15,
//                                   fontWeight: FontWeight.w700,
//                                   color: Colors.white,
//                                 ),
//                                 overflow: TextOverflow.ellipsis,
//                               ),
//                             ),
//                             const SizedBox(width: 8),
//                             Container(
//                               padding: const EdgeInsets.symmetric(
//                                   horizontal: 7, vertical: 2),
//                               decoration: BoxDecoration(
//                                 color: const Color(0xFFEF4444),
//                                 borderRadius: BorderRadius.circular(6),
//                               ),
//                               child: Text(
//                                 'Pending',
//                                 style: GoogleFonts.poppins(
//                                   fontSize: 9,
//                                   fontWeight: FontWeight.w800,
//                                   color: Colors.white,
//                                   letterSpacing: 0.3,
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                         const SizedBox(height: 4),
//                         Text(
//                           'Set up your company profile to unlock all features and manage your sites',
//                           style: GoogleFonts.poppins(
//                             fontSize: 11.5,
//                             color: AppColors.greyLight,
//                             height: 1.4,
//                           ),
//                         ),
//                         const SizedBox(height: 10),
//                         // Progress stepper dots
//                         Row(
//                           children: [
//                             _StepDot(done: true, label: 'Phone'),
//                             _StepLine(done: true),
//                             _StepDot(done: true, label: 'Password'),
//                             _StepLine(done: false),
//                             _StepDot(done: false, label: 'Company'),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                   const SizedBox(width: 8),

//                   // Arrow
//                   Container(
//                     width: 36,
//                     height: 36,
//                     decoration: BoxDecoration(
//                       color: AppColors.amber.withOpacity(0.15),
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                     child: const Icon(
//                       Icons.arrow_forward_rounded,
//                       color: AppColors.amber,
//                       size: 18,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     _shimmerController.dispose();
//     super.dispose();
//   }
// }

// class _StepDot extends StatelessWidget {
//   final bool done;
//   final String label;
//   const _StepDot({required this.done, required this.label});

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Container(
//           width: 16,
//           height: 16,
//           decoration: BoxDecoration(
//             color: done ? AppColors.amber : Colors.white.withOpacity(0.15),
//             shape: BoxShape.circle,
//             border: Border.all(
//               color:
//                   done ? AppColors.amber : Colors.white.withOpacity(0.3),
//               width: 1.5,
//             ),
//           ),
//           child: done
//               ? const Icon(Icons.check, size: 10, color: AppColors.navy)
//               : null,
//         ),
//         const SizedBox(height: 3),
//         Text(
//           label,
//           style: GoogleFonts.poppins(
//             fontSize: 9,
//             color: done ? AppColors.amber : AppColors.greyLight,
//             fontWeight: done ? FontWeight.w600 : FontWeight.w400,
//           ),
//         ),
//       ],
//     );
//   }
// }

// class _StepLine extends StatelessWidget {
//   final bool done;
//   const _StepLine({required this.done});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: 28,
//       height: 2,
//       margin: const EdgeInsets.only(bottom: 12),
//       decoration: BoxDecoration(
//         color: done ? AppColors.amber : Colors.white.withOpacity(0.15),
//         borderRadius: BorderRadius.circular(1),
//       ),
//     );
//   }
// }

// // ══════════════════════════════════════════════════════════════════════════════
// // HELPER WIDGETS
// // ══════════════════════════════════════════════════════════════════════════════

// class _SectionTitle extends StatelessWidget {
//   final String title;
//   const _SectionTitle({required this.title});

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
//       child: Text(
//         title.toUpperCase(),
//         style: GoogleFonts.poppins(
//           fontSize: 11,
//           fontWeight: FontWeight.w700,
//           color: AppColors.greyLight,
//           letterSpacing: 1.2,
//         ),
//       ),
//     );
//   }
// }

// class _ProfileCard extends StatelessWidget {
//   final List<Widget> children;
//   const _ProfileCard({required this.children});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(18),
//         border: Border.all(color: AppColors.border, width: 1),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.04),
//             blurRadius: 12,
//             offset: const Offset(0, 3),
//           ),
//         ],
//       ),
//       child: Column(children: children),
//     );
//   }
// }

// class _ProfileTile extends StatelessWidget {
//   final IconData icon;
//   final Color iconColor;
//   final Color iconBg;
//   final String title;
//   final String subtitle;
//   final Widget? trailing;
//   final bool showArrow;
//   final VoidCallback? onTap;

//   const _ProfileTile({
//     required this.icon,
//     required this.iconColor,
//     required this.iconBg,
//     required this.title,
//     required this.subtitle,
//     this.trailing,
//     this.showArrow = true,
//     this.onTap,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: onTap,
//       borderRadius: BorderRadius.circular(18),
//       child: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
//         child: Row(
//           children: [
//             Container(
//               width: 40,
//               height: 40,
//               decoration: BoxDecoration(
//                 color: iconBg,
//                 borderRadius: BorderRadius.circular(12),
//               ),
//               child: Icon(icon, color: iconColor, size: 20),
//             ),
//             const SizedBox(width: 14),
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     title,
//                     style: GoogleFonts.poppins(
//                       fontSize: 14,
//                       fontWeight: FontWeight.w600,
//                       color: AppColors.dark,
//                     ),
//                   ),
//                   Text(
//                     subtitle,
//                     style: GoogleFonts.poppins(
//                         fontSize: 12, color: AppColors.grey),
//                   ),
//                 ],
//               ),
//             ),
//             if (trailing != null) ...[
//               const SizedBox(width: 8),
//               trailing!,
//             ],
//             if (showArrow && trailing == null)
//               const Icon(Icons.chevron_right_rounded,
//                   color: AppColors.greyLight, size: 20),
//             if (showArrow && trailing != null)
//               const SizedBox(width: 4),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class _Divider extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) => const Divider(
//         height: 1,
//         indent: 70,
//         endIndent: 16,
//         color: AppColors.border,
//       );
// }

// class _HeaderIconBtn extends StatelessWidget {
//   final IconData icon;
//   final VoidCallback onTap;
//   const _HeaderIconBtn({required this.icon, required this.onTap});

//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: onTap,
//       borderRadius: BorderRadius.circular(10),
//       child: Container(
//         padding: const EdgeInsets.all(8),
//         decoration: BoxDecoration(
//           color: Colors.white.withOpacity(0.08),
//           borderRadius: BorderRadius.circular(10),
//           border: Border.all(color: Colors.white.withOpacity(0.12)),
//         ),
//         child: Icon(icon, color: Colors.white, size: 20),
//       ),
//     );
//   }
// }

// class _SubBadge extends StatelessWidget {
//   final ProfileData? status;
//   const _SubBadge({required this.status});

//   @override
//   Widget build(BuildContext context) {
//     if (status == null) return const SizedBox.shrink();

//     final plan = status!.subscription.plan.toLowerCase();
//     final isPro = plan == 'active';
//     final isExpired = status!.subscription.trialExpired;
//     final isTrial = !isPro && !isExpired;

//     Color bg;
//     Color text;
//     IconData icon;
//     String label;

//     if (isPro) {
//       bg = AppColors.greenLight;
//       text = AppColors.green;
//       icon = Icons.workspace_premium_rounded;
//       label = 'Pro · ${status!.subscription.trialDaysLeft}d left';
//     } else if (isTrial) {
//       bg = AppColors.amberLight;
//       text = AppColors.amberDark;
//       icon = Icons.hourglass_top_rounded;
//       label = 'Free Trial · ${status!.subscription.trialDaysLeft}d left';
//     } else {
//       bg = AppColors.redLight;
//       text = AppColors.red;
//       icon = Icons.lock_outline_rounded;
//       label = 'Trial Expired';
//     }

//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
//       decoration: BoxDecoration(
//         color: bg,
//         borderRadius: BorderRadius.circular(8),
//       ),
//       child: Row(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Icon(icon, size: 12, color: text),
//           const SizedBox(width: 4),
//           Text(
//             label,
//             style: GoogleFonts.poppins(
//               fontSize: 11,
//               fontWeight: FontWeight.w600,
//               color: text,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class _DaysLeftChip extends StatelessWidget {
//   final ProfileData status;
//   const _DaysLeftChip({required this.status});

//   @override
//   Widget build(BuildContext context) {
//     final days = status.subscription.trialDaysLeft;
//     final isPro = status.subscription.plan.toLowerCase() == 'active';

//     Color color = days > 7
//         ? (isPro ? AppColors.green : AppColors.navy)
//         : days > 3
//             ? AppColors.amberDark
//             : AppColors.red;

//     Color bg = days > 7
//         ? (isPro ? AppColors.greenLight : const Color(0xFFEEF2FF))
//         : days > 3
//             ? AppColors.amberLight
//             : AppColors.redLight;

//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
//       decoration: BoxDecoration(
//         color: bg,
//         borderRadius: BorderRadius.circular(8),
//       ),
//       child: Text(
//         '$days days left',
//         style: GoogleFonts.poppins(
//           fontSize: 12,
//           fontWeight: FontWeight.w700,
//           color: color,
//         ),
//       ),
//     );
//   }
// }

import 'package:construction_app/models/profile_model.dart';
import 'package:construction_app/provider/company_provider.dart';
import 'package:construction_app/provider/login_provider.dart';
import 'package:construction_app/services/shared_preference_helper.dart';
import 'package:construction_app/view/company/change_password_screen.dart';
import 'package:construction_app/view/company/edit_company_profile_screen.dart';
import 'package:construction_app/view/company/privacy_policy_screen.dart';
import 'package:construction_app/view/login_screen.dart';
import 'package:construction_app/view/profile_register_screen.dart';
import 'package:construction_app/view/registration_screen.dart';
import 'package:construction_app/widgets/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  final bool isRegistered;
  final VoidCallback? onRegistrationComplete;

  const ProfileScreen({
    super.key,
    required this.isRegistered,
    this.onRegistrationComplete,
  });

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with SingleTickerProviderStateMixin {
  String _userName = '';
  String _phone = '';
  ProfileData? _profileData;

  late AnimationController _bannerController;
  late Animation<double> _bannerAnim;

  @override
  void initState() {
    super.initState();
    _bannerController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );
    _bannerAnim = CurvedAnimation(
      parent: _bannerController,
      curve: Curves.easeOutBack,
    );
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadData();
    });
  }

  Future<void> _loadData() async {
    final name  = await SharedPreferenceHelper.getUserName();
    final phone = await SharedPreferenceHelper.getPhone();
    final profileData =
        await context.read<CompanyProvider>().getProfile(null);
    if (!mounted) return;
    setState(() {
      _userName    = profileData?.name ?? (name.isNotEmpty ? name : 'User');
      _phone       = profileData?.mobile ?? phone;
      _profileData = profileData;
    });
    bool isCompleted = profileData?.registration.status == 'completed' && 
                      profileData?.company.address != null;
    if (!isCompleted) {
      _bannerController.forward();
    } else {
      _bannerController.reverse();
    }
  }

  Future<void> _logout() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => Dialog(
        backgroundColor: Colors.transparent,
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 56, height: 56,
                decoration: BoxDecoration(
                  color: AppColors.redLight,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Icon(Icons.logout_rounded,
                    color: AppColors.red, size: 28),
              ),
              const SizedBox(height: 16),
              Text('Sign Out?',
                  style: GoogleFonts.poppins(
                      fontSize: 18, fontWeight: FontWeight.w700,
                      color: AppColors.dark)),
              const SizedBox(height: 8),
              Text(
                'You will need to sign in again to access your account.',
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                    fontSize: 13, color: AppColors.grey, height: 1.5),
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(ctx, false),
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: AppColors.border),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                        padding: const EdgeInsets.symmetric(vertical: 14),
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
                      onPressed: () => Navigator.pop(ctx, true),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.red,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      child: Text('Sign Out',
                          style: GoogleFonts.poppins(
                              fontSize: 14, fontWeight: FontWeight.w600)),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );

    if (confirmed == true && mounted) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(
          child: CircularProgressIndicator(color: AppColors.amber),
        ),
      );

      await Provider.of<LoginProvider>(context, listen: false).logout(
        onSuccess: () {
          if (mounted) {
            Navigator.pop(context);
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (_) => const LoginScreen()),
              (route) => false,
            );
          }
        },
        onFailure: (errorMessage) {
          if (mounted) {
            Navigator.pop(context);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(errorMessage),
                backgroundColor: AppColors.red,
              ),
            );
          }
        },
      );
    }
  }

  void _goToRegistration() {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (_, anim, __) => ProfileRegisterScreen(
          onSuccess: () {
            // Notify MainScreen to update _isRegistered
            widget.onRegistrationComplete?.call();
            // Refresh profile data
            _loadData();
          },
        ),
        transitionsBuilder: (_, anim, __, child) => SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0, 1),
            end: Offset.zero,
          ).animate(
              CurvedAnimation(parent: anim, curve: Curves.easeOutCubic)),
          child: child,
        ),
        transitionDuration: const Duration(milliseconds: 400),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isRegisteredComplete = (_profileData?.registration.status == 'completed' &&
                                _profileData?.company.address != null);

    final initials = _userName.isNotEmpty
        ? _userName
            .trim()
            .split(' ')
            .map((w) => w[0])
            .take(2)
            .join()
            .toUpperCase()
        : 'U';

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FC),
      body: CustomScrollView(
        slivers: [
          // ── App bar / header ─────────────────────────────────────────
          SliverAppBar(
            expandedHeight: 220,
            pinned: true,
            backgroundColor: AppColors.navy,
            automaticallyImplyLeading: false,
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                children: [
                  Positioned(
                    top: -30, right: -30,
                    child: Container(
                      width: 160, height: 160,
                      decoration: BoxDecoration(
                        color: AppColors.amber.withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: -20, left: -40,
                    child: Container(
                      width: 140, height: 140,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.04),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                  SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text('Profile',
                                  style: GoogleFonts.poppins(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white,
                                  )),
                              const Spacer(),
                              _HeaderIconBtn(
                                icon: Icons.settings_outlined,
                                onTap: () {},
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Row(
                            children: [
                              // Avatar
                              Container(
                                width: 64, height: 64,
                                decoration: BoxDecoration(
                                  gradient: const LinearGradient(
                                    colors: [AppColors.amber, Color(0xFFD97706)],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  ),
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      color: AppColors.amber.withOpacity(0.4),
                                      blurRadius: 16,
                                      offset: const Offset(0, 4),
                                    ),
                                  ],
                                ),
                                child: Center(
                                  child: Text(initials,
                                      style: GoogleFonts.poppins(
                                        fontSize: 22,
                                        fontWeight: FontWeight.w800,
                                        color: AppColors.navy,
                                      )),
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      _userName.isNotEmpty
                                          ? _userName
                                          : 'Loading...',
                                      style: GoogleFonts.poppins(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.white,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    if (_phone.isNotEmpty)
                                      Row(
                                        children: [
                                          const Icon(Icons.phone_outlined,
                                              size: 12,
                                              color: AppColors.greyLight),
                                          const SizedBox(width: 4),
                                          Text('+91 $_phone',
                                              style: GoogleFonts.poppins(
                                                fontSize: 12,
                                                color: AppColors.greyLight,
                                              )),
                                        ],
                                      ),
                                    const SizedBox(height: 6),
                                    _SubBadge(profileData: _profileData),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // ── Body ────────────────────────────────────────────────────
          SliverToBoxAdapter(
            child: Column(
              children: [
                const SizedBox(height: 20),

                // Registration banner
                if (_profileData != null && 
                    (_profileData!.registration.status != 'completed' || 
                     _profileData!.company.address == null))
                  ScaleTransition(
                    scale: _bannerAnim,
                    child: _RegistrationBanner(
                      profileData: _profileData!,
                      steps: _profileData!.registration.steps,
                      onTap: _goToRegistration,
                    ),
                  ),

                // Account section
                _SectionTitle(title: 'Account'),
                _ProfileCard(
                  children: [
                    _ProfileTile(
                      icon: Icons.business_outlined,
                      iconColor: AppColors.amber,
                      iconBg: AppColors.amberLight,
                      title: 'Company Profile',
                      subtitle: isRegisteredComplete
                          ? 'View & edit company details'
                          : 'Not registered yet',
                      trailing: isRegisteredComplete
                          ? null
                          : Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 3),
                              decoration: BoxDecoration(
                                color: AppColors.amberLight,
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Text('Pending',
                                  style: GoogleFonts.poppins(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w700,
                                      color: AppColors.amberDark)),
                            ),
                      onTap: isRegisteredComplete ? () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => EditCompanyProfileScreen(
                              profileData: _profileData!,
                              onSaved: () => _loadData(),
                            ),
                          ),
                        ).then((_) => _loadData());
                      } : _goToRegistration,
                    ),
                    _Divider(),
                    _ProfileTile(
                      icon: Icons.lock_outline_rounded,
                      iconColor: AppColors.blue,
                      iconBg: AppColors.blueLight,
                      title: 'Change Password',
                      subtitle: 'Update your login password',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const ChangePasswordScreen(),
                          ),
                        );
                      },
                    ),
                    // _Divider(),
                    // _ProfileTile(
                    //   icon: Icons.notifications_outlined,
                    //   iconColor: const Color(0xFF7C3AED),
                    //   iconBg: AppColors.purpleLight,
                    //   title: 'Notifications',
                    //   subtitle: 'Manage alert preferences',
                    //   onTap: () {},
                    // ),
                  ],
                ),

                // Subscription section
                _SectionTitle(title: 'Subscription'),
                _ProfileCard(
                  children: [
                    _ProfileTile(
                      icon: Icons.workspace_premium_outlined,
                      iconColor: AppColors.amber,
                      iconBg: AppColors.amberLight,
                      title: 'Current Plan',
                      subtitle: _profileData?.subscription.plan ?? 'Loading...',
                      trailing: _profileData != null
                          ? _DaysLeftChip(profileData: _profileData!)
                          : null,
                      onTap: () {},
                    ),
                  ],
                ),

                // App section
                _SectionTitle(title: 'App'),
                _ProfileCard(
                  children: [
                    // _ProfileTile(
                    //   icon: Icons.help_outline_rounded,
                    //   iconColor: const Color(0xFF0891B2),
                    //   iconBg: const Color(0xFFCFFAFE),
                    //   title: 'Help & Support',
                    //   subtitle: 'FAQs, contact us',
                    //   onTap: () {},
                    // ),
                    // _Divider(),
                    _ProfileTile(
                      icon: Icons.privacy_tip_outlined,
                      iconColor: AppColors.grey,
                      iconBg: AppColors.greyBg,
                      title: 'Privacy Policy',
                      subtitle: 'How we use your data',
                      onTap: () {
                        //Navigator.push(context, MaterialPageRoute(builder: (context) => PrivacyPolicyScreen(),));
                      },
                    ),
                    _Divider(),
                    _ProfileTile(
                      icon: Icons.info_outline_rounded,
                      iconColor: AppColors.grey,
                      iconBg: AppColors.greyBg,
                      title: 'App Version',
                      subtitle: _profileData?.app.version ?? '1.0.0',
                      showArrow: false,
                      onTap: null,
                    ),
                  ],
                ),

                // Logout button
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                  child: InkWell(
                    onTap: _logout,
                    borderRadius: BorderRadius.circular(16),
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      decoration: BoxDecoration(
                        color: AppColors.redLight,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                            color: AppColors.red.withOpacity(0.2), width: 1.5),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.logout_rounded,
                              color: AppColors.red, size: 20),
                          const SizedBox(width: 10),
                          Text('Sign Out',
                              style: GoogleFonts.poppins(
                                fontSize: 15, fontWeight: FontWeight.w700,
                                color: AppColors.red,
                              )),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _bannerController.dispose();
    super.dispose();
  }
}

// ══════════════════════════════════════════════════════════════════════════════
// REGISTRATION BANNER
// ══════════════════════════════════════════════════════════════════════════════

class _RegistrationBanner extends StatefulWidget {
  final ProfileData profileData;
  final List<RegistrationStep> steps;
  final VoidCallback onTap;
  const _RegistrationBanner({
    required this.profileData,
    required this.steps,
    required this.onTap,
  });

  @override
  State<_RegistrationBanner> createState() => _RegistrationBannerState();
}

class _RegistrationBannerState extends State<_RegistrationBanner>
    with SingleTickerProviderStateMixin {
  late AnimationController _shimmerController;
  late Animation<double> _shimmerAnim;

  @override
  void initState() {
    super.initState();
    _shimmerController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();
    _shimmerAnim = _shimmerController;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [AppColors.navy, Color(0xFF2D2D4E)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: AppColors.navy.withOpacity(0.3),
              blurRadius: 20, offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Stack(
          children: [
            Positioned.fill(
              child: AnimatedBuilder(
                animation: _shimmerAnim,
                builder: (_, __) => ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: ShaderMask(
                    shaderCallback: (rect) => LinearGradient(
                      begin: Alignment(-2 + _shimmerAnim.value * 4, 0),
                      end: Alignment(-1 + _shimmerAnim.value * 4, 0),
                      colors: [
                        Colors.transparent,
                        Colors.white.withOpacity(0.04),
                        Colors.transparent,
                      ],
                    ).createShader(rect),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(18),
              child: Row(
                children: [
                  Container(
                    width: 52, height: 52,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [AppColors.amber, Color(0xFFD97706)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.amber.withOpacity(0.35),
                          blurRadius: 12, offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: const Icon(Icons.domain_add_rounded,
                        color: AppColors.navy, size: 26),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Flexible(
                              child: Text('Complete Registration',
                                  style: GoogleFonts.poppins(
                                    fontSize: 15, fontWeight: FontWeight.w700,
                                    color: Colors.white,
                                  ),
                                  overflow: TextOverflow.ellipsis),
                            ),
                            const SizedBox(width: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 7, vertical: 2),
                              decoration: BoxDecoration(
                                color: const Color(0xFFEF4444),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Text('Pending',
                                  style: GoogleFonts.poppins(
                                    fontSize: 9, fontWeight: FontWeight.w800,
                                    color: Colors.white, letterSpacing: 0.3,
                                  )),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Set up your company profile to unlock all features',
                          style: GoogleFonts.poppins(
                              fontSize: 11.5,
                              color: AppColors.greyLight, height: 1.4),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: List.generate(widget.steps.length, (i) {
                            final step = widget.steps[i];
                            final isLast = i == widget.steps.length - 1;
                            return Expanded(
                              flex: isLast ? 0 : 1,
                              child: Row(
                                children: [
                                  _StepDot(
                                      done: (step.key == 'company' &&
                                              widget.profileData.company
                                                      .address ==
                                                  null)
                                          ? false
                                          : step.completed,
                                      label: step.label),
                                  if (!isLast)
                                    Expanded(
                                        child: _StepLine(
                                            done: (step.key == 'company' &&
                                                    widget.profileData.company
                                                            .address ==
                                                        null)
                                                ? false
                                                : step.completed)),
                                ],
                              ),
                            );
                          }),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    width: 36, height: 36,
                    decoration: BoxDecoration(
                      color: AppColors.amber.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(Icons.arrow_forward_rounded,
                        color: AppColors.amber, size: 18),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _shimmerController.dispose();
    super.dispose();
  }
}

class _StepDot extends StatelessWidget {
  final bool done;
  final String label;
  const _StepDot({required this.done, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 16, height: 16,
          decoration: BoxDecoration(
            color: done ? AppColors.amber : Colors.white.withOpacity(0.15),
            shape: BoxShape.circle,
            border: Border.all(
              color: done ? AppColors.amber : Colors.white.withOpacity(0.3),
              width: 1.5,
            ),
          ),
          child: done
              ? const Icon(Icons.check, size: 10, color: AppColors.navy)
              : null,
        ),
        const SizedBox(height: 3),
        Text(label,
            style: GoogleFonts.poppins(
              fontSize: 9,
              color: done ? AppColors.amber : AppColors.greyLight,
              fontWeight: done ? FontWeight.w600 : FontWeight.w400,
            )),
      ],
    );
  }
}

class _StepLine extends StatelessWidget {
  final bool done;
  const _StepLine({required this.done});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 28, height: 2,
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: done ? AppColors.amber : Colors.white.withOpacity(0.15),
        borderRadius: BorderRadius.circular(1),
      ),
    );
  }
}

// ══════════════════════════════════════════════════════════════════════════════
// HELPER WIDGETS
// ══════════════════════════════════════════════════════════════════════════════

class _SectionTitle extends StatelessWidget {
  final String title;
  const _SectionTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
      child: Text(title.toUpperCase(),
          style: GoogleFonts.poppins(
            fontSize: 11, fontWeight: FontWeight.w700,
            color: AppColors.greyLight, letterSpacing: 1.2,
          )),
    );
  }
}

class _ProfileCard extends StatelessWidget {
  final List<Widget> children;
  const _ProfileCard({required this.children});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.border, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 12, offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(children: children),
    );
  }
}

class _ProfileTile extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final Color iconBg;
  final String title;
  final String subtitle;
  final Widget? trailing;
  final bool showArrow;
  final VoidCallback? onTap;

  const _ProfileTile({
    required this.icon,
    required this.iconColor,
    required this.iconBg,
    required this.title,
    required this.subtitle,
    this.trailing,
    this.showArrow = true,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(18),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          children: [
            Container(
              width: 40, height: 40,
              decoration: BoxDecoration(
                color: iconBg, borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: iconColor, size: 20),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: GoogleFonts.poppins(
                        fontSize: 14, fontWeight: FontWeight.w600,
                        color: AppColors.dark,
                      )),
                  Text(subtitle,
                      style: GoogleFonts.poppins(
                          fontSize: 12, color: AppColors.grey)),
                ],
              ),
            ),
            if (trailing != null) ...[
              const SizedBox(width: 8),
              trailing!,
            ],
            if (showArrow && trailing == null)
              const Icon(Icons.chevron_right_rounded,
                  color: AppColors.greyLight, size: 20),
          ],
        ),
      ),
    );
  }
}

class _Divider extends StatelessWidget {
  @override
  Widget build(BuildContext context) => const Divider(
        height: 1, indent: 70, endIndent: 16, color: AppColors.border,
      );
}

class _HeaderIconBtn extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  const _HeaderIconBtn({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.08),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.white.withOpacity(0.12)),
        ),
        child: Icon(icon, color: Colors.white, size: 20),
      ),
    );
  }
}

class _SubBadge extends StatelessWidget {
  final ProfileData? profileData;
  const _SubBadge({required this.profileData});

  @override
  Widget build(BuildContext context) {
    if (profileData == null) return const SizedBox.shrink();

    final plan      = profileData!.subscription.plan.toLowerCase();
    final isPro     = plan == 'active';
    final isExpired = profileData!.subscription.trialExpired;
    final daysLeft  = profileData!.subscription.trialDaysLeft;

    final Color bg, text;
    final IconData icon;
    final String label;

    if (isPro) {
      bg = AppColors.greenLight; text = AppColors.green;
      icon = Icons.workspace_premium_rounded;
      label = 'Pro · ${daysLeft}d left';
    } else if (!isExpired) {
      bg = AppColors.amberLight; text = AppColors.amberDark;
      icon = Icons.hourglass_top_rounded;
      label = 'Free Trial · ${daysLeft}d left';
    } else {
      bg = AppColors.redLight; text = AppColors.red;
      icon = Icons.lock_outline_rounded;
      label = 'Trial Expired';
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
          color: bg, borderRadius: BorderRadius.circular(8)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12, color: text),
          const SizedBox(width: 4),
          Text(label,
              style: GoogleFonts.poppins(
                fontSize: 11, fontWeight: FontWeight.w600, color: text,
              )),
        ],
      ),
    );
  }
}

class _DaysLeftChip extends StatelessWidget {
  final ProfileData profileData;
  const _DaysLeftChip({required this.profileData});

  @override
  Widget build(BuildContext context) {
    final days  = profileData.subscription.trialDaysLeft;
    final isPro = profileData.subscription.plan.toLowerCase() == 'active';

    final color = days > 7
        ? (isPro ? AppColors.green : AppColors.navy)
        : days > 3
            ? AppColors.amberDark
            : AppColors.red;

    final bg = days > 7
        ? (isPro ? AppColors.greenLight : const Color(0xFFEEF2FF))
        : days > 3
            ? AppColors.amberLight
            : AppColors.redLight;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
          color: bg, borderRadius: BorderRadius.circular(8)),
      child: Text('$days days left',
          style: GoogleFonts.poppins(
            fontSize: 12, fontWeight: FontWeight.w700, color: color,
          )),
    );
  }
}

