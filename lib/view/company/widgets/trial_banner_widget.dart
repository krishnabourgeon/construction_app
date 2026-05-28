// // ══════════════════════════════════════════════════════════════════════════════
// // TRIAL BANNER WIDGET
// // Add this to the top of DashboardScreen to show trial/subscription days left
// // ══════════════════════════════════════════════════════════════════════════════

// import 'package:construction_app/services/trial_services.dart';
// import 'package:construction_app/view/company/payment_subscription_screen.dart';
// import 'package:construction_app/widgets/app_theme.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';

// class TrialBannerWidget extends StatefulWidget {
//   const TrialBannerWidget({super.key});

//   @override
//   State<TrialBannerWidget> createState() => _TrialBannerWidgetState();
// }

// class _TrialBannerWidgetState extends State<TrialBannerWidget> {
//   SubscriptionStatus? _status;

//   @override
//   void initState() {
//     super.initState();
//     _loadStatus();
//   }

//   Future<void> _loadStatus() async {
//     final status = await TrialService.getStatus();
//     if (mounted) setState(() => _status = status);
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (_status == null) return const SizedBox.shrink();

//     // If active subscription with plenty of days, show compact badge
//     if (_status!.hasActiveSubscription && _status!.subscriptionDaysRemaining > 7) {
//       return _ProBadge(daysLeft: _status!.subscriptionDaysRemaining);
//     }

//     // Trial active: show banner with days remaining
//     if (_status!.isTrialActive) {
//       return _TrialActiveBanner(
//         daysLeft: _status!.trialDaysRemaining,
//         onUpgrade: _navigateToPayment,
//       );
//     }

//     // Trial expired or sub expiring soon
//     return _ExpiredBanner(onUpgrade: _navigateToPayment);
//   }

//   void _navigateToPayment() {
//     Navigator.push(
//       context,
//       MaterialPageRoute(builder: (_) => const PaymentScreen()),
//     ).then((_) => _loadStatus());
//   }
// }

// // ── Pro badge (subscription active, many days left) ───────────────────────
// class _ProBadge extends StatelessWidget {
//   final int daysLeft;
//   const _ProBadge({required this.daysLeft});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
//       padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
//       decoration: BoxDecoration(
//         color: AppColors.greenLight,
//         borderRadius: BorderRadius.circular(12),
//         border: Border.all(color: AppColors.green.withOpacity(0.3)),
//       ),
//       child: Row(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           const Icon(Icons.verified_rounded, color: AppColors.green, size: 16),
//           const SizedBox(width: 6),
//           Text(
//             'Pro Active · $daysLeft days left',
//             style: GoogleFonts.poppins(
//               fontSize: 12,
//               fontWeight: FontWeight.w600,
//               color: AppColors.green,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// // ── Trial active banner ───────────────────────────────────────────────────
// class _TrialActiveBanner extends StatelessWidget {
//   final int daysLeft;
//   final VoidCallback onUpgrade;

//   const _TrialActiveBanner(
//       {required this.daysLeft, required this.onUpgrade});

//   Color get _bannerColor {
//     if (daysLeft > 7) return AppColors.navy;
//     if (daysLeft > 3) return const Color(0xFFD97706);
//     return const Color(0xFFDC2626);
//   }

//   Color get _bgColor {
//     if (daysLeft > 7) return const Color(0xFFEEF2FF);
//     if (daysLeft > 3) return AppColors.amberLight;
//     return AppColors.redLight;
//   }

//   IconData get _icon {
//     if (daysLeft > 7) return Icons.hourglass_top_rounded;
//     if (daysLeft > 3) return Icons.hourglass_bottom_rounded;
//     return Icons.warning_amber_rounded;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: const EdgeInsets.fromLTRB(16, 8, 16, 4),
//       padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//       decoration: BoxDecoration(
//         color: _bgColor,
//         borderRadius: BorderRadius.circular(14),
//         border: Border.all(color: _bannerColor.withOpacity(0.25)),
//       ),
//       child: Row(
//         children: [
//           Container(
//             width: 36,
//             height: 36,
//             decoration: BoxDecoration(
//               color: _bannerColor.withOpacity(0.12),
//               borderRadius: BorderRadius.circular(10),
//             ),
//             child: Icon(_icon, color: _bannerColor, size: 20),
//           ),
//           const SizedBox(width: 12),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   daysLeft == 1
//                       ? 'Continue Your BproAccess!'
//                       : 'Free Trial: $daysLeft days left',
//                   style: GoogleFonts.poppins(
//                     fontSize: 13,
//                     fontWeight: FontWeight.w700,
//                     color: _bannerColor,
//                   ),
//                 ),
//                 Text(
//                   daysLeft == 1
//                   ?'Your trial period is ending soon. Upgrade now to keep managing projects, teams, and reports without interruption.'
//                   :'Upgrade now to keep access',
//                   style: GoogleFonts.poppins(
//                     fontSize: 11,
//                     color: _bannerColor.withOpacity(0.7),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           SizedBox(width: 10,),
//           GestureDetector(
//             onTap: onUpgrade,
//             child: Container(
//               padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//               decoration: BoxDecoration(
//                 color: _bannerColor,
//                 borderRadius: BorderRadius.circular(8),
//               ),
//               child: Text(
//                 daysLeft == 1
//                 ?'Upgrade'
//                 :'Upgrade Now',
//                 style: GoogleFonts.poppins(
//                   fontSize: 12,
//                   fontWeight: FontWeight.w700,
//                   color: Colors.white,
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// // ── Expired banner ────────────────────────────────────────────────────────
// class _ExpiredBanner extends StatelessWidget {
//   final VoidCallback onUpgrade;
//   const _ExpiredBanner({required this.onUpgrade});

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onUpgrade,
//       child: Container(
//         margin: const EdgeInsets.fromLTRB(16, 8, 16, 4),
//         padding: const EdgeInsets.all(16),
//         decoration: BoxDecoration(
//           gradient: const LinearGradient(
//             colors: [AppColors.navy, Color(0xFF2D2D4E)],
//           ),
//           borderRadius: BorderRadius.circular(16),
//           boxShadow: [
//             BoxShadow(
//               color: AppColors.navy.withOpacity(0.25),
//               blurRadius: 16,
//               offset: const Offset(0, 4),
//             ),
//           ],
//         ),
//         child: Row(
//           children: [
//             Container(
//               width: 44,
//               height: 44,
//               decoration: BoxDecoration(
//                 color: AppColors.amber.withOpacity(0.15),
//                 borderRadius: BorderRadius.circular(12),
//               ),
//               child: const Icon(Icons.lock_rounded,
//                   color: AppColors.amber, size: 22),
//             ),
//             const SizedBox(width: 14),
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     'Trial Expired',
//                     style: GoogleFonts.poppins(
//                       fontSize: 14,
//                       fontWeight: FontWeight.w700,
//                       color: AppColors.white,
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
//             ),
//             Container(
//               padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
//               decoration: BoxDecoration(
//                 gradient: const LinearGradient(
//                   colors: [AppColors.amber, Color(0xFFD97706)],
//                 ),
//                 borderRadius: BorderRadius.circular(10),
//               ),
//               child: Text(
//                 'Subscribe',
//                 style: GoogleFonts.poppins(
//                   fontSize: 13,
//                   fontWeight: FontWeight.w700,
//                   color: AppColors.dark,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// // ══════════════════════════════════════════════════════════════════════════════
// // ACCESS GUARD WIDGET
// // Wrap screens or features with this to block access after trial/sub expires
// // ══════════════════════════════════════════════════════════════════════════════

// class AccessGuard extends StatefulWidget {
//   final Widget child;
//   const AccessGuard({super.key, required this.child});

//   @override
//   State<AccessGuard> createState() => _AccessGuardState();
// }

// class _AccessGuardState extends State<AccessGuard> {
//   bool? _canAccess;

//   @override
//   void initState() {
//     super.initState();
//     _check();
//   }

//   Future<void> _check() async {
//     final can = await TrialService.canAccessApp();
//     if (mounted) setState(() => _canAccess = can);
//     if (!can && mounted) {
//       WidgetsBinding.instance.addPostFrameCallback((_) {
//         Navigator.pushAndRemoveUntil(
//           context,
//           MaterialPageRoute(builder: (_) => const PaymentScreen()),
//           (route) => false,
//         );
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (_canAccess == null) {
//       return const Scaffold(
//         body: Center(child: CircularProgressIndicator()),
//       );
//     }
//     return _canAccess! ? widget.child : const SizedBox.shrink();
//   }
// }

import 'package:construction_app/services/shared_preference_helper.dart';
import 'package:construction_app/view/company/payment_subscription_screen.dart';
import 'package:construction_app/widgets/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TrialBannerWidget extends StatefulWidget {
  const TrialBannerWidget({super.key});

  @override
  State<TrialBannerWidget> createState() => _TrialBannerWidgetState();
}

class _TrialBannerWidgetState extends State<TrialBannerWidget> {
  int _daysLeft = 0;
  bool _trialExpired = true;
  bool _loaded = false;

  @override
  void initState() {
    super.initState();
    _loadTrialInfo();
  }

  Future<void> _loadTrialInfo() async {
    final daysLeft = await SharedPreferenceHelper.getTrialDaysLeft();
    final expired = await SharedPreferenceHelper.getTrialExpired();
    if (mounted) {
      setState(() {
        _daysLeft = daysLeft;
        _trialExpired = expired;
        _loaded = true;
      });
    }
  }

  void _navigateToPayment() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const PaymentScreen()),
    ).then((_) => _loadTrialInfo()); // refresh after returning
  }

  @override
  Widget build(BuildContext context) {
    if (!_loaded) return const SizedBox.shrink();

    if (_trialExpired) {
      return _ExpiredBanner(onUpgrade: _navigateToPayment);
    }

    return _TrialActiveBanner(
      daysLeft: _daysLeft,
      onUpgrade: _navigateToPayment,
    );
  }
}

// ── Trial active banner ───────────────────────────────────────────────────
class _TrialActiveBanner extends StatelessWidget {
  final int daysLeft;
  final VoidCallback onUpgrade;
  const _TrialActiveBanner({required this.daysLeft, required this.onUpgrade});

  Color get _bannerColor {
    if (daysLeft > 7) return AppColors.navy;
    if (daysLeft > 3) return const Color(0xFFD97706);
    return const Color(0xFFDC2626);
  }

  Color get _bgColor {
    if (daysLeft > 7) return const Color(0xFFEEF2FF);
    if (daysLeft > 3) return AppColors.amberLight;
    return AppColors.redLight;
  }

  IconData get _icon {
    if (daysLeft > 7) return Icons.hourglass_top_rounded;
    if (daysLeft > 3) return Icons.hourglass_bottom_rounded;
    return Icons.warning_amber_rounded;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 8, 16, 4),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: _bgColor,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: _bannerColor.withOpacity(0.25)),
      ),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: _bannerColor.withOpacity(0.12),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(_icon, color: _bannerColor, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  daysLeft == 1
                      ? 'Continue Your BproAccess!'
                      : 'Free Trial: $daysLeft days left',
                  style: GoogleFonts.poppins(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: _bannerColor,
                  ),
                ),
                Text(
                  daysLeft == 1
                      ? 'Your trial period is ending soon. Upgrade now to keep managing projects.'
                      : 'Upgrade now to keep access',
                  style: GoogleFonts.poppins(
                    fontSize: 11,
                    color: _bannerColor.withOpacity(0.7),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          GestureDetector(
            onTap: onUpgrade,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: _bannerColor,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                daysLeft == 1 ? 'Upgrade' : 'Upgrade Now',
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Expired banner ────────────────────────────────────────────────────────
class _ExpiredBanner extends StatelessWidget {
  final VoidCallback onUpgrade;
  const _ExpiredBanner({required this.onUpgrade});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onUpgrade,
      child: Container(
        margin: const EdgeInsets.fromLTRB(16, 8, 16, 4),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [AppColors.navy, Color(0xFF2D2D4E)],
          ),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: AppColors.navy.withOpacity(0.25),
              blurRadius: 16,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: AppColors.amber.withOpacity(0.15),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(
                Icons.lock_rounded,
                color: AppColors.amber,
                size: 22,
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Trial Expired',
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: AppColors.white,
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
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [AppColors.amber, Color(0xFFD97706)],
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                'Subscribe',
                style: GoogleFonts.poppins(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: AppColors.dark,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
