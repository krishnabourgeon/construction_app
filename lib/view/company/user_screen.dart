import 'package:construction_app/models/models.dart';
import 'package:construction_app/provider/company_provider.dart';
import 'package:construction_app/widgets/app_theme.dart';
import 'package:construction_app/widgets/common_widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

// ── Avatar color palette by index ─────────────────────────────────────────────

const List<Color> _avatarBgs = [
  Color(0xFFFEF3C7),
  Color(0xFFDBEAFE),
  Color(0xFFFEE2E2),
  Color(0xFFEDE9FE),
  Color(0xFFDCFCE7),
  Color(0xFFFED7AA),
];

const List<Color> _avatarFgs = [
  Color(0xFFB45309),
  Color(0xFF1D4ED8),
  Color(0xFFB91C1C),
  Color(0xFF6D28D9),
  Color(0xFF15803D),
  Color(0xFFEA580C),
];

// ── Users List Screen ─────────────────────────────────────────────────────────

class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  String _search = '';

  List<UserModel> get _filtered => sampleUsers
      .where((u) =>
          u.name.toLowerCase().contains(_search.toLowerCase()) ||
          u.role.toLowerCase().contains(_search.toLowerCase()) ||
          u.email.toLowerCase().contains(_search.toLowerCase()))
      .toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.greyBg,
      body: Column(
        children: [
          // ── Header ──────────────────────────────────────────────────────
          Container(
            color: AppColors.navy,
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top + 16,
              bottom: 20,
              left: 20,
              right: 20,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Management',
                        style: GoogleFonts.poppins(
                            fontSize: 11, color: AppColors.greyLight)),
                    Text('Supervisor',
                        style: GoogleFonts.poppins(
                          fontSize: 22,
                          fontWeight: FontWeight.w600,
                          color: AppColors.white,
                        )),
                  ],
                ),
                GestureDetector(
                  onTap: () async {
                    final result = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const AddUserScreen(),
                      ),
                    );

                    if (result == true) {
                      // ✅ Refresh the list when user is added
                      setState(() {});
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 14, vertical: 8),
                    decoration: BoxDecoration(
                      color: AppColors.amber,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.add,
                            size: 16, color: AppColors.dark),
                        const SizedBox(width: 4),
                        Text('Add',
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: AppColors.dark,
                            )),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          // ── Search bar ──────────────────────────────────────────────────
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
            child: TextField(
              onChanged: (v) => setState(() => _search = v),
              style: GoogleFonts.poppins(fontSize: 13),
              decoration: InputDecoration(
                hintText: 'Search supervisor...',
                filled: true,
                fillColor: AppColors.white,
                prefixIcon: const Icon(Icons.search,
                    color: AppColors.grey, size: 20),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: AppColors.border),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: AppColors.border),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide:
                      const BorderSide(color: AppColors.amber, width: 2),
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 12),
              ),
            ),
          ),

          // ── Count ───────────────────────────────────────────────────────
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 6, 16, 4),
            child: Row(
              children: [
                Text(
                  '${_filtered.length} users',
                  style: GoogleFonts.poppins(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: AppColors.grey),
                ),
              ],
            ),
          ),

          // ── List ────────────────────────────────────────────────────────
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.fromLTRB(16, 4, 16, 16),
              itemCount: _filtered.length,
              itemBuilder: (_, i) {
                final user = _filtered[i];
                final colorIdx = i % _avatarBgs.length;
                return _UserCard(
                  user: user,
                  avatarBg: _avatarBgs[colorIdx],
                  avatarFg: _avatarFgs[colorIdx],
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => UserDetailScreen(
                              user: user,
                              avatarBg: _avatarBgs[colorIdx],
                              avatarFg: _avatarFgs[colorIdx],
                            )),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// ── User Card ─────────────────────────────────────────────────────────────────

class _UserCard extends StatelessWidget {
  final UserModel user;
  final Color avatarBg;
  final Color avatarFg;
  final VoidCallback onTap;

  const _UserCard({
    required this.user,
    required this.avatarBg,
    required this.avatarFg,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.border),
        ),
        child: Row(
          children: [
            // Avatar circle
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: avatarBg,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Center(
                child: Text(
                  user.initials!,
                  style: GoogleFonts.poppins(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: avatarFg,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            // Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(user.name,
                      style: GoogleFonts.poppins(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: AppColors.dark,
                      )),
                  const SizedBox(height: 2),
                  Text(user.role,
                      style: GoogleFonts.poppins(
                          fontSize: 11, color: AppColors.grey)),
                  const SizedBox(height: 1),
                  Text(user.phone,
                      style: GoogleFonts.poppins(
                          fontSize: 11, color: AppColors.greyLight)),
                ],
              ),
            ),
            // Status badge
            _StatusBadge(status: user.status),
          ],
        ),
      ),
    );
  }
}

// ── User Status Badge ─────────────────────────────────────────────────────────

class _StatusBadge extends StatelessWidget {
  final String status;
  const _StatusBadge({required this.status});

  @override
  Widget build(BuildContext context) {
    final isActive = status == 'Active';
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: isActive ? AppColors.greenLight : AppColors.amberLight,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        status,
        style: GoogleFonts.poppins(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          color: isActive ? AppColors.green : AppColors.amberDark,
        ),
      ),
    );
  }
}

// ── User Detail Screen ────────────────────────────────────────────────────────

class UserDetailScreen extends StatelessWidget {
  final UserModel user;
  final Color avatarBg;
  final Color avatarFg;

  const UserDetailScreen({
    super.key,
    required this.user,
    required this.avatarBg,
    required this.avatarFg,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.greyBg,
      body: Column(
        children: [
          // Header
          Container(
            color: AppColors.navy,
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top + 8,
              bottom: 28,
              left: 16,
              right: 16,
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.arrow_back_ios_new_rounded,
                          color: AppColors.white, size: 18),
                      padding: EdgeInsets.zero,
                    ),
                    Text('Supervisor',
                        style: GoogleFonts.poppins(
                            fontSize: 13, color: AppColors.greyLight)),
                    const Spacer(),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.edit_outlined,
                          color: AppColors.amber, size: 20),
                    ),
                    IconButton(
                      onPressed: () => _confirmDelete(context),
                      icon: const Icon(Icons.delete_outline_rounded,
                          color: Color(0xFFEF4444), size: 20),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                // Avatar + name
                Container(
                  width: 72,
                  height: 72,
                  decoration: BoxDecoration(
                    color: avatarBg,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(user.initials!,
                        style: GoogleFonts.poppins(
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                          color: avatarFg,
                        )),
                  ),
                ),
                const SizedBox(height: 10),
                Text(user.name,
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: AppColors.white,
                    )),
                const SizedBox(height: 4),
                _StatusBadge(status: user.status),
              ],
            ),
          ),

          // Detail rows
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(color: AppColors.border),
                ),
                child: Column(
                  children: [
                    _DetailRow(Icons.badge_outlined, AppColors.amberLight,
                        AppColors.amberDark, 'Role', user.role),
                    _DetailRow(Icons.phone_outlined, AppColors.blueLight,
                        AppColors.blue, 'Phone', user.phone),
                    _DetailRow(Icons.email_outlined, AppColors.greenLight,
                        AppColors.green, 'Email', user.email),
                    _DetailRow(Icons.toggle_on_outlined, AppColors.greyBg,
                        AppColors.grey, 'Status', user.status),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _confirmDelete(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        title: Text('Delete Supervisor',
            style: GoogleFonts.poppins(
                fontWeight: FontWeight.w600, fontSize: 16)),
        content: Text(
            'Are you sure you want to delete ${user.name}?',
            style:
                GoogleFonts.poppins(fontSize: 13, color: AppColors.grey)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel',
                style: GoogleFonts.poppins(color: AppColors.grey)),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
            child: Text('Delete',
                style: GoogleFonts.poppins(
                    color: AppColors.red, fontWeight: FontWeight.w600)),
          ),
        ],
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  final IconData icon;
  final Color iconBg;
  final Color iconColor;
  final String label;
  final String value;

  const _DetailRow(
      this.icon, this.iconBg, this.iconColor, this.label, this.value);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Color(0xFFF3F4F6))),
      ),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
                color: iconBg, borderRadius: BorderRadius.circular(10)),
            child: Icon(icon, color: iconColor, size: 18),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label,
                    style: GoogleFonts.poppins(
                        fontSize: 11, color: AppColors.greyLight)),
                Text(value,
                    style: GoogleFonts.poppins(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: AppColors.dark,
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ── Add User Screen ───────────────────────────────────────────────────────────

class AddUserScreen extends StatefulWidget {
  const AddUserScreen({super.key});

  @override
  State<AddUserScreen> createState() => _AddUserScreenState();
}

class _AddUserScreenState extends State<AddUserScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();
  final _phoneCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();
  final _confirmPasswordCtrl = TextEditingController();
  // String? _selectedRole;
  // String _selectedStatus = 'Active';
  bool _showPw = false;
  bool _showConfirmPw = false;
  bool _saving = false;

  // final List<String> _roles = [
  //   'Supervisor',
  //   'Site Engineer',
  //   'Accountant',
  //   'Manager',
  //   'Labour Contractor',
  // ];

  // void _save() async {
  //   if (!_formKey.currentState!.validate()) return;
  //   setState(() => _saving = true);
  //   await Future.delayed(const Duration(seconds: 1));

  //   // Add to sample list
  //   sampleUsers.add(UserModel(
  //     id: DateTime.now().millisecondsSinceEpoch.toString(),
  //     name: _nameCtrl.text.trim(),
  //     phone: _phoneCtrl.text.trim(),
  //     email: _emailCtrl.text.trim(),
  //     role: _selectedRole ?? 'Supervisor',
  //     status: _selectedStatus,
      
  //   ));

  //   setState(() => _saving = false);
  //   if (!mounted) return;

  //   ScaffoldMessenger.of(context).showSnackBar(
  //     SnackBar(
  //       content: Text('Supervisor added successfully!',
  //           style: GoogleFonts.poppins(fontSize: 13)),
  //       backgroundColor: AppColors.green,
  //       behavior: SnackBarBehavior.floating,
  //       shape:
  //           RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
  //     ),
  //   );
  //   Navigator.pop(context);
  // }

  void _save() async {
  if (!_formKey.currentState!.validate()) return;

  final provider = context.read<CompanyProvider>();

  setState(() => _saving = true);

  await provider.createUser(
    name: _nameCtrl.text.trim(),
    mobile: _phoneCtrl.text.trim(),
    email: _emailCtrl.text.trim(),
    password: _passwordCtrl.text.trim(),
    passwordConfirmation: _confirmPasswordCtrl.text.trim(),
    onFailure: (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(error),
          backgroundColor: Colors.red,
        ),
      );
    },
  );

  setState(() => _saving = false);

  if (provider.errorToast == null) {
    //  SUCCESS
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Supervisor added successfully!',
          style: GoogleFonts.poppins(fontSize: 13),
        ),
        backgroundColor: AppColors.green,
      ),
    );

    Navigator.pop(context, true); // return success
  }
}

  @override
  void dispose() {
    _nameCtrl.dispose();
    _phoneCtrl.dispose();
    _emailCtrl.dispose();
    _passwordCtrl.dispose();
    _confirmPasswordCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.greyBg,
      body: Column(
        children: [
          // Header
          Container(
            color: AppColors.navy,
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top + 8,
              bottom: 16,
              left: 8,
              right: 16,
            ),
            child: Row(
              children: [
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.arrow_back_ios_new_rounded,
                      color: AppColors.white, size: 18),
                ),
                Text('Add New Supervisor',
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: AppColors.white,
                    )),
              ],
            ),
          ),

          // Form
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: _formKey,
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: AppColors.border),
                  ),
                  child: Column(
                    children: [
                      // Full Name
                      AppTextField(
                        label: 'Full Name *',
                        hint: 'e.g. Anand Krishnan',
                        controller: _nameCtrl,
                        validator: (v) =>
                            v!.isEmpty ? 'Name is required' : null,
                      ),

                      // Phone
                      AppTextField(
                        label: 'Phone Number *',
                        hint: '+91 00000 00000',
                        controller: _phoneCtrl,
                        keyboardType: TextInputType.phone,
                        validator: (v) {
                          if (v!.isEmpty) return 'Phone is required';
                          if (v.replaceAll(RegExp(r'\D'), '').length < 10) {
                            return 'Enter a valid phone number';
                          }
                          return null;
                        },
                      ),

                      // Email
                      AppTextField(
                        label: 'Email Address *',
                        hint: 'user@buildco.in',
                        controller: _emailCtrl,
                        keyboardType: TextInputType.emailAddress,
                        validator: (v) {
                          if (v!.isEmpty) return 'Email is required';
                          if (!v.contains('@')) return 'Enter a valid email';
                          return null;
                        },
                      ),

                      // Role
                      // AppDropdown(
                      //   label: 'Role *',
                      //   value: _selectedRole,
                      //   items: _roles,
                      //   onChanged: (v) =>
                      //       setState(() => _selectedRole = v),
                      // ),

                      // Password
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Password *',
                              style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.dark)),
                          const SizedBox(height: 6),
                          TextFormField(
                            controller: _passwordCtrl,
                            obscureText: !_showPw,
                            validator: (v) {
                              if (v!.isEmpty) return 'Password is required';
                              if (v.length < 6) {
                                return 'Minimum 6 characters';
                              }
                              return null;
                            },
                            style: GoogleFonts.poppins(
                                fontSize: 14, color: AppColors.dark),
                            decoration: InputDecoration(
                              hintText: 'Set a password',
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _showPw
                                      ? Icons.visibility_outlined
                                      : Icons.visibility_off_outlined,
                                  color: AppColors.grey,
                                  size: 20,
                                ),
                                onPressed: () =>
                                    setState(() => _showPw = !_showPw),
                              ),
                            ),
                          ),
                          const SizedBox(height: 14),
                        ],
                      ),

                      // Confirm Password
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Confirm Password *',
                              style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.dark)),
                          const SizedBox(height: 6),
                          TextFormField(
                            controller: _confirmPasswordCtrl,
                            obscureText: !_showConfirmPw,
                            validator: (v) {
                              if (v!.isEmpty) {
                                return 'Please confirm your password';
                              }
                              if (v != _passwordCtrl.text) {
                                return 'Passwords do not match';
                              }
                              return null;
                            },
                            style: GoogleFonts.poppins(
                                fontSize: 14, color: AppColors.dark),
                            decoration: InputDecoration(
                              hintText: 'Re-enter password',
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _showConfirmPw
                                      ? Icons.visibility_outlined
                                      : Icons.visibility_off_outlined,
                                  color: AppColors.grey,
                                  size: 20,
                                ),
                                onPressed: () => setState(
                                    () => _showConfirmPw = !_showConfirmPw),
                              ),
                            ),
                          ),
                          const SizedBox(height: 14),
                        ],
                      ),

                      // Status toggle
                      // Column(
                      //   crossAxisAlignment: CrossAxisAlignment.start,
                      //   children: [
                      //     Text('Status',
                      //         style: GoogleFonts.poppins(
                      //             fontSize: 12,
                      //             fontWeight: FontWeight.w600,
                      //             color: AppColors.dark)),
                      //     const SizedBox(height: 8),
                      //     Row(
                      //       children: ['Active', 'Inactive'].map((s) {
                      //         final selected = _selectedStatus == s;
                      //         return GestureDetector(
                      //           onTap: () =>
                      //               setState(() => _selectedStatus = s),
                      //           child: Container(
                      //             margin: const EdgeInsets.only(right: 10),
                      //             padding: const EdgeInsets.symmetric(
                      //                 horizontal: 16, vertical: 8),
                      //             decoration: BoxDecoration(
                      //               color: selected
                      //                   ? (s == 'Active'
                      //                       ? AppColors.greenLight
                      //                       : AppColors.amberLight)
                      //                   : AppColors.greyBg,
                      //               borderRadius: BorderRadius.circular(20),
                      //               border: Border.all(
                      //                 color: selected
                      //                     ? (s == 'Active'
                      //                         ? AppColors.green
                      //                         : AppColors.amberDark)
                      //                     : AppColors.border,
                      //               ),
                      //             ),
                      //             child: Text(
                      //               s,
                      //               style: GoogleFonts.poppins(
                      //                 fontSize: 12,
                      //                 fontWeight: FontWeight.w500,
                      //                 color: selected
                      //                     ? (s == 'Active'
                      //                         ? AppColors.green
                      //                         : AppColors.amberDark)
                      //                     : AppColors.grey,
                      //               ),
                      //             ),
                      //           ),
                      //         );
                      //       }).toList(),
                      //     ),
                      //     const SizedBox(height: 14),
                      //   ],
                      // ),

                      AppButton(
                          label: 'Save Supervisor',
                          onPressed: _save,
                          isLoading: _saving),
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
}