// // // ══════════════════════════════════════════════════════════════════════════════
// // // OTP VERIFICATION SCREEN
// // // ══════════════════════════════════════════════════════════════════════════════
 
// // import 'package:construction_app/view/registration_screen.dart';
// // import 'package:construction_app/widgets/app_theme.dart';
// // import 'package:flutter/material.dart';
// // import 'package:google_fonts/google_fonts.dart';
// // import 'package:pinput/pinput.dart';


// // class OTPVerificationScreen extends StatefulWidget {
// //   final String phoneNumber;
 
// //   const OTPVerificationScreen({super.key, required this.phoneNumber});
 
// //   @override
// //   State<OTPVerificationScreen> createState() => _OTPVerificationScreenState();
// // }
 
// // class _OTPVerificationScreenState extends State<OTPVerificationScreen> {
// //   final _otpController = TextEditingController();
// //   bool _isLoading = false;
// //   int _resendTimer = 30;
 
// //   @override
// //   void initState() {
// //     super.initState();
// //     _startResendTimer();
// //   }
 
// //   void _startResendTimer() {
// //     Future.delayed(const Duration(seconds: 1), () {
// //       if (mounted && _resendTimer > 0) {
// //         setState(() => _resendTimer--);
// //         _startResendTimer();
// //       }
// //     });
// //   }
 
// //   Future<void> _verifyOTP() async {
// //     if (_otpController.text.length != 6) {
// //       _showSnackbar('Please enter complete OTP', isError: true);
// //       return;
// //     }
 
// //     setState(() => _isLoading = true);
 
// //     try {
// //       // TODO: Implement your OTP verification API call
// //       // await yourAuthService.verifyOTP(widget.phoneNumber, _otpController.text);
 
// //       await Future.delayed(const Duration(seconds: 1)); // Simulating API call
 
// //       if (!mounted) return;
 
// //       // Navigate to Registration
// //       Navigator.pushReplacement(
// //         context,
// //         MaterialPageRoute(
// //           builder: (_) => CompanyRegisterScreen()
// //         ),
// //       );
// //     } catch (e) {
// //       _showSnackbar('Invalid OTP. Please try again.', isError: true);
// //     } finally {
// //       if (mounted) setState(() => _isLoading = false);
// //     }
// //   }
 
// //   void _showSnackbar(String message, {bool isError = false}) {
// //     ScaffoldMessenger.of(context).showSnackBar(
// //       SnackBar(
// //         content: Text(message, style: GoogleFonts.poppins(fontSize: 13)),
// //         backgroundColor: isError ? AppColors.red : AppColors.green,
// //         behavior: SnackBarBehavior.floating,
// //         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
// //       ),
// //     );
// //   }
 
// //   @override
// //   Widget build(BuildContext context) {
// //     final defaultPinTheme = PinTheme(
// //       width: 56,
// //       height: 60,
// //       textStyle: GoogleFonts.poppins(
// //         fontSize: 22,
// //         fontWeight: FontWeight.w600,
// //         color: AppColors.dark,
// //       ),
// //       decoration: BoxDecoration(
// //         color: AppColors.greyFill,
// //         borderRadius: BorderRadius.circular(12),
// //         border: Border.all(color: AppColors.border),
// //       ),
// //     );
 
// //     return Scaffold(
// //       backgroundColor: AppColors.white,
// //       appBar: AppBar(
// //         backgroundColor: Colors.transparent,
// //         elevation: 0,
// //         leading: IconButton(
// //           icon: const Icon(Icons.arrow_back, color: AppColors.dark),
// //           onPressed: () => Navigator.pop(context),
// //         ),
// //       ),
// //       body: SafeArea(
// //         child: SingleChildScrollView(
// //           padding: const EdgeInsets.all(24),
// //           child: Column(
// //             crossAxisAlignment: CrossAxisAlignment.start,
// //             children: [
// //               const SizedBox(height: 20),
 
// //               // Title
// //               Text('Enter OTP',
// //                   style: GoogleFonts.poppins(
// //                     fontSize: 26,
// //                     fontWeight: FontWeight.w700,
// //                     color: AppColors.dark,
// //                   )),
// //               const SizedBox(height: 8),
// //               Text.rich(
// //                 TextSpan(
// //                   text: 'We\'ve sent a 6-digit code to\n',
// //                   style: GoogleFonts.poppins(fontSize: 14, color: AppColors.grey),
// //                   children: [
// //                     TextSpan(
// //                       text: '+91 ${widget.phoneNumber}',
// //                       style: GoogleFonts.poppins(
// //                           fontSize: 14,
// //                           color: AppColors.dark,
// //                           fontWeight: FontWeight.w600),
// //                     ),
// //                   ],
// //                 ),
// //               ),
// //               const SizedBox(height: 40),
 
// //               // OTP Input
// //               Center(
// //                 child: Pinput(
// //                   controller: _otpController,
// //                   length: 6,
// //                   defaultPinTheme: defaultPinTheme,
// //                   focusedPinTheme: defaultPinTheme.copyWith(
// //                     decoration: defaultPinTheme.decoration!.copyWith(
// //                       border: Border.all(color: AppColors.amber, width: 2),
// //                     ),
// //                   ),
// //                   onCompleted: (_) => _verifyOTP(),
// //                 ),
// //               ),
// //               const SizedBox(height: 32),
 
// //               // Resend OTP
// //               Center(
// //                 child: _resendTimer > 0
// //                     ? Text('Resend OTP in $_resendTimer seconds',
// //                         style: GoogleFonts.poppins(
// //                             fontSize: 13, color: AppColors.grey))
// //                     : TextButton(
// //                         onPressed: () {
// //                           setState(() => _resendTimer = 30);
// //                           _startResendTimer();
// //                           _showSnackbar('OTP sent successfully');
// //                         },
// //                         child: Text('Resend OTP',
// //                             style: GoogleFonts.poppins(
// //                                 fontSize: 14,
// //                                 fontWeight: FontWeight.w600,
// //                                 color: AppColors.amber)),
// //                       ),
// //               ),
// //               const SizedBox(height: 24),
 
// //               // Verify Button
// //               SizedBox(
// //                 width: double.infinity,
// //                 child: ElevatedButton(
// //                   onPressed: _isLoading ? null : _verifyOTP,
// //                   style: ElevatedButton.styleFrom(
// //                     backgroundColor: AppColors.amber,
// //                     foregroundColor: AppColors.dark,
// //                     padding: const EdgeInsets.symmetric(vertical: 16),
// //                     shape: RoundedRectangleBorder(
// //                         borderRadius: BorderRadius.circular(12)),
// //                     elevation: 0,
// //                   ),
// //                   child: _isLoading
// //                       ? const SizedBox(
// //                           height: 20,
// //                           width: 20,
// //                           child: CircularProgressIndicator(
// //                             strokeWidth: 2,
// //                             valueColor: AlwaysStoppedAnimation(AppColors.dark),
// //                           ),
// //                         )
// //                       : Text('Verify & Continue',
// //                           style: GoogleFonts.poppins(
// //                               fontSize: 16, fontWeight: FontWeight.w600)),
// //                 ),
// //               ),
// //             ],
// //           ),
// //         ),
// //       ),
// //     );
// //   }
 
// //   @override
// //   void dispose() {
// //     _otpController.dispose();
// //     super.dispose();
// //   }
// // }




// // ══════════════════════════════════════════════════════════════════════════════
// // OTP VERIFICATION SCREEN  — Enhanced UI
// // ══════════════════════════════════════════════════════════════════════════════

// import 'dart:math';
// import 'package:construction_app/view/create_password_screen.dart';
// import 'package:construction_app/widgets/app_theme.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:pinput/pinput.dart';

// class OTPVerificationScreen extends StatefulWidget {
//   final String phoneNumber;

//   const OTPVerificationScreen({super.key, required this.phoneNumber});

//   @override
//   State<OTPVerificationScreen> createState() => _OTPVerificationScreenState();
// }

// class _OTPVerificationScreenState extends State<OTPVerificationScreen>
//     with TickerProviderStateMixin {
//   final _otpController = TextEditingController();
//   bool _isLoading = false;
//   int _resendTimer = 30;
//   bool _otpFilled = false;

//   late AnimationController _pulseController;
//   late AnimationController _shakeController;
//   late Animation<double> _pulseAnimation;
//   late Animation<double> _shakeAnimation;

//   @override
//   void initState() {
//     super.initState();

//     _pulseController = AnimationController(
//       vsync: this,
//       duration: const Duration(seconds: 2),
//     )..repeat(reverse: true);
//     _pulseAnimation =
//         Tween<double>(begin: 0.95, end: 1.05).animate(_pulseController);

//     _shakeController = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 500),
//     );
//     _shakeAnimation = Tween<double>(begin: 0, end: 1).animate(
//       CurvedAnimation(parent: _shakeController, curve: Curves.elasticIn),
//     );

//     _startResendTimer();
//   }

//   void _startResendTimer() {
//     Future.delayed(const Duration(seconds: 1), () {
//       if (mounted && _resendTimer > 0) {
//         setState(() => _resendTimer--);
//         _startResendTimer();
//       }
//     });
//   }

//   Future<void> _verifyOTP() async {
//     if (_otpController.text.length != 6) {
//       _shakeController.forward(from: 0);
//       _showSnackbar('Please enter the complete 6-digit OTP', isError: true);
//       return;
//     }

//     setState(() => _isLoading = true);

//     try {
//       // TODO: Replace with your actual OTP verification API call
//       await Future.delayed(const Duration(seconds: 1));

//       if (!mounted) return;
//       HapticFeedback.heavyImpact();

//       Navigator.pushReplacement(
//         context,
//         PageRouteBuilder(
//           pageBuilder: (_, anim, __) =>
//               CreatePasswordScreen(phoneNumber: widget.phoneNumber),
//           transitionsBuilder: (_, anim, __, child) => FadeTransition(
//             opacity: anim,
//             child: SlideTransition(
//               position: Tween<Offset>(
//                 begin: const Offset(1, 0),
//                 end: Offset.zero,
//               ).animate(CurvedAnimation(parent: anim, curve: Curves.easeOut)),
//               child: child,
//             ),
//           ),
//           transitionDuration: const Duration(milliseconds: 400),
//         ),
//       );
//     } catch (e) {
//       _shakeController.forward(from: 0);
//       _showSnackbar('Invalid OTP. Please try again.', isError: true);
//     } finally {
//       if (mounted) setState(() => _isLoading = false);
//     }
//   }

//   void _showSnackbar(String message, {bool isError = false}) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Row(
//           children: [
//             Icon(
//               isError ? Icons.error_outline : Icons.check_circle_outline,
//               color: AppColors.white,
//               size: 18,
//             ),
//             const SizedBox(width: 8),
//             Text(message,
//                 style: GoogleFonts.poppins(fontSize: 13, color: AppColors.white)),
//           ],
//         ),
//         backgroundColor: isError ? const Color(0xFFDC2626) : AppColors.green,
//         behavior: SnackBarBehavior.floating,
//         margin: const EdgeInsets.all(16),
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//         duration: const Duration(seconds: 3),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;

//     final defaultPinTheme = PinTheme(
//       width: 52,
//       height: 58,
//       textStyle: GoogleFonts.poppins(
//         fontSize: 22,
//         fontWeight: FontWeight.w700,
//         color: AppColors.dark,
//       ),
//       decoration: BoxDecoration(
//         color: AppColors.white,
//         borderRadius: BorderRadius.circular(14),
//         border: Border.all(color: AppColors.border, width: 1.5),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.04),
//             blurRadius: 8,
//             offset: const Offset(0, 2),
//           ),
//         ],
//       ),
//     );

//     final focusedPinTheme = defaultPinTheme.copyWith(
//       decoration: BoxDecoration(
//         color: AppColors.amberLight,
//         borderRadius: BorderRadius.circular(14),
//         border: Border.all(color: AppColors.amber, width: 2),
//         boxShadow: [
//           BoxShadow(
//             color: AppColors.amber.withOpacity(0.2),
//             blurRadius: 12,
//             offset: const Offset(0, 4),
//           ),
//         ],
//       ),
//     );

//     final filledPinTheme = defaultPinTheme.copyWith(
//       decoration: BoxDecoration(
//         color: AppColors.navy,
//         borderRadius: BorderRadius.circular(14),
//         border: Border.all(color: AppColors.navy, width: 2),
//         boxShadow: [
//           BoxShadow(
//             color: AppColors.navy.withOpacity(0.25),
//             blurRadius: 10,
//             offset: const Offset(0, 4),
//           ),
//         ],
//       ),
//       textStyle: GoogleFonts.poppins(
//         fontSize: 22,
//         fontWeight: FontWeight.w700,
//         color: AppColors.white,
//       ),
//     );

//     return Scaffold(
//       backgroundColor: const Color(0xFFF8F9FC),
//       body: Stack(
//         children: [
//           // ── Background decorations ──────────────────────────────────────
//           Positioned(
//             top: -60,
//             right: -60,
//             child: _CircleDecor(size: 200, color: AppColors.amberLight),
//           ),
//           Positioned(
//             top: 80,
//             left: -40,
//             child: _CircleDecor(size: 120, color: AppColors.navy.withOpacity(0.07)),
//           ),
//           Positioned(
//             bottom: -80,
//             left: -40,
//             child: _CircleDecor(size: 240, color: AppColors.amberLight.withOpacity(0.5)),
//           ),

//           // ── Main content ──────────────────────────────────────────────
//           SafeArea(
//             child: Column(
//               children: [
//                 // Back button
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//                   child: Align(
//                     alignment: Alignment.centerLeft,
//                     child: Material(
//                       color: Colors.transparent,
//                       child: InkWell(
//                         borderRadius: BorderRadius.circular(12),
//                         onTap: () => Navigator.pop(context),
//                         child: Container(
//                           padding: const EdgeInsets.all(10),
//                           decoration: BoxDecoration(
//                             color: AppColors.white,
//                             borderRadius: BorderRadius.circular(12),
//                             border: Border.all(color: AppColors.border),
//                           ),
//                           child: const Icon(Icons.arrow_back_ios_new_rounded,
//                               size: 18, color: AppColors.dark),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),

//                 Expanded(
//                   child: SingleChildScrollView(
//                     padding: const EdgeInsets.symmetric(horizontal: 24),
//                     child: Column(
//                       children: [
//                         SizedBox(height: size.height * 0.04),

//                         // ── Shield icon with pulse animation ───────────────
//                         ScaleTransition(
//                           scale: _pulseAnimation,
//                           child: Container(
//                             width: 96,
//                             height: 96,
//                             decoration: BoxDecoration(
//                               gradient: const LinearGradient(
//                                 colors: [AppColors.amber, Color(0xFFD97706)],
//                                 begin: Alignment.topLeft,
//                                 end: Alignment.bottomRight,
//                               ),
//                               borderRadius: BorderRadius.circular(28),
//                               boxShadow: [
//                                 BoxShadow(
//                                   color: AppColors.amber.withOpacity(0.4),
//                                   blurRadius: 24,
//                                   offset: const Offset(0, 8),
//                                 ),
//                               ],
//                             ),
//                             child: const Icon(
//                               Icons.shield_outlined,
//                               color: Colors.white,
//                               size: 46,
//                             ),
//                           ),
//                         ),

//                         const SizedBox(height: 28),

//                         // ── Title ──────────────────────────────────────────
//                         Text(
//                           'Verify Your Number',
//                           style: GoogleFonts.poppins(
//                             fontSize: 26,
//                             fontWeight: FontWeight.w700,
//                             color: AppColors.dark,
//                             letterSpacing: -0.5,
//                           ),
//                         ),
//                         const SizedBox(height: 10),

//                         // ── Subtitle ───────────────────────────────────────
//                         RichText(
//                           textAlign: TextAlign.center,
//                           text: TextSpan(
//                             text: 'We sent a 6-digit code to\n',
//                             style: GoogleFonts.poppins(
//                                 fontSize: 14, color: AppColors.grey, height: 1.6),
//                             children: [
//                               TextSpan(
//                                 text: '+91 ${widget.phoneNumber}',
//                                 style: GoogleFonts.poppins(
//                                   fontSize: 15,
//                                   color: AppColors.dark,
//                                   fontWeight: FontWeight.w700,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),

//                         SizedBox(height: size.height * 0.05),

//                         // ── OTP Input with shake animation ─────────────────
//                         AnimatedBuilder(
//                           animation: _shakeAnimation,
//                           builder: (context, child) {
//                             final offset =
//                                 sin(_shakeAnimation.value * pi * 6) * 8;
//                             return Transform.translate(
//                               offset: Offset(offset, 0),
//                               child: child,
//                             );
//                           },
//                           child: Pinput(
//                             controller: _otpController,
//                             length: 6,
//                             defaultPinTheme: defaultPinTheme,
//                             focusedPinTheme: focusedPinTheme,
//                             submittedPinTheme: filledPinTheme,
//                             hapticFeedbackType: HapticFeedbackType.lightImpact,
//                             onChanged: (val) =>
//                                 setState(() => _otpFilled = val.length == 6),
//                             onCompleted: (_) => _verifyOTP(),
//                           ),
//                         ),

//                         const SizedBox(height: 32),

//                         // ── Resend OTP ─────────────────────────────────────
//                         Container(
//                           padding: const EdgeInsets.symmetric(
//                               horizontal: 20, vertical: 12),
//                           decoration: BoxDecoration(
//                             color: AppColors.white,
//                             borderRadius: BorderRadius.circular(12),
//                             border: Border.all(color: AppColors.border),
//                           ),
//                           child: Row(
//                             mainAxisSize: MainAxisSize.min,
//                             children: [
//                               Icon(
//                                 Icons.timer_outlined,
//                                 size: 16,
//                                 color: _resendTimer > 0
//                                     ? AppColors.grey
//                                     : AppColors.amber,
//                               ),
//                               const SizedBox(width: 8),
//                               if (_resendTimer > 0)
//                                 Text(
//                                   'Resend code in  $_resendTimer s',
//                                   style: GoogleFonts.poppins(
//                                       fontSize: 13, color: AppColors.grey),
//                                 )
//                               else
//                                 GestureDetector(
//                                   onTap: () {
//                                     setState(() => _resendTimer = 30);
//                                     _startResendTimer();
//                                     _otpController.clear();
//                                     setState(() => _otpFilled = false);
//                                     _showSnackbar('OTP resent successfully!');
//                                   },
//                                   child: Text(
//                                     'Resend OTP',
//                                     style: GoogleFonts.poppins(
//                                       fontSize: 13,
//                                       fontWeight: FontWeight.w700,
//                                       color: AppColors.amber,
//                                     ),
//                                   ),
//                                 ),
//                             ],
//                           ),
//                         ),

//                         SizedBox(height: size.height * 0.05),

//                         // ── Verify Button ──────────────────────────────────
//                         AnimatedContainer(
//                           duration: const Duration(milliseconds: 300),
//                           width: double.infinity,
//                           height: 56,
//                           decoration: BoxDecoration(
//                             gradient: _otpFilled
//                                 ? const LinearGradient(
//                                     colors: [
//                                       AppColors.amber,
//                                       Color(0xFFD97706)
//                                     ],
//                                     begin: Alignment.centerLeft,
//                                     end: Alignment.centerRight,
//                                   )
//                                 : const LinearGradient(
//                                     colors: [Color(0xFFE5E7EB), Color(0xFFD1D5DB)],
//                                   ),
//                             borderRadius: BorderRadius.circular(16),
//                             boxShadow: _otpFilled
//                                 ? [
//                                     BoxShadow(
//                                       color: AppColors.amber.withOpacity(0.4),
//                                       blurRadius: 16,
//                                       offset: const Offset(0, 6),
//                                     )
//                                   ]
//                                 : [],
//                           ),
//                           child: ElevatedButton(
//                             onPressed: (_isLoading || !_otpFilled)
//                                 ? null
//                                 : _verifyOTP,
//                             style: ElevatedButton.styleFrom(
//                               backgroundColor: Colors.transparent,
//                               shadowColor: Colors.transparent,
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(16),
//                               ),
//                             ),
//                             child: _isLoading
//                                 ? const SizedBox(
//                                     height: 22,
//                                     width: 22,
//                                     child: CircularProgressIndicator(
//                                       strokeWidth: 2.5,
//                                       valueColor: AlwaysStoppedAnimation(
//                                           AppColors.white),
//                                     ),
//                                   )
//                                 : Row(
//                                     mainAxisAlignment: MainAxisAlignment.center,
//                                     children: [
//                                       Text(
//                                         'Verify & Continue',
//                                         style: GoogleFonts.poppins(
//                                           fontSize: 16,
//                                           fontWeight: FontWeight.w700,
//                                           color: _otpFilled
//                                               ? AppColors.dark
//                                               : AppColors.grey,
//                                         ),
//                                       ),
//                                       const SizedBox(width: 8),
//                                       Icon(
//                                         Icons.arrow_forward_rounded,
//                                         size: 20,
//                                         color: _otpFilled
//                                             ? AppColors.dark
//                                             : AppColors.grey,
//                                       ),
//                                     ],
//                                   ),
//                           ),
//                         ),

//                         const SizedBox(height: 20),

//                         // ── Footer note ────────────────────────────────────
//                         Text(
//                           'By verifying, you agree to our Terms & Privacy Policy',
//                           textAlign: TextAlign.center,
//                           style: GoogleFonts.poppins(
//                             fontSize: 11,
//                             color: AppColors.greyLight,
//                             height: 1.5,
//                           ),
//                         ),
//                         const SizedBox(height: 24),
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     _otpController.dispose();
//     _pulseController.dispose();
//     _shakeController.dispose();
//     super.dispose();
//   }
// }

// // ── Helper widget ────────────────────────────────────────────────────────────
// class _CircleDecor extends StatelessWidget {
//   final double size;
//   final Color color;
//   const _CircleDecor({required this.size, required this.color});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: size,
//       height: size,
//       decoration: BoxDecoration(color: color, shape: BoxShape.circle),
//     );
//   }
// }



import 'dart:math';
import 'package:construction_app/provider/company_provider.dart';
import 'package:construction_app/services/shared_preference_helper.dart';
import 'package:construction_app/view/create_password_screen.dart';
import 'package:construction_app/widgets/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';

class OTPVerificationScreen extends StatefulWidget {
  final String phoneNumber;
  const OTPVerificationScreen({super.key, required this.phoneNumber});

  @override
  State<OTPVerificationScreen> createState() => _OTPVerificationScreenState();
}

class _OTPVerificationScreenState extends State<OTPVerificationScreen>
    with SingleTickerProviderStateMixin {
  final _otpController = TextEditingController();
  bool _isLoading = false;
  bool _otpFilled = false;
  int _resendTimer = 30;

  late AnimationController _shakeController;
  late Animation<double> _shakeAnimation;

  @override
  void initState() {
    super.initState();
    _shakeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    _shakeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _shakeController, curve: Curves.elasticIn),
    );
    _startResendTimer();
  }

  void _startResendTimer() {
    Future.delayed(const Duration(seconds: 1), () {
      if (mounted && _resendTimer > 0) {
        setState(() => _resendTimer--);
        _startResendTimer();
      }
    });
  }

  Future<void> _verifyOTP() async {
    if (_otpController.text.length != 6) {
      _shakeController.forward(from: 0);
      _showSnackbar('Please enter the complete 6-digit OTP', isError: true);
      return;
    }
    setState(() => _isLoading = true);
    try {
    final verifyOtpResponse =  await context.read<CompanyProvider>().verifyOtp(
        otp: int.parse(_otpController.text),
        phoneNumber: int.parse(widget.phoneNumber),
      );
      await Future.delayed(const Duration(seconds: 1));
      if (!mounted) return;
      await SharedPreferenceHelper.setOtpVerified(true);

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => CreatePasswordScreen(phoneNumber: widget.phoneNumber,companyId:verifyOtpResponse.companyId,regtoken: verifyOtpResponse.regToken, ),
        ),
      );
    } catch (e) {
      _shakeController.forward(from: 0);
      _showSnackbar('Invalid OTP. Please try again.', isError: true);
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  void _showSnackbar(String message, {bool isError = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message, style: GoogleFonts.poppins(fontSize: 13)),
        backgroundColor: isError ? const Color(0xFFDC2626) : AppColors.green,
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        duration: const Duration(seconds: 3),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 52,
      height: 56,
      textStyle: GoogleFonts.poppins(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: AppColors.dark,
      ),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border, width: 1.5),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyWith(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.amber, width: 2),
      ),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: BoxDecoration(
        color: AppColors.navy,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.navy, width: 2),
      ),
      textStyle: GoogleFonts.poppins(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: AppColors.white,
      ),
    );

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded,
              size: 18, color: AppColors.dark),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),

              // ── Header ────────────────────────────────────────────────
              Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  color: AppColors.amberLight,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: const Icon(Icons.shield_outlined,
                    color: AppColors.amber, size: 26),
              ),
              const SizedBox(height: 20),
              Text(
                'Verify your number',
                style: GoogleFonts.poppins(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color: AppColors.dark,
                ),
              ),
              const SizedBox(height: 8),
              RichText(
                text: TextSpan(
                  text: 'We sent a 6-digit code to ',
                  style: GoogleFonts.poppins(
                      fontSize: 14, color: AppColors.grey, height: 1.5),
                  children: [
                    TextSpan(
                      text: '+91 ${widget.phoneNumber}',
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppColors.dark,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 40),

              // ── OTP Input ─────────────────────────────────────────────
              AnimatedBuilder(
                animation: _shakeAnimation,
                builder: (context, child) => Transform.translate(
                  offset: Offset(sin(_shakeAnimation.value * pi * 6) * 6, 0),
                  child: child,
                ),
                child: Pinput(
                  controller: _otpController,
                  length: 6,
                  defaultPinTheme: defaultPinTheme,
                  focusedPinTheme: focusedPinTheme,
                  submittedPinTheme: submittedPinTheme,
                  hapticFeedbackType: HapticFeedbackType.lightImpact,
                  onChanged: (val) =>
                      setState(() => _otpFilled = val.length == 6),
                  onCompleted: (_) => _verifyOTP(),
                ),
              ),

              const SizedBox(height: 24),

              // ── Resend row ────────────────────────────────────────────
              Row(
                children: [
                  Text(
                    "Didn't receive the code? ",
                    style: GoogleFonts.poppins(
                        fontSize: 13, color: AppColors.grey),
                  ),
                  if (_resendTimer > 0)
                    Text(
                      'Resend in ${_resendTimer}s',
                      style: GoogleFonts.poppins(
                          fontSize: 13, color: AppColors.grey),
                    )
                  else
                    GestureDetector(
                      onTap: () {
                        setState(() => _resendTimer = 30);
                        _startResendTimer();
                        _otpController.clear();
                        setState(() => _otpFilled = false);
                        _showSnackbar('OTP resent successfully!');
                      },
                      child: Text(
                        'Resend OTP',
                        style: GoogleFonts.poppins(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: AppColors.amber,
                        ),
                      ),
                    ),
                ],
              ),

              const Spacer(),

              // ── Verify Button ─────────────────────────────────────────
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: (_isLoading || !_otpFilled) ? null : _verifyOTP,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.amber,
                    disabledBackgroundColor: AppColors.border,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                  child: _isLoading
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor:
                                AlwaysStoppedAnimation(AppColors.white),
                          ),
                        )
                      : Text(
                          'Verify & Continue',
                          style: GoogleFonts.poppins(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: _otpFilled ? AppColors.dark : AppColors.grey,
                          ),
                        ),
                ),
              ),

              const SizedBox(height: 16),
              Center(
                child: Text(
                  'By verifying, you agree to our Terms & Privacy Policy',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                      fontSize: 11, color: AppColors.greyLight),
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _otpController.dispose();
    _shakeController.dispose();
    super.dispose();
  }
}