// import 'package:construction_app/view/phone_verification_screen.dart';
// import 'package:construction_app/view/registration_screen.dart';
// import 'package:construction_app/widgets/app_theme.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:construction_app/services/shared_preference_helper.dart';
// import 'package:construction_app/view/login_screen.dart';
// import 'package:construction_app/view/user/main_userscreen.dart';
// import 'package:construction_app/view/company/main_screen.dart';

// class SplashScreen extends StatefulWidget {
//   const SplashScreen({super.key});

//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }

// class _SplashScreenState extends State<SplashScreen> {
//   @override
//   void initState() {
//     super.initState();
//     _checkLoginState();
//   }

//   // Future<void> _checkLoginState() async {
//   //   await Future.delayed(const Duration(seconds: 2));

//   //   String token = await SharedPreferenceHelper.getToken();
//   //   String role = await SharedPreferenceHelper.getRole();
//   //   await SharedPreferenceHelper.getCompanyId();
//   //   await SharedPreferenceHelper.getUserName();

//   //   if (!mounted) return;

//   //   if (token.isNotEmpty) {
//   //     if (role.toLowerCase() == 'supervisor') {
//   //       Navigator.pushReplacement(
//   //         context,
//   //         MaterialPageRoute(builder: (_) => const MainUserScreen()),
//   //       );
//   //     } else {
//   //       Navigator.pushReplacement(
//   //         context,
//   //         MaterialPageRoute(builder: (_) => const MainScreen()),
//   //       );
//   //     }
//   //   } else {
//   //     Navigator.pushReplacement(
//   //       context,
//   //       MaterialPageRoute(builder: (_) => const LoginScreen()),
//   //     );
//   //   }
//   // }



//   Future<void> _checkLoginState() async {
//   await Future.delayed(const Duration(seconds: 2));
//   if (!mounted) return;

//   // ── First ever launch → go to Registration ──────────────────────
//   final firstLaunch = await SharedPreferenceHelper.isFirstLaunch();
//   if (firstLaunch) {
//     await SharedPreferenceHelper.setFirstLaunchDone();
//     Navigator.pushReplacement(
//       context,
//       MaterialPageRoute(builder: (_) =>  PhoneVerificationScreen()),
//     );
//     return;
//   }

//   // ── Returning user → check token ────────────────────────────────
//   final String token = await SharedPreferenceHelper.getToken();
//   final String role  = await SharedPreferenceHelper.getRole();

//   if (token.isNotEmpty) {
//     Navigator.pushReplacement(
//       context,
//       MaterialPageRoute(
//         builder: (_) => role.toLowerCase() == 'supervisor'
//             ? const MainUserScreen()
//             : const MainScreen(),
//       ),
//     );
//   } else {
//     Navigator.pushReplacement(
//       context,
//       MaterialPageRoute(builder: (_) => const LoginScreen()),
//     );
//   }
// }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.navy,
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Container(
//               width: 96,
//               height: 96,
//               decoration: BoxDecoration(
//                 color: AppColors.amber,
//                 borderRadius: BorderRadius.circular(24),
//               ),
//               child: Image.asset(
//                 'assets/image/construction_logo.jpeg',
//                 width: 100,
//                 height: 100,
//                 fit: BoxFit.contain,
//               ),
//             ),
//             const SizedBox(height: 24),
//             Text(
//               'RealLine',
//               style: GoogleFonts.poppins(
//                 color: AppColors.white,
//                 fontSize: 32,
//                 fontWeight: FontWeight.w700,
//               ),
//             ),
//             const SizedBox(height: 8),
//             Text(
//               'Site Management Platform',
//               style: GoogleFonts.poppins(
//                 color: AppColors.greyLight,
//                 fontSize: 14,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }


// ══════════════════════════════════════════════════════════════════════════════
// UPDATED SPLASH SCREEN
// Handles: first launch → OTP → Password → Registration popup
//          returning user → check subscription → dashboard or payment
// Replace your existing splash_screen.dart with this file
// ══════════════════════════════════════════════════════════════════════════════

import 'package:construction_app/provider/version_provider.dart';
import 'package:construction_app/view/company/payment_subscription_screen.dart';
import 'package:construction_app/view/phone_verification_screen.dart';
import 'package:construction_app/widgets/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:construction_app/services/shared_preference_helper.dart';
import 'package:construction_app/view/login_screen.dart';
import 'package:construction_app/view/user/main_userscreen.dart';
import 'package:construction_app/view/company/main_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animController;
  late Animation<double> _scaleAnim;
  late Animation<double> _fadeAnim;

  @override
  void initState() {
    super.initState();

    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..forward();

    _scaleAnim = Tween<double>(begin: 0.7, end: 1.0).animate(
      CurvedAnimation(parent: _animController, curve: Curves.elasticOut),
    );
    _fadeAnim = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animController,
        curve: const Interval(0.0, 0.6, curve: Curves.easeIn),
      ),
    );

    _checkLoginState();
  }

  Future<void> _checkLoginState() async {
    await Future.delayed(const Duration(seconds: 2));
    if (!mounted) return;

    // ── First ever launch → go to Phone Verification ────────────────────
    final firstLaunch = await SharedPreferenceHelper.isFirstLaunch();
    if (firstLaunch) {
      await SharedPreferenceHelper.setFirstLaunchDone();
      _navigate(PhoneVerificationScreen());
      return;
    }

    // ── Returning user → check OTP verification ────────────────────────
    final bool otpVerified = await SharedPreferenceHelper.isOtpVerified();
    if (!otpVerified) {
      _navigate(PhoneVerificationScreen());
      return;
    }

    // ── Returning user → check auth token ───────────────────────────────
    final String token = await SharedPreferenceHelper.getToken();
    final String role = await SharedPreferenceHelper.getRole();

    if (token.isEmpty) {
      _navigate(const LoginScreen());
      return;
    }

    // // ── Logged in → check trial / subscription ───────────────────────────
    // final canAccess = await TrialService.canAccessApp();
    // if (!canAccess) {
    //   _navigate(const PaymentScreen());
    //   return;
    // }

    // final trialExpired = await SharedPreferenceHelper.getTrialExpired();
    // if (trialExpired) {
    //   _navigate(const PaymentScreen());
    //   return;
    // }


    /// ── CHECK APP UPDATE ─────────────────────────────────────────────
final versionProvider = VersionProvider();

await versionProvider.fetchVersion();

final isUpdateAvailable = versionProvider.isUpdateAvailable();

if (isUpdateAvailable) {
  _navigate(const MainScreen());
  return;
}

/// ── CHECK TRIAL ─────────────────────────────────────────────────
final trialExpired = await SharedPreferenceHelper.getTrialExpired();

if (trialExpired) {
  _navigate(const PaymentScreen());
  return;
}

    // ── All good → go to dashboard ───────────────────────────────────────
    _navigate(
      role.toLowerCase() == 'supervisor'
          ? const MainUserScreen()
          : const MainScreen(),
    );
  }

  void _navigate(Widget page) {
    if (!mounted) return;
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        pageBuilder: (_, anim, __) => page,
        transitionsBuilder: (_, anim, __, child) => FadeTransition(
          opacity: anim,
          child: child,
        ),
        transitionDuration: const Duration(milliseconds: 500),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.navy,
      body: Stack(
        children: [
          // Decorative circles
          Positioned(
            top: -80,
            right: -80,
            child: Container(
              width: 260,
              height: 260,
              decoration: BoxDecoration(
                color: AppColors.amber.withOpacity(0.08),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            bottom: -120,
            left: -60,
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.04),
                shape: BoxShape.circle,
              ),
            ),
          ),

          // Center content
          Center(
            child: FadeTransition(
              opacity: _fadeAnim,
              child: ScaleTransition(
                scale: _scaleAnim,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Logo
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [AppColors.amber, Color(0xFFD97706)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(28),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.amber.withOpacity(0.4),
                            blurRadius: 32,
                            offset: const Offset(0, 10),
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.domain_rounded,
                        color: AppColors.navy,
                        size: 52,
                      ),
                    ),
                    const SizedBox(height: 28),

                    Text(
                      'Bpro',
                      style: GoogleFonts.poppins(
                        color: AppColors.white,
                        fontSize: 36,
                        fontWeight: FontWeight.w800,
                        letterSpacing: -0.5,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Site Management Platform',
                      style: GoogleFonts.poppins(
                        color: AppColors.greyLight,
                        fontSize: 14,
                        letterSpacing: 0.5,
                      ),
                    ),
                    const SizedBox(height: 48),

                    // Loading indicator
                    SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(
                        strokeWidth: 2.5,
                        valueColor: AlwaysStoppedAnimation(
                          AppColors.amber.withOpacity(0.7),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Version text at bottom
          Positioned(
            bottom: 32,
            left: 0,
            right: 0,
            child: FadeTransition(
              opacity: _fadeAnim,
              child: Text(
                'v1.0.0',
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  fontSize: 11,
                  color: AppColors.greyLight.withOpacity(0.5),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }
}