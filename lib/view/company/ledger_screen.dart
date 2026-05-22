import 'package:construction_app/widgets/app_theme.dart';
import 'package:construction_app/widgets/common_widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ── Avatar color palette ───────────────────────────────────────────────────────

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

// ── Ledger Model ──────────────────────────────────────────────────────────────

class LedgerEntry {
  final String id;
  final String name;
  final String group;

  LedgerEntry({required this.id, required this.name, required this.group});
}

// ── Sample groups ─────────────────────────────────────────────────────────────

const List<String> kLedgerGroups = [
  'Assets',
  'Liabilities',
  'Income',
  'Expenses',
  'Capital',
  'Bank Accounts',
  'Cash in Hand',
  'Sundry Debtors',
  'Sundry Creditors',
  'Fixed Assets',
  'Loans & Advances',
];

// ── Ledger Screen ─────────────────────────────────────────────────────────────

class LedgerScreen extends StatefulWidget {
  const LedgerScreen({super.key});

  @override
  State<LedgerScreen> createState() => _LedgerScreenState();
}

class _LedgerScreenState extends State<LedgerScreen> {
  String _search = '';

  // Sample data — replace with provider/API call
  final List<LedgerEntry> _ledgers = [
    LedgerEntry(id: '1', name: 'Cash Account', group: 'Cash in Hand'),
    LedgerEntry(id: '2', name: 'HDFC Bank', group: 'Bank Accounts'),
    LedgerEntry(id: '3', name: 'Sales Revenue', group: 'Income'),
    LedgerEntry(id: '4', name: 'Office Rent', group: 'Expenses'),
    LedgerEntry(id: '5', name: 'Rajan Constructions', group: 'Sundry Creditors'),
    LedgerEntry(id: '6', name: 'Kerala Cement Depot', group: 'Sundry Debtors'),
  ];

  List<LedgerEntry> get _filtered => _ledgers
      .where((l) =>
          l.name.toLowerCase().contains(_search.toLowerCase()) ||
          l.group.toLowerCase().contains(_search.toLowerCase()))
      .toList();

  Future<void> _openAddLedger() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const AddLedgerScreen()),
    );
    if (result is LedgerEntry) {
      setState(() => _ledgers.add(result));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.greyBg,
      body: Column(
        children: [
          // ── Header ────────────────────────────────────────────────────
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
                    Text(
                      'Accounts',
                      style: GoogleFonts.poppins(
                        fontSize: 15,
                        color: AppColors.greyLight,
                      ),
                    ),
                    Text(
                      'Ledger',
                      style: GoogleFonts.poppins(
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                        color: AppColors.white,
                      ),
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: _openAddLedger,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.amber,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.add, size: 18, color: AppColors.dark),
                        const SizedBox(width: 4),
                        Text(
                          'Add',
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: AppColors.dark,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          // ── Search bar ────────────────────────────────────────────────
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
            child: TextField(
              onChanged: (v) => setState(() => _search = v),
              style: GoogleFonts.poppins(fontSize: 15),
              decoration: InputDecoration(
                hintText: 'Search ledger by name or group',
                filled: true,
                fillColor: AppColors.white,
                prefixIcon: const Icon(
                  Icons.search,
                  color: AppColors.grey,
                  size: 20,
                ),
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

          // ── Count ─────────────────────────────────────────────────────
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 6, 16, 4),
            child: Row(
              children: [
                Text(
                  '${_filtered.length} ledger${_filtered.length == 1 ? '' : 's'}',
                  style: GoogleFonts.poppins(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: AppColors.grey,
                  ),
                ),
              ],
            ),
          ),

          // ── List ──────────────────────────────────────────────────────
          Expanded(
            child: _filtered.isEmpty
                ? Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.account_balance_wallet_outlined,
                            size: 52, color: AppColors.greyLight),
                        const SizedBox(height: 12),
                        Text(
                          _search.isEmpty
                              ? 'No ledgers yet.\nTap Add to create one.'
                              : 'No results for "$_search"',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            color: AppColors.grey,
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.fromLTRB(16, 4, 16, 16),
                    itemCount: _filtered.length,
                    itemBuilder: (_, i) {
                      final entry = _filtered[i];
                      final colorIdx = i % _avatarBgs.length;
                      return _LedgerCard(
                        entry: entry,
                        avatarBg: _avatarBgs[colorIdx],
                        avatarFg: _avatarFgs[colorIdx],
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

// ── Ledger Card ───────────────────────────────────────────────────────────────

class _LedgerCard extends StatelessWidget {
  final LedgerEntry entry;
  final Color avatarBg;
  final Color avatarFg;

  const _LedgerCard({
    required this.entry,
    required this.avatarBg,
    required this.avatarFg,
  });

  @override
  Widget build(BuildContext context) {
    final initials = entry.name.trim().isNotEmpty
        ? entry.name.trim().substring(0, entry.name.trim().length >= 2 ? 2 : 1).toUpperCase()
        : '??';

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          // Avatar
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: avatarBg,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Center(
              child: Text(
                initials,
                style: GoogleFonts.poppins(
                  fontSize: 16,
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
                Text(
                  entry.name,
                  style: GoogleFonts.poppins(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: AppColors.dark,
                  ),
                ),
                const SizedBox(height: 3),
                Row(
                  children: [
                    const Icon(Icons.folder_outlined,
                        size: 13, color: AppColors.greyLight),
                    const SizedBox(width: 4),
                    Text(
                      entry.group,
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        color: AppColors.grey,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Group badge
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: AppColors.amberLight,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              entry.group,
              style: GoogleFonts.poppins(
                fontSize: 10,
                fontWeight: FontWeight.w600,
                color: AppColors.amberDark,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Add Ledger Screen ─────────────────────────────────────────────────────────

class AddLedgerScreen extends StatefulWidget {
  const AddLedgerScreen({super.key});

  @override
  State<AddLedgerScreen> createState() => _AddLedgerScreenState();
}

class _AddLedgerScreenState extends State<AddLedgerScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();
  String? _selectedGroup;
  bool _saving = false;

  void _save() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _saving = true);

    // Simulate API save — replace with your provider call
    await Future.delayed(const Duration(milliseconds: 600));

    setState(() => _saving = false);
    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Ledger added successfully!',
          style: GoogleFonts.poppins(fontSize: 13),
        ),
        backgroundColor: AppColors.green,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );

    Navigator.pop(
      context,
      LedgerEntry(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        name: _nameCtrl.text.trim(),
        group: _selectedGroup!,
      ),
    );
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.greyBg,
      body: Column(
        children: [
          // ── Header ──────────────────────────────────────────────────
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
                  icon: const Icon(
                    Icons.arrow_back_ios_new_rounded,
                    color: AppColors.white,
                    size: 18,
                  ),
                ),
                Text(
                  'Add New Ledger',
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: AppColors.white,
                  ),
                ),
              ],
            ),
          ),

          // ── Form ────────────────────────────────────────────────────
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Section heading
                      Text(
                        'Ledger Details',
                        style: GoogleFonts.poppins(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: AppColors.dark,
                        ),
                      ),
                      Text(
                        'Fill in the name and assign a group for this ledger account.',
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          color: AppColors.grey,
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Name
                      AppTextField(
                        label: 'Ledger Name *',
                        hint: 'e.g. HDFC Bank Current Account',
                        controller: _nameCtrl,
                        validator: (v) =>
                            v == null || v.trim().isEmpty
                                ? 'Ledger name is required'
                                : null,
                      ),

                      // Group dropdown
                      Text(
                        'Group *',
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: AppColors.dark,
                        ),
                      ),
                      const SizedBox(height: 6),
                      DropdownButtonFormField<String>(
                        value: _selectedGroup,
                        hint: Text(
                          'Select group',
                          style: GoogleFonts.poppins(
                            fontSize: 13,
                            color: AppColors.greyLight,
                          ),
                        ),
                        isExpanded: true,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: AppColors.white,
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 14),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide:
                                const BorderSide(color: AppColors.border),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide:
                                const BorderSide(color: AppColors.border),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(
                                color: AppColors.amber, width: 2),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide:
                                const BorderSide(color: AppColors.red),
                          ),
                        ),
                        items: kLedgerGroups
                            .map(
                              (g) => DropdownMenuItem(
                                value: g,
                                child: Text(
                                  g,
                                  style: GoogleFonts.poppins(
                                      fontSize: 14, color: AppColors.dark),
                                ),
                              ),
                            )
                            .toList(),
                        onChanged: (v) => setState(() => _selectedGroup = v),
                        validator: (v) =>
                            v == null ? 'Please select a group' : null,
                      ),
                      const SizedBox(height: 24),

                      // Save button
                      AppButton(
                        label: 'Save Ledger',
                        onPressed: _save,
                        isLoading: _saving,
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
}