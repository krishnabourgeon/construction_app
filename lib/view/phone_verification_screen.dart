// import 'package:construction_app/view/otp_verification_screen.dart';
// import 'package:construction_app/widgets/app_theme.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:shared_preferences/shared_preferences.dart';
 
// // ══════════════════════════════════════════════════════════════════════════════
// // 1. PHONE VERIFICATION SCREEN
// // ══════════════════════════════════════════════════════════════════════════════
 
// class PhoneVerificationScreen extends StatefulWidget {
//   const PhoneVerificationScreen({super.key});
 
//   @override
//   State<PhoneVerificationScreen> createState() =>
//       _PhoneVerificationScreenState();
// }
 
// class _PhoneVerificationScreenState extends State<PhoneVerificationScreen> {
//   final _phoneController = TextEditingController();
//   final _nameController = TextEditingController();
//   final _formKey = GlobalKey<FormState>();
//   bool _isLoading = false;
 
//   @override
//   void dispose() {
//     _phoneController.dispose();
//     super.dispose();
//   }
 
//   Future<void> _sendOTP() async {
//     if (!_formKey.currentState!.validate()) return;
 
//     setState(() => _isLoading = true);
 
//     try {
//       // TODO: Implement your OTP API call here
//       // await yourAuthService.sendOTP(_phoneController.text);
 
//       await Future.delayed(const Duration(seconds: 1)); // Simulating API call
 
//       if (!mounted) return;
 
//       // Navigate to OTP verification
//       Navigator.push(
//         context,
//         MaterialPageRoute(
//           builder: (_) => OTPVerificationScreen(
//             phoneNumber: _phoneController.text,
//           ),
//         ),
//       );
//     } catch (e) {
//       _showSnackbar('Failed to send OTP. Please try again.', isError: true);
//     } finally {
//       if (mounted) setState(() => _isLoading = false);
//     }
//   }
 
//   void _showSnackbar(String message, {bool isError = false}) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text(message, style: GoogleFonts.poppins(fontSize: 13)),
//         backgroundColor: isError ? AppColors.red : AppColors.green,
//         behavior: SnackBarBehavior.floating,
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//       ),
//     );
//   }
 
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.white,
//       body: SafeArea(
//         child: SingleChildScrollView(
//           padding: const EdgeInsets.all(24),
//           child: Form(
//             key: _formKey,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 const SizedBox(height: 40),
 
//                 // Logo/Icon
//                 Center(
//                   child: Container(
//                     padding: const EdgeInsets.all(20),
//                     decoration: BoxDecoration(
//                       color: AppColors.amber,
//                       shape: BoxShape.circle,
//                     ),
//                     child: const Icon(Icons.phone_android,
//                         size: 48, color: AppColors.white),
//                   ),
//                 ),
//                 const SizedBox(height: 32),
 
//                 // Title
//                 Text('Verify Your Phone',
//                     style: GoogleFonts.poppins(
//                       fontSize: 26,
//                       fontWeight: FontWeight.w700,
//                       color: AppColors.dark,
//                     )),
//                 const SizedBox(height: 8),
//                 Text(
//                     'We\'ll send you a one-time password to verify your phone number',
//                     style: GoogleFonts.poppins(
//                         fontSize: 14, color: AppColors.grey)),
//                 const SizedBox(height: 40),
//                 // Contact Person Name
//                 Text('Contact Person',
//                     style: GoogleFonts.poppins(
//                         fontSize: 13,
//                         fontWeight: FontWeight.w600,
//                         color: AppColors.dark)),
//                 const SizedBox(height: 8),
//                 TextFormField(
//                   controller: _nameController,
//                   keyboardType: TextInputType.text,
//                   maxLength: 10,
//                   style: GoogleFonts.poppins(fontSize: 16),
//                   decoration: InputDecoration(
//                     prefixIcon:
//                         const Icon(Icons.person, color: AppColors.amber),
//                     hintText: 'Enter your name',
//                     hintStyle: GoogleFonts.poppins(
//                         fontSize: 14, color: AppColors.greyLight),
//                     filled: true,
//                     fillColor: AppColors.greyFill,
//                     counterText: '',
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(12),
//                       borderSide: BorderSide.none,
//                     ),
//                     focusedBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(12),
//                       borderSide:
//                           const BorderSide(color: AppColors.amber, width: 2),
//                     ),
//                   ),
//                   //inputFormatters: [FilteringTextInputFormatter.digitsOnly],
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'Please enter your name';
//                     }
//                     return null;
//                   },
//                 ),
//                 // Phone Number Input
//                 SizedBox(height: 20),

//                 Text('Phone Number',
//                     style: GoogleFonts.poppins(
//                         fontSize: 13,
//                         fontWeight: FontWeight.w600,
//                         color: AppColors.dark)),
//                 const SizedBox(height: 8),
//                 TextFormField(
//                   controller: _phoneController,
//                   keyboardType: TextInputType.phone,
//                   maxLength: 10,
//                   style: GoogleFonts.poppins(fontSize: 16),
//                   decoration: InputDecoration(
//                     prefixIcon:
//                         const Icon(Icons.phone, color: AppColors.amber),
//                     hintText: 'Enter 10-digit mobile number',
//                     hintStyle: GoogleFonts.poppins(
//                         fontSize: 14, color: AppColors.greyLight),
//                     filled: true,
//                     fillColor: AppColors.greyFill,
//                     counterText: '',
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(12),
//                       borderSide: BorderSide.none,
//                     ),
//                     focusedBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(12),
//                       borderSide:
//                           const BorderSide(color: AppColors.amber, width: 2),
//                     ),
//                   ),
//                   inputFormatters: [FilteringTextInputFormatter.digitsOnly],
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'Please enter your phone number';
//                     }
//                     if (value.length != 10) {
//                       return 'Phone number must be 10 digits';
//                     }
//                     return null;
//                   },
//                 ),
//                 const SizedBox(height: 32),
 
//                 // Send OTP Button
//                 SizedBox(
//                   width: double.infinity,
//                   child: ElevatedButton(
//                     onPressed: _isLoading ? null : _sendOTP,
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: AppColors.amber,
//                       foregroundColor: AppColors.dark,
//                       padding: const EdgeInsets.symmetric(vertical: 16),
//                       shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(12)),
//                       elevation: 0,
//                     ),
//                     child: _isLoading
//                         ? const SizedBox(
//                             height: 20,
//                             width: 20,
//                             child: CircularProgressIndicator(
//                               strokeWidth: 2,
//                               valueColor:
//                                   AlwaysStoppedAnimation(AppColors.dark),
//                             ),
//                           )
//                         : Text('Send OTP',
//                             style: GoogleFonts.poppins(
//                                 fontSize: 16, fontWeight: FontWeight.w600)),
//                   ),
//                 ),
//                 const SizedBox(height: 24),
 
//                 // Terms & Conditions
//                 Center(
//                   child: Text.rich(
//                     TextSpan(
//                       text: 'By continuing, you agree to our ',
//                       style: GoogleFonts.poppins(
//                           fontSize: 12, color: AppColors.grey),
//                       children: [
//                         TextSpan(
//                           text: 'Terms & Conditions',
//                           style: GoogleFonts.poppins(
//                               fontSize: 12,
//                               color: AppColors.amber,
//                               fontWeight: FontWeight.w600),
//                         ),
//                       ],
//                     ),
//                     textAlign: TextAlign.center,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }






import 'package:construction_app/provider/company_provider.dart';
import 'package:construction_app/view/login_screen.dart';
import 'package:construction_app/view/otp_verification_screen.dart';
import 'package:construction_app/widgets/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class PhoneVerificationScreen extends StatefulWidget {
  const PhoneVerificationScreen({super.key});

  @override
  State<PhoneVerificationScreen> createState() =>
      _PhoneVerificationScreenState();
}

class _PhoneVerificationScreenState extends State<PhoneVerificationScreen>
    with TickerProviderStateMixin {
  final _phoneController = TextEditingController();
  final _nameController = TextEditingController();
  final _companyNameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _phoneFocus = FocusNode();
  final _nameFocus = FocusNode();
  final _companyNameFocus = FocusNode();

  bool _isLoading = false;
  bool _nameValid = false;
  bool _phoneValid = false;

  late AnimationController _heroController;
  late AnimationController _cardController;
  late AnimationController _floatController;

  late Animation<double> _heroFade;
  late Animation<Offset> _heroSlide;
  late Animation<double> _cardFade;
  late Animation<Offset> _cardSlide;
  late Animation<double> _floatAnim;

  @override
  void initState() {
    super.initState();

    _heroController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );
    _cardController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _floatController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat(reverse: true);

    _heroFade = CurvedAnimation(
      parent: _heroController,
      curve: const Interval(0.0, 0.7, curve: Curves.easeOut),
    );
    _heroSlide = Tween<Offset>(
      begin: const Offset(0, -0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _heroController,
      curve: Curves.easeOutCubic,
    ));

    _cardFade = CurvedAnimation(
      parent: _cardController,
      curve: const Interval(0.2, 1.0, curve: Curves.easeOut),
    );
    _cardSlide = Tween<Offset>(
      begin: const Offset(0, 0.4),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _cardController,
      curve: Curves.easeOutCubic,
    ));

    _floatAnim = Tween<double>(begin: -6, end: 6).animate(
      CurvedAnimation(parent: _floatController, curve: Curves.easeInOut),
    );

    // Stagger the animations
    _heroController.forward();
    Future.delayed(const Duration(milliseconds: 300),
        () => _cardController.forward());

    _nameController.addListener(_validate);
    _phoneController.addListener(_validate);
  }

  void _validate() {
    setState(() {
      _nameValid = _nameController.text.trim().isNotEmpty;
      _phoneValid = _phoneController.text.length == 10;
    });
  }

  bool get _canSubmit => _nameValid && _phoneValid && !_isLoading;

  Future<void> _sendOTP() async {
    if (!_formKey.currentState!.validate()) return;
    FocusScope.of(context).unfocus();
    setState(() => _isLoading = true);
    HapticFeedback.mediumImpact();

    try {
      await context.read<CompanyProvider>().phoneNumberVerification(
        phoneNumber: int.parse(_phoneController.text),
        contactperson: _nameController.text,
        companyName: _companyNameController.text,
        onSuccess: (msg) {
          if (!mounted) return;
          _showSnackbar(msg);
          Navigator.push(
            context,
            PageRouteBuilder(
              pageBuilder: (_, anim, __) =>
                  OTPVerificationScreen(phoneNumber: _phoneController.text),
              transitionsBuilder: (_, anim, __, child) => SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(1, 0),
                  end: Offset.zero,
                ).animate(CurvedAnimation(parent: anim, curve: Curves.easeOutCubic)),
                child: FadeTransition(opacity: anim, child: child),
              ),
              transitionDuration: const Duration(milliseconds: 400),
            ),
          );
        },
        onFailure: (err) {
          _showSnackbar(err, isError: true);
        },
      );
    } catch (e) {
      _showSnackbar('An unexpected error occurred.', isError: true);
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  void _showSnackbar(String message, {bool isError = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(
              isError ? Icons.error_outline : Icons.check_circle_outline,
              color: Colors.white,
              size: 18,
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(message,
                  style: GoogleFonts.poppins(
                      fontSize: 13, color: Colors.white)),
            ),
          ],
        ),
        backgroundColor: isError ? const Color(0xFFDC2626) : AppColors.green,
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        duration: const Duration(seconds: 3),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: AppColors.navy,
      resizeToAvoidBottomInset: true,
      body: Stack(
        children: [
          // ── Animated background blobs ─────────────────────────────────
          AnimatedBuilder(
            animation: _floatAnim,
            builder: (_, __) => Stack(
              children: [
                Positioned(
                  top: -40 + _floatAnim.value,
                  right: -50,
                  child: _GlowBlob(size: 220, color: AppColors.amber.withOpacity(0.12)),
                ),
                Positioned(
                  top: 160 - _floatAnim.value * 0.5,
                  left: -70,
                  child: _GlowBlob(size: 180, color: Colors.white.withOpacity(0.04)),
                ),
                Positioned(
                  top: size.height * 0.28 + _floatAnim.value * 0.3,
                  right: -30,
                  child: _GlowBlob(size: 120, color: AppColors.amber.withOpacity(0.07)),
                ),
              ],
            ),
          ),

          // ── Grid dots pattern ─────────────────────────────────────────
          Positioned.fill(
            child: CustomPaint(painter: _DotGridPainter()),
          ),

          // ── Main scrollable content ───────────────────────────────────
          SafeArea(
            child: Column(
              children: [
                // ── Hero section ─────────────────────────────────────────
                FadeTransition(
                  opacity: _heroFade,
                  child: SlideTransition(
                    position: _heroSlide,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(24, 20, 24, 0),
                      child: Column(
                        children: [
                          // Logo + floating icon
                          AnimatedBuilder(
                            animation: _floatAnim,
                            builder: (_, __) => Transform.translate(
                              offset: Offset(0, _floatAnim.value * 0.6),
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  // Outer glow ring
                                  Container(
                                    width: 110,
                                    height: 110,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: AppColors.amber.withOpacity(0.25),
                                        width: 2,
                                      ),
                                    ),
                                  ),
                                  // Middle ring
                                  Container(
                                    width: 88,
                                    height: 88,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: AppColors.amber.withOpacity(0.1),
                                      border: Border.all(
                                        color: AppColors.amber.withOpacity(0.3),
                                        width: 1.5,
                                      ),
                                    ),
                                  ),
                                  // Core icon container
                                  Container(
                                    width: 68,
                                    height: 68,
                                    decoration: BoxDecoration(
                                      gradient: const LinearGradient(
                                        colors: [
                                          AppColors.amber,
                                          Color(0xFFD97706),
                                        ],
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                      ),
                                      shape: BoxShape.circle,
                                      boxShadow: [
                                        BoxShadow(
                                          color: AppColors.amber.withOpacity(0.5),
                                          blurRadius: 24,
                                          offset: const Offset(0, 8),
                                        ),
                                      ],
                                    ),
                                    child: const Icon(
                                      Icons.phone_android_rounded,
                                      color: Colors.white,
                                      size: 32,
                                    ),
                                  ),
                                  // Small badge
                                  Positioned(
                                    right: 10,
                                    top: 10,
                                    child: Container(
                                      width: 22,
                                      height: 22,
                                      decoration: BoxDecoration(
                                        color: AppColors.green,
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                            color: AppColors.navy, width: 2),
                                      ),
                                      child: const Icon(
                                        Icons.verified_rounded,
                                        color: Colors.white,
                                        size: 12,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          const SizedBox(height: 22),

                          Text(
                            'Build Smarter with Bpro',
                            style: GoogleFonts.poppins(
                              fontSize: 25,
                              fontWeight: FontWeight.w800,
                              color: Colors.white,
                              letterSpacing: -0.5,
                              height: 1.1,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            'Verify your phone number to manage projects, teams, and site operations securely',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.poppins(
                              fontSize: 13.5,
                              color: AppColors.greyLight,
                              height: 1.55,
                            ),
                          ),

                          const SizedBox(height: 20),

                          // Feature pills row
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // _FeaturePill(
                              //     icon: Icons.timer_outlined, label: '15-day Free Trial'),
                              // const SizedBox(width: 8),
                              _FeaturePill(
                                  icon: Icons.lock_outline_rounded,
                                  label: 'Secure & Fast'),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                // ── Form card ─────────────────────────────────────────────
                Expanded(
                  child: FadeTransition(
                    opacity: _cardFade,
                    child: SlideTransition(
                      position: _cardSlide,
                      child: Container(
                        decoration: const BoxDecoration(
                          color: Color(0xFFF8F9FC),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(36),
                            topRight: Radius.circular(36),
                          ),
                        ),
                        child: SingleChildScrollView(
                          padding: EdgeInsets.only(
                            left: 24,
                            right: 24,
                            top: 32,
                            bottom: MediaQuery.of(context).viewInsets.bottom + 24,
                          ),
                          child: Form(
                            key: _formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Drag handle
                                Center(
                                  child: Container(
                                    width: 40,
                                    height: 4,
                                    margin: const EdgeInsets.only(bottom: 24),
                                    decoration: BoxDecoration(
                                      color: AppColors.border,
                                      borderRadius: BorderRadius.circular(2),
                                    ),
                                  ),
                                ),

                                // Section label
                                Row(
                                  children: [
                                    Container(
                                      width: 4,
                                      height: 20,
                                      decoration: BoxDecoration(
                                        color: AppColors.amber,
                                        borderRadius: BorderRadius.circular(2),
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    Text(
                                      'Your Details',
                                      style: GoogleFonts.poppins(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w700,
                                        color: AppColors.dark,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 4),
                                Padding(
                                  padding: const EdgeInsets.only(left: 14),
                                  child: Text(
                                    'We\'ll send you a one-time verification code',
                                    style: GoogleFonts.poppins(
                                        fontSize: 12.5, color: AppColors.grey),
                                  ),
                                ),

                                const SizedBox(height: 28),

                                // ── Name Field ──────────────────────────────
                                _AnimatedInputField(
                                  controller: _companyNameController,
                                  focusNode: _companyNameFocus,
                                  label: 'Company Name',
                                  hint: 'Enter the company name',
                                  icon: Icons.person_outline_rounded,
                                  keyboardType: TextInputType.name,
                                  isValid: _nameValid,
                                  textCapitalization: TextCapitalization.words,
                                  validator: (v) {
                                    if (v == null || v.trim().isEmpty) {
                                      return 'Please enter the company name';
                                    }
                                    return null;
                                  },
                                ),

                                const SizedBox(height: 18),

                                // ── Name Field ──────────────────────────────
                                _AnimatedInputField(
                                  controller: _nameController,
                                  focusNode: _nameFocus,
                                  label: 'Contact Person',
                                  hint: 'Enter your full name',
                                  icon: Icons.person_outline_rounded,
                                  keyboardType: TextInputType.name,
                                  isValid: _nameValid,
                                  textCapitalization: TextCapitalization.words,
                                  validator: (v) {
                                    if (v == null || v.trim().isEmpty) {
                                      return 'Please enter your name';
                                    }
                                    return null;
                                  },
                                ),

                                const SizedBox(height: 18),

                                // ── Phone Field ─────────────────────────────
                                _label('Phone Number'),
                                const SizedBox(height: 6),
                                TextFormField(
                                  controller: _phoneController,
                                  focusNode: _phoneFocus,
                                  keyboardType: TextInputType.phone,
                                  maxLength: 10,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly
                                  ],
                                  style: GoogleFonts.poppins(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.dark,
                                    letterSpacing: 2,
                                  ),
                                  decoration: InputDecoration(
                                    counterText: '',
                                    hintText: '00000 00000',
                                    hintStyle: GoogleFonts.poppins(
                                      fontSize: 16,
                                      color: AppColors.greyLight,
                                      letterSpacing: 2,
                                      fontWeight: FontWeight.w400,
                                    ),
                                    filled: true,
                                    fillColor: Colors.white,
                                    prefixIcon: Container(
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 12, vertical: 10),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 6),
                                      decoration: BoxDecoration(
                                        color: AppColors.navy.withOpacity(0.07),
                                        borderRadius: BorderRadius.circular(8),
                                        border: Border.all(
                                            color: AppColors.border, width: 1),
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          // India flag emoji substitute
                                          Text('🇮🇳',
                                              style: const TextStyle(
                                                  fontSize: 16)),
                                          const SizedBox(width: 4),
                                          Text('+91',
                                              style: GoogleFonts.poppins(
                                                fontSize: 13,
                                                fontWeight: FontWeight.w700,
                                                color: AppColors.dark,
                                              )),
                                        ],
                                      ),
                                    ),
                                    suffixIcon: _phoneValid
                                        ? Padding(
                                            padding: const EdgeInsets.only(
                                                right: 14),
                                            child: Icon(
                                              Icons.check_circle_rounded,
                                              color: AppColors.green,
                                              size: 22,
                                            ),
                                          )
                                        : null,
                                    contentPadding:
                                        const EdgeInsets.symmetric(
                                            vertical: 18, horizontal: 16),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(16),
                                      borderSide: const BorderSide(
                                          color: AppColors.border,
                                          width: 1.5),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(16),
                                      borderSide: const BorderSide(
                                          color: AppColors.border,
                                          width: 1.5),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(16),
                                      borderSide: const BorderSide(
                                          color: AppColors.amber, width: 2),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(16),
                                      borderSide: const BorderSide(
                                          color: AppColors.red, width: 1.5),
                                    ),
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(16),
                                      borderSide: const BorderSide(
                                          color: AppColors.red, width: 2),
                                    ),
                                  ),
                                  validator: (v) {
                                    if (v == null || v.isEmpty) {
                                      return 'Please enter your phone number';
                                    }
                                    if (v.length != 10) {
                                      return 'Enter a valid 10-digit number';
                                    }
                                    return null;
                                  },
                                ),

                                // // Progress dots showing typed digits
                                // if (_phoneController.text.isNotEmpty)
                                //   Padding(
                                //     padding: const EdgeInsets.only(
                                //         top: 10, left: 4),
                                //     child: Row(
                                //       children: List.generate(10, (i) {
                                //         final filled =
                                //             i < _phoneController.text.length;
                                //         return AnimatedContainer(
                                //           duration: const Duration(
                                //               milliseconds: 150),
                                //           margin: const EdgeInsets.only(
                                //               right: 4),
                                //           width: filled ? 18 : 8,
                                //           height: 4,
                                //           decoration: BoxDecoration(
                                //             color: filled
                                //                 ? (_phoneValid
                                //                     ? AppColors.green
                                //                     : AppColors.amber)
                                //                 : AppColors.border,
                                //             borderRadius:
                                //                 BorderRadius.circular(2),
                                //           ),
                                //         );
                                //       }),
                                //     ),
                                //   ),

                                const SizedBox(height: 32),

                                // ── Send OTP Button ─────────────────────────
                                AnimatedContainer(
                                  duration: const Duration(milliseconds: 300),
                                  width: double.infinity,
                                  height: 58,
                                  decoration: BoxDecoration(
                                    gradient: _canSubmit
                                        ? const LinearGradient(
                                            colors: [
                                              AppColors.amber,
                                              Color(0xFFD97706),
                                            ],
                                            begin: Alignment.centerLeft,
                                            end: Alignment.centerRight,
                                          )
                                        : const LinearGradient(
                                            colors: [
                                              Color(0xFFE5E7EB),
                                              Color(0xFFD1D5DB),
                                            ],
                                          ),
                                    borderRadius: BorderRadius.circular(18),
                                    boxShadow: _canSubmit
                                        ? [
                                            BoxShadow(
                                              color: AppColors.amber
                                                  .withOpacity(0.45),
                                              blurRadius: 20,
                                              offset: const Offset(0, 8),
                                            ),
                                          ]
                                        : [],
                                  ),
                                  child: ElevatedButton(
                                    onPressed: _canSubmit ? _sendOTP : null,
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.transparent,
                                      shadowColor: Colors.transparent,
                                      disabledBackgroundColor:
                                          Colors.transparent,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(18),
                                      ),
                                    ),
                                    child: _isLoading
                                        ? Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              const SizedBox(
                                                height: 20,
                                                width: 20,
                                                child:
                                                    CircularProgressIndicator(
                                                  strokeWidth: 2.5,
                                                  valueColor:
                                                      AlwaysStoppedAnimation(
                                                          Colors.white),
                                                ),
                                              ),
                                              const SizedBox(width: 12),
                                              Text(
                                                'Sending OTP...',
                                                style: GoogleFonts.poppins(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w600,
                                                  color: AppColors.dark,
                                                ),
                                              ),
                                            ],
                                          )
                                        : Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                'Send OTP',
                                                style: GoogleFonts.poppins(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w700,
                                                  color: _canSubmit
                                                      ? AppColors.dark
                                                      : AppColors.grey,
                                                ),
                                              ),
                                              const SizedBox(width: 8),
                                              Icon(
                                                Icons.send_rounded,
                                                size: 18,
                                                color: _canSubmit
                                                    ? AppColors.dark
                                                    : AppColors.grey,
                                              ),
                                            ],
                                          ),
                                  ),
                                ),

                                const SizedBox(height: 20),

                                // ── Divider with "or" ───────────────────────
                                Row(
                                  children: [
                                    Expanded(
                                        child: Divider(
                                            color: AppColors.border,
                                            thickness: 1)),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 14),
                                      child: Text(
                                        'Already have an account?',
                                        style: GoogleFonts.poppins(
                                            fontSize: 12,
                                            color: AppColors.greyLight),
                                      ),
                                    ),
                                    Expanded(
                                        child: Divider(
                                            color: AppColors.border,
                                            thickness: 1)),
                                  ],
                                ),

                                const SizedBox(height: 16),

                                // ── Login link ──────────────────────────────
                                SizedBox(
                                  width: double.infinity,
                                  height: 52,
                                  child: OutlinedButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const LoginScreen(),
                                        ),
                                      );
                                    },
                                    style: OutlinedButton.styleFrom(
                                      side: const BorderSide(
                                          color: AppColors.navy, width: 1.5),
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(18),
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const Icon(
                                            Icons.login_rounded,
                                            color: AppColors.navy,
                                            size: 18),
                                        const SizedBox(width: 8),
                                        Text(
                                          'Sign In Instead',
                                          style: GoogleFonts.poppins(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w600,
                                            color: AppColors.navy,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),

                                const SizedBox(height: 20),

                                // ── Terms ───────────────────────────────────
                                Center(
                                  child: Text.rich(
                                    TextSpan(
                                      text: 'By continuing, you agree to our ',
                                      style: GoogleFonts.poppins(
                                          fontSize: 11.5,
                                          color: AppColors.greyLight),
                                      children: [
                                        TextSpan(
                                          text: 'Terms & Conditions',
                                          style: GoogleFonts.poppins(
                                            fontSize: 11.5,
                                            color: AppColors.amber,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        TextSpan(
                                          text: ' and ',
                                          style: GoogleFonts.poppins(
                                              fontSize: 11.5,
                                              color: AppColors.greyLight),
                                        ),
                                        TextSpan(
                                          text: 'Privacy Policy',
                                          style: GoogleFonts.poppins(
                                            fontSize: 11.5,
                                            color: AppColors.amber,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                const SizedBox(height: 8),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _label(String text) => Text(
        text,
        style: GoogleFonts.poppins(
          fontSize: 13,
          fontWeight: FontWeight.w600,
          color: AppColors.dark,
        ),
      );

  @override
  void dispose() {
    _phoneController.dispose();
    _nameController.dispose();
    _phoneFocus.dispose();
    _nameFocus.dispose();
    _heroController.dispose();
    _cardController.dispose();
    _floatController.dispose();
    super.dispose();
  }
}

// ══════════════════════════════════════════════════════════════════════════════
// HELPER WIDGETS
// ══════════════════════════════════════════════════════════════════════════════

class _GlowBlob extends StatelessWidget {
  final double size;
  final Color color;
  const _GlowBlob({required this.size, required this.color});

  @override
  Widget build(BuildContext context) => Container(
        width: size,
        height: size,
        decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      );
}

class _FeaturePill extends StatelessWidget {
  final IconData icon;
  final String label;
  const _FeaturePill({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.08),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withOpacity(0.15)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: AppColors.amber),
          const SizedBox(width: 6),
          Text(
            label,
            style: GoogleFonts.poppins(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: Colors.white.withOpacity(0.9),
            ),
          ),
        ],
      ),
    );
  }
}

class _AnimatedInputField extends StatefulWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final String label;
  final String hint;
  final IconData icon;
  final TextInputType keyboardType;
  final bool isValid;
  final TextCapitalization textCapitalization;
  final String? Function(String?)? validator;

  const _AnimatedInputField({
    required this.controller,
    required this.focusNode,
    required this.label,
    required this.hint,
    required this.icon,
    required this.keyboardType,
    required this.isValid,
    required this.validator,
    this.textCapitalization = TextCapitalization.none,
  });

  @override
  State<_AnimatedInputField> createState() => _AnimatedInputFieldState();
}

class _AnimatedInputFieldState extends State<_AnimatedInputField> {
  bool _focused = false;

  @override
  void initState() {
    super.initState();
    widget.focusNode.addListener(() {
      if (mounted) setState(() => _focused = widget.focusNode.hasFocus);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: GoogleFonts.poppins(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: _focused ? AppColors.amber : AppColors.dark,
          ),
        ),
        const SizedBox(height: 6),
        AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            boxShadow: _focused
                ? [
                    BoxShadow(
                      color: AppColors.amber.withOpacity(0.15),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    )
                  ]
                : [],
          ),
          child: TextFormField(
            controller: widget.controller,
            focusNode: widget.focusNode,
            keyboardType: widget.keyboardType,
            textCapitalization: widget.textCapitalization,
            style: GoogleFonts.poppins(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: AppColors.dark),
            decoration: InputDecoration(
              hintText: widget.hint,
              hintStyle: GoogleFonts.poppins(
                  fontSize: 14, color: AppColors.greyLight),
              filled: true,
              fillColor: Colors.white,
              prefixIcon: Container(
                margin: const EdgeInsets.all(12),
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: _focused
                      ? AppColors.amberLight
                      : AppColors.greyFill,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  widget.icon,
                  size: 18,
                  color: _focused ? AppColors.amber : AppColors.grey,
                ),
              ),
              suffixIcon: widget.isValid
                  ? Padding(
                      padding: const EdgeInsets.only(right: 14),
                      child: Icon(Icons.check_circle_rounded,
                          color: AppColors.green, size: 22),
                    )
                  : null,
              contentPadding: const EdgeInsets.symmetric(
                  vertical: 18, horizontal: 16),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide:
                    const BorderSide(color: AppColors.border, width: 1.5),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide:
                    const BorderSide(color: AppColors.border, width: 1.5),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide:
                    const BorderSide(color: AppColors.amber, width: 2),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide:
                    const BorderSide(color: AppColors.red, width: 1.5),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide:
                    const BorderSide(color: AppColors.red, width: 2),
              ),
            ),
            validator: widget.validator,
          ),
        ),
      ],
    );
  }
}

// ── Subtle dot grid background painter ───────────────────────────────────────
class _DotGridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.04)
      ..style = PaintingStyle.fill;

    const spacing = 28.0;
    const dotRadius = 1.2;

    for (double x = spacing; x < size.width; x += spacing) {
      for (double y = spacing; y < size.height * 0.45; y += spacing) {
        canvas.drawCircle(Offset(x, y), dotRadius, paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}