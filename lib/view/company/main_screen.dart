// // import 'package:construction_app/view/company/dashboard_screen.dart';
// // import 'package:construction_app/view/company/site_list_screen.dart';
// // import 'package:construction_app/view/company/supplier_screen.dart';
// // import 'package:construction_app/view/company/user_screen.dart';
// // import 'package:construction_app/widgets/app_theme.dart';
// // import 'package:flutter/material.dart';
// // import 'package:flutter/services.dart';
// // import 'package:google_fonts/google_fonts.dart';


// // class MainScreen extends StatefulWidget {
// //   const MainScreen({super.key});

// //   @override
// //   State<MainScreen> createState() => _MainScreenState();
// // }

// // class _MainScreenState extends State<MainScreen> {
// //    // final List<Site> sites = getSampleSites();
// //   int _currentIndex = 0;
// //     void changeTab(int index) {
// //     setState(() => _currentIndex = index);
// //   }

// //   late final _screens = [
// //     DashboardScreen(onNavigate: changeTab),
// //     const SupplierScreen(),
// //     const UserScreen(),
// //     const SitesScreen(),
    
// //     // ViewMaterialsScreen(sites: sites),
// //     // ViewLabourScreen(sites: sites),
// //   ];

// //   @override
// //   Widget build(BuildContext context) {
// //     SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
// //       statusBarColor: AppColors.navy,
// //       statusBarIconBrightness: Brightness.light,
// //     ));
// //     return Scaffold(
// //       body: _screens[_currentIndex],
// //       bottomNavigationBar: Container(
// //         decoration: const BoxDecoration(
// //           color: AppColors.navy,
// //           border: Border(top: BorderSide(color: Color(0xFF2D2D44), width: 1)),
// //         ),
// //         child: BottomNavigationBar(
// //           currentIndex: _currentIndex,
// //           onTap: (i) => setState(() => _currentIndex = i),
// //           backgroundColor: AppColors.navy,
// //           selectedItemColor: AppColors.amber,
// //           unselectedItemColor: AppColors.grey,
// //           type: BottomNavigationBarType.fixed,
// //           selectedLabelStyle: GoogleFonts.poppins(
// //               fontSize: 10, fontWeight: FontWeight.w600),
// //           unselectedLabelStyle:
// //               GoogleFonts.poppins(fontSize: 10),
// //           items: const [
// //             BottomNavigationBarItem(
// //               icon: Icon(Icons.home_outlined),
// //               activeIcon: Icon(Icons.home_rounded),
// //               label: 'Home',
// //             ),
// //             BottomNavigationBarItem(
// //               icon: Icon(Icons.person_outline),
// //               activeIcon: Icon(Icons.person_rounded),
// //               label: 'Supplier',
// //             ),
// //             BottomNavigationBarItem(
// //               icon: Icon(Icons.person_outline),
// //               activeIcon: Icon(Icons.person_rounded),
// //               label: 'Supervisor',
// //             ),
// //             BottomNavigationBarItem(
// //               icon: Icon(Icons.domain_outlined),
// //               activeIcon: Icon(Icons.domain_rounded),
// //               label: 'Sites',
// //             ),
// //             // BottomNavigationBarItem(
// //             //   icon: Icon(Icons.inventory_2_outlined),
// //             //   activeIcon: Icon(Icons.inventory_2_rounded),
// //             //   label: 'Materials',
// //             // ),
// //             // BottomNavigationBarItem(
// //             //   icon: Icon(Icons.people_alt_outlined),
// //             //   activeIcon: Icon(Icons.people_alt_rounded),
// //             //   label: 'Labour',
// //             // ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }




// // ══════════════════════════════════════════════════════════════════════════════
// // MAIN SCREEN  — with Profile tab in bottom nav
// // Replace lib/view/company/main_screen.dart
// // ══════════════════════════════════════════════════════════════════════════════

// import 'package:construction_app/services/shared_preference_helper.dart';
// import 'package:construction_app/view/company/dashboard_screen.dart';
// import 'package:construction_app/view/company/profile_screen.dart';
// import 'package:construction_app/view/company/site_list_screen.dart';
// import 'package:construction_app/view/company/supplier_screen.dart';
// import 'package:construction_app/view/company/user_screen.dart';
// import 'package:construction_app/widgets/app_theme.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:google_fonts/google_fonts.dart';

// class MainScreen extends StatefulWidget {
//   const MainScreen({super.key});

//   @override
//   State<MainScreen> createState() => _MainScreenState();
// }

// class _MainScreenState extends State<MainScreen> with TickerProviderStateMixin {
//   int _currentIndex = 0;

//   void changeTab(int index) => setState(() => _currentIndex = index);

//   late final List<Widget> _screens;

//   // Track whether registration is complete
//   // TODO: set this from your SharedPreferences / provider
//   // e.g. final bool _isRegistered = await SharedPreferenceHelper.getCompanyId() != 0;
//   bool _isRegistered = false; 

//   @override
//   void initState() {
//     super.initState();
//     _checkRegistration();
//     _screens = [
//       DashboardScreen(onNavigate: changeTab),
//       const SupplierScreen(),
//       const UserScreen(),
//       const SitesScreen(),
//       ProfileScreen(
//         isRegistered: _isRegistered,
//         onRegistrationComplete: () {
//           setState(() => _isRegistered = true);
//         },
//       ),
//     ];
//   }

//   Future<void> _checkRegistration() async {
//     final companyId = await SharedPreferenceHelper.getCompanyId();
//     if (mounted) {
//       setState(() {
//         _isRegistered = companyId != 0;
//         // Update the screen list if needed (though ProfileScreen uses its own state mostly)
//         _screens[4] = ProfileScreen(
//           isRegistered: _isRegistered,
//           onRegistrationComplete: () {
//             setState(() => _isRegistered = true);
//           },
//         );
//       });
//     }
//   }

//   static const _navItems = [
//     _NavItem(Icons.home_outlined,    Icons.home_rounded,       'Home'),
//     _NavItem(Icons.storefront_outlined, Icons.storefront_rounded, 'Supplier'),
//     _NavItem(Icons.supervised_user_circle_outlined, Icons.supervised_user_circle_rounded, 'Supervisor'),
//     _NavItem(Icons.domain_outlined,  Icons.domain_rounded,     'Sites'),
//     _NavItem(Icons.person_outline_rounded, Icons.person_rounded, 'Profile'),
//   ];

//   @override
//   Widget build(BuildContext context) {
//     SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
//       statusBarColor: AppColors.navy,
//       statusBarIconBrightness: Brightness.light,
//     ));

//     return Scaffold(
//       body: IndexedStack(index: _currentIndex, children: _screens),
//       bottomNavigationBar: _BottomNav(
//         currentIndex: _currentIndex,
//         items: _navItems,
//         showBadge: !_isRegistered, // show red dot on Profile when not registered
//         onTap: (i) => setState(() => _currentIndex = i),
//       ),
//     );
//   }
// }

// // ── Nav item model ─────────────────────────────────────────────────────────
// class _NavItem {
//   final IconData icon;
//   final IconData activeIcon;
//   final String label;
//   const _NavItem(this.icon, this.activeIcon, this.label);
// }

// // ── Custom bottom nav bar ──────────────────────────────────────────────────
// class _BottomNav extends StatelessWidget {
//   final int currentIndex;
//   final List<_NavItem> items;
//   final bool showBadge; // badge on last item (Profile)
//   final ValueChanged<int> onTap;

//   const _BottomNav({
//     required this.currentIndex,
//     required this.items,
//     required this.showBadge,
//     required this.onTap,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         color: AppColors.navy,
//         border: const Border(
//           top: BorderSide(color: Color(0xFF2D2D44), width: 1),
//         ),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.3),
//             blurRadius: 20,
//             offset: const Offset(0, -4),
//           ),
//         ],
//       ),
//       child: SafeArea(
//         top: false,
//         child: SizedBox(
//           height: 64,
//           child: Row(
//             children: List.generate(items.length, (i) {
//               final item = items[i];
//               final isSelected = i == currentIndex;
//               final isProfile = i == items.length - 1;

//               return Expanded(
//                 child: GestureDetector(
//                   behavior: HitTestBehavior.opaque,
//                   onTap: () => onTap(i),
//                   child: AnimatedContainer(
//                     duration: const Duration(milliseconds: 200),
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         // Icon with badge
//                         Stack(
//                           clipBehavior: Clip.none,
//                           children: [
//                             AnimatedContainer(
//                               duration: const Duration(milliseconds: 250),
//                               padding: const EdgeInsets.symmetric(
//                                   horizontal: 12, vertical: 4),
//                               decoration: BoxDecoration(
//                                 color: isSelected
//                                     ? AppColors.amber.withOpacity(0.15)
//                                     : Colors.transparent,
//                                 borderRadius: BorderRadius.circular(10),
//                               ),
//                               child: Icon(
//                                 isSelected ? item.activeIcon : item.icon,
//                                 color: isSelected
//                                     ? AppColors.amber
//                                     : AppColors.grey,
//                                 size: 22,
//                               ),
//                             ),
//                             // Red dot badge for incomplete profile
//                             if (isProfile && showBadge)
//                               Positioned(
//                                 top: -2,
//                                 right: 6,
//                                 child: Container(
//                                   width: 9,
//                                   height: 9,
//                                   decoration: BoxDecoration(
//                                     color: const Color(0xFFEF4444),
//                                     shape: BoxShape.circle,
//                                     border: Border.all(
//                                         color: AppColors.navy, width: 1.5),
//                                   ),
//                                 ),
//                               ),
//                           ],
//                         ),
//                         const SizedBox(height: 2),
//                         Text(
//                           item.label,
//                           style: GoogleFonts.poppins(
//                             fontSize: 10,
//                             fontWeight: isSelected
//                                 ? FontWeight.w700
//                                 : FontWeight.w400,
//                             color: isSelected
//                                 ? AppColors.amber
//                                 : AppColors.grey,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               );
//             }),
//           ),
//         ),
//       ),
//     );
//   }
// }





import 'package:construction_app/services/shared_preference_helper.dart';
import 'package:construction_app/view/company/dashboard_screen.dart';
import 'package:construction_app/view/company/payment_subscription_screen.dart';
import 'package:construction_app/view/company/profile_screen.dart';
import 'package:construction_app/view/company/site_list_screen.dart';
import 'package:construction_app/view/company/supplier_screen.dart';
import 'package:construction_app/view/company/user_screen.dart';
import 'package:construction_app/widgets/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with TickerProviderStateMixin {
  int _currentIndex = 0;

  // ── Trial / subscription lock state ───────────────────────────────────────
  bool _isTrialExpired = false;

  void changeTab(int index) => setState(() => _currentIndex = index);

  late final List<Widget> _screens;

  bool _isRegistered = false;

  @override
  void initState() {
    super.initState();
    _checkRegistration();
    _checkTrial(); // ── NEW ──────────────────────────────────────────────────
    _screens = [
      DashboardScreen(onNavigate: changeTab),
      const SupplierScreen(),
      const UserScreen(),
      const SitesScreen(),
      ProfileScreen(
        isRegistered: _isRegistered,
        onRegistrationComplete: () {
          setState(() => _isRegistered = true);
        },
      ),
    ];
  }

  // ── NEW: check whether trial has expired and no subscription is active ────
  Future<void> _checkTrial() async {
    final expired = await SharedPreferenceHelper.getTrialExpired();
    final hasSub = await SharedPreferenceHelper.hasSubscription();
    if (mounted) {
      setState(() => _isTrialExpired = expired && !hasSub);
    }
  }

  Future<void> _checkRegistration() async {
    final companyId = await SharedPreferenceHelper.getCompanyId();
    if (mounted) {
      setState(() {
        _isRegistered = companyId != 0;
        _screens[4] = ProfileScreen(
          isRegistered: _isRegistered,
          onRegistrationComplete: () {
            setState(() => _isRegistered = true);
          },
        );
      });
    }
  }

  static const _navItems = [
    _NavItem(Icons.home_outlined, Icons.home_rounded, 'Home'),
    _NavItem(Icons.storefront_outlined, Icons.storefront_rounded, 'Supplier'),
    _NavItem(Icons.supervised_user_circle_outlined,
        Icons.supervised_user_circle_rounded, 'Supervisor'),
    _NavItem(Icons.domain_outlined, Icons.domain_rounded, 'Sites'),
    _NavItem(Icons.person_outline_rounded, Icons.person_rounded, 'Profile'),
  ];

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: AppColors.navy,
      statusBarIconBrightness: Brightness.light,
    ));

    return Scaffold(
      // ── NEW: show payment bottom sheet when trial is expired ───────────────
      bottomSheet: _isTrialExpired ? _paymentBottomSheet() : null,

      // ── NEW: block all body touches while locked ───────────────────────────
      body: IgnorePointer(
        ignoring: _isTrialExpired,
        child: IndexedStack(index: _currentIndex, children: _screens),
      ),

      // ── NEW: block bottom nav touches while locked ─────────────────────────
      bottomNavigationBar: IgnorePointer(
        ignoring: _isTrialExpired,
        child: _BottomNav(
          currentIndex: _currentIndex,
          items: _navItems,
          showBadge: !_isRegistered,
          onTap: (i) => setState(() => _currentIndex = i),
        ),
      ),
    );
  }

  // ── NEW: payment bottom sheet ─────────────────────────────────────────────
  // Slides up from the bottom and blocks the entire app until the user
  // subscribes. After returning from PaymentScreen, _checkTrial() re-runs —
  // if they paid, hasSubscription() is true, isLocked becomes false, and
  // the sheet disappears automatically.
  Widget _paymentBottomSheet() {
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 20, 24, 32),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 20,
            offset: const Offset(0, -6),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Handle bar ────────────────────────────────────────────────────
          Center(
            child: Container(
              width: 40,
              height: 4,
              margin: const EdgeInsets.only(bottom: 20),
              decoration: BoxDecoration(
                color: AppColors.border,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),

          // ── Lock icon + heading ───────────────────────────────────────────
          Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: AppColors.amberLight,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.lock_rounded,
                    color: AppColors.amber, size: 22),
              ),
              const SizedBox(width: 14),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Trial Expired',
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: AppColors.dark,
                    ),
                  ),
                  Text(
                    'Subscribe to regain full access',
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      color: AppColors.greyLight,
                    ),
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(height: 20),

          // ── Subscribe button ──────────────────────────────────────────────
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => const PaymentScreen()),
                );
                // Re-check after returning — if paid, sheet disappears
                _checkTrial();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.amber,
                foregroundColor: AppColors.dark,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                'SUBSCRIBE NOW',
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Nav item model ─────────────────────────────────────────────────────────
class _NavItem {
  final IconData icon;
  final IconData activeIcon;
  final String label;
  const _NavItem(this.icon, this.activeIcon, this.label);
}

// ── Custom bottom nav bar ──────────────────────────────────────────────────
class _BottomNav extends StatelessWidget {
  final int currentIndex;
  final List<_NavItem> items;
  final bool showBadge;
  final ValueChanged<int> onTap;

  const _BottomNav({
    required this.currentIndex,
    required this.items,
    required this.showBadge,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.navy,
        border: const Border(
          top: BorderSide(color: Color(0xFF2D2D44), width: 1),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: 64,
          child: Row(
            children: List.generate(items.length, (i) {
              final item = items[i];
              final isSelected = i == currentIndex;
              final isProfile = i == items.length - 1;

              return Expanded(
                child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () => onTap(i),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Stack(
                          clipBehavior: Clip.none,
                          children: [
                            AnimatedContainer(
                              duration: const Duration(milliseconds: 250),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 4),
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? AppColors.amber.withOpacity(0.15)
                                    : Colors.transparent,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Icon(
                                isSelected ? item.activeIcon : item.icon,
                                color: isSelected
                                    ? AppColors.amber
                                    : AppColors.grey,
                                size: 22,
                              ),
                            ),
                            // Red dot badge for incomplete profile
                            if (isProfile && showBadge)
                              Positioned(
                                top: -2,
                                right: 6,
                                child: Container(
                                  width: 9,
                                  height: 9,
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFEF4444),
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                        color: AppColors.navy, width: 1.5),
                                  ),
                                ),
                              ),
                          ],
                        ),
                        const SizedBox(height: 2),
                        Text(
                          item.label,
                          style: GoogleFonts.poppins(
                            fontSize: 10,
                            fontWeight: isSelected
                                ? FontWeight.w700
                                : FontWeight.w400,
                            color: isSelected
                                ? AppColors.amber
                                : AppColors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}