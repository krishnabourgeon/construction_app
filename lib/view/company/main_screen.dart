// import 'package:construction_app/provider/version_provider.dart';
// import 'package:construction_app/services/shared_preference_helper.dart';
// import 'package:construction_app/view/company/dashboard_screen.dart';
// import 'package:construction_app/view/company/payment_subscription_screen.dart';
// import 'package:construction_app/view/company/profile_screen.dart';
// import 'package:construction_app/view/company/site_list_screen.dart';
// import 'package:construction_app/view/company/supplier_screen.dart';
// import 'package:construction_app/view/company/user_screen.dart';
// import 'package:construction_app/widgets/app_theme.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:provider/provider.dart';

// class MainScreen extends StatefulWidget {
//   const MainScreen({super.key});

//   @override
//   State<MainScreen> createState() => _MainScreenState();
// }

// class _MainScreenState extends State<MainScreen>
//     with TickerProviderStateMixin {
//   int _currentIndex = 0;

//   // ── Trial / subscription lock state ───────────────────────────────────────
//   bool _isTrialExpired = false;

//   void changeTab(int index) => setState(() => _currentIndex = index);

//   late final List<Widget> _screens;

//   bool _isRegistered = false;

//   @override
//   void initState() {
//     super.initState();

//     _checkRegistration();
//     _checkTrial();

//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       context.read<VersionProvider>().fetchVersion();
//     });

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

//   // ── Check whether trial has expired ───────────────────────────────────────
//   Future<void> _checkTrial() async {
//     final expired = await SharedPreferenceHelper.getTrialExpired();
//     final hasSub = await SharedPreferenceHelper.hasSubscription();

//     if (mounted) {
//       setState(() => _isTrialExpired = expired && !hasSub);
//     }
//   }

//   Future<void> _checkRegistration() async {
//     final companyId = await SharedPreferenceHelper.getCompanyId();

//     if (mounted) {
//       setState(() {
//         _isRegistered = companyId != 0;

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
//     _NavItem(Icons.home_outlined, Icons.home_rounded, 'Home'),
//     _NavItem(
//       Icons.storefront_outlined,
//       Icons.storefront_rounded,
//       'Supplier',
//     ),
//     _NavItem(
//       Icons.supervised_user_circle_outlined,
//       Icons.supervised_user_circle_rounded,
//       'Supervisor',
//     ),
//     _NavItem(Icons.domain_outlined, Icons.domain_rounded, 'Sites'),
//     _NavItem(Icons.person_outline_rounded, Icons.person_rounded, 'Profile'),
//   ];

//   @override
//   Widget build(BuildContext context) {
//     final versionProvider = context.watch<VersionProvider>();
//     final isUpdateAvailable = versionProvider.isUpdateAvailable();

//     SystemChrome.setSystemUIOverlayStyle(
//       const SystemUiOverlayStyle(
//         statusBarColor: AppColors.navy,
//         statusBarIconBrightness: Brightness.light,
//       ),
//     );

//     return Scaffold(
//       // ── Bottom Sheet Priority ──────────────────────────────────────────────
//       bottomSheet: isUpdateAvailable
//           ? _updateBottomSheet(versionProvider)
//           : (_isTrialExpired ? _paymentBottomSheet() : null),

//       // ── Block app if locked/update ────────────────────────────────────────
//       body: IgnorePointer(
//         ignoring: _isTrialExpired || isUpdateAvailable,
//         child: IndexedStack(
//           index: _currentIndex,
//           children: _screens,
//         ),
//       ),

//       // ── Block nav bar if locked/update ────────────────────────────────────
//       bottomNavigationBar: IgnorePointer(
//         ignoring: _isTrialExpired || isUpdateAvailable,
//         child: _BottomNav(
//           currentIndex: _currentIndex,
//           items: _navItems,
//           showBadge: !_isRegistered,
//           onTap: (i) => setState(() => _currentIndex = i),
//         ),
//       ),
//     );
//   }

//   // ──────────────────────────────────────────────────────────────────────────
//   // PAYMENT SHEET
//   // ──────────────────────────────────────────────────────────────────────────

//   Widget _paymentBottomSheet() {
//     return Container(
//       padding: const EdgeInsets.fromLTRB(24, 20, 24, 32),
//       decoration: BoxDecoration(
//         color: AppColors.white,
//         borderRadius: const BorderRadius.vertical(
//           top: Radius.circular(20),
//         ),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.15),
//             blurRadius: 20,
//             offset: const Offset(0, -6),
//           ),
//         ],
//       ),
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Center(
//             child: Container(
//               width: 40,
//               height: 4,
//               margin: const EdgeInsets.only(bottom: 20),
//               decoration: BoxDecoration(
//                 color: AppColors.border,
//                 borderRadius: BorderRadius.circular(2),
//               ),
//             ),
//           ),

//           Row(
//             children: [
//               Container(
//                 width: 44,
//                 height: 44,
//                 decoration: BoxDecoration(
//                   color: AppColors.amberLight,
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//                 child: const Icon(
//                   Icons.lock_rounded,
//                   color: AppColors.amber,
//                   size: 22,
//                 ),
//               ),

//               const SizedBox(width: 14),

//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     'Trial Expired',
//                     style: GoogleFonts.poppins(
//                       fontSize: 16,
//                       fontWeight: FontWeight.w700,
//                       color: AppColors.dark,
//                     ),
//                   ),
//                   Text(
//                     'Subscribe to regain full access',
//                     style: GoogleFonts.poppins(
//                       fontSize: 12,
//                       color: AppColors.greyLight,
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),

//           const SizedBox(height: 20),

//           SizedBox(
//             width: double.infinity,
//             height: 50,
//             child: ElevatedButton(
//               onPressed: () async {
//                 await Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (_) => const PaymentScreen(),
//                   ),
//                 );

//                 _checkTrial();
//               },
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: AppColors.amber,
//                 foregroundColor: AppColors.dark,
//                 elevation: 0,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//               ),
//               child: Text(
//                 'SUBSCRIBE NOW',
//                 style: GoogleFonts.poppins(
//                   fontSize: 14,
//                   fontWeight: FontWeight.w700,
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   // ──────────────────────────────────────────────────────────────────────────
//   // UPDATE SHEET
//   // ──────────────────────────────────────────────────────────────────────────

//   Widget _updateBottomSheet(VersionProvider provider) {
//     return Container(
//       padding: const EdgeInsets.fromLTRB(24, 20, 24, 32),
//       decoration: BoxDecoration(
//         color: AppColors.white,
//         borderRadius: const BorderRadius.vertical(
//           top: Radius.circular(20),
//         ),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.15),
//             blurRadius: 20,
//             offset: const Offset(0, -6),
//           ),
//         ],
//       ),
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Center(
//             child: Container(
//               width: 40,
//               height: 4,
//               margin: const EdgeInsets.only(bottom: 20),
//               decoration: BoxDecoration(
//                 color: AppColors.border,
//                 borderRadius: BorderRadius.circular(2),
//               ),
//             ),
//           ),

//           Row(
//             children: [
//               Container(
//                 width: 44,
//                 height: 44,
//                 decoration: BoxDecoration(
//                   color: AppColors.amberLight,
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//                 child: const Icon(
//                   Icons.system_update_alt_rounded,
//                   color: AppColors.amber,
//                   size: 22,
//                 ),
//               ),

//               const SizedBox(width: 14),

//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     'Update Available',
//                     style: GoogleFonts.poppins(
//                       fontSize: 16,
//                       fontWeight: FontWeight.w700,
//                       color: AppColors.dark,
//                     ),
//                   ),
//                   Text(
//                     'Please update the app to continue',
//                     style: GoogleFonts.poppins(
//                       fontSize: 12,
//                       color: AppColors.greyLight,
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),

//           const SizedBox(height: 20),

//           SizedBox(
//             width: double.infinity,
//             height: 50,
//             child: ElevatedButton(
//               onPressed: provider.redirectToStore,
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: AppColors.amber,
//                 foregroundColor: AppColors.dark,
//                 elevation: 0,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//               ),
//               child: Text(
//                 'UPDATE NOW',
//                 style: GoogleFonts.poppins(
//                   fontSize: 14,
//                   fontWeight: FontWeight.w700,
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// // ────────────────────────────────────────────────────────────────────────────
// // NAV ITEM MODEL
// // ────────────────────────────────────────────────────────────────────────────

// class _NavItem {
//   final IconData icon;
//   final IconData activeIcon;
//   final String label;

//   const _NavItem(this.icon, this.activeIcon, this.label);
// }

// // ────────────────────────────────────────────────────────────────────────────
// // CUSTOM BOTTOM NAV BAR
// // ────────────────────────────────────────────────────────────────────────────

// class _BottomNav extends StatelessWidget {
//   final int currentIndex;
//   final List<_NavItem> items;
//   final bool showBadge;
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
//           top: BorderSide(
//             color: Color(0xFF2D2D44),
//             width: 1,
//           ),
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
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Stack(
//                         clipBehavior: Clip.none,
//                         children: [
//                           AnimatedContainer(
//                             duration: const Duration(milliseconds: 250),
//                             padding: const EdgeInsets.symmetric(
//                               horizontal: 12,
//                               vertical: 4,
//                             ),
//                             decoration: BoxDecoration(
//                               color: isSelected
//                                   ? AppColors.amber.withOpacity(0.15)
//                                   : Colors.transparent,
//                               borderRadius: BorderRadius.circular(10),
//                             ),
//                             child: Icon(
//                               isSelected
//                                   ? item.activeIcon
//                                   : item.icon,
//                               color: isSelected
//                                   ? AppColors.amber
//                                   : AppColors.grey,
//                               size: 22,
//                             ),
//                           ),

//                           if (isProfile && showBadge)
//                             Positioned(
//                               top: -2,
//                               right: 6,
//                               child: Container(
//                                 width: 9,
//                                 height: 9,
//                                 decoration: BoxDecoration(
//                                   color: const Color(0xFFEF4444),
//                                   shape: BoxShape.circle,
//                                   border: Border.all(
//                                     color: AppColors.navy,
//                                     width: 1.5,
//                                   ),
//                                 ),
//                               ),
//                             ),
//                         ],
//                       ),

//                       const SizedBox(height: 2),

//                       Text(
//                         item.label,
//                         style: GoogleFonts.poppins(
//                           fontSize: 10,
//                           fontWeight: isSelected
//                               ? FontWeight.w700
//                               : FontWeight.w400,
//                           color: isSelected
//                               ? AppColors.amber
//                               : AppColors.grey,
//                         ),
//                       ),
//                     ],
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




import 'package:construction_app/provider/version_provider.dart';
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
import 'package:provider/provider.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen>
    with TickerProviderStateMixin {
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
    _checkTrial();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<VersionProvider>().fetchVersion();
    });

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

  // ── Check whether trial has expired ───────────────────────────────────────
  Future<void> _checkTrial() async {
    final subscriptionStatus = await SharedPreferenceHelper.getSubscriptionStatus();

    if (mounted) {
      // Only block the app when status is explicitly 'expired'
      // 'paid' or 'trial' (active) → never block
      setState(() => _isTrialExpired = subscriptionStatus == 'expired');
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
    _NavItem(
      Icons.storefront_outlined,
      Icons.storefront_rounded,
      'Supplier',
    ),
    _NavItem(
      Icons.supervised_user_circle_outlined,
      Icons.supervised_user_circle_rounded,
      'Supervisor',
    ),
    _NavItem(Icons.domain_outlined, Icons.domain_rounded, 'Sites'),
    _NavItem(Icons.person_outline_rounded, Icons.person_rounded, 'Profile'),
  ];

  @override
  Widget build(BuildContext context) {
    final versionProvider = context.watch<VersionProvider>();
    final isUpdateAvailable = versionProvider.isUpdateAvailable();

    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: AppColors.navy,
        statusBarIconBrightness: Brightness.light,
      ),
    );

    return Scaffold(
      // ── Bottom Sheet Priority ──────────────────────────────────────────────
      bottomSheet: isUpdateAvailable
          ? _updateBottomSheet(versionProvider)
          : (_isTrialExpired ? _paymentBottomSheet() : null),

      // ── Block app if locked/update ────────────────────────────────────────
      body: IgnorePointer(
        ignoring: _isTrialExpired || isUpdateAvailable,
        child: IndexedStack(
          index: _currentIndex,
          children: _screens,
        ),
      ),

      // ── Block nav bar if locked/update ────────────────────────────────────
      bottomNavigationBar: IgnorePointer(
        ignoring: _isTrialExpired || isUpdateAvailable,
        child: _BottomNav(
          currentIndex: _currentIndex,
          items: _navItems,
          showBadge: !_isRegistered,
          onTap: (i) => setState(() => _currentIndex = i),
        ),
      ),
    );
  }

  // ──────────────────────────────────────────────────────────────────────────
  // PAYMENT SHEET
  // ──────────────────────────────────────────────────────────────────────────

  Widget _paymentBottomSheet() {
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 20, 24, 32),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(20),
        ),
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

          Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: AppColors.amberLight,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.lock_rounded,
                  color: AppColors.amber,
                  size: 22,
                ),
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

          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const PaymentScreen(),
                  ),
                );

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

  // ──────────────────────────────────────────────────────────────────────────
  // UPDATE SHEET
  // ──────────────────────────────────────────────────────────────────────────

  Widget _updateBottomSheet(VersionProvider provider) {
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 20, 24, 32),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(20),
        ),
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

          Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: AppColors.amberLight,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.system_update_alt_rounded,
                  color: AppColors.amber,
                  size: 22,
                ),
              ),

              const SizedBox(width: 14),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Update Available',
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: AppColors.dark,
                    ),
                  ),
                  Text(
                    'Please update the app to continue',
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

          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: provider.redirectToStore,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.amber,
                foregroundColor: AppColors.dark,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                'UPDATE NOW',
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

// ────────────────────────────────────────────────────────────────────────────
// NAV ITEM MODEL
// ────────────────────────────────────────────────────────────────────────────

class _NavItem {
  final IconData icon;
  final IconData activeIcon;
  final String label;

  const _NavItem(this.icon, this.activeIcon, this.label);
}

// ────────────────────────────────────────────────────────────────────────────
// CUSTOM BOTTOM NAV BAR
// ────────────────────────────────────────────────────────────────────────────

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
          top: BorderSide(
            color: Color(0xFF2D2D44),
            width: 1,
          ),
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
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Stack(
                        clipBehavior: Clip.none,
                        children: [
                          AnimatedContainer(
                            duration: const Duration(milliseconds: 250),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? AppColors.amber.withOpacity(0.15)
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Icon(
                              isSelected
                                  ? item.activeIcon
                                  : item.icon,
                              color: isSelected
                                  ? AppColors.amber
                                  : AppColors.grey,
                              size: 22,
                            ),
                          ),

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
                                    color: AppColors.navy,
                                    width: 1.5,
                                  ),
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
              );
            }),
          ),
        ),
      ),
    );
  }
}