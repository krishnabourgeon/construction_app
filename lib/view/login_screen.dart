// import 'package:construction_app/view/forgot_password_screen.dart';
// import 'package:construction_app/widgets/app_theme.dart';
// import 'package:construction_app/widgets/common_widgets.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:provider/provider.dart';
// import 'package:construction_app/provider/login_provider.dart';
// import 'package:construction_app/services/helpers.dart';
// import 'package:construction_app/view/company/payment_subscription_screen.dart';
// import 'user/main_userscreen.dart';
// import 'company/main_screen.dart';

// class LoginScreen extends StatefulWidget {
//   const LoginScreen({super.key});

//   @override
//   State<LoginScreen> createState() => _LoginScreenState();
// }

// class _LoginScreenState extends State<LoginScreen> {
//   final _formKey = GlobalKey<FormState>();
//   final _phoneController = TextEditingController();
//   final _passwordController = TextEditingController();
//   bool _obscurePassword = true;
//   bool _isLoading = false;

//   @override
//   void dispose() {
//     _phoneController.dispose();
//     _passwordController.dispose();
//     super.dispose();
//   }

//   void _login() async {
//     if (!_formKey.currentState!.validate()) return;
//     setState(() => _isLoading = true);

//     final provider = Provider.of<LoginProvider>(context, listen: false);
//     provider.loginUsernameController.text = _phoneController.text;
//     provider.loginPasswordController.text = _passwordController.text;

//     await provider.login(
//       onSuccess: (role, trialExpired) {
//         Helpers.successToast('Login Successful');

//         if (trialExpired) {
//           Navigator.pushReplacement(
//             context,
//             MaterialPageRoute(builder: (_) => const PaymentScreen()),
//           );
//         } else {
//           if (role == 'supervisor') {
//             Navigator.pushReplacement(
//               context,
//               MaterialPageRoute(builder: (_) => const MainUserScreen()),
//             );
//           } else {
//             Navigator.pushReplacement(
//               context,
//               MaterialPageRoute(builder: (_) => const MainScreen()),
//             );
//           }
//         }
//       },
//       onFailure: (errorMessage) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text(errorMessage), backgroundColor: Colors.red),
//         );
//       },
//     );

//     if (mounted) {
//       setState(() => _isLoading = false);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.greyBg,
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             // ── Top hero ──────────────────────────────────────────────────
//             Container(
//               width: double.infinity,
//               color: AppColors.navy,
//               padding: EdgeInsets.only(
//                 top: MediaQuery.of(context).padding.top + 40,
//                 bottom: 48,
//                 left: 24,
//                 right: 24,
//               ),
//               child: Column(
//                 children: [
//                   // Logo
//                   Container(
//                     width: 72,
//                     height: 72,
//                     decoration: BoxDecoration(
//                       color: AppColors.amber,
//                       borderRadius: BorderRadius.circular(20),
//                     ),
//                     child: const Icon(
//                       Icons.domain_rounded,
//                       color: AppColors.navy,
//                       size: 40,
//                     ),
//                   ),
//                   const SizedBox(height: 16),
//                   Text(
//                     'BproConstructions',
//                     style: GoogleFonts.poppins(
//                       color: AppColors.white,
//                       fontSize: 26,
//                       fontWeight: FontWeight.w700,
//                     ),
//                   ),
//                   const SizedBox(height: 4),
//                   Text(
//                     'Site Management Platform',
//                     style: GoogleFonts.poppins(
//                       color: AppColors.greyLight,
//                       fontSize: 13,
//                     ),
//                   ),
//                 ],
//               ),
//             ),

//             // ── Form card ─────────────────────────────────────────────────
//             Container(
//               margin: const EdgeInsets.all(20),
//               padding: const EdgeInsets.all(24),
//               decoration: BoxDecoration(
//                 color: AppColors.white,
//                 borderRadius: BorderRadius.circular(24),
//                 border: Border.all(color: AppColors.border),
//               ),
//               child: Form(
//                 key: _formKey,
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       'Welcome back',
//                       style: GoogleFonts.poppins(
//                         fontSize: 20,
//                         fontWeight: FontWeight.w600,
//                         color: AppColors.dark,
//                       ),
//                     ),
//                     const SizedBox(height: 4),
//                     Text(
//                       'Sign in to your account',
//                       style: GoogleFonts.poppins(
//                         fontSize: 13,
//                         color: AppColors.grey,
//                       ),
//                     ),
//                     const SizedBox(height: 24),

//                     // Email
//                     AppTextField(
//                       label: 'Phone Number',
//                       hint: '9876543210',
//                       controller: _phoneController,
//                       // inputFormatters: [
//                       //   FilteringTextInputFormatter.digitsOnly,
//                       //   LengthLimitingTextInputFormatter(10),
//                       // ],
//                       keyboardType: TextInputType.phone,
//                       validator: (v) {
//                         if (v == null || v.isEmpty)
//                           return 'Phone number is required';
//                         if (v.length != 10)
//                           return 'Phone number must be 10 digits';
//                         return null;
//                       },
//                     ),

//                     // Password
//                     AppTextField(
//                       label: 'Password',
//                       hint: 'Enter your password',
//                       controller: _passwordController,
//                       obscureText: _obscurePassword,
//                       suffixIcon: IconButton(
//                         icon: Icon(
//                           _obscurePassword
//                               ? Icons.visibility_off_outlined
//                               : Icons.visibility_outlined,
//                           color: AppColors.grey,
//                           size: 20,
//                         ),
//                         onPressed: () => setState(
//                           () => _obscurePassword = !_obscurePassword,
//                         ),
//                       ),
//                       validator: (v) {
//                         if (v == null || v.isEmpty)
//                           return 'Password is required';
//                         if (v.length < 6) return 'Minimum 8 characters';
//                         return null;
//                       },
//                     ),

//                     // Forgot password
//                     Align(
//                       alignment: Alignment.centerRight,
//                       child: TextButton(
//                         onPressed: () {
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                               builder: (_) => const ForgotPasswordScreen(),
//                             ),
//                           );
//                         },
//                         style: TextButton.styleFrom(
//                           padding: EdgeInsets.zero,
//                           minimumSize: Size.zero,
//                           tapTargetSize: MaterialTapTargetSize.shrinkWrap,
//                         ),
//                         child: Text(
//                           'Forgot Password?',
//                           style: GoogleFonts.poppins(
//                             fontSize: 12,
//                             fontWeight: FontWeight.w500,
//                             color: AppColors.amber,
//                           ),
//                         ),
//                       ),
//                     ),
//                     const SizedBox(height: 20),

//                     // Login button
//                     AppButton(
//                       label: 'Sign In',
//                       onPressed: _login,
//                       isLoading: _isLoading,
//                     ),
//                     const SizedBox(height: 12),

//                     // Register link
//                     // Row(
//                     //   mainAxisAlignment: MainAxisAlignment.center,
//                     //   children: [
//                     //     Text(
//                     //       "Don't have an account? ",
//                     //       style: GoogleFonts.poppins(
//                     //         fontSize: 13,
//                     //         color: AppColors.grey,
//                     //       ),
//                     //     ),
//                     //     GestureDetector(
//                     //       onTap: () {
//                     //         Navigator.of(context).push(
//                     //           MaterialPageRoute(
//                     //             builder: (_) =>  CompanyRegisterScreen(),
//                     //           ),
//                     //         );
//                     //       },
//                     //       child: Text(
//                     //         'Register',
//                     //         style: GoogleFonts.poppins(
//                     //           fontSize: 13,
//                     //           fontWeight: FontWeight.w600,
//                     //           color: AppColors.navy,
//                     //         ),
//                     //       ),
//                     //     ),
//                     //   ],
//                     // ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }






import 'package:construction_app/view/forgot_password_screen.dart';
import 'package:construction_app/widgets/app_theme.dart';
import 'package:construction_app/widgets/common_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:construction_app/provider/login_provider.dart';
import 'package:construction_app/services/helpers.dart';
import 'package:construction_app/view/company/payment_subscription_screen.dart';
import 'user/main_userscreen.dart';
import 'company/main_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;
  bool _isLoading = false;

  @override
  void dispose() {
    _phoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _login() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isLoading = true);

    final provider = Provider.of<LoginProvider>(context, listen: false);
    provider.loginUsernameController.text = _phoneController.text;
    provider.loginPasswordController.text = _passwordController.text;

    await provider.login(
      onSuccess: (role, trialExpired, subscriptionStatus) {
        Helpers.successToast('Login Successful');

        // Paid user → always go to dashboard, never payment screen
        if (subscriptionStatus == 'paid') {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (_) =>
                  role == 'supervisor' ? const MainUserScreen() : const MainScreen(),
            ),
          );
          return;
        }

        if (trialExpired || subscriptionStatus == 'expired') {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => const PaymentScreen()),
          );
        } else {
          if (role == 'supervisor') {
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
        }
      },
      onFailure: (errorMessage) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(errorMessage), backgroundColor: Colors.red),
        );
      },
    );

    if (mounted) {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.greyBg,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // ── Top hero ──────────────────────────────────────────────────
            Container(
              width: double.infinity,
              color: AppColors.navy,
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).padding.top + 40,
                bottom: 48,
                left: 24,
                right: 24,
              ),
              child: Column(
                children: [
                  // Logo
                  Container(
                    width: 72,
                    height: 72,
                    decoration: BoxDecoration(
                      color: AppColors.amber,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Icon(
                      Icons.domain_rounded,
                      color: AppColors.navy,
                      size: 40,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'BproConstructions',
                    style: GoogleFonts.poppins(
                      color: AppColors.white,
                      fontSize: 26,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Site Management Platform',
                    style: GoogleFonts.poppins(
                      color: AppColors.greyLight,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),

            // ── Form card ─────────────────────────────────────────────────
            Container(
              margin: const EdgeInsets.all(20),
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: AppColors.border),
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Welcome back',
                      style: GoogleFonts.poppins(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: AppColors.dark,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Sign in to your account',
                      style: GoogleFonts.poppins(
                        fontSize: 13,
                        color: AppColors.grey,
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Email
                    AppTextField(
                      label: 'Phone Number',
                      hint: '9876543210',
                      controller: _phoneController,
                      // inputFormatters: [
                      //   FilteringTextInputFormatter.digitsOnly,
                      //   LengthLimitingTextInputFormatter(10),
                      // ],
                      keyboardType: TextInputType.phone,
                      validator: (v) {
                        if (v == null || v.isEmpty)
                          return 'Phone number is required';
                        if (v.length != 10)
                          return 'Phone number must be 10 digits';
                        return null;
                      },
                    ),

                    // Password
                    AppTextField(
                      label: 'Password',
                      hint: 'Enter your password',
                      controller: _passwordController,
                      obscureText: _obscurePassword,
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscurePassword
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined,
                          color: AppColors.grey,
                          size: 20,
                        ),
                        onPressed: () => setState(
                          () => _obscurePassword = !_obscurePassword,
                        ),
                      ),
                      validator: (v) {
                        if (v == null || v.isEmpty)
                          return 'Password is required';
                        if (v.length < 6) return 'Minimum 8 characters';
                        return null;
                      },
                    ),

                    // Forgot password
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const ForgotPasswordScreen(),
                            ),
                          );
                        },
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                          minimumSize: Size.zero,
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        child: Text(
                          'Forgot Password?',
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: AppColors.amber,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Login button
                    AppButton(
                      label: 'Sign In',
                      onPressed: _login,
                      isLoading: _isLoading,
                    ),
                    const SizedBox(height: 12),

                    // Register link
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    //   children: [
                    //     Text(
                    //       "Don't have an account? ",
                    //       style: GoogleFonts.poppins(
                    //         fontSize: 13,
                    //         color: AppColors.grey,
                    //       ),
                    //     ),
                    //     GestureDetector(
                    //       onTap: () {
                    //         Navigator.of(context).push(
                    //           MaterialPageRoute(
                    //             builder: (_) =>  CompanyRegisterScreen(),
                    //           ),
                    //         );
                    //       },
                    //       child: Text(
                    //         'Register',
                    //         style: GoogleFonts.poppins(
                    //           fontSize: 13,
                    //           fontWeight: FontWeight.w600,
                    //           color: AppColors.navy,
                    //         ),
                    //       ),
                    //     ),
                    //   ],
                    // ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}