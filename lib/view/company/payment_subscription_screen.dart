import 'package:construction_app/models/payment_details_model.dart';
import 'package:construction_app/provider/company_provider.dart';
import 'package:construction_app/provider/login_provider.dart';
import 'package:construction_app/services/payment_service.dart';
import 'package:construction_app/view/company/main_screen.dart';
import 'package:construction_app/view/login_screen.dart';
import 'package:construction_app/widgets/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:construction_app/services/shared_preference_helper.dart';
import 'package:construction_app/view/user/main_userscreen.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen>
    with SingleTickerProviderStateMixin {
  int _selectedPlanIndex = 0;
  bool _isLoading = true;
  List<PaymentDetails> _plans = [];
  String _userRole = '';
  bool _isTrialExpired = false;

  late AnimationController _animController;
  late Animation<double> _slideAnimation;
  late PaymentService _paymentService;

  @override
  void initState() {
    super.initState();
    _loadRole();

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

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadPlans();
    });
  }

  Future<void> _loadRole() async {
    final role = await SharedPreferenceHelper.getRole();
    final expired = await SharedPreferenceHelper.getTrialExpired();
    final hasSub = await SharedPreferenceHelper.hasSubscription();
    if (mounted) {
      setState(() {
        _userRole = role;
        _isTrialExpired = expired && !hasSub;
      });
    }
  }

  Future<void> _loadPlans() async {
    setState(() => _isLoading = true);
    final result = await context.read<CompanyProvider>().getPaymentDetails((
      error,
    ) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(error, style: GoogleFonts.poppins(fontSize: 13)),
            backgroundColor: AppColors.red,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        );
      }
    });

    if (!mounted) return;
    setState(() {
      _plans = result?.data ?? [];
      // Default select the plan with a badge (best value) if available
      final badgeIndex = _plans.indexWhere(
        (p) => p.badge != null && p.badge!.isNotEmpty,
      );
      _selectedPlanIndex = badgeIndex >= 0 ? badgeIndex : 0;
      _isLoading = false;
    });
  }

  Future<void> _handlePayment() async {
    if (_plans.isEmpty) return;
    final selectedPlan = _plans[_selectedPlanIndex];

    // price comes as string e.g. "999.00", convert to paise
    final priceInPaise =
        (double.tryParse(selectedPlan.price) ?? 0).round() * 100;

    _paymentService.openCheckout(
      amount: priceInPaise,
      name: 'BproPro',
      description: '${selectedPlan.name} Subscription',
      email: 'customer@email.com',
      contact: '9876543210',
    );
  }

  void _onPaymentSuccess(PaymentSuccessResponse response) async {
    if (!mounted) return;
    await SharedPreferenceHelper.saveTrialInfo(daysLeft: 30, expired: false, );
    await SharedPreferenceHelper.saveSubscriptionExpiry(
      DateTime.now().add(const Duration(days: 30)),
    );
    _showSuccessDialog();
  }

  void _onPaymentFailure(PaymentFailureResponse response) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          response.message ?? 'Payment failed. Please try again.',
          style: GoogleFonts.poppins(fontSize: 13),
        ),
        backgroundColor: AppColors.red,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  void _onExternalWallet(ExternalWalletResponse response) {
    debugPrint('External Wallet: ${response.walletName}');
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
              BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 40),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: const BoxDecoration(
                  color: AppColors.greenLight,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.check_circle_rounded,
                  color: AppColors.green,
                  size: 44,
                ),
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
                'Welcome to BproPro.\nYour subscription is now active.',
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
                  onPressed: () async {
                    String role = await SharedPreferenceHelper.getRole();
                    if (!mounted) return;
                    Navigator.pop(ctx);
                    if (role.toLowerCase() == 'supervisor') {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const MainUserScreen(),
                        ),
                        (route) => false,
                      );
                    } else {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (_) => const MainScreen()),
                        (route) => false,
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.amber,
                    foregroundColor: AppColors.dark,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    elevation: 0,
                  ),
                  child: Text(
                    'Go to Dashboard',
                    style: GoogleFonts.poppins(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                    ),
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
    final isSupervisor = _userRole.toLowerCase() == 'supervisor';

    return PopScope(
      canPop: !_isTrialExpired,
      child: Scaffold(
        backgroundColor: AppColors.navy,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          automaticallyImplyLeading: !_isTrialExpired,
          leading: !_isTrialExpired
              ? IconButton(
                  icon: const Icon(
                    Icons.arrow_back_ios_new_rounded,
                    color: AppColors.white,
                    size: 20,
                  ),
                  onPressed: () => Navigator.pop(context),
                )
              : null,
          actions: [
            IconButton(
              icon: const Icon(Icons.logout_rounded, color: AppColors.white),
              onPressed: _handleLogout,
              tooltip: 'Log Out',
            ),
            const SizedBox(width: 8),
          ],
        ),
        body: Stack(
          children: [
            // Background decorative circles
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
                  child: isSupervisor
                      ? _buildSupervisorSuspendedView()
                      : _buildCompanyPaymentView(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSupervisorSuspendedView() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 90,
          height: 90,
          decoration: BoxDecoration(
            color: AppColors.amber.withOpacity(0.15),
            shape: BoxShape.circle,
            border: Border.all(
              color: AppColors.amber.withOpacity(0.3),
              width: 2,
            ),
          ),
          child: const Icon(
            Icons.lock_person_rounded,
            color: AppColors.amber,
            size: 44,
          ),
        ),
        const SizedBox(height: 24),
        Text(
          'Workspace Suspended',
          style: GoogleFonts.poppins(
            fontSize: 24,
            fontWeight: FontWeight.w700,
            color: AppColors.white,
          ),
        ),
        const SizedBox(height: 12),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child: Text(
            'Your company\'s trial period or subscription has expired. Please contact your company administrator or manager to renew the subscription and restore full access.',
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              fontSize: 14,
              color: AppColors.greyLight,
              height: 1.5,
            ),
          ),
        ),
        const SizedBox(height: 36),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child: SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: _handleLogout,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.amber,
                foregroundColor: AppColors.dark,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                elevation: 0,
              ),
              child: Text(
                'Sign Out / Log Out',
                style: GoogleFonts.poppins(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCompanyPaymentView() {
    return Column(
      children: [
        // ── Header ──────────────────────────────────────────
        Padding(
          padding: const EdgeInsets.fromLTRB(24, 0, 24, 0),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: AppColors.amber.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: AppColors.amber.withOpacity(0.3)),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.lock_open_rounded,
                      color: AppColors.amber,
                      size: 16,
                    ),
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
                'Continue Your\nBproAccess',
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
                'Upgrade your workspace to continue managing '
                'projects, teams, and reports seamlessly',
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

        // ── Plans area ───────────────────────────────────────
        Expanded(
          child: Container(
            decoration: const BoxDecoration(
              color: Color(0xFFF8F9FC),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(32),
                topRight: Radius.circular(32),
              ),
            ),
            child: _isLoading
                ? const Center(
                    child: CircularProgressIndicator(color: AppColors.amber),
                  )
                : _plans.isEmpty
                ? _buildEmptyState()
                : SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(20, 28, 20, 24),
                    child: Column(
                      children: [
                        // Plan cards
                        ..._plans.asMap().entries.map((entry) {
                          return _PlanCard(
                            plan: entry.value,
                            isSelected: entry.key == _selectedPlanIndex,
                            onTap: () =>
                                setState(() => _selectedPlanIndex = entry.key),
                          );
                        }),

                        const SizedBox(height: 8),

                        // Pay button
                        _PayButton(
                          label: 'Pay ${_plans[_selectedPlanIndex].priceLabel}',
                          onPressed: _handlePayment,
                        ),

                        const SizedBox(height: 14),

                        // Security note
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.lock_rounded,
                              size: 12,
                              color: AppColors.greyLight,
                            ),
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
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.error_outline_rounded,
            color: AppColors.greyLight,
            size: 48,
          ),
          const SizedBox(height: 12),
          Text(
            'No plans available',
            style: GoogleFonts.poppins(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: AppColors.grey,
            ),
          ),
          const SizedBox(height: 8),
          TextButton(
            onPressed: _loadPlans,
            child: Text(
              'Retry',
              style: GoogleFonts.poppins(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppColors.amber,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _handleLogout() async {
    setState(() => _isLoading = true);
    try {
      final loginProvider = context.read<LoginProvider>();
      await loginProvider.logout(
        onSuccess: () {
          if (mounted) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (_) => const LoginScreen()),
              (route) => false,
            );
          }
        },
        onFailure: (err) {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(err), backgroundColor: AppColors.red),
            );
          }
        },
      );
    } catch (e) {
      debugPrint("Error logging out: $e");
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  void dispose() {
    _animController.dispose();
    _paymentService.dispose();
    super.dispose();
  }
}

// ══════════════════════════════════════════════════════════════════════════════
// PLAN CARD
// ══════════════════════════════════════════════════════════════════════════════

class _PlanCard extends StatelessWidget {
  final PaymentDetails plan;
  final bool isSelected;
  final VoidCallback onTap;

  const _PlanCard({
    required this.plan,
    required this.isSelected,
    required this.onTap,
  });

  // Plans with a badge use amber, others use navy
  Color get _planColor => (plan.badge != null && plan.badge!.isNotEmpty)
      ? AppColors.amber
      : AppColors.navy;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: isSelected
              ? (plan.badge != null && plan.badge!.isNotEmpty
                    ? AppColors.amberLight
                    : const Color(0xFFEEF2FF))
              : AppColors.white,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: isSelected ? _planColor : AppColors.border,
            width: isSelected ? 2 : 1.5,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: _planColor.withOpacity(0.15),
                    blurRadius: 16,
                    offset: const Offset(0, 4),
                  ),
                ]
              : [],
        ),
        child: Row(
          children: [
            // Radio button
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 22,
              height: 22,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isSelected ? _planColor : Colors.transparent,
                border: Border.all(
                  color: isSelected ? _planColor : AppColors.border,
                  width: 2,
                ),
              ),
              child: isSelected
                  ? const Icon(Icons.check, color: Colors.white, size: 14)
                  : null,
            ),
            const SizedBox(width: 14),

            // Plan details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        plan.name,
                        style: GoogleFonts.poppins(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: AppColors.dark,
                        ),
                      ),
                      if (plan.badge != null && plan.badge!.isNotEmpty) ...[
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.amber,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            plan.badge!.toUpperCase(),
                            style: GoogleFonts.poppins(
                              fontSize: 9,
                              fontWeight: FontWeight.w800,
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
                    runSpacing: 2,
                    children: plan.features
                        .map(
                          (f) => Text(
                            '✓ $f',
                            style: GoogleFonts.poppins(
                              fontSize: 11,
                              color: AppColors.grey,
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ],
              ),
            ),

            const SizedBox(width: 12),

            // Price column
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                if (plan.originalPriceLabel != null) ...[
                  Text(
                    plan.originalPriceLabel!,
                    style: GoogleFonts.poppins(
                      fontSize: 11,
                      color: AppColors.greyLight,
                      decoration: TextDecoration.lineThrough,
                    ),
                  ),
                ],
                Text(
                  plan.priceLabel,
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    color: _planColor,
                  ),
                ),
                Text(
                  plan.periodLabel,
                  style: GoogleFonts.poppins(
                    fontSize: 11,
                    color: AppColors.grey,
                  ),
                ),
                if (plan.saveLabel != null) ...[
                  const SizedBox(height: 4),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 6,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.greenLight,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      plan.saveLabel!,
                      style: GoogleFonts.poppins(
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                        color: AppColors.green,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// ══════════════════════════════════════════════════════════════════════════════
// PAY BUTTON
// ══════════════════════════════════════════════════════════════════════════════

class _PayButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;

  const _PayButton({required this.label, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [AppColors.amber, Color(0xFFD97706)],
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
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.payment_rounded,
                size: 20,
                color: AppColors.dark,
              ),
              const SizedBox(width: 8),
              Text(
                label,
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
    );
  }
}
