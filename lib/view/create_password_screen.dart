// // ══════════════════════════════════════════════════════════════════════════════
// // CREATE PASSWORD SCREEN
// // ══════════════════════════════════════════════════════════════════════════════

// import 'package:construction_app/view/login_screen.dart';
// import 'package:construction_app/view/registration_screen.dart';
// import 'package:construction_app/widgets/app_theme.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:google_fonts/google_fonts.dart';

// class CreatePasswordScreen extends StatefulWidget {
//   final String phoneNumber;

//   const CreatePasswordScreen({super.key, required this.phoneNumber});

//   @override
//   State<CreatePasswordScreen> createState() => _CreatePasswordScreenState();
// }

// class _CreatePasswordScreenState extends State<CreatePasswordScreen>
//     with SingleTickerProviderStateMixin {
//   final _passwordController = TextEditingController();
//   final _confirmController = TextEditingController();
//   final _formKey = GlobalKey<FormState>();

//   bool _obscurePassword = true;
//   bool _obscureConfirm = true;
//   bool _isLoading = false;

//   // Strength indicators
//   bool _hasMinLength = false;
//   bool _hasUpperCase = false;
//   bool _hasNumber = false;
//   bool _hasSpecialChar = false;

//   late AnimationController _fadeController;
//   late Animation<double> _fadeAnimation;

//   @override
//   void initState() {
//     super.initState();
//     _fadeController = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 600),
//     )..forward();
//     _fadeAnimation = CurvedAnimation(
//       parent: _fadeController,
//       curve: Curves.easeOut,
//     );
//   }

//   void _analyzePassword(String value) {
//     setState(() {
//       _hasMinLength = value.length >= 8;
//       _hasUpperCase = value.contains(RegExp(r'[A-Z]'));
//       _hasNumber = value.contains(RegExp(r'[0-9]'));
//       _hasSpecialChar = value.contains(RegExp(r'[!@#\$%^&*(),.?":{}|<>]'));
//     });
//   }

//   int get _strengthScore =>
//       [_hasMinLength, _hasUpperCase, _hasNumber, _hasSpecialChar]
//           .where((e) => e)
//           .length;

//   Color get _strengthColor {
//     if (_strengthScore <= 1) return const Color(0xFFDC2626);
//     if (_strengthScore == 2) return const Color(0xFFF59E0B);
//     if (_strengthScore == 3) return const Color(0xFF10B981);
//     return const Color(0xFF059669);
//   }

//   String get _strengthLabel {
//     if (_passwordController.text.isEmpty) return '';
//     if (_strengthScore <= 1) return 'Weak';
//     if (_strengthScore == 2) return 'Fair';
//     if (_strengthScore == 3) return 'Good';
//     return 'Strong';
//   }

//   Future<void> _createPassword() async {
//     if (!_formKey.currentState!.validate()) return;
//     setState(() => _isLoading = true);
//     HapticFeedback.mediumImpact();

//     try {
//       // TODO: Call API to save password
//       await Future.delayed(const Duration(seconds: 1));
//       if (!mounted) return;

//       _showRegistrationPopup();
//     } finally {
//       if (mounted) setState(() => _isLoading = false);
//     }
//   }

//   void _showRegistrationPopup() {
//     showDialog(
//       context: context,
//       barrierDismissible: false,
//       builder: (ctx) => Dialog(
//         backgroundColor: Colors.transparent,
//         insetPadding: const EdgeInsets.symmetric(horizontal: 24),
//         child: Container(
//           decoration: BoxDecoration(
//             color: AppColors.white,
//             borderRadius: BorderRadius.circular(24),
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.black.withOpacity(0.12),
//                 blurRadius: 40,
//                 offset: const Offset(0, 16),
//               ),
//             ],
//           ),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               // ── Top gradient banner ────────────────────────────────────
//               Container(
//                 width: double.infinity,
//                 padding: const EdgeInsets.all(24),
//                 decoration: const BoxDecoration(
//                   gradient: LinearGradient(
//                     colors: [AppColors.navy, Color(0xFF2D2D4E)],
//                     begin: Alignment.topLeft,
//                     end: Alignment.bottomRight,
//                   ),
//                   borderRadius: BorderRadius.only(
//                     topLeft: Radius.circular(24),
//                     topRight: Radius.circular(24),
//                   ),
//                 ),
//                 child: Column(
//                   children: [
//                     Container(
//                       width: 64,
//                       height: 64,
//                       decoration: BoxDecoration(
//                         color: AppColors.amber,
//                         borderRadius: BorderRadius.circular(20),
//                         boxShadow: [
//                           BoxShadow(
//                             color: AppColors.amber.withOpacity(0.4),
//                             blurRadius: 16,
//                             offset: const Offset(0, 6),
//                           ),
//                         ],
//                       ),
//                       child: const Icon(
//                         Icons.domain_rounded,
//                         color: AppColors.navy,
//                         size: 34,
//                       ),
//                     ),
//                     const SizedBox(height: 14),
//                     Text(
//                       'Almost There! 🎉',
//                       style: GoogleFonts.poppins(
//                         fontSize: 20,
//                         fontWeight: FontWeight.w700,
//                         color: AppColors.white,
//                       ),
//                     ),
//                     const SizedBox(height: 6),
//                     Text(
//                       'Your account is ready. Would you like to\ncomplete your company registration?',
//                       textAlign: TextAlign.center,
//                       style: GoogleFonts.poppins(
//                         fontSize: 13,
//                         color: AppColors.greyLight,
//                         height: 1.5,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),

//               // ── Body ───────────────────────────────────────────────────
//               Padding(
//                 padding: const EdgeInsets.all(24),
//                 child: Column(
//                   children: [
//                     // Trial badge
//                     Container(
//                       padding: const EdgeInsets.symmetric(
//                           horizontal: 16, vertical: 10),
//                       decoration: BoxDecoration(
//                         color: AppColors.amberLight,
//                         borderRadius: BorderRadius.circular(12),
//                         border: Border.all(
//                             color: AppColors.amber.withOpacity(0.3)),
//                       ),
//                       child: Row(
//                         mainAxisSize: MainAxisSize.min,
//                         children: [
//                           const Icon(Icons.star_rounded,
//                               color: AppColors.amber, size: 18),
//                           const SizedBox(width: 8),
//                           Text(
//                             '15-Day Free Trial Included!',
//                             style: GoogleFonts.poppins(
//                               fontSize: 13,
//                               fontWeight: FontWeight.w600,
//                               color: AppColors.amberDark,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     const SizedBox(height: 20),

//                     // Continue with registration button
//                     SizedBox(
//                       width: double.infinity,
//                       height: 52,
//                       child: ElevatedButton(
//                         onPressed: () {
//                           Navigator.pop(ctx);
//                           Navigator.pushReplacement(
//                             context,
//                             MaterialPageRoute(
//                                 builder: (_) => CompanyRegisterScreen()),
//                           );
//                         },
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: AppColors.amber,
//                           foregroundColor: AppColors.dark,
//                           elevation: 0,
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(14),
//                           ),
//                         ),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             const Icon(Icons.app_registration_rounded,
//                                 size: 18),
//                             const SizedBox(width: 8),
//                             Text(
//                               'Continue with Registration',
//                               style: GoogleFonts.poppins(
//                                 fontSize: 15,
//                                 fontWeight: FontWeight.w700,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),

//                     const SizedBox(height: 10),

//                     // Skip for now button
//                     SizedBox(
//                       width: double.infinity,
//                       height: 52,
//                       child: OutlinedButton(
//                         onPressed: () {
//                           Navigator.pop(ctx);
//                           Navigator.pushAndRemoveUntil(
//                             context,
//                             MaterialPageRoute(
//                                 builder: (_) => const LoginScreen()),
//                             (route) => false,
//                           );
//                         },
//                         style: OutlinedButton.styleFrom(
//                           side: const BorderSide(
//                               color: AppColors.border, width: 1.5),
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(14),
//                           ),
//                         ),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             const Icon(Icons.skip_next_rounded,
//                                 color: AppColors.grey, size: 18),
//                             const SizedBox(width: 8),
//                             Text(
//                               'Skip for Now',
//                               style: GoogleFonts.poppins(
//                                 fontSize: 15,
//                                 fontWeight: FontWeight.w600,
//                                 color: AppColors.grey,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),

//                     const SizedBox(height: 12),
//                     Text(
//                       'You can always complete registration later',
//                       style: GoogleFonts.poppins(
//                         fontSize: 11,
//                         color: AppColors.greyLight,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFF8F9FC),
//       body: Stack(
//         children: [
//           // Background decorations
//           Positioned(
//             top: -80,
//             left: -80,
//             child: Container(
//               width: 240,
//               height: 240,
//               decoration: BoxDecoration(
//                 color: AppColors.navy.withOpacity(0.06),
//                 shape: BoxShape.circle,
//               ),
//             ),
//           ),
//           Positioned(
//             bottom: -60,
//             right: -60,
//             child: Container(
//               width: 200,
//               height: 200,
//               decoration: BoxDecoration(
//                 color: AppColors.amberLight.withOpacity(0.7),
//                 shape: BoxShape.circle,
//               ),
//             ),
//           ),

//           SafeArea(
//             child: FadeTransition(
//               opacity: _fadeAnimation,
//               child: Column(
//                 children: [
//                   // Back button
//                   Padding(
//                     padding: const EdgeInsets.symmetric(
//                         horizontal: 16, vertical: 4),
//                     child: Align(
//                       alignment: Alignment.centerLeft,
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

//                   Expanded(
//                     child: SingleChildScrollView(
//                       padding: const EdgeInsets.symmetric(horizontal: 24),
//                       child: Form(
//                         key: _formKey,
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             const SizedBox(height: 20),

//                             // Lock icon
//                             Container(
//                               width: 80,
//                               height: 80,
//                               decoration: BoxDecoration(
//                                 gradient: const LinearGradient(
//                                   colors: [AppColors.navy, Color(0xFF2D2D4E)],
//                                   begin: Alignment.topLeft,
//                                   end: Alignment.bottomRight,
//                                 ),
//                                 borderRadius: BorderRadius.circular(24),
//                                 boxShadow: [
//                                   BoxShadow(
//                                     color: AppColors.navy.withOpacity(0.3),
//                                     blurRadius: 20,
//                                     offset: const Offset(0, 8),
//                                   ),
//                                 ],
//                               ),
//                               child: const Icon(Icons.lock_outline_rounded,
//                                   color: AppColors.white, size: 38),
//                             ),

//                             const SizedBox(height: 24),
//                             Text(
//                               'Create Password',
//                               style: GoogleFonts.poppins(
//                                 fontSize: 26,
//                                 fontWeight: FontWeight.w700,
//                                 color: AppColors.dark,
//                                 letterSpacing: -0.5,
//                               ),
//                             ),
//                             const SizedBox(height: 6),
//                             Text(
//                               'Set a strong password to secure your\nBproaccount.',
//                               style: GoogleFonts.poppins(
//                                   fontSize: 14,
//                                   color: AppColors.grey,
//                                   height: 1.5),
//                             ),

//                             const SizedBox(height: 32),

//                             // ── Password Field ──────────────────────────
//                             _buildLabel('New Password'),
//                             const SizedBox(height: 6),
//                             TextFormField(
//                               controller: _passwordController,
//                               obscureText: _obscurePassword,
//                               onChanged: _analyzePassword,
//                               style: GoogleFonts.poppins(
//                                   fontSize: 15, color: AppColors.dark),
//                               decoration: _inputDecoration(
//                                 hint: 'Enter your password',
//                                 suffixIcon: IconButton(
//                                   icon: Icon(
//                                     _obscurePassword
//                                         ? Icons.visibility_off_outlined
//                                         : Icons.visibility_outlined,
//                                     color: AppColors.grey,
//                                     size: 20,
//                                   ),
//                                   onPressed: () => setState(
//                                       () => _obscurePassword = !_obscurePassword),
//                                 ),
//                               ),
//                               validator: (v) {
//                                 if (v == null || v.isEmpty)
//                                   return 'Password is required';
//                                 if (v.length < 8)
//                                   return 'Minimum 8 characters required';
//                                 return null;
//                               },
//                             ),

//                             const SizedBox(height: 12),

//                             // ── Strength bar ────────────────────────────
//                             if (_passwordController.text.isNotEmpty) ...[
//                               Row(
//                                 children: [
//                                   Expanded(
//                                     child: Row(
//                                       children: List.generate(
//                                         4,
//                                         (i) => Expanded(
//                                           child: Container(
//                                             height: 4,
//                                             margin: EdgeInsets.only(
//                                                 right: i < 3 ? 4 : 0),
//                                             decoration: BoxDecoration(
//                                               color: i < _strengthScore
//                                                   ? _strengthColor
//                                                   : AppColors.border,
//                                               borderRadius:
//                                                   BorderRadius.circular(2),
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                   const SizedBox(width: 10),
//                                   Text(
//                                     _strengthLabel,
//                                     style: GoogleFonts.poppins(
//                                       fontSize: 12,
//                                       fontWeight: FontWeight.w600,
//                                       color: _strengthColor,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                               const SizedBox(height: 12),

//                               // Checklist
//                               Wrap(
//                                 spacing: 8,
//                                 runSpacing: 6,
//                                 children: [
//                                   _CheckChip(
//                                       label: '8+ chars',
//                                       active: _hasMinLength),
//                                   _CheckChip(
//                                       label: 'Uppercase',
//                                       active: _hasUpperCase),
//                                   _CheckChip(
//                                       label: 'Number',
//                                       active: _hasNumber),
//                                   _CheckChip(
//                                       label: 'Symbol',
//                                       active: _hasSpecialChar),
//                                 ],
//                               ),
//                               const SizedBox(height: 8),
//                             ],

//                             const SizedBox(height: 16),

//                             // ── Confirm Password ────────────────────────
//                             _buildLabel('Confirm Password'),
//                             const SizedBox(height: 6),
//                             TextFormField(
//                               controller: _confirmController,
//                               obscureText: _obscureConfirm,
//                               style: GoogleFonts.poppins(
//                                   fontSize: 15, color: AppColors.dark),
//                               decoration: _inputDecoration(
//                                 hint: 'Re-enter your password',
//                                 suffixIcon: IconButton(
//                                   icon: Icon(
//                                     _obscureConfirm
//                                         ? Icons.visibility_off_outlined
//                                         : Icons.visibility_outlined,
//                                     color: AppColors.grey,
//                                     size: 20,
//                                   ),
//                                   onPressed: () => setState(
//                                       () => _obscureConfirm = !_obscureConfirm),
//                                 ),
//                               ),
//                               validator: (v) {
//                                 if (v == null || v.isEmpty)
//                                   return 'Please confirm your password';
//                                 if (v != _passwordController.text)
//                                   return 'Passwords do not match';
//                                 return null;
//                               },
//                             ),

//                             const SizedBox(height: 36),

//                             // ── Create Button ───────────────────────────
//                             SizedBox(
//                               width: double.infinity,
//                               height: 56,
//                               child: DecoratedBox(
//                                 decoration: BoxDecoration(
//                                   gradient: const LinearGradient(
//                                     colors: [
//                                       AppColors.amber,
//                                       Color(0xFFD97706)
//                                     ],
//                                     begin: Alignment.centerLeft,
//                                     end: Alignment.centerRight,
//                                   ),
//                                   borderRadius: BorderRadius.circular(16),
//                                   boxShadow: [
//                                     BoxShadow(
//                                       color: AppColors.amber.withOpacity(0.4),
//                                       blurRadius: 16,
//                                       offset: const Offset(0, 6),
//                                     ),
//                                   ],
//                                 ),
//                                 child: ElevatedButton(
//                                   onPressed: _isLoading ? null : _createPassword,
//                                   style: ElevatedButton.styleFrom(
//                                     backgroundColor: Colors.transparent,
//                                     shadowColor: Colors.transparent,
//                                     shape: RoundedRectangleBorder(
//                                         borderRadius: BorderRadius.circular(16)),
//                                   ),
//                                   child: _isLoading
//                                       ? const SizedBox(
//                                           height: 22,
//                                           width: 22,
//                                           child: CircularProgressIndicator(
//                                             strokeWidth: 2.5,
//                                             valueColor: AlwaysStoppedAnimation(
//                                                 AppColors.white),
//                                           ),
//                                         )
//                                       : Row(
//                                           mainAxisAlignment:
//                                               MainAxisAlignment.center,
//                                           children: [
//                                             Text(
//                                               'Create Password',
//                                               style: GoogleFonts.poppins(
//                                                 fontSize: 16,
//                                                 fontWeight: FontWeight.w700,
//                                                 color: AppColors.dark,
//                                               ),
//                                             ),
//                                             const SizedBox(width: 8),
//                                             const Icon(
//                                                 Icons.arrow_forward_rounded,
//                                                 size: 20,
//                                                 color: AppColors.dark),
//                                           ],
//                                         ),
//                                 ),
//                               ),
//                             ),

//                             const SizedBox(height: 24),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildLabel(String text) => Text(
//         text,
//         style: GoogleFonts.poppins(
//           fontSize: 13,
//           fontWeight: FontWeight.w600,
//           color: AppColors.dark,
//         ),
//       );

//   InputDecoration _inputDecoration(
//       {required String hint, Widget? suffixIcon}) {
//     return InputDecoration(
//       hintText: hint,
//       hintStyle:
//           GoogleFonts.poppins(fontSize: 14, color: AppColors.greyLight),
//       filled: true,
//       fillColor: AppColors.white,
//       suffixIcon: suffixIcon,
//       contentPadding:
//           const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
//       border: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(14),
//         borderSide: const BorderSide(color: AppColors.border),
//       ),
//       enabledBorder: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(14),
//         borderSide: const BorderSide(color: AppColors.border, width: 1.5),
//       ),
//       focusedBorder: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(14),
//         borderSide: const BorderSide(color: AppColors.amber, width: 2),
//       ),
//       errorBorder: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(14),
//         borderSide: const BorderSide(color: AppColors.red, width: 1.5),
//       ),
//       focusedErrorBorder: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(14),
//         borderSide: const BorderSide(color: AppColors.red, width: 2),
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     _passwordController.dispose();
//     _confirmController.dispose();
//     _fadeController.dispose();
//     super.dispose();
//   }
// }

// // ── Helper widget ────────────────────────────────────────────────────────────
// class _CheckChip extends StatelessWidget {
//   final String label;
//   final bool active;
//   const _CheckChip({required this.label, required this.active});

//   @override
//   Widget build(BuildContext context) {
//     return AnimatedContainer(
//       duration: const Duration(milliseconds: 300),
//       padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
//       decoration: BoxDecoration(
//         color: active ? AppColors.greenLight : AppColors.greyBg,
//         borderRadius: BorderRadius.circular(8),
//         border: Border.all(
//           color: active ? AppColors.green.withOpacity(0.4) : AppColors.border,
//         ),
//       ),
//       child: Row(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Icon(
//             active ? Icons.check_circle_rounded : Icons.radio_button_unchecked,
//             size: 13,
//             color: active ? AppColors.green : AppColors.greyLight,
//           ),
//           const SizedBox(width: 4),
//           Text(
//             label,
//             style: GoogleFonts.poppins(
//               fontSize: 11,
//               fontWeight: FontWeight.w500,
//               color: active ? AppColors.green : AppColors.grey,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:construction_app/provider/company_provider.dart';
import 'package:construction_app/view/login_screen.dart';
import 'package:construction_app/view/registration_screen.dart';
import 'package:construction_app/widgets/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class CreatePasswordScreen extends StatefulWidget {
  final String phoneNumber;
  final int companyId;
  final String regtoken;
  const CreatePasswordScreen({
    super.key,
    required this.phoneNumber,
    required this.companyId,
    required this.regtoken,
  });

  @override
  State<CreatePasswordScreen> createState() => _CreatePasswordScreenState();
}

class _CreatePasswordScreenState extends State<CreatePasswordScreen> {
  final _passwordController = TextEditingController();
  final _confirmController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool _obscurePassword = true;
  bool _obscureConfirm = true;
  bool _isLoading = false;

  bool _hasMinLength = false;
  bool _hasUpperCase = false;
  bool _hasNumber = false;
  bool _hasSpecialChar = false;

  void _analyzePassword(String value) {
    setState(() {
      _hasMinLength = value.length >= 8;
      _hasUpperCase = value.contains(RegExp(r'[A-Z]'));
      _hasNumber = value.contains(RegExp(r'[0-9]'));
      _hasSpecialChar = value.contains(RegExp(r'[!@#\$%^&*(),.?":{}|<>]'));
    });
  }

  int get _strengthScore => [
    _hasMinLength,
    _hasUpperCase,
    _hasNumber,
    _hasSpecialChar,
  ].where((e) => e).length;

  Color get _strengthColor {
    if (_strengthScore <= 1) return const Color(0xFFDC2626);
    if (_strengthScore == 2) return const Color(0xFFF59E0B);
    if (_strengthScore == 3) return const Color(0xFF10B981);
    return const Color(0xFF059669);
  }

  String get _strengthLabel {
    if (_passwordController.text.isEmpty) return '';
    if (_strengthScore <= 1) return 'Weak';
    if (_strengthScore == 2) return 'Fair';
    if (_strengthScore == 3) return 'Good';
    return 'Strong';
  }

  Future<void> _createPassword() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isLoading = true);
    HapticFeedback.mediumImpact();
    try {
      await context.read<CompanyProvider>().setPassword(
        password: _passwordController.text,
        confirmPassword: _confirmController.text,
        companyId: widget.companyId,
      );
      await Future.delayed(const Duration(seconds: 1));
      if (!mounted) return;
      _showRegistrationDialog();
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  void _showRegistrationDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppColors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        contentPadding: EdgeInsets.zero,
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Top banner
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 28, horizontal: 24),
              decoration: const BoxDecoration(
                color: AppColors.navy,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Column(
                children: [
                  Container(
                    width: 56,
                    height: 56,
                    decoration: BoxDecoration(
                      color: AppColors.amber,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const Icon(
                      Icons.domain_rounded,
                      color: AppColors.navy,
                      size: 28,
                    ),
                  ),
                  const SizedBox(height: 14),
                  Text(
                    'Account Created! 🎉',
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: AppColors.white,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Complete your company registration\nto get started.',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      fontSize: 13,
                      color: AppColors.greyLight,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),

            // Body
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  // Trial badge
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.amberLight,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: AppColors.amber.withOpacity(0.3),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.star_rounded,
                          color: AppColors.amber,
                          size: 16,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '15-Day Free Trial Included',
                          style: GoogleFonts.poppins(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: AppColors.amberDark,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(ctx);
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (_) => CompanyRegisterScreen(
                              companyID: widget.companyId,
                              regtoken: widget.regtoken,
                            ),
                          ),
                        );
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
                        'Complete Registration',
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: TextButton(
                      onPressed: () {
                        Navigator.pop(ctx);
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const LoginScreen(),
                          ),
                          (route) => false,
                        );
                      },
                      child: Text(
                        'Skip for now',
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: AppColors.grey,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            size: 18,
            color: AppColors.dark,
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16),

                // ── Header ───────────────────────────────────────────────
                Container(
                  width: 52,
                  height: 52,
                  decoration: BoxDecoration(
                    color: AppColors.navy.withOpacity(0.08),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: const Icon(
                    Icons.lock_outline_rounded,
                    color: AppColors.navy,
                    size: 26,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  'Create password',
                  style: GoogleFonts.poppins(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    color: AppColors.dark,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'Set a strong password to secure your account.',
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: AppColors.grey,
                    height: 1.5,
                  ),
                ),

                const SizedBox(height: 36),

                // ── Password Field ────────────────────────────────────────
                _buildLabel('New Password'),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _passwordController,
                  obscureText: _obscurePassword,
                  onChanged: _analyzePassword,
                  style: GoogleFonts.poppins(
                    fontSize: 15,
                    color: AppColors.dark,
                  ),
                  decoration: _inputDecoration(
                    hint: 'Enter your password',
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscurePassword
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                        color: AppColors.grey,
                        size: 20,
                      ),
                      onPressed: () =>
                          setState(() => _obscurePassword = !_obscurePassword),
                    ),
                  ),
                  validator: (v) {
                    if (v == null || v.isEmpty) return 'Password is required';
                    if (v.length < 8) return 'Minimum 8 characters required';
                    return null;
                  },
                ),

                // ── Strength bar ──────────────────────────────────────────
                if (_passwordController.text.isNotEmpty) ...[
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      ...List.generate(
                        4,
                        (i) => Expanded(
                          child: Container(
                            height: 3,
                            margin: EdgeInsets.only(right: i < 3 ? 4 : 0),
                            decoration: BoxDecoration(
                              color: i < _strengthScore
                                  ? _strengthColor
                                  : AppColors.border,
                              borderRadius: BorderRadius.circular(2),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        _strengthLabel,
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: _strengthColor,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 6,
                    runSpacing: 6,
                    children: [
                      _CheckChip(label: '8+ chars', active: _hasMinLength),
                      _CheckChip(label: 'Uppercase', active: _hasUpperCase),
                      _CheckChip(label: 'Number', active: _hasNumber),
                      _CheckChip(label: 'Symbol', active: _hasSpecialChar),
                    ],
                  ),
                ],

                const SizedBox(height: 20),

                // ── Confirm Password ──────────────────────────────────────
                _buildLabel('Confirm Password'),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _confirmController,
                  obscureText: _obscureConfirm,
                  style: GoogleFonts.poppins(
                    fontSize: 15,
                    color: AppColors.dark,
                  ),
                  decoration: _inputDecoration(
                    hint: 'Re-enter your password',
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscureConfirm
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                        color: AppColors.grey,
                        size: 20,
                      ),
                      onPressed: () =>
                          setState(() => _obscureConfirm = !_obscureConfirm),
                    ),
                  ),
                  validator: (v) {
                    if (v == null || v.isEmpty)
                      return 'Please confirm your password';
                    if (v != _passwordController.text)
                      return 'Passwords do not match';
                    return null;
                  },
                ),

                const SizedBox(height: 36),

                // ── Create Button ─────────────────────────────────────────
                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : _createPassword,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.amber,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: _isLoading
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation(
                                AppColors.white,
                              ),
                            ),
                          )
                        : Text(
                            'Create Password',
                            style: GoogleFonts.poppins(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: AppColors.dark,
                            ),
                          ),
                  ),
                ),

                const SizedBox(height: 32),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(String text) => Text(
    text,
    style: GoogleFonts.poppins(
      fontSize: 13,
      fontWeight: FontWeight.w600,
      color: AppColors.dark,
    ),
  );

  InputDecoration _inputDecoration({required String hint, Widget? suffixIcon}) {
    return InputDecoration(
      hintText: hint,
      hintStyle: GoogleFonts.poppins(fontSize: 14, color: AppColors.greyLight),
      filled: true,
      fillColor: const Color(0xFFF8F9FC),
      suffixIcon: suffixIcon,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.border),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.border, width: 1.5),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.amber, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.red, width: 1.5),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.red, width: 2),
      ),
    );
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmController.dispose();
    super.dispose();
  }
}

class _CheckChip extends StatelessWidget {
  final String label;
  final bool active;
  const _CheckChip({required this.label, required this.active});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: active ? AppColors.greenLight : AppColors.greyBg,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: active ? AppColors.green.withOpacity(0.4) : AppColors.border,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            active ? Icons.check_circle_rounded : Icons.radio_button_unchecked,
            size: 12,
            color: active ? AppColors.green : AppColors.greyLight,
          ),
          const SizedBox(width: 4),
          Text(
            label,
            style: GoogleFonts.poppins(
              fontSize: 11,
              fontWeight: FontWeight.w500,
              color: active ? AppColors.green : AppColors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
