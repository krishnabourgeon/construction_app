import 'package:construction_app/models/change_password_body.dart';
import 'package:construction_app/provider/company_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:construction_app/widgets/app_theme.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final _formKey = GlobalKey<FormState>();

  final _currentCtrl = TextEditingController();
  final _newCtrl     = TextEditingController();
  final _confirmCtrl = TextEditingController();

  // bool _showCurrent = false;
  bool _showNew     = false;
  bool _showConfirm = false;
  bool _isLoading   = false;

  // ── Password strength ────────────────────────────────────────────
  double get _strength {
    final p = _newCtrl.text;
    if (p.isEmpty) return 0;
    double s = 0;
    if (p.length >= 8)                        s += 0.25;
    if (RegExp(r'[A-Z]').hasMatch(p))         s += 0.25;
    if (RegExp(r'[0-9]').hasMatch(p))         s += 0.25;
    if (RegExp(r'[!@#\$%^&*]').hasMatch(p))   s += 0.25;
    return s;
  }

  Color get _strengthColor {
    final s = _strength;
    if (s <= 0.25) return AppColors.red;
    if (s <= 0.50) return AppColors.amberDark;
    if (s <= 0.75) return AppColors.blue;
    return AppColors.green;
  }

  String get _strengthLabel {
    final s = _strength;
    if (s <= 0.25) return 'Weak';
    if (s <= 0.50) return 'Fair';
    if (s <= 0.75) return 'Good';
    return 'Strong';
  }

  // ── Rules ────────────────────────────────────────────────────────
  bool get _rule8   => _newCtrl.text.length >= 8;
  bool get _ruleUC  => RegExp(r'[A-Z]').hasMatch(_newCtrl.text);
  bool get _ruleNum => RegExp(r'[0-9]').hasMatch(_newCtrl.text);
  bool get _ruleSpc => RegExp(r'[!@#\$%^&*]').hasMatch(_newCtrl.text);
  bool get _match   =>
      _newCtrl.text.isNotEmpty &&
      _newCtrl.text == _confirmCtrl.text;

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isLoading = true);
    try {
      // Replace with your actual API call:
      await context.read<CompanyProvider>().changePassword(
        body: ChangePasswordBody(
          //currentPassword: _currentCtrl.text,
          newPassword: _newCtrl.text,
          newPasswordConfirmation: _confirmCtrl.text,
        ),
      );
      await Future.delayed(const Duration(seconds: 1));
      if (!mounted) return;
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Password updated successfully',
              style: GoogleFonts.poppins(fontSize: 13)),
          backgroundColor: AppColors.green,
          behavior: SnackBarBehavior.floating,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString(),
              style: GoogleFonts.poppins(fontSize: 13)),
          backgroundColor: AppColors.red,
          behavior: SnackBarBehavior.floating,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
      );
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  void initState() {
    super.initState();
    _newCtrl.addListener(() => setState(() {}));
    _confirmCtrl.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _currentCtrl.dispose();
    _newCtrl.dispose();
    _confirmCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FC),
      body: CustomScrollView(
        slivers: [
          // ── App Bar ───────────────────────────────────────────────
          SliverAppBar(
            expandedHeight: 160,
            pinned: true,
            backgroundColor: AppColors.navy,
            automaticallyImplyLeading: false,
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                children: [
                  Positioned(
                    top: -20, right: -20,
                    child: Container(
                      width: 90, height: 90,
                      decoration: BoxDecoration(
                        color: AppColors.amber.withOpacity(0.08),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                  SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 14),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              _HeaderBtn(
                                icon: Icons.arrow_back_rounded,
                                onTap: () => Navigator.pop(context),
                              ),
                              const SizedBox(width: 12),
                              Text('Change password',
                                  style: GoogleFonts.poppins(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white,
                                  )),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Row(
                            children: [
                              Container(
                                width: 48, height: 48,
                                decoration: BoxDecoration(
                                  color: AppColors.amber.withOpacity(0.15),
                                  borderRadius: BorderRadius.circular(14),
                                ),
                                child: const Icon(Icons.lock_outline_rounded,
                                    color: AppColors.amber, size: 24),
                              ),
                              const SizedBox(width: 14),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Update your password',
                                      style: GoogleFonts.poppins(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white,
                                      )),
                                  const SizedBox(height: 2),
                                  Text('Keep your account secure',
                                      style: GoogleFonts.poppins(
                                        fontSize: 12,
                                        color: AppColors.greyLight,
                                      )),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // ── Body ─────────────────────────────────────────────────
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    // Info banner
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: AppColors.blueLight,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                            color: AppColors.blue.withOpacity(0.3)),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(Icons.info_outline_rounded,
                              color: AppColors.blue, size: 18),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              'After updating, you\'ll stay signed in on this device but signed out on other sessions.',
                              style: GoogleFonts.poppins(
                                fontSize: 12,
                                color: const Color(0xFF1E40AF),
                                height: 1.5,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Password fields card
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(18),
                        border: Border.all(color: AppColors.border),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.04),
                            blurRadius: 12, offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          // Current password
                          // _PwField(
                          //   label: 'Current password',
                          //   controller: _currentCtrl,
                          //   obscure: !_showCurrent,
                          //   prefixIcon: Icons.lock_open_rounded,
                          //   iconBg: const Color(0xFFF0FDF4),
                          //   iconColor: const Color(0xFF16A34A),
                          //   onToggle: () =>
                          //       setState(() => _showCurrent = !_showCurrent),
                          //   validator: (v) =>
                          //       v!.isEmpty ? 'Enter your current password' : null,
                          // ),
                          // const Divider(
                          //     height: 1, indent: 60, endIndent: 14,
                          //     color: AppColors.border),

                          // New password
                          _PwField(
                            label: 'New password',
                            controller: _newCtrl,
                            obscure: !_showNew,
                            prefixIcon: Icons.lock_outline_rounded,
                            iconBg: AppColors.blueLight,
                            iconColor: AppColors.blue,
                            onToggle: () =>
                                setState(() => _showNew = !_showNew),
                            validator: (v) {
                              if (v!.isEmpty) return 'Enter a new password';
                              if (v.length < 8) return 'Minimum 8 characters';
                              return null;
                            },
                            suffix: _newCtrl.text.isNotEmpty
                                ? Padding(
                                    padding:
                                        const EdgeInsets.only(bottom: 6),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(2),
                                          child: LinearProgressIndicator(
                                            value: _strength,
                                            backgroundColor: AppColors.greyBg,
                                            color: _strengthColor,
                                            minHeight: 3,
                                          ),
                                        ),
                                        const SizedBox(height: 3),
                                        Text(_strengthLabel,
                                            style: GoogleFonts.poppins(
                                              fontSize: 10,
                                              color: _strengthColor,
                                              fontWeight: FontWeight.w600,
                                            )),
                                      ],
                                    ),
                                  )
                                : null,
                          ),
                          const Divider(
                              height: 1, indent: 60, endIndent: 14,
                              color: AppColors.border),

                          // Confirm password
                          _PwField(
                            label: 'Confirm new password',
                            controller: _confirmCtrl,
                            obscure: !_showConfirm,
                            prefixIcon: Icons.lock_outline_rounded,
                            iconBg: AppColors.amberLight,
                            iconColor: AppColors.amberDark,
                            onToggle: () =>
                                setState(() => _showConfirm = !_showConfirm),
                            validator: (v) {
                              if (v!.isEmpty) return 'Confirm your new password';
                              if (v != _newCtrl.text)
                                return 'Passwords do not match';
                              return null;
                            },
                            matchIndicator: _confirmCtrl.text.isNotEmpty
                                ? Row(
                                    children: [
                                      Icon(
                                        _match
                                            ? Icons.check_circle_rounded
                                            : Icons.cancel_rounded,
                                        size: 13,
                                        color: _match
                                            ? AppColors.green
                                            : AppColors.red,
                                      ),
                                      const SizedBox(width: 4),
                                      Text(
                                        _match
                                            ? 'Passwords match'
                                            : 'Passwords do not match',
                                        style: GoogleFonts.poppins(
                                          fontSize: 10,
                                          color: _match
                                              ? AppColors.green
                                              : AppColors.red,
                                        ),
                                      ),
                                    ],
                                  )
                                : null,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Requirements card
                    Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(18),
                        border: Border.all(color: AppColors.border),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.04),
                            blurRadius: 12, offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Password requirements',
                              style: GoogleFonts.poppins(
                                fontSize: 11,
                                fontWeight: FontWeight.w700,
                                color: AppColors.grey,
                                letterSpacing: 0.3,
                              )),
                          const SizedBox(height: 10),
                          _Rule(met: _rule8,
                              label: 'At least 8 characters'),
                          _Rule(met: _ruleUC,
                              label: 'One uppercase letter (A–Z)'),
                          _Rule(met: _ruleNum,
                              label: 'One number (0–9)'),
                          _Rule(met: _ruleSpc,
                              label: 'One special character (!@#\$%)'),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Update button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _isLoading ? null : _submit,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.navy,
                          foregroundColor: Colors.white,
                          elevation: 0,
                          padding:
                              const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14)),
                        ),
                        child: _isLoading
                            ? const SizedBox(
                                width: 20, height: 20,
                                child: CircularProgressIndicator(
                                    color: Colors.white, strokeWidth: 2))
                            : Text('Update password',
                                style: GoogleFonts.poppins(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w700)),
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
}

// ── Password field ─────────────────────────────────────────────────────────

class _PwField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final bool obscure;
  final IconData prefixIcon;
  final Color iconBg;
  final Color iconColor;
  final VoidCallback onToggle;
  final String? Function(String?)? validator;
  final Widget? suffix;
  final Widget? matchIndicator;

  const _PwField({
    required this.label,
    required this.controller,
    required this.obscure,
    required this.prefixIcon,
    required this.iconBg,
    required this.iconColor,
    required this.onToggle,
    this.validator,
    this.suffix,
    this.matchIndicator,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(14, 10, 14, 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Container(
              width: 36, height: 46,
              decoration: BoxDecoration(
                  color: iconBg,
                  borderRadius: BorderRadius.circular(10)),
              child: Icon(prefixIcon, color: iconColor, size: 18),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label,
                    style: GoogleFonts.poppins(
                        fontSize: 14, color: AppColors.greyLight)),
                const SizedBox(height: 2),
                TextFormField(
                  controller: controller,
                  obscureText: obscure,
                  validator: validator,
                  style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: AppColors.dark,
                      fontWeight: FontWeight.w500),
                  decoration: InputDecoration(
                    isDense: true,
                    contentPadding: EdgeInsets.zero,
                    border: InputBorder.none,
                    hintText: '••••••••',
                    hintStyle: GoogleFonts.poppins(
                        color: AppColors.greyLight, fontSize: 14),
                    suffixIcon: GestureDetector(
                      onTap: onToggle,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 2),
                        child: Icon(
                          obscure
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined,
                          size: 18,
                          color: AppColors.greyLight,
                        ),
                      ),
                    ),
                    suffixIconConstraints:
                        const BoxConstraints(minWidth: 24, minHeight: 0),
                  ),
                ),
                if (suffix != null) ...[
                  const SizedBox(height: 4),
                  suffix!,
                ],
                if (matchIndicator != null) ...[
                  const SizedBox(height: 3),
                  matchIndicator!,
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ── Requirement rule row ───────────────────────────────────────────────────

class _Rule extends StatelessWidget {
  final bool met;
  final String label;
  const _Rule({required this.met, required this.label});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        children: [
          Icon(
            met ? Icons.check_circle_rounded : Icons.radio_button_unchecked_rounded,
            size: 15,
            color: met ? AppColors.green : AppColors.greyLight,
          ),
          const SizedBox(width: 8),
          Text(label,
              style: GoogleFonts.poppins(
                fontSize: 12,
                color: met ? AppColors.dark : AppColors.greyLight,
                fontWeight: met ? FontWeight.w500 : FontWeight.w400,
              )),
        ],
      ),
    );
  }
}

// ── Header back button ─────────────────────────────────────────────────────

class _HeaderBtn extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  const _HeaderBtn({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        padding: const EdgeInsets.all(7),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.08),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.white.withOpacity(0.12)),
        ),
        child: Icon(icon, color: Colors.white, size: 18),
      ),
    );
  }
}