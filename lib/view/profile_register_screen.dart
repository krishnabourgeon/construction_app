import 'dart:io';
import 'package:construction_app/models/profile_register_body.dart';
import 'package:construction_app/provider/company_provider.dart';
import 'package:construction_app/view/login_screen.dart';
import 'package:construction_app/widgets/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class ProfileRegisterScreen extends StatefulWidget {
  final VoidCallback? onSuccess;
  const ProfileRegisterScreen({super.key, this.onSuccess});

  @override
  State<ProfileRegisterScreen> createState() => _ProfileRegisterScreenState();
}

class _ProfileRegisterScreenState extends State<ProfileRegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final PageController _pageCtrl = PageController();

  // Page 1 – Contact & Address
  final _emailCtrl   = TextEditingController();
  final _phoneCtrl   = TextEditingController();
  final _addressCtrl = TextEditingController();
  final _cityCtrl    = TextEditingController();
  final _stateCtrl   = TextEditingController();
  final _pincodeCtrl = TextEditingController();

  // Page 2 – Company Info
  final _companyNameCtrl = TextEditingController();
  final _regNumberCtrl   = TextEditingController();
  final _gstCtrl         = TextEditingController();
  final _adminNameCtrl   = TextEditingController();
  final _adminEmailCtrl  = TextEditingController();
  final _pwCtrl          = TextEditingController();
  final _confirmPwCtrl   = TextEditingController();
  String? _selectedType;
  bool _showPw        = false;
  bool _showConfirmPw = false;
  bool _agreed        = false;

  int _currentPage = 0;
  bool _saving = false;

  File? _logoImage;
  final ImagePicker _picker = ImagePicker();

  static const List<String> _companyTypes = [
    'Private Limited',
    'Public Limited',
    'Sole Proprietorship',
    'Partnership',
    'LLP',
    'Other',
  ];

  @override
  void dispose() {
    _pageCtrl.dispose();
    _companyNameCtrl.dispose(); _regNumberCtrl.dispose();
    _gstCtrl.dispose(); _emailCtrl.dispose();
    _phoneCtrl.dispose(); _addressCtrl.dispose();
    _cityCtrl.dispose(); _stateCtrl.dispose(); _pincodeCtrl.dispose();
    _adminNameCtrl.dispose(); _adminEmailCtrl.dispose();
    _pwCtrl.dispose(); _confirmPwCtrl.dispose();
    super.dispose();
  }

  // ── Navigation ──────────────────────────────────────────────────────────────

  void _nextPage() {
    if (_currentPage < 1) {
      if (!_formKey.currentState!.validate()) return;
      _pageCtrl.nextPage(
          duration: const Duration(milliseconds: 350), curve: Curves.easeInOut);
      setState(() => _currentPage++);
    } else {
      _submit();
    }
  }

  void _prevPage() {
    if (_currentPage > 0) {
      _pageCtrl.previousPage(
          duration: const Duration(milliseconds: 350), curve: Curves.easeInOut);
      setState(() => _currentPage--);
    }
  }

  void _submit() async {
    if (!_formKey.currentState!.validate()) return;
    if (!_agreed) {
      _showSnack('Please accept the Terms & Conditions', AppColors.orange);
      return;
    }
    setState(() => _saving = true);

    final registerCompanyBody = ProfileRegisterBody(
      //companyEma: _companyNameCtrl.text.trim(),
      companyType: _selectedType ?? '',
      registrationNumber: _regNumberCtrl.text.trim(),
      gstNumber: _gstCtrl.text.trim(),
      companyEmail: _emailCtrl.text.trim(),
      //phoneNumber: _phoneCtrl.text.trim(),
      streetAddress: _addressCtrl.text.trim(),
      city: _cityCtrl.text.trim(),
      state: _stateCtrl.text.trim(),
      pincode: _pincodeCtrl.text.trim(),
      // adminName: _adminNameCtrl.text.trim(),
      // adminEmail: _adminEmailCtrl.text.trim(),
      // password: _pwCtrl.text.trim(),
      // passwordConfirmation: _confirmPwCtrl.text.trim(),
    );

    final companyProvider = Provider.of<CompanyProvider>(context, listen: false);
    await companyProvider.registerProfile(
      profileRegisterBody: registerCompanyBody,
      logoFile: _logoImage,
      onFailure: (errorMessage) {
        setState(() => _saving = false);
        _showSnack(errorMessage, AppColors.orange);
      },
    );

    setState(() => _saving = false);
    if (!mounted) return;

    // ── Coming from ProfileScreen → pop back ─────────────────────────────────
    if (widget.onSuccess != null) {
      widget.onSuccess!();
      Navigator.pop(context);
      return;
    }

    // ── Coming from Login flow → show Go to Login dialog ─────────────────────
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        backgroundColor: AppColors.white,
        child: Padding(
          padding: const EdgeInsets.all(28),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 72, height: 72,
                decoration: BoxDecoration(
                  color: AppColors.green.withOpacity(0.12),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Container(
                    width: 52, height: 52,
                    decoration: const BoxDecoration(
                      color: AppColors.green, shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.check_rounded,
                        color: AppColors.white, size: 28),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Text('Registration Successful!',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                      fontSize: 18, fontWeight: FontWeight.w700,
                      color: AppColors.dark)),
              const SizedBox(height: 8),
              Text(
                '${_companyNameCtrl.text.trim()} has been registered.\nPlease login to continue.',
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(fontSize: 13, color: AppColors.grey),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity, height: 48,
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (_) => const LoginScreen()),
                      (route) => false,
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFF1A1A2E), Color(0xFF16213E)],
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: Text('Go to Login',
                          style: GoogleFonts.poppins(
                              fontSize: 14, fontWeight: FontWeight.w700,
                              color: AppColors.white)),
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

  void _showSnack(String msg, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(msg, style: GoogleFonts.poppins(fontSize: 13)),
      backgroundColor: color,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    ));
  }

  Future<void> _pickLogoImage() async {
    final XFile? pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );
    if (pickedFile != null) {
      setState(() => _logoImage = File(pickedFile.path));
    }
  }

  // ── Build ───────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.greyBg,
      body: Column(
        children: [
          _buildHeader(),
          _buildStepper(),
          Expanded(
            child: Form(
              key: _formKey,
              child: PageView(
                controller: _pageCtrl,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  _buildPage1(),
                  _buildPage2(),
                ],
              ),
            ),
          ),
          _buildBottomBar(),
        ],
      ),
    );
  }

  // ── Header ──────────────────────────────────────────────────────────────────

  Widget _buildHeader() {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF1A1A2E), Color(0xFF16213E)],
        ),
      ),
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top + 14,
        bottom: 22, left: 20, right: 20,
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              width: 38, height: 38,
              decoration: BoxDecoration(
                  color: Colors.white10,
                  borderRadius: BorderRadius.circular(10)),
              child: const Icon(Icons.arrow_back_ios_new,
                  size: 16, color: AppColors.white),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Company Registration',
                    style: GoogleFonts.poppins(
                      fontSize: 18, fontWeight: FontWeight.w700,
                      color: AppColors.white,
                    )),
                Text('Fill in your company details',
                    style: GoogleFonts.poppins(
                        fontSize: 12, color: AppColors.greyLight)),
              ],
            ),
          ),
          Container(
            width: 44, height: 44,
            decoration: BoxDecoration(
              color: AppColors.amber,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.business_rounded,
                color: AppColors.dark, size: 24),
          ),
        ],
      ),
    );
  }

  // ── Stepper ─────────────────────────────────────────────────────────────────

  Widget _buildStepper() {
    final steps = ['Contact', 'Company'];
    return Container(
      color: AppColors.white,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
      child: Row(
        children: List.generate(steps.length, (i) {
          final done   = i < _currentPage;
          final active = i == _currentPage;
          return Expanded(
            child: Row(
              children: [
                Container(
                  width: 32, height: 32,
                  decoration: BoxDecoration(
                    color: done
                        ? AppColors.green
                        : active
                            ? AppColors.amber
                            : const Color(0xFFF3F4F6),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: done
                        ? const Icon(Icons.check, size: 16, color: AppColors.white)
                        : Text('${i + 1}',
                            style: GoogleFonts.poppins(
                              fontSize: 13, fontWeight: FontWeight.w700,
                              color: active ? AppColors.dark : AppColors.grey,
                            )),
                  ),
                ),
                const SizedBox(width: 6),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(steps[i],
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            fontWeight: active ? FontWeight.w600 : FontWeight.w400,
                            color: active ? AppColors.dark : AppColors.grey,
                          )),
                      if (i < steps.length - 1)
                        Container(
                          height: 2,
                          margin: const EdgeInsets.only(top: 4, right: 8),
                          decoration: BoxDecoration(
                            color: done ? AppColors.green : const Color(0xFFE5E7EB),
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }

  // ── Page 1 – Contact & Address ───────────────────────────────────────────────

  Widget _buildPage1() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // _sectionLabel('Contact Details'),
          // _card(children: [
          //   _field(
          //     ctrl: _emailCtrl,
          //     label: 'Company Email *',
          //     hint: 'company@example.com',
          //     icon: Icons.email_outlined,
          //     keyboardType: TextInputType.emailAddress,
          //   ),
          //   _field(
          //     ctrl: _phoneCtrl,
          //     label: 'Phone Number *',
          //     hint: '+91 00000 00000',
          //     icon: Icons.phone_outlined,
          //     keyboardType: TextInputType.phone,
          //     isLast: true,
          //   ),
          // ]),
          const SizedBox(height: 14),
          _sectionLabel('Registered Address'),
          _card(children: [
            _field(
              ctrl: _addressCtrl,
              label: 'Street Address',
              hint: 'Building, Street, Area',
              icon: Icons.location_on_outlined,
              maxLines: 2,
            ),
            Row(
              children: [
                Expanded(
                  child: _field(
                    ctrl: _cityCtrl,
                    label: 'City',
                    hint: 'e.g. Kochi',
                    icon: Icons.location_city_outlined,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _field(
                    ctrl: _stateCtrl,
                    label: 'State',
                    hint: 'e.g. Kerala',
                    icon: Icons.map_outlined,
                  ),
                ),
              ],
            ),
            _field(
              ctrl: _pincodeCtrl,
              label: 'Pincode',
              hint: '6 digit pincode',
              icon: Icons.pin_drop_outlined,
              keyboardType: TextInputType.number,
              isLast: true,
            ),
          ]),
        ],
      ),
    );
  }

  // ── Page 2 – Company Info ────────────────────────────────────────────────────

  Widget _buildPage2() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionLabel('Company Information'),
          _card(children: [
            _field(
              ctrl: _emailCtrl,
              label: 'Company Email',
              hint: 'e.g. company@example.com',
              icon: Icons.email_outlined,
            ),
            _dropdownField(
              label: 'Company Type',
              hint: 'Select company type',
              icon: Icons.category_outlined,
              value: _selectedType,
              items: _companyTypes,
              onChanged: (v) => setState(() => _selectedType = v),
            ),
            _field(
              ctrl: _regNumberCtrl,
              label: 'Registration Number',
              hint: 'e.g. CIN / LLPIN',
              icon: Icons.numbers_outlined,
            ),
            _field(
              ctrl: _gstCtrl,
              label: 'GST Number',
              hint: 'e.g. 27AAPFU0939F1ZV',
              icon: Icons.receipt_long_outlined,
              isLast: true,
            ),
          ]),
          const SizedBox(height: 14),
          _sectionLabel('Company Logo'),
          _logoUploadCard(),
          const SizedBox(height: 14),
          // Terms
          GestureDetector(
            onTap: () => setState(() => _agreed = !_agreed),
            child: Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color: _agreed ? AppColors.amber : AppColors.border,
                  width: _agreed ? 1.5 : 1,
                ),
              ),
              child: Row(
                children: [
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    width: 22, height: 22,
                    decoration: BoxDecoration(
                      color: _agreed ? AppColors.amber : AppColors.greyBg,
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(
                          color: _agreed ? AppColors.amber : AppColors.grey),
                    ),
                    child: _agreed
                        ? const Icon(Icons.check, size: 14, color: AppColors.dark)
                        : null,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: RichText(
                      text: TextSpan(
                        style: GoogleFonts.poppins(
                            fontSize: 12, color: AppColors.grey),
                        children: [
                          const TextSpan(text: 'I agree to the '),
                          TextSpan(
                            text: 'Terms & Conditions',
                            style: GoogleFonts.poppins(
                              fontSize: 12, fontWeight: FontWeight.w600,
                              color: AppColors.amber,
                            ),
                          ),
                          const TextSpan(text: ' and '),
                          TextSpan(
                            text: 'Privacy Policy',
                            style: GoogleFonts.poppins(
                              fontSize: 12, fontWeight: FontWeight.w600,
                              color: AppColors.amber,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  // ── Bottom Bar ───────────────────────────────────────────────────────────────

  Widget _buildBottomBar() {
    final isLast = _currentPage == 1;
    return Container(
      color: AppColors.white,
      padding: EdgeInsets.only(
        left: 16, right: 16, top: 12,
        bottom: MediaQuery.of(context).padding.bottom + 12,
      ),
      child: Row(
        children: [
          if (_currentPage > 0)
            GestureDetector(
              onTap: _prevPage,
              child: Container(
                height: 50, width: 50,
                decoration: BoxDecoration(
                  color: AppColors.greyBg,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: AppColors.border),
                ),
                child: const Icon(Icons.arrow_back_ios_new,
                    size: 16, color: AppColors.dark),
              ),
            ),
          if (_currentPage > 0) const SizedBox(width: 12),
          Expanded(
            child: GestureDetector(
              onTap: _saving ? null : _nextPage,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                height: 50,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFFF59E0B), Color(0xFFD97706)],
                  ),
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.amber.withOpacity(0.35),
                      blurRadius: 10, offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Center(
                  child: _saving
                      ? const SizedBox(
                          width: 22, height: 22,
                          child: CircularProgressIndicator(
                              strokeWidth: 2.5, color: AppColors.dark),
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              isLast ? 'Submit Registration' : 'Continue',
                              style: GoogleFonts.poppins(
                                fontSize: 15, fontWeight: FontWeight.w700,
                                color: AppColors.dark,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Icon(
                              isLast
                                  ? Icons.check_circle_outline
                                  : Icons.arrow_forward_rounded,
                              size: 20, color: AppColors.dark,
                            ),
                          ],
                        ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ── Logo Upload Card ─────────────────────────────────────────────────────────

  Widget _logoUploadCard() {
    return GestureDetector(
      onTap: _pickLogoImage,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: _logoImage != null ? AppColors.green : AppColors.amber,
            width: 1.5,
          ),
        ),
        child: _logoImage != null
            ? Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.file(_logoImage!,
                        width: 56, height: 56, fit: BoxFit.cover),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 3),
                          decoration: BoxDecoration(
                            color: AppColors.green.withOpacity(0.12),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(Icons.check_circle_rounded,
                                  size: 13, color: AppColors.green),
                              const SizedBox(width: 4),
                              Text('Logo Uploaded',
                                  style: GoogleFonts.poppins(
                                      fontSize: 11, fontWeight: FontWeight.w600,
                                      color: AppColors.green)),
                            ],
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          _logoImage!.path.split('/').last,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.poppins(
                              fontSize: 12, fontWeight: FontWeight.w500,
                              color: AppColors.dark),
                        ),
                        const SizedBox(height: 2),
                        Text('Tap to change',
                            style: GoogleFonts.poppins(
                                fontSize: 11, color: AppColors.grey)),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () => setState(() => _logoImage = null),
                    child: Container(
                      width: 32, height: 32,
                      decoration: BoxDecoration(
                        color: AppColors.red.withOpacity(0.08),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(Icons.close_rounded,
                          size: 16, color: AppColors.red),
                    ),
                  ),
                ],
              )
            : Column(
                children: [
                  Container(
                    width: 56, height: 56,
                    decoration: BoxDecoration(
                      color: AppColors.amberLight,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const Icon(Icons.cloud_upload_outlined,
                        color: AppColors.amberDark, size: 28),
                  ),
                  const SizedBox(height: 10),
                  Text('Tap to upload logo',
                      style: GoogleFonts.poppins(
                          fontSize: 13, fontWeight: FontWeight.w600,
                          color: AppColors.dark)),
                  const SizedBox(height: 4),
                  Text('PNG, JPG up to 5MB',
                      style: GoogleFonts.poppins(
                          fontSize: 11, color: AppColors.grey)),
                ],
              ),
      ),
    );
  }

  // ── Field Helpers ────────────────────────────────────────────────────────────

  Widget _sectionLabel(String text) => Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Text(text,
            style: GoogleFonts.poppins(
              fontSize: 13, fontWeight: FontWeight.w700,
              color: AppColors.dark,
            )),
      );

  Widget _card({required List<Widget> children}) => Container(
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.border),
        ),
        padding: const EdgeInsets.fromLTRB(16, 6, 16, 6),
        child: Column(children: children),
      );

  Widget _field({
    required TextEditingController ctrl,
    required String label,
    required String hint,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
    int maxLines = 1,
    bool isLast = false,
  }) {
    return Padding(
      padding: EdgeInsets.only(bottom: isLast ? 6 : 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 12),
          Text(label,
              style: GoogleFonts.poppins(
                fontSize: 12, fontWeight: FontWeight.w600,
                color: AppColors.dark,
              )),
          const SizedBox(height: 6),
          TextFormField(
            controller: ctrl,
            keyboardType: keyboardType,
            maxLines: maxLines,
            validator: validator,
            style: GoogleFonts.poppins(fontSize: 13, color: AppColors.dark),
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: GoogleFonts.poppins(
                  fontSize: 13, color: AppColors.greyLight),
              prefixIcon: Icon(icon, size: 18, color: AppColors.grey),
              filled: true,
              fillColor: AppColors.greyBg,
              contentPadding: const EdgeInsets.symmetric(
                  vertical: 12, horizontal: 12),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: AppColors.border)),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: AppColors.border)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(
                      color: AppColors.amber, width: 1.8)),
              errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: AppColors.red)),
              focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(
                      color: AppColors.red, width: 1.8)),
            ),
          ),
          const SizedBox(height: 4),
        ],
      ),
    );
  }

  Widget _dropdownField({
    required String label,
    required String hint,
    required IconData icon,
    required String? value,
    required List<String> items,
    required void Function(String?) onChanged,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 12),
        Text(label,
            style: GoogleFonts.poppins(
              fontSize: 12, fontWeight: FontWeight.w600,
              color: AppColors.dark,
            )),
        const SizedBox(height: 6),
        DropdownButtonFormField<String>(
          value: value,
          onChanged: onChanged,
          validator: validator,
          style: GoogleFonts.poppins(fontSize: 13, color: AppColors.dark),
          icon: const Icon(Icons.keyboard_arrow_down_rounded,
              color: AppColors.grey),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: GoogleFonts.poppins(
                fontSize: 13, color: AppColors.greyLight),
            prefixIcon: Icon(icon, size: 18, color: AppColors.grey),
            filled: true,
            fillColor: AppColors.greyBg,
            contentPadding: const EdgeInsets.symmetric(
                vertical: 12, horizontal: 12),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: AppColors.border)),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: AppColors.border)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(
                    color: AppColors.amber, width: 1.8)),
            errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: AppColors.red)),
          ),
          items: items
              .map((e) => DropdownMenuItem(
                    value: e,
                    child: Text(e,
                        style: GoogleFonts.poppins(
                            fontSize: 13, color: AppColors.dark)),
                  ))
              .toList(),
        ),
        const SizedBox(height: 4),
      ],
    );
  }
}

