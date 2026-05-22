import 'dart:async';
import 'package:construction_app/provider/company_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen>
    with SingleTickerProviderStateMixin {
  // ── step controller ──────────────────────────────────────────────────────
  int _step = 0; // 0 = phone, 1 = otp, 2 = new password

  // ── page animation ───────────────────────────────────────────────────────
  late final AnimationController _animCtrl;
  late Animation<double> _fadeAnim;
  late Animation<Offset> _slideAnim;

  // ── phone step ───────────────────────────────────────────────────────────
  final _phoneCtrl = TextEditingController();
  final _phoneFocus = FocusNode();
  bool _phoneSending = false;

  // ── otp step ─────────────────────────────────────────────────────────────
  final List<TextEditingController> _otpCtrl =
      List.generate(6, (_) => TextEditingController());
  final List<FocusNode> _otpFocus = List.generate(6, (_) => FocusNode());
  bool _otpVerifying = false;
  int _resendSeconds = 30;
  Timer? _resendTimer;

  // ── password step ────────────────────────────────────────────────────────
  final _newPassCtrl = TextEditingController();
  final _confirmPassCtrl = TextEditingController();
  bool _showNew = false;
  bool _showConfirm = false;
  bool _saving = false;
  String _resetToken = '';

  @override
  void initState() {
    super.initState();
    _animCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 420),
    );
    _setAnims();
    _animCtrl.forward();
  }

  void _setAnims() {
    _fadeAnim = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _animCtrl, curve: Curves.easeOut),
    );
    _slideAnim =
        Tween<Offset>(begin: const Offset(0.08, 0), end: Offset.zero).animate(
      CurvedAnimation(parent: _animCtrl, curve: Curves.easeOut),
    );
  }

  Future<void> _goTo(int step) async {
    await _animCtrl.reverse();
    setState(() => _step = step);
    _animCtrl.forward();
  }

  // ── actions ───────────────────────────────────────────────────────────────
  Future<void> _sendOtp() async {
    if (_phoneCtrl.text.length < 10) return;
    setState(() => _phoneSending = true);
    final provider = context.read<CompanyProvider>();
    final result = await provider.forgotPasswordSendOtp(
      mobile: _phoneCtrl.text,
      onFailure: (err) {
        _showSnack(err);
      },
    );
    setState(() => _phoneSending = false);
    if (result != null) {
      if (result.status) {
        _showSnack(result.message);
        _startResendTimer();
        _goTo(1);
      } else {
        _showSnack(result.message);
      }
    }
  }

  Future<void> _verifyOtp() async {
    final otp = _otpCtrl.map((c) => c.text).join();
    if (otp.length < 6) return;
    setState(() => _otpVerifying = true);
    final provider = context.read<CompanyProvider>();
    final result = await provider.forgotPasswordVerifyOtp(
      mobile: _phoneCtrl.text,
      otp: otp,
      onFailure: (err) {
        _showSnack(err);
      },
    );
    setState(() => _otpVerifying = false);
    if (result != null) {
      if (result.status) {
        _showSnack(result.message);
        _resetToken = result.resetToken ?? '';
        _goTo(2);
      } else {
        _showSnack(result.message);
      }
    }
  }

  Future<void> _savePassword() async {
    if (_newPassCtrl.text != _confirmPassCtrl.text) {
      _showSnack('Passwords do not match');
      return;
    }
    if (_newPassCtrl.text.length < 8) {
      _showSnack('Password must be at least 8 characters');
      return;
    }
    setState(() => _saving = true);
    final provider = context.read<CompanyProvider>();
    final result = await provider.forgotPasswordReset(
      mobile: _phoneCtrl.text,
      password: _newPassCtrl.text,
      confirmPassword: _confirmPassCtrl.text,
      regToken: _resetToken,
      onFailure: (err) {
        _showSnack(err);
      },
    );
    setState(() => _saving = false);
    if (result != null) {
      if (result.status) {
        _showSnack(result.message);
        if (mounted) Navigator.pop(context);
      } else {
        _showSnack(result.message);
      }
    }
  }

  void _startResendTimer() {
    _resendSeconds = 30;
    _resendTimer?.cancel();
    _resendTimer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (_resendSeconds == 0) {
        t.cancel();
      } else {
        setState(() => _resendSeconds--);
      }
    });
  }

  void _showSnack(String msg) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(msg)));
  }

  @override
  void dispose() {
    _animCtrl.dispose();
    _phoneCtrl.dispose();
    _phoneFocus.dispose();
    for (final c in _otpCtrl) c.dispose();
    for (final f in _otpFocus) f.dispose();
    _newPassCtrl.dispose();
    _confirmPassCtrl.dispose();
    _resendTimer?.cancel();
    super.dispose();
  }

  // ── build ─────────────────────────────────────────────────────────────────
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F0F1A),
      body: Stack(
        children: [
          // ── background mesh ────────────────────────────────────────────
          Positioned(
            top: -80,
            right: -60,
            child: _GlowBlob(
              color: const Color(0xFFF59E0B).withOpacity(0.18),
              size: 280,
            ),
          ),
          Positioned(
            bottom: 60,
            left: -80,
            child: _GlowBlob(
              color: const Color(0xFF6366F1).withOpacity(0.13),
              size: 260,
            ),
          ),

          // ── main content ───────────────────────────────────────────────
          SafeArea(
            child: Column(
              children: [
                // ── top bar ──────────────────────────────────────────────
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  child: Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back_ios_new_rounded,
                            color: Colors.white70, size: 20),
                        onPressed: () {
                          if (_step > 0) {
                            _goTo(_step - 1);
                          } else {
                            Navigator.pop(context);
                          }
                        },
                      ),
                      const Spacer(),
                      _StepDots(current: _step),
                      const Spacer(),
                      const SizedBox(width: 40),
                    ],
                  ),
                ),

                // ── animated page ─────────────────────────────────────────
                Expanded(
                  child: FadeTransition(
                    opacity: _fadeAnim,
                    child: SlideTransition(
                      position: _slideAnim,
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.fromLTRB(28, 16, 28, 32),
                        child: _buildStep(),
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

  Widget _buildStep() {
    switch (_step) {
      case 0:
        return _PhoneStep(
          ctrl: _phoneCtrl,
          focus: _phoneFocus,
          loading: _phoneSending,
          onSend: _sendOtp,
        );
      case 1:
        return _OtpStep(
          phone: _phoneCtrl.text,
          otpCtrl: _otpCtrl,
          otpFocus: _otpFocus,
          verifying: _otpVerifying,
          resendSeconds: _resendSeconds,
          onVerify: _verifyOtp,
          onResend: () {
            _startResendTimer();
            _showSnack('OTP resent!');
          },
        );
      case 2:
        return _NewPasswordStep(
          newCtrl: _newPassCtrl,
          confirmCtrl: _confirmPassCtrl,
          showNew: _showNew,
          showConfirm: _showConfirm,
          saving: _saving,
          onToggleNew: () => setState(() => _showNew = !_showNew),
          onToggleConfirm: () => setState(() => _showConfirm = !_showConfirm),
          onSave: _savePassword,
        );
      default:
        return const SizedBox();
    }
  }
}

// ════════════════════════════════════════════════════════════════════════════
//  STEP 1 — PHONE NUMBER
// ════════════════════════════════════════════════════════════════════════════

class _PhoneStep extends StatelessWidget {
  final TextEditingController ctrl;
  final FocusNode focus;
  final bool loading;
  final VoidCallback onSend;

  const _PhoneStep({
    required this.ctrl,
    required this.focus,
    required this.loading,
    required this.onSend,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 24),
        // ── icon ────────────────────────────────────────────────────────
        Container(
          width: 64,
          height: 64,
          decoration: BoxDecoration(
            color: const Color(0xFFF59E0B).withOpacity(0.12),
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
                color: const Color(0xFFF59E0B).withOpacity(0.3), width: 1),
          ),
          child: const Icon(Icons.phone_iphone_rounded,
              color: Color(0xFFF59E0B), size: 30),
        ),
        const SizedBox(height: 24),

        // ── title ────────────────────────────────────────────────────────
        Text(
          'Forgot\nPassword?',
          style: GoogleFonts.spaceGrotesk(
            fontSize: 36,
            fontWeight: FontWeight.w800,
            color: Colors.white,
            height: 1.1,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          'Enter your registered mobile number.\nWe\'ll send you a one-time password.',
          style: GoogleFonts.inter(
            fontSize: 14,
            color: Colors.white54,
            height: 1.6,
          ),
        ),
        const SizedBox(height: 40),

        // ── phone field ──────────────────────────────────────────────────
        Text(
          'MOBILE NUMBER',
          style: GoogleFonts.inter(
            fontSize: 11,
            fontWeight: FontWeight.w600,
            color: Colors.black,
            letterSpacing: 1.4,
          ),
        ),
        const SizedBox(height: 10),
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFF1C1C2E),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: const Color(0xFF2D2D44), width: 1),
          ),
          child: Row(
            children: [
              // country code
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
                decoration: const BoxDecoration(
                  border: Border(
                    right: BorderSide(color: Color(0xFF2D2D44), width: 1),
                  ),
                ),
                child: Text(
                  '+91',
                  style: GoogleFonts.spaceGrotesk(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Expanded(
                child: TextField(
                  controller: ctrl,
                  focusNode: focus,
                  keyboardType: TextInputType.phone,
                  maxLength: 10,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  style: GoogleFonts.spaceGrotesk(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 2,
                  ),
                  decoration: InputDecoration(
                    counterText: '',
                    hintText: '98765 43210',
                    hintStyle: GoogleFonts.spaceGrotesk(
                      color: Colors.grey[100],
                      fontSize: 15,
                      letterSpacing: 2,
                    ),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 18),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 36),

        // ── send otp button ──────────────────────────────────────────────
        _PrimaryButton(
          label: 'Send OTP',
          loading: loading,
          onTap: onSend,
        ),
      ],
    );
  }
}

// ════════════════════════════════════════════════════════════════════════════
//  STEP 2 — OTP VERIFICATION
// ════════════════════════════════════════════════════════════════════════════

class _OtpStep extends StatelessWidget {
  final String phone;
  final List<TextEditingController> otpCtrl;
  final List<FocusNode> otpFocus;
  final bool verifying;
  final int resendSeconds;
  final VoidCallback onVerify;
  final VoidCallback onResend;

  const _OtpStep({
    required this.phone,
    required this.otpCtrl,
    required this.otpFocus,
    required this.verifying,
    required this.resendSeconds,
    required this.onVerify,
    required this.onResend,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 24),

        // ── icon ─────────────────────────────────────────────────────────
        Container(
          width: 64,
          height: 64,
          decoration: BoxDecoration(
            color: const Color(0xFF6366F1).withOpacity(0.12),
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
                color: const Color(0xFF6366F1).withOpacity(0.3), width: 1),
          ),
          child: const Icon(Icons.sms_rounded,
              color: Color(0xFF6366F1), size: 30),
        ),
        const SizedBox(height: 24),

        Text(
          'Verify OTP',
          style: GoogleFonts.spaceGrotesk(
            fontSize: 36,
            fontWeight: FontWeight.w800,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 12),
        RichText(
          text: TextSpan(
            style: GoogleFonts.inter(
                fontSize: 14, color: Colors.white54, height: 1.6),
            children: [
              const TextSpan(text: 'We sent a 6-digit code to\n'),
              TextSpan(
                text: '+91 $phone',
                style: const TextStyle(
                    color: Color(0xFFF59E0B), fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
        const SizedBox(height: 44),

        // ── OTP boxes ────────────────────────────────────────────────────
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(
            6,
            (i) => Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                child: _OtpBox(
                  ctrl: otpCtrl[i],
                  focus: otpFocus[i],
                  onChanged: (val) {
                    if (val.isNotEmpty && i < 5) {
                      otpFocus[i + 1].requestFocus();
                    } else if (val.isEmpty && i > 0) {
                      otpFocus[i - 1].requestFocus();
                    }
                  },
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 32),

        // ── resend ───────────────────────────────────────────────────────
        Center(
          child: resendSeconds > 0
              ? Text(
                  'Resend OTP in ${resendSeconds}s',
                  style: GoogleFonts.inter(
                      fontSize: 13, color: Colors.white38),
                )
              : GestureDetector(
                  onTap: onResend,
                  child: Text(
                    'Resend OTP',
                    style: GoogleFonts.inter(
                      fontSize: 13,
                      color: const Color(0xFFF59E0B),
                      fontWeight: FontWeight.w600,
                      decoration: TextDecoration.underline,
                      decorationColor: const Color(0xFFF59E0B),
                    ),
                  ),
                ),
        ),
        const SizedBox(height: 40),

        // ── verify button ─────────────────────────────────────────────────
        _PrimaryButton(
          label: 'Verify OTP',
          loading: verifying,
          color: const Color(0xFF6366F1),
          onTap: onVerify,
        ),
      ],
    );
  }
}

// ── single OTP input box ──────────────────────────────────────────────────
class _OtpBox extends StatefulWidget {
  final TextEditingController ctrl;
  final FocusNode focus;
  final ValueChanged<String> onChanged;

  const _OtpBox(
      {required this.ctrl,
      required this.focus,
      required this.onChanged});

  @override
  State<_OtpBox> createState() => _OtpBoxState();
}

class _OtpBoxState extends State<_OtpBox> {
  bool _focused = false;

  @override
  void initState() {
    super.initState();
    widget.focus.addListener(() {
      setState(() => _focused = widget.focus.hasFocus);
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      height: 60,
      decoration: BoxDecoration(
        color: const Color(0xFF1C1C2E),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: _focused
              ? const Color(0xFF6366F1)
              : widget.ctrl.text.isNotEmpty
                  ? const Color(0xFFF59E0B).withOpacity(0.5)
                  : const Color(0xFF2D2D44),
          width: _focused ? 2 : 1,
        ),
        boxShadow: _focused
            ? [
                BoxShadow(
                  color: const Color(0xFF6366F1).withOpacity(0.25),
                  blurRadius: 12,
                  spreadRadius: 1,
                )
              ]
            : [],
      ),
      child: Center(
        child: TextField(
          controller: widget.ctrl,
          focusNode: widget.focus,
          textAlign: TextAlign.center,
          textAlignVertical: TextAlignVertical.center,
          keyboardType: TextInputType.number,
          maxLength: 1,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          style: GoogleFonts.spaceGrotesk(
            fontSize: 24,
            fontWeight: FontWeight.w700,
            color: Colors.black,
          ),
          decoration: const InputDecoration(
            counterText: '',
            border: InputBorder.none,
            contentPadding: EdgeInsets.zero,
          ),
          onChanged: (val) {
            setState(() {});
            widget.onChanged(val);
          },
        ),
      ),
    );
  }
}

// ════════════════════════════════════════════════════════════════════════════
//  STEP 3 — NEW PASSWORD
// ════════════════════════════════════════════════════════════════════════════

class _NewPasswordStep extends StatelessWidget {
  final TextEditingController newCtrl;
  final TextEditingController confirmCtrl;
  final bool showNew;
  final bool showConfirm;
  final bool saving;
  final VoidCallback onToggleNew;
  final VoidCallback onToggleConfirm;
  final VoidCallback onSave;

  const _NewPasswordStep({
    required this.newCtrl,
    required this.confirmCtrl,
    required this.showNew,
    required this.showConfirm,
    required this.saving,
    required this.onToggleNew,
    required this.onToggleConfirm,
    required this.onSave,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 24),

        // ── icon ─────────────────────────────────────────────────────────
        Container(
          width: 64,
          height: 64,
          decoration: BoxDecoration(
            color: const Color(0xFF10B981).withOpacity(0.12),
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
                color: const Color(0xFF10B981).withOpacity(0.3), width: 1),
          ),
          child: const Icon(Icons.lock_reset_rounded,
              color: Color(0xFF10B981), size: 30),
        ),
        const SizedBox(height: 24),

        Text(
          'New Password',
          style: GoogleFonts.spaceGrotesk(
            fontSize: 36,
            fontWeight: FontWeight.w800,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          'Create a strong password you haven\'t\nused before.',
          style: GoogleFonts.inter(
            fontSize: 14,
            color: Colors.white54,
            height: 1.6,
          ),
        ),
        const SizedBox(height: 40),

        // ── new password ─────────────────────────────────────────────────
        _PasswordField(
          label: 'NEW PASSWORD',
          ctrl: newCtrl,
          show: showNew,
          onToggle: onToggleNew,
        ),
        const SizedBox(height: 16),

        // ── confirm password ──────────────────────────────────────────────
        _PasswordField(
          label: 'CONFIRM PASSWORD',
          ctrl: confirmCtrl,
          show: showConfirm,
          onToggle: onToggleConfirm,
        ),
        const SizedBox(height: 12),

        // ── password hint ─────────────────────────────────────────────────
        Row(
          children: [
            const Icon(Icons.info_outline_rounded,
                color: Colors.white24, size: 14),
            const SizedBox(width: 6),
            Text(
              'Minimum 8 characters',
              style: GoogleFonts.inter(fontSize: 12, color: Colors.white30),
            ),
          ],
        ),
        const SizedBox(height: 40),

        // ── save button ───────────────────────────────────────────────────
        _PrimaryButton(
          label: 'Update Password',
          loading: saving,
          color: const Color(0xFF10B981),
          onTap: onSave,
        ),
      ],
    );
  }
}

// ── password text field ───────────────────────────────────────────────────
class _PasswordField extends StatelessWidget {
  final String label;
  final TextEditingController ctrl;
  final bool show;
  final VoidCallback onToggle;

  const _PasswordField({
    required this.label,
    required this.ctrl,
    required this.show,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 11,
            fontWeight: FontWeight.w600,
            color: Colors.white38,
            letterSpacing: 1.4,
          ),
        ),
        const SizedBox(height: 10),
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFF1C1C2E),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: const Color(0xFF2D2D44), width: 1),
          ),
          child: TextField(
            controller: ctrl,
            obscureText: !show,
            style: GoogleFonts.spaceGrotesk(
              color: Colors.black,
              fontSize: 15,
              letterSpacing: show ? 0 : 3,
            ),
            decoration: InputDecoration(
              hintText: '••••••••',
              hintStyle: GoogleFonts.spaceGrotesk(
                color: Colors.white24,
                letterSpacing: 3,
                fontSize: 15,
              ),
              border: InputBorder.none,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
              suffixIcon: IconButton(
                onPressed: onToggle,
                icon: Icon(
                  show
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined,
                  color: Colors.black,
                  size: 20,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// ════════════════════════════════════════════════════════════════════════════
//  SHARED WIDGETS
// ════════════════════════════════════════════════════════════════════════════

// ── amber primary button ──────────────────────────────────────────────────
class _PrimaryButton extends StatelessWidget {
  final String label;
  final bool loading;
  final VoidCallback onTap;
  final Color color;

  const _PrimaryButton({
    required this.label,
    required this.loading,
    required this.onTap,
    this.color = const Color(0xFFF59E0B),
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: loading ? null : onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        width: double.infinity,
        height: 56,
        decoration: BoxDecoration(
          color: loading ? color.withOpacity(0.5) : color,
          borderRadius: BorderRadius.circular(14),
          boxShadow: loading
              ? []
              : [
                  BoxShadow(
                    color: color.withOpacity(0.35),
                    blurRadius: 20,
                    offset: const Offset(0, 6),
                  ),
                ],
        ),
        child: Center(
          child: loading
              ? const SizedBox(
                  width: 22,
                  height: 22,
                  child: CircularProgressIndicator(
                    strokeWidth: 2.5,
                    color: Colors.white,
                  ),
                )
              : Text(
                  label,
                  style: GoogleFonts.spaceGrotesk(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                    letterSpacing: 0.5,
                  ),
                ),
        ),
      ),
    );
  }
}

// ── step indicator dots ───────────────────────────────────────────────────
class _StepDots extends StatelessWidget {
  final int current;
  const _StepDots({required this.current});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(3, (i) {
        final active = i == current;
        final done = i < current;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: const EdgeInsets.symmetric(horizontal: 4),
          width: active ? 24 : 8,
          height: 8,
          decoration: BoxDecoration(
            color: done
                ? const Color(0xFFF59E0B)
                : active
                    ? const Color(0xFFF59E0B)
                    : Colors.white12,
            borderRadius: BorderRadius.circular(4),
          ),
        );
      }),
    );
  }
}

// ── decorative glow blob ──────────────────────────────────────────────────
class _GlowBlob extends StatelessWidget {
  final Color color;
  final double size;
  const _GlowBlob({required this.color, required this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(
          colors: [color, color.withOpacity(0)],
        ),
      ),
    );
  }
}