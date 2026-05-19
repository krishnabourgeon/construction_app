import 'package:construction_app/view/user/dashboard_userscreen.dart';
import 'package:construction_app/widgets/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:construction_app/services/shared_preference_helper.dart';
import 'package:construction_app/view/company/payment_subscription_screen.dart';


class MainUserScreen extends StatefulWidget {
  const MainUserScreen({super.key});

  @override
  State<MainUserScreen> createState() => _MainUserScreenState();
}

class _MainUserScreenState extends State<MainUserScreen> {
  int _currentIndex = 0;

  final _screens = const [
    DashboardUserScreen(),
   // SitesUserScreen(),
   // MaterialsUserScreen(),
    //LabourUserScreen(),
  ];

  @override
  void initState() {
    super.initState();
    _checkTrial();
  }

  Future<void> _checkTrial() async {
    final expired = await SharedPreferenceHelper.getTrialExpired();
    final hasSub = await SharedPreferenceHelper.hasSubscription();
    if (expired && !hasSub) {
      if (mounted) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => const PaymentScreen()),
          (route) => false,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: AppColors.navy,
      statusBarIconBrightness: Brightness.light,
    ));
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: AppColors.navy,
          border: Border(top: BorderSide(color: Color(0xFF2D2D44), width: 1)),
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (i) => setState(() => _currentIndex = i),
          backgroundColor: AppColors.navy,
          selectedItemColor: AppColors.amber,
          unselectedItemColor: AppColors.grey,
          type: BottomNavigationBarType.fixed,
          selectedLabelStyle: GoogleFonts.poppins(
              fontSize: 10, fontWeight: FontWeight.w600),
          unselectedLabelStyle:
              GoogleFonts.poppins(fontSize: 10),
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              activeIcon: Icon(Icons.home_rounded),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.domain_outlined),
              activeIcon: Icon(Icons.domain_rounded),
              label: 'Sites',
            ),
            // BottomNavigationBarItem(
            //   icon: Icon(Icons.inventory_2_outlined),
            //   activeIcon: Icon(Icons.inventory_2_rounded),
            //   label: 'Materials',
            // ),
            // BottomNavigationBarItem(
            //   icon: Icon(Icons.people_alt_outlined),
            //   activeIcon: Icon(Icons.people_alt_rounded),
            //   label: 'Labour',
            // ),
          ],
        ),
      ),
    );
  }
}
