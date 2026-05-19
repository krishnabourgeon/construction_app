import 'package:flutter/material.dart';

class PrivacyPolicyScreen extends StatefulWidget {
  const PrivacyPolicyScreen({super.key});
 
  @override
  State<PrivacyPolicyScreen> createState() => _PrivacyPolicyScreenState();
}
 
class _PrivacyPolicyScreenState extends State<PrivacyPolicyScreen>
    with SingleTickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();
  bool _hasScrolledToBottom = false;
  bool _accepted = false;
  late AnimationController _buttonAnimController;
  late Animation<double> _buttonScale;
 
  static const _bg = Color(0xFF0F0F1A);
  static const _surface = Color(0xFF1A1A2E);
  static const _accent = Color(0xFF6C63FF);
  static const _accentSoft = Color(0xFF9D97FF);
  static const _textPrimary = Color(0xFFF0EFFF);
  static const _textSecondary = Color(0xFF9896B8);
  static const _divider = Color(0xFF2A2A45);
  static const _cardBg = Color(0xFF16162A);
 
  @override
  void initState() {
    super.initState();
    _buttonAnimController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 120),
    );
    _buttonScale = Tween<double>(begin: 1.0, end: 0.96).animate(
      CurvedAnimation(parent: _buttonAnimController, curve: Curves.easeInOut),
    );
 
    _scrollController.addListener(() {
      final maxScroll = _scrollController.position.maxScrollExtent;
      final current = _scrollController.position.pixels;
      if (current >= maxScroll - 50 && !_hasScrolledToBottom) {
        setState(() => _hasScrolledToBottom = true);
      }
    });
  }
 
  @override
  void dispose() {
    _scrollController.dispose();
    _buttonAnimController.dispose();
    super.dispose();
  }
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bg,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            Expanded(
              child: _buildContent(),
            ),
            _buildFooter(),
          ],
        ),
      ),
    );
  }
 
  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 16),
      decoration: BoxDecoration(
        color: _bg,
        border: Border(
          bottom: BorderSide(color: _divider, width: 1),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              GestureDetector(
                onTap: () => Navigator.maybePop(context),
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: _surface,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: _divider),
                  ),
                  child: const Icon(
                    Icons.arrow_back_ios_new_rounded,
                    color: _textSecondary,
                    size: 16,
                  ),
                ),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: _accent.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: _accent.withOpacity(0.3)),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.verified_user_rounded, color: _accent, size: 14),
                    SizedBox(width: 6),
                    Text(
                      'v2.4 · May 2026',
                      style: TextStyle(
                        color: _accentSoft,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.3,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          const Text(
            'Privacy\nPolicy',
            style: TextStyle(
              color: _textPrimary,
              fontSize: 34,
              fontWeight: FontWeight.w800,
              height: 1.1,
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'We take your privacy seriously. Please read through our policy carefully.',
            style: TextStyle(
              color: _textSecondary,
              fontSize: 14,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
 
  Widget _buildContent() {
    return ListView(
      controller: _scrollController,
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 24),
      children: [
        _buildSummaryCards(),
        const SizedBox(height: 28),
        _buildSection(
          icon: Icons.info_outline_rounded,
          title: '1. Information We Collect',
          content:
              'We collect information you provide directly to us, such as when you create or modify your account, request services, contact customer support, or otherwise communicate with us.\n\nThis includes:\n• Name, email address, and password\n• Profile information and preferences\n• Payment and transaction information\n• Communications you send us\n• Device and usage data collected automatically',
        ),
        _buildSection(
          icon: Icons.manage_search_rounded,
          title: '2. How We Use Your Information',
          content:
              'We use the information we collect to provide, maintain, and improve our services, process transactions, send you technical notices, respond to your comments and questions, and send you marketing communications (where permitted by law).\n\nWe may also use your data to personalize your experience, monitor and analyze trends and usage, detect and prevent fraudulent transactions, and comply with legal obligations.',
        ),
        _buildSection(
          icon: Icons.share_rounded,
          title: '3. Information Sharing',
          content:
              'We do not share, sell, rent, or trade your personal information with third parties for their commercial purposes. We may share your information with vendors and service providers that perform services on our behalf, such as payment processing, data analysis, email delivery, and hosting services.\n\nThese third parties are contractually obligated to use your information only as necessary to provide the applicable services.',
        ),
        _buildSection(
          icon: Icons.lock_outline_rounded,
          title: '4. Data Security',
          content:
              'We take reasonable measures to help protect information about you from loss, theft, misuse, unauthorized access, disclosure, alteration, and destruction. All data is encrypted in transit using TLS and at rest using AES-256 encryption.\n\nHowever, no internet or email transmission is ever fully secure or error-free. Please take special care in deciding what information you send to us.',
        ),
        _buildSection(
          icon: Icons.cookie_outlined,
          title: '5. Cookies & Tracking',
          content:
              'We use cookies and similar tracking technologies to track activity on our platform and hold certain information. Cookies are files with a small amount of data which may include an anonymous unique identifier.\n\nYou can instruct your browser to refuse all cookies or to indicate when a cookie is being sent. However, if you do not accept cookies, you may not be able to use some portions of our platform.',
        ),
        _buildSection(
          icon: Icons.person_outline_rounded,
          title: '6. Your Rights & Choices',
          content:
              'You have the right to access, update, or delete the information we have on you. You may also object to processing of your personal information, ask us to restrict processing of your personal information, or request portability of your personal information.\n\nYou can exercise these rights by logging into your account settings or contacting us directly. We will respond to all requests within 30 days.',
        ),
        _buildSection(
          icon: Icons.child_care_rounded,
          title: '7. Children\'s Privacy',
          content:
              'Our service does not address anyone under the age of 13. We do not knowingly collect personally identifiable information from children under 13. If you are a parent or guardian and you are aware that your child has provided us with personal data, please contact us immediately.',
        ),
        _buildSection(
          icon: Icons.update_rounded,
          title: '8. Changes to This Policy',
          content:
              'We may update our Privacy Policy from time to time. We will notify you of any changes by posting the new Privacy Policy on this page and updating the version date at the top. You are advised to review this Privacy Policy periodically for any changes.',
        ),
        _buildSection(
          icon: Icons.mail_outline_rounded,
          title: '9. Contact Us',
          content:
              'If you have any questions about this Privacy Policy, please contact us:\n\n• Email: privacy@yourapp.com\n• Address: 123 App Street, Tech City, TC 00000\n• Phone: +1 (800) 000-0000\n\nWe aim to respond to all privacy-related inquiries within 48 hours.',
        ),
        const SizedBox(height: 12),
        _buildScrollHint(),
      ],
    );
  }
 
  Widget _buildSummaryCards() {
    final items = [
      (Icons.lock_rounded, 'Encrypted', 'End-to-end\nprotection'),
      (Icons.block_rounded, 'No Selling', 'Your data\nstays yours'),
      (Icons.tune_rounded, 'Control', 'Manage your\npreferences'),
    ];
 
    return Row(
      children: items.map((item) {
        return Expanded(
          child: Container(
            margin: EdgeInsets.only(
              right: item == items.last ? 0 : 10,
            ),
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: _cardBg,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: _divider),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  _accent.withOpacity(0.08),
                  Colors.transparent,
                ],
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 34,
                  height: 34,
                  decoration: BoxDecoration(
                    color: _accent.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(item.$1, color: _accent, size: 18),
                ),
                const SizedBox(height: 10),
                Text(
                  item.$2,
                  style: const TextStyle(
                    color: _textPrimary,
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  item.$3,
                  style: const TextStyle(
                    color: _textSecondary,
                    fontSize: 11,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
 
  Widget _buildSection({
    required IconData icon,
    required String title,
    required String content,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: _cardBg,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _divider),
      ),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          tilePadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 4),
          childrenPadding: const EdgeInsets.fromLTRB(18, 0, 18, 18),
          leading: Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: _accent.withOpacity(0.12),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: _accentSoft, size: 19),
          ),
          title: Text(
            title,
            style: const TextStyle(
              color: _textPrimary,
              fontSize: 14,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.1,
            ),
          ),
          iconColor: _textSecondary,
          collapsedIconColor: _textSecondary,
          children: [
            Divider(color: _divider, height: 1),
            const SizedBox(height: 14),
            Text(
              content,
              style: const TextStyle(
                color: _textSecondary,
                fontSize: 13.5,
                height: 1.7,
              ),
            ),
          ],
        ),
      ),
    );
  }
 
  Widget _buildScrollHint() {
    if (_hasScrolledToBottom) return const SizedBox.shrink();
    return Center(
      child: Column(
        children: [
          const Icon(Icons.keyboard_arrow_down_rounded,
              color: _textSecondary, size: 20),
          const SizedBox(height: 4),
          Text(
            'Scroll to read all sections',
            style: TextStyle(
              color: _textSecondary.withOpacity(0.6),
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
 
  Widget _buildFooter() {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
      decoration: BoxDecoration(
        color: _bg,
        border: Border(top: BorderSide(color: _divider)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () => setState(() => _accepted = !_accepted),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  width: 22,
                  height: 22,
                  decoration: BoxDecoration(
                    color: _accepted ? _accent : Colors.transparent,
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(
                      color: _accepted ? _accent : _textSecondary,
                      width: 2,
                    ),
                  ),
                  child: _accepted
                      ? const Icon(Icons.check_rounded,
                          color: Colors.white, size: 14)
                      : null,
                ),
                const SizedBox(width: 12),
                const Expanded(
                  child: Text(
                    'I have read and agree to the Privacy Policy and Terms of Service.',
                    style: TextStyle(
                      color: _textSecondary,
                      fontSize: 13,
                      height: 1.5,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          ScaleTransition(
            scale: _buttonScale,
            child: GestureDetector(
              onTapDown: (_) => _accepted ? _buttonAnimController.forward() : null,
              onTapUp: (_) {
                _buttonAnimController.reverse();
                if (_accepted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: const Text('Privacy Policy accepted!'),
                      backgroundColor: _accent,
                      behavior: SnackBarBehavior.floating,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                    ),
                  );
                }
              },
              onTapCancel: () => _buttonAnimController.reverse(),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                width: double.infinity,
                height: 54,
                decoration: BoxDecoration(
                  gradient: _accepted
                      ? const LinearGradient(
                          colors: [Color(0xFF6C63FF), Color(0xFF9D97FF)],
                        )
                      : null,
                  color: _accepted ? null : _surface,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: _accepted ? Colors.transparent : _divider,
                  ),
                  boxShadow: _accepted
                      ? [
                          BoxShadow(
                            color: _accent.withOpacity(0.4),
                            blurRadius: 20,
                            offset: const Offset(0, 8),
                          )
                        ]
                      : [],
                ),
                child: Center(
                  child: Text(
                    _accepted ? 'Continue →' : 'Accept to Continue',
                    style: TextStyle(
                      color: _accepted ? Colors.white : _textSecondary,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.2,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}