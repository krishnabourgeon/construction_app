import 'package:construction_app/models/edit_profile_body.dart' as editBody;
import 'package:construction_app/provider/company_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:construction_app/models/profile_model.dart';
import 'package:construction_app/widgets/app_theme.dart';
import 'package:provider/provider.dart';

class EditCompanyProfileScreen extends StatefulWidget {
  final ProfileData profileData;
  final VoidCallback? onSaved;

  const EditCompanyProfileScreen({
    super.key,
     required this.profileData,
    this.onSaved,
  });

  @override
  State<EditCompanyProfileScreen> createState() =>
      _EditCompanyProfileScreenState();
}

class _EditCompanyProfileScreenState extends State<EditCompanyProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _isSaving = false;

  late final TextEditingController _nameCtrl;
  late final TextEditingController _companyNameCtrl;
  late final TextEditingController _emailCtrl;
  late final TextEditingController _phoneCtrl;
  late final TextEditingController _companyTypeCtrl;
  late final TextEditingController _regNumberCtrl;
  late final TextEditingController _gstCtrl;
  late final TextEditingController _addressCtrl;
  late final TextEditingController _cityCtrl;
  late final TextEditingController _stateCtrl;
  late final TextEditingController _pincodeCtrl;

  @override
  void initState() {
    super.initState();
    final p = widget.profileData;
    _nameCtrl        = TextEditingController(text: p.name);
    _companyNameCtrl = TextEditingController(text: p.company.name);
    _emailCtrl       = TextEditingController(text: p.company.email);
    _phoneCtrl       = TextEditingController(text: p.company.phone);
    _companyTypeCtrl = TextEditingController(text: p.company.companyType);
    _regNumberCtrl   = TextEditingController(text: p.company.registrationNumber);
    _gstCtrl         = TextEditingController(text: p.company.gstNumber);
    _addressCtrl     = TextEditingController(text: p.company.address);
    _cityCtrl        = TextEditingController(text: p.company.city);
    _stateCtrl       = TextEditingController(text: p.company.state);
    _pincodeCtrl     = TextEditingController(text: p.company.pincode);
  }

  @override
  void dispose() {
    for (final c in [
      _nameCtrl, _companyNameCtrl, _emailCtrl, _phoneCtrl,
      _companyTypeCtrl, _regNumberCtrl, _gstCtrl, _addressCtrl,
      _cityCtrl, _stateCtrl, _pincodeCtrl,
    ]) {
      c.dispose();
    }
    super.dispose();
  }

  // ── Build API request body ─────────────────────────────────────────────
  editBody.EditProfileBody _buildBody() => editBody.EditProfileBody(
        name: _nameCtrl.text.trim(),
        company: editBody.Company(
          name:               _companyNameCtrl.text.trim(),
          email:              _emailCtrl.text.trim(),
          phone:              _phoneCtrl.text.trim(),
          companyType:        _companyTypeCtrl.text.trim(),
          registrationNumber: _regNumberCtrl.text.trim(),
          gstNumber:          _gstCtrl.text.trim(),
          address:            _addressCtrl.text.trim(),
          city:               _cityCtrl.text.trim(),
          state:              _stateCtrl.text.trim(),
          pincode:            _pincodeCtrl.text.trim(),
        ),
      );

  // ── Save handler ───────────────────────────────────────────────────────
  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isSaving = true);
    try {
      final body = _buildBody();
      await context.read<CompanyProvider>().editProfile(body: body);
      await Future.delayed(const Duration(seconds: 1)); // stub
      if (!mounted) return;
      widget.onSaved?.call();
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Profile updated successfully',
              style: GoogleFonts.poppins(fontSize: 13)),
          backgroundColor: AppColors.green,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10)),
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
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10)),
        ),
      );
    } finally {
      if (mounted) setState(() => _isSaving = false);
    }
  }

  // ── Derive initials from company name for avatar ───────────────────────
  String get _initials {
    final words = _companyNameCtrl.text.trim().split(' ');
    return words
        .where((w) => w.isNotEmpty)
        .take(2)
        .map((w) => w[0])
        .join()
        .toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FC),
      body: Form(
        key: _formKey,
        child: CustomScrollView(
          slivers: [
            // ── App Bar ──────────────────────────────────────────────
            SliverAppBar(
              expandedHeight: 190,
              pinned: true,
              backgroundColor: AppColors.navy,
              automaticallyImplyLeading: false,
              flexibleSpace: FlexibleSpaceBar(
                background: Stack(
                  children: [
                    Positioned(
                      top: -20, right: -20,
                      child: Container(
                        width: 100, height: 100,
                        decoration: BoxDecoration(
                          color: AppColors.amber.withOpacity(0.09),
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
                            // Top row
                            Row(
                              children: [
                                _HeaderBtn(
                                  icon: Icons.close_rounded,
                                  onTap: () => Navigator.pop(context),
                                ),
                                const SizedBox(width: 12),
                                Text('Edit profile',
                                    style: GoogleFonts.poppins(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white,
                                    )),
                                const Spacer(),
                                _isSaving
                                    ? const SizedBox(
                                        width: 20, height: 20,
                                        child: CircularProgressIndicator(
                                            color: AppColors.amber,
                                            strokeWidth: 2))
                                    : GestureDetector(
                                        onTap: _save,
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 14, vertical: 6),
                                          decoration: BoxDecoration(
                                            color: AppColors.amber
                                                .withOpacity(0.15),
                                            borderRadius:
                                                BorderRadius.circular(9),
                                            border: Border.all(
                                                color: AppColors.amber
                                                    .withOpacity(0.35)),
                                          ),
                                          child: Text('Save',
                                              style: GoogleFonts.poppins(
                                                fontSize: 13,
                                                fontWeight: FontWeight.w600,
                                                color: AppColors.amber,
                                              )),
                                        ),
                                      ),
                              ],
                            ),
                            const SizedBox(height: 18),
                            // Avatar + live company name preview
                            Row(
                              children: [
                                Container(
                                  width: 58, height: 58,
                                  decoration: BoxDecoration(
                                    gradient: const LinearGradient(
                                      colors: [
                                        AppColors.amber,
                                        Color(0xFFD97706)
                                      ],
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                    ),
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  child: Center(
                                    child: Text(
                                      _initials.isEmpty ? 'CO' : _initials,
                                      style: GoogleFonts.poppins(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w800,
                                        color: AppColors.navy,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 14),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        _companyNameCtrl.text.isNotEmpty
                                            ? _companyNameCtrl.text
                                            : 'Company name',
                                        style: GoogleFonts.poppins(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      const SizedBox(height: 3),
                                      Text(
                                        _gstCtrl.text.isNotEmpty
                                            ? 'GST · ${_gstCtrl.text}'
                                            : 'GST not added',
                                        style: GoogleFonts.poppins(
                                          fontSize: 11,
                                          color: AppColors.greyLight,
                                        ),
                                      ),
                                    ],
                                  ),
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

            // ── Form Body ────────────────────────────────────────────
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
                child: Column(
                  children: [

                    // ── Personal ──────────────────────────────────────
                    _Section(
                      label: 'Personal',
                      children: [
                        _EditField(
                          label: 'Full name *',
                          hint: 'Your full name',
                          controller: _nameCtrl,
                          icon: Icons.person_outline_rounded,
                          iconBg: AppColors.blueLight,
                          iconColor: AppColors.blue,
                          validator: (v) =>
                              v!.trim().isEmpty ? 'Full name is required' : null,
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),

                    // ── Company Info ──────────────────────────────────
                    _Section(
                      label: 'Company Info',
                      children: [
                        _EditField(
                          label: 'Company name *',
                          hint: 'Registered company name',
                          controller: _companyNameCtrl,
                          icon: Icons.business_rounded,
                          iconBg: AppColors.amberLight,
                          iconColor: AppColors.amberDark,
                          onChanged: (_) => setState(() {}),
                          validator: (v) =>
                              v!.trim().isEmpty ? 'Company name is required' : null,
                        ),
                        _EditField(
                          label: 'Company type *',
                          hint: 'e.g. Residential, Commercial',
                          controller: _companyTypeCtrl,
                          icon: Icons.category_outlined,
                          iconBg: const Color(0xFFF0FDFA),
                          iconColor: const Color(0xFF0D9488),
                          validator: (v) =>
                              v!.trim().isEmpty ? 'Company type is required' : null,
                        ),
                        _EditField(
                          label: 'Registration number',
                          hint: 'Company registration number',
                          controller: _regNumberCtrl,
                          icon: Icons.verified_outlined,
                          iconBg: AppColors.purpleLight,
                          iconColor: const Color(0xFF7C3AED),
                          inputFormatters: [UpperCaseTextFormatter()],
                        ),
                        _EditField(
                          label: 'GST number',
                          hint: 'e.g. 29AABCR1234N1Z2',
                          controller: _gstCtrl,
                          icon: Icons.badge_outlined,
                          iconBg: AppColors.amberLight,
                          iconColor: AppColors.amberDark,
                          inputFormatters: [
                            UpperCaseTextFormatter(),
                            LengthLimitingTextInputFormatter(15),
                          ],
                          onChanged: (_) => setState(() {}),
                          validator: (v) {
                            if (v == null || v.trim().isEmpty) return null;
                            if (v.trim().length != 15) {
                              return 'GST number must be 15 characters';
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),

                    // ── Contact Details ───────────────────────────────
                    _Section(
                      label: 'Contact Details',
                      children: [
                        _EditField(
                          label: 'Business email *',
                          hint: 'company@example.com',
                          controller: _emailCtrl,
                          icon: Icons.mail_outline_rounded,
                          iconBg: AppColors.blueLight,
                          iconColor: AppColors.blue,
                          keyboardType: TextInputType.emailAddress,
                          validator: (v) {
                            if (v!.trim().isEmpty) return 'Email is required';
                            if (!RegExp(r'^[\w.+-]+@[\w-]+\.[a-z]{2,}$')
                                .hasMatch(v.trim())) {
                              return 'Enter a valid email address';
                            }
                            return null;
                          },
                        ),
                        _EditField(
                          label: 'Business phone *',
                          hint: '98470 12345',
                          controller: _phoneCtrl,
                          icon: Icons.phone_outlined,
                          iconBg: const Color(0xFFF0FDFA),
                          iconColor: const Color(0xFF0D9488),
                          keyboardType: TextInputType.phone,
                          prefix: '+91 ',
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            LengthLimitingTextInputFormatter(10),
                          ],
                          validator: (v) {
                            if (v!.trim().isEmpty) return 'Phone is required';
                            if (v.trim().length < 10) {
                              return 'Enter a valid 10-digit number';
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),

                    // ── Address ───────────────────────────────────────
                    _Section(
                      label: 'Address',
                      children: [
                        _EditField(
                          label: 'Street address *',
                          hint: 'Door no., street, area',
                          controller: _addressCtrl,
                          icon: Icons.location_on_outlined,
                          iconBg: const Color(0xFFF0FDF4),
                          iconColor: const Color(0xFF16A34A),
                          maxLines: 2,
                          validator: (v) =>
                              v!.trim().isEmpty ? 'Address is required' : null,
                        ),
                        _EditField(
                          label: 'City / District *',
                          hint: 'e.g. Thiruvananthapuram',
                          controller: _cityCtrl,
                          icon: Icons.location_city_rounded,
                          iconBg: AppColors.amberLight,
                          iconColor: AppColors.amberDark,
                          validator: (v) =>
                              v!.trim().isEmpty ? 'City is required' : null,
                        ),
                        _EditField(
                          label: 'State *',
                          hint: 'e.g. Kerala',
                          controller: _stateCtrl,
                          icon: Icons.map_outlined,
                          iconBg: AppColors.blueLight,
                          iconColor: AppColors.blue,
                          validator: (v) =>
                              v!.trim().isEmpty ? 'State is required' : null,
                        ),
                        _EditField(
                          label: 'PIN code *',
                          hint: '6-digit PIN',
                          controller: _pincodeCtrl,
                          icon: Icons.pin_drop_outlined,
                          iconBg: AppColors.purpleLight,
                          iconColor: const Color(0xFF7C3AED),
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            LengthLimitingTextInputFormatter(6),
                          ],
                          validator: (v) {
                            if (v!.trim().isEmpty) return 'PIN code is required';
                            if (v.trim().length != 6) {
                              return 'Enter a valid 6-digit PIN';
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 28),

                    // ── Save button ───────────────────────────────────
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _isSaving ? null : _save,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.amber,
                          foregroundColor: AppColors.navy,
                          disabledBackgroundColor:
                              AppColors.amber.withOpacity(0.5),
                          elevation: 0,
                          padding:
                              const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14)),
                        ),
                        child: _isSaving
                            ? const SizedBox(
                                width: 20, height: 20,
                                child: CircularProgressIndicator(
                                    color: AppColors.navy, strokeWidth: 2))
                            : Text('Save changes',
                                style: GoogleFonts.poppins(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w700)),
                      ),
                    ),
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

// ══════════════════════════════════════════════════════════════════════════════
// SECTION WRAPPER
// ══════════════════════════════════════════════════════════════════════════════

class _Section extends StatelessWidget {
  final String label;
  final List<Widget> children;
  const _Section({required this.label, required this.children});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 8),
          child: Text(label.toUpperCase(),
              style: GoogleFonts.poppins(
                fontSize: 11,
                fontWeight: FontWeight.w700,
                color: AppColors.greyLight,
                letterSpacing: 1.2,
              )),
        ),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: AppColors.border),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.04),
                blurRadius: 12,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            children: List.generate(children.length, (i) {
              return Column(
                children: [
                  children[i],
                  if (i < children.length - 1)
                    const Divider(
                      height: 1,
                      indent: 62,
                      endIndent: 14,
                      color: AppColors.border,
                    ),
                ],
              );
            }),
          ),
        ),
      ],
    );
  }
}

// ══════════════════════════════════════════════════════════════════════════════
// EDITABLE FIELD ROW
// ══════════════════════════════════════════════════════════════════════════════

class _EditField extends StatelessWidget {
  final String label;
  final String? hint;
  final TextEditingController controller;
  final IconData icon;
  final Color iconBg;
  final Color iconColor;
  final String? prefix;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String?)? validator;
  final ValueChanged<String>? onChanged;
  final int maxLines;

  const _EditField({
    required this.label,
    required this.controller,
    required this.icon,
    required this.iconBg,
    required this.iconColor,
    this.hint,
    this.prefix,
    this.keyboardType,
    this.inputFormatters,
    this.validator,
    this.onChanged,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(14, 11, 14, 11),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 3),
            child: Container(
              width: 36, height: 36,
              decoration: BoxDecoration(
                color: iconBg,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: iconColor, size: 18),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label,
                    style: GoogleFonts.poppins(
                        fontSize: 10.5, color: AppColors.greyLight)),
                const SizedBox(height: 2),
                TextFormField(
                  controller: controller,
                  keyboardType: keyboardType,
                  inputFormatters: inputFormatters,
                  validator: validator,
                  onChanged: onChanged,
                  maxLines: maxLines,
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: AppColors.dark,
                    fontWeight: FontWeight.w500,
                  ),
                  decoration: InputDecoration(
                    isDense: true,
                    contentPadding: EdgeInsets.zero,
                    border: InputBorder.none,
                    hintText: hint,
                    hintStyle: GoogleFonts.poppins(
                        color: AppColors.greyLight, fontSize: 13),
                    prefixText: prefix,
                    prefixStyle: GoogleFonts.poppins(
                      color: AppColors.dark,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                    errorStyle: GoogleFonts.poppins(
                        fontSize: 10.5, color: AppColors.red),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Icon(Icons.edit_outlined,
                size: 14, color: AppColors.amber),
          ),
        ],
      ),
    );
  }
}

// ══════════════════════════════════════════════════════════════════════════════
// HELPERS
// ══════════════════════════════════════════════════════════════════════════════

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

/// Forces text input to uppercase — used for GST & registration number.
class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue old, TextEditingValue newVal) {
    return newVal.copyWith(text: newVal.text.toUpperCase());
  }
}