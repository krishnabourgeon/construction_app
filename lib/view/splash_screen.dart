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

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkLoginState();
  }

  Future<void> _checkLoginState() async {
    await Future.delayed(const Duration(seconds: 2));
    
    String token = await SharedPreferenceHelper.getToken();
    String role = await SharedPreferenceHelper.getRole();
    await SharedPreferenceHelper.getCompanyId();
    await SharedPreferenceHelper.getUserName();

    if (!mounted) return;

    if (token.isNotEmpty) {
      if (role.toLowerCase() == 'supervisor') {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const MainUserScreen()),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const MainScreen()),
        );
      }
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const LoginScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.navy,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 96,
              height: 96,
              decoration: BoxDecoration(
                color: AppColors.amber,
                borderRadius: BorderRadius.circular(24),
              ),
              child: Image.asset(
                'assets/image/construction_logo.jpeg',
                width: 100,
                height: 100,
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'BuildXpert',
              style: GoogleFonts.poppins(
                color: AppColors.white,
                fontSize: 32,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Site Management Platform',
              style: GoogleFonts.poppins(
                color: AppColors.greyLight,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
