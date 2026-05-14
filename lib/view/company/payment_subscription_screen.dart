// ══════════════════════════════════════════════════════════════════════════════
// PAYMENT / SUBSCRIPTION SCREEN
// Shown when the free trial expires
// ══════════════════════════════════════════════════════════════════════════════

import 'package:construction_app/services/payment_service.dart';
import 'package:construction_app/services/trial_services.dart';
import 'package:construction_app/view/company/main_screen.dart';
import 'package:construction_app/widgets/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen>
    with SingleTickerProviderStateMixin {
  int _selectedPlanIndex = 1; // default: yearly
  bool _isLoading = false;

  late AnimationController _animController;
  late Animation<double> _slideAnimation;
  late PaymentService _paymentService;

  final List<_PlanData> _plans = [
    _PlanData(
      title: 'Monthly',
      price: '₹999',
      period: '/month',
      originalPrice: null,
      savings: null,
      highlight: false,
      color: AppColors.navy,
      durationMonths: 1,
      features: ['All features', 'Unlimited sites', 'Email support'],
    ),
    _PlanData(
      title: 'Yearly',
      price: '₹7,999',
      period: '/year',
      originalPrice: '₹11,988',
      savings: 'Save 33%',
      highlight: true,
      color: AppColors.amber,
      durationMonths: 12,
      features: [
        'All features',
        'Unlimited sites',
        'Priority support',
        'Advanced reports',
        '2 months FREE',
      ],
    ),
    _PlanData(
      title: '6 Months',
      price: '₹4,499',
      period: '/6 months',
      originalPrice: '₹5,994',
      savings: 'Save 25%',
      highlight: false,
      color: AppColors.navy,
      durationMonths: 6,
      features: [
        'All features',
        'Unlimited sites',
        'Chat support',
        'Basic reports',
      ],
    ),
  ];




  // @override
  // void initState() {
  //   super.initState();
  //   _animController = AnimationController(
  //     vsync: this,
  //     duration: const Duration(milliseconds: 700),
  //   )..forward();
  //   _slideAnimation = CurvedAnimation(
  //     parent: _animController,
  //     curve: Curves.easeOutCubic,
  //   );
  // }


  @override
void initState() {
  super.initState();

  _animController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 700),
  )..forward();

  _slideAnimation = CurvedAnimation(
    parent: _animController,
    curve: Curves.easeOutCubic,
  );

  _paymentService = PaymentService(
    onSuccess: _onPaymentSuccess,
    onFailure: _onPaymentFailure,
    onExternalWallet: _onExternalWallet,
  );
}

  // Future<void> _handlePayment() async {
  //   setState(() => _isLoading = true);
  //   HapticFeedback.mediumImpact();

  //   try {
  //     // TODO: Integrate Razorpay / Stripe / other payment gateway
  //     // For now, simulating successful payment
  //     await Future.delayed(const Duration(seconds: 2));

  //     await TrialService.activateSubscription(
  //         durationMonths: _plans[_selectedPlanIndex].durationMonths);

  //     if (!mounted) return;
  //     _showSuccessDialog();
  //   } catch (e) {
  //     if (mounted) {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(
  //           content: Text('Payment failed. Please try again.',
  //               style: GoogleFonts.poppins(fontSize: 13)),
  //           backgroundColor: AppColors.red,
  //           behavior: SnackBarBehavior.floating,
  //           shape:
  //               RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
  //         ),
  //       );
  //     }
  //   } finally {
  //     if (mounted) setState(() => _isLoading = false);
  //   }
  // }


  Future<void> _handlePayment() async {
  final selectedPlan = _plans[_selectedPlanIndex];

  int amount;

  if (selectedPlan.durationMonths == 1) {
    amount = 99900;
  } else if (selectedPlan.durationMonths == 6) {
    amount = 449900;
  } else {
    amount = 799900;
  }

  _paymentService.openCheckout(
    amount: amount,
    name: 'RealLine Pro',
    description: '${selectedPlan.title} Subscription',
    email: 'customer@email.com',
    contact: '9876543210',
  );
}

void _onPaymentSuccess(PaymentSuccessResponse response) async {
  final selectedPlan = _plans[_selectedPlanIndex];

  await TrialService.activateSubscription(
    durationMonths: selectedPlan.durationMonths,
  );

  if (!mounted) return;

  _showSuccessDialog();
}

void _onPaymentFailure(PaymentFailureResponse response) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        'Payment Failed',
        style: GoogleFonts.poppins(),
      ),
    ),
  );
}

void _onExternalWallet(ExternalWalletResponse response) {
  debugPrint(
    'External Wallet: ${response.walletName}',
  );
}

  void _showSuccessDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: const EdgeInsets.symmetric(horizontal: 32),
        child: Container(
          padding: const EdgeInsets.all(32),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 40,
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: AppColors.greenLight,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.check_circle_rounded,
                    color: AppColors.green, size: 44),
              ),
              const SizedBox(height: 20),
              Text(
                'Payment Successful!',
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: AppColors.dark,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Welcome to RealLine Pro.\nYour subscription is now active.',
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  color: AppColors.grey,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 28),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(ctx);
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (_) => const MainScreen()),
                      (route) => false,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.amber,
                    foregroundColor: AppColors.dark,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14)),
                    elevation: 0,
                  ),
                  child: Text(
                    'Go to Dashboard',
                    style: GoogleFonts.poppins(
                        fontSize: 15, fontWeight: FontWeight.w700),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.navy,
      body: Stack(
        children: [
          // Background circles
          Positioned(
            top: -60,
            right: -60,
            child: Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                color: AppColors.amber.withOpacity(0.08),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            top: 120,
            left: -80,
            child: Container(
              width: 220,
              height: 220,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.03),
                shape: BoxShape.circle,
              ),
            ),
          ),

          SafeArea(
            child: SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0, 0.3),
                end: Offset.zero,
              ).animate(_slideAnimation),
              child: FadeTransition(
                opacity: _slideAnimation,
                child: Column(
                  children: [
                    // ── Header ───────────────────────────────────────────
                    Padding(
                      padding: const EdgeInsets.fromLTRB(24, 16, 24, 0),
                      child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            decoration: BoxDecoration(
                              color: AppColors.amber.withOpacity(0.15),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                  color: AppColors.amber.withOpacity(0.3)),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(Icons.lock_open_rounded,
                                    color: AppColors.amber, size: 16),
                                const SizedBox(width: 6),
                                Text(
                                  'Upgrade to Continue',
                                  style: GoogleFonts.poppins(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.amber,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'Continue Your\nRealLine Access',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.poppins(
                              fontSize: 28,
                              fontWeight: FontWeight.w700,
                              color: AppColors.white,
                              height: 1.2,
                              letterSpacing: -0.5,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Upgrade your workspace to continue managing projects, teams, and reports seamlessly',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              color: AppColors.greyLight,
                              height: 1.5,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 24),

                    // ── Plans ─────────────────────────────────────────────
                    Expanded(
                      child: Container(
                        decoration: const BoxDecoration(
                          color: Color(0xFFF8F9FC),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(32),
                            topRight: Radius.circular(32),
                          ),
                        ),
                        child: SingleChildScrollView(
                          padding: const EdgeInsets.fromLTRB(20, 28, 20, 24),
                          child: Column(
                            children: [
                              // Plan cards
                              ..._plans.asMap().entries.map((entry) {
                                final idx = entry.key;
                                final plan = entry.value;
                                final isSelected = idx == _selectedPlanIndex;

                                return GestureDetector(
                                  onTap: () =>
                                      setState(() => _selectedPlanIndex = idx),
                                  child: AnimatedContainer(
                                    duration: const Duration(milliseconds: 250),
                                    margin: const EdgeInsets.only(bottom: 12),
                                    padding: const EdgeInsets.all(18),
                                    decoration: BoxDecoration(
                                      color: isSelected
                                          ? (plan.highlight
                                              ? AppColors.amberLight
                                              : const Color(0xFFEEF2FF))
                                          : AppColors.white,
                                      borderRadius: BorderRadius.circular(18),
                                      border: Border.all(
                                        color: isSelected
                                            ? plan.color
                                            : AppColors.border,
                                        width: isSelected ? 2 : 1.5,
                                      ),
                                      boxShadow: isSelected
                                          ? [
                                              BoxShadow(
                                                color: plan.color
                                                    .withOpacity(0.15),
                                                blurRadius: 16,
                                                offset: const Offset(0, 4),
                                              )
                                            ]
                                          : [],
                                    ),
                                    child: Row(
                                      children: [
                                        // Radio
                                        AnimatedContainer(
                                          duration:
                                              const Duration(milliseconds: 200),
                                          width: 22,
                                          height: 22,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: isSelected
                                                ? plan.color
                                                : Colors.transparent,
                                            border: Border.all(
                                              color: isSelected
                                                  ? plan.color
                                                  : AppColors.border,
                                              width: 2,
                                            ),
                                          ),
                                          child: isSelected
                                              ? const Icon(Icons.check,
                                                  color: Colors.white, size: 14)
                                              : null,
                                        ),
                                        const SizedBox(width: 14),

                                        // Details
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  Text(
                                                    plan.title,
                                                    style: GoogleFonts.poppins(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      color: AppColors.dark,
                                                    ),
                                                  ),
                                                  if (plan.highlight) ...[
                                                    const SizedBox(width: 8),
                                                    Container(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          horizontal: 8,
                                                          vertical: 2),
                                                      decoration: BoxDecoration(
                                                        color: AppColors.amber,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(6),
                                                      ),
                                                      child: Text(
                                                        'BEST VALUE',
                                                        style:
                                                            GoogleFonts.poppins(
                                                          fontSize: 9,
                                                          fontWeight:
                                                              FontWeight.w800,
                                                          color: AppColors.dark,
                                                          letterSpacing: 0.5,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ],
                                              ),
                                              const SizedBox(height: 4),
                                              Wrap(
                                                spacing: 6,
                                                runSpacing: 4,
                                                children: plan.features
                                                    .map(
                                                      (f) => Text(
                                                        '✓ $f',
                                                        style:
                                                            GoogleFonts.poppins(
                                                          fontSize: 11,
                                                          color:
                                                              AppColors.grey,
                                                        ),
                                                      ),
                                                    )
                                                    .toList(),
                                              ),
                                            ],
                                          ),
                                        ),

                                        // Price
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            if (plan.originalPrice != null)
                                              Text(
                                                plan.originalPrice!,
                                                style: GoogleFonts.poppins(
                                                  fontSize: 11,
                                                  color: AppColors.greyLight,
                                                  decoration:
                                                      TextDecoration.lineThrough,
                                                ),
                                              ),
                                            Text(
                                              plan.price,
                                              style: GoogleFonts.poppins(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w800,
                                                color: plan.color,
                                              ),
                                            ),
                                            Text(
                                              plan.period,
                                              style: GoogleFonts.poppins(
                                                fontSize: 11,
                                                color: AppColors.grey,
                                              ),
                                            ),
                                            if (plan.savings != null)
                                              Container(
                                                margin:
                                                    const EdgeInsets.only(top: 4),
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 6,
                                                        vertical: 2),
                                                decoration: BoxDecoration(
                                                  color: AppColors.greenLight,
                                                  borderRadius:
                                                      BorderRadius.circular(6),
                                                ),
                                                child: Text(
                                                  plan.savings!,
                                                  style: GoogleFonts.poppins(
                                                    fontSize: 10,
                                                    fontWeight: FontWeight.w700,
                                                    color: AppColors.green,
                                                  ),
                                                ),
                                              ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }),

                              const SizedBox(height: 8),

                              // ── Payment Button ─────────────────────────
                              SizedBox(
                                width: double.infinity,
                                height: 56,
                                child: DecoratedBox(
                                  decoration: BoxDecoration(
                                    gradient: const LinearGradient(
                                      colors: [
                                        AppColors.amber,
                                        Color(0xFFD97706)
                                      ],
                                    ),
                                    borderRadius: BorderRadius.circular(16),
                                    boxShadow: [
                                      BoxShadow(
                                        color: AppColors.amber.withOpacity(0.4),
                                        blurRadius: 16,
                                        offset: const Offset(0, 6),
                                      ),
                                    ],
                                  ),
                                  child: ElevatedButton(
                                    onPressed: _isLoading ? null : _handlePayment,
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.transparent,
                                      shadowColor: Colors.transparent,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(16)),
                                    ),
                                    child: _isLoading
                                        ? const SizedBox(
                                            height: 22,
                                            width: 22,
                                            child: CircularProgressIndicator(
                                              strokeWidth: 2.5,
                                              valueColor:
                                                  AlwaysStoppedAnimation(
                                                      Colors.white),
                                            ),
                                          )
                                        : Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              const Icon(
                                                  Icons
                                                      .payment_rounded,
                                                  size: 20,
                                                  color: AppColors.dark),
                                              const SizedBox(width: 8),
                                              Text(
                                                'Pay ${_plans[_selectedPlanIndex].price}',
                                                style: GoogleFonts.poppins(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w700,
                                                  color: AppColors.dark,
                                                ),
                                              ),
                                            ],
                                          ),
                                  ),
                                ),
                              ),

                              const SizedBox(height: 14),

                              // Security note
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(Icons.lock_rounded,
                                      size: 12, color: AppColors.greyLight),
                                  const SizedBox(width: 4),
                                  Text(
                                    'Secure payment · Cancel anytime',
                                    style: GoogleFonts.poppins(
                                      fontSize: 11,
                                      color: AppColors.greyLight,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
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
    _paymentService.dispose();
    super.dispose();
  }
}




// ── Data model ──────────────────────────────────────────────────────────────
class _PlanData {
  final String title;
  final String price;
  final String period;
  final String? originalPrice;
  final String? savings;
  final bool highlight;
  final Color color;
  final int durationMonths;
  final List<String> features;

  const _PlanData({
    required this.title,
    required this.price,
    required this.period,
    this.originalPrice,
    this.savings,
    required this.highlight,
    required this.color,
    required this.durationMonths,
    required this.features,
  });
}