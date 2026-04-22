import 'package:construction_app/models/models.dart';
import 'package:construction_app/widgets/app_theme.dart';
import 'package:construction_app/widgets/common_widgets.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';


// ── Site List Screen ──────────────────────────────────────────────────────────

class SitesUserScreen extends StatefulWidget {
  const SitesUserScreen({super.key});

  @override
  State<SitesUserScreen> createState() => _SitesUserScreenState();
}

class _SitesUserScreenState extends State<SitesUserScreen> {
  String _search = '';

  List<SiteModel> get _filtered => sampleSites
      .where((s) =>
          s.name.toLowerCase().contains(_search.toLowerCase()) ||
          s.contactPerson.toLowerCase().contains(_search.toLowerCase()))
      .toList();

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
                    Text('Sites',
                        style: GoogleFonts.poppins(
                          fontSize: 22,
                          fontWeight: FontWeight.w600,
                          color: AppColors.white,
                        )),
                  ],
                ),
                GestureDetector(
                  onTap: () => Navigator.push(context,
                      MaterialPageRoute(builder: (_) => const AddSiteUserScreen())),
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                    decoration: BoxDecoration(
                      color: AppColors.amber,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.add, size: 16, color: AppColors.dark),
                        const SizedBox(width: 4),
                        Text('Add Site',
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

          // Search bar
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
            child: TextField(
              onChanged: (v) => setState(() => _search = v),
              style: GoogleFonts.poppins(fontSize: 13),
              decoration: InputDecoration(
                hintText: 'Search sites...',
                filled: true,
                fillColor: AppColors.white,
                prefixIcon:
                    const Icon(Icons.search, color: AppColors.grey, size: 20),
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

          // List
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
              itemCount: _filtered.length,
              itemBuilder: (_, i) => _SiteCard(site: _filtered[i]),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Site Card ─────────────────────────────────────────────────────────────────

class _SiteCard extends StatelessWidget {
  final SiteModel site;

  const _SiteCard({required this.site});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
          context, MaterialPageRoute(builder: (_) => SiteDetailUserScreen(site: site))),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: AppColors.border),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    site.name,
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppColors.dark,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                StatusBadge(status: site.status),
              ],
            ),
            const SizedBox(height: 10),
            _InfoRow(Icons.person_outline_rounded, site.contactPerson),
            const SizedBox(height: 4),
            _InfoRow(Icons.phone_outlined, site.mobile),
            const SizedBox(height: 4),
            _InfoRow(Icons.calendar_today_outlined,
                '${site.startDate}  →  ${site.targetDate}'),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Estimated Amount',
                    style: GoogleFonts.poppins(
                        fontSize: 12, color: AppColors.grey)),
                Text(
                  formatAmount(site.estimatedAmount),
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: AppColors.orange,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String text;

  const _InfoRow(this.icon, this.text);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 14, color: AppColors.greyLight),
        const SizedBox(width: 6),
        Expanded(
          child: Text(
            text,
            style:
                GoogleFonts.poppins(fontSize: 12, color: AppColors.grey),
          ),
        ),
      ],
    );
  }
}

// ── Site Detail Screen ────────────────────────────────────────────────────────

class SiteDetailUserScreen extends StatelessWidget {
  final SiteModel site;

  const SiteDetailUserScreen({super.key, required this.site});

  @override
  Widget build(BuildContext context) {
    final siteMaterials =
        sampleMaterials.where((m) => m.siteId == site.id).toList();
    final siteLabour =
        sampleLabour.where((l) => l.siteId == site.id).toList();

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: AppColors.greyBg,
        body: Column(
          children: [
            // Header
            Container(
              color: AppColors.navy,
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).padding.top + 8,
                bottom: 12,
                left: 16,
                right: 16,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(Icons.arrow_back_ios_new_rounded,
                            color: AppColors.white, size: 18),
                        padding: EdgeInsets.zero,
                      ),
                      Text('Sites',
                          style: GoogleFonts.poppins(
                              fontSize: 13, color: AppColors.greyLight)),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Padding(
                    padding: const EdgeInsets.only(left: 4),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(site.name,
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: AppColors.white,
                            )),
                        const SizedBox(height: 6),
                        StatusBadge(status: site.status),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // Tabs
            Container(
              color: AppColors.white,
              child: TabBar(
                labelStyle:
                    GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w500),
                unselectedLabelColor: AppColors.grey,
                labelColor: AppColors.orange,
                indicatorColor: AppColors.orange,
                tabs: const [
                  Tab(text: 'Info'),
                  Tab(text: 'Materials'),
                  Tab(text: 'Labour'),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                children: [
                  // Info tab
                  _InfoTab(site: site),
                  // Materials tab
                  _MaterialsUserTab(materials: siteMaterials),
                  // Labour tab
                  _LabourTab(labour: siteLabour),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoTab extends StatelessWidget {
  final SiteModel site;

  const _InfoTab({required this.site});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: AppColors.border),
        ),
        child: Column(
          children: [
            _DetailRow('Contact Person', site.contactPerson),
            _DetailRow('Mobile', site.mobile, highlight: true),
            _DetailRow('Start Date', site.startDate),
            _DetailRow('Target Date', site.targetDate),
            _DetailRow('Supervisor', site.supervisor),
            _DetailRow('Estimated Amount', formatAmount(site.estimatedAmount),
                highlight: true),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Description',
                      style: GoogleFonts.poppins(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: AppColors.grey)),
                  const SizedBox(height: 6),
                  Text(site.description,
                      style: GoogleFonts.poppins(
                          fontSize: 13, color: AppColors.dark, height: 1.6)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  final String label;
  final String value;
  final bool highlight;

  const _DetailRow(this.label, this.value, {this.highlight = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Color(0xFFF3F4F6))),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style:
                  GoogleFonts.poppins(fontSize: 12, color: AppColors.grey)),
          Text(value,
              style: GoogleFonts.poppins(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: highlight ? AppColors.orange : AppColors.dark,
              )),
        ],
      ),
    );
  }
}

class _MaterialsUserTab extends StatelessWidget {
  final List<MaterialModel> materials;

  const _MaterialsUserTab({required this.materials});

  @override
  Widget build(BuildContext context) {
    if (materials.isEmpty) {
      return Center(
          child: Text('No materials added yet',
              style: GoogleFonts.poppins(color: AppColors.grey)));
    }
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: materials.length,
      itemBuilder: (_, i) {
        final m = materials[i];
        return Container(
          margin: const EdgeInsets.only(bottom: 10),
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: AppColors.border),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(m.materialName,
                        style: GoogleFonts.poppins(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: AppColors.dark)),
                    const SizedBox(height: 3),
                    Text('${m.quantity} ${m.unit} × ₹${m.price.toInt()} • ${m.supplier}',
                        style: GoogleFonts.poppins(
                            fontSize: 11, color: AppColors.grey)),
                    Text(m.addedDate,
                        style: GoogleFonts.poppins(
                            fontSize: 10, color: AppColors.greyLight)),
                  ],
                ),
              ),
              Text(
                '₹${m.amount.toInt()}',
                style: GoogleFonts.poppins(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: AppColors.orange,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _LabourTab extends StatelessWidget {
  final List<LabourModel> labour;

  const _LabourTab({required this.labour});

  @override
  Widget build(BuildContext context) {
    if (labour.isEmpty) {
      return Center(
          child: Text('No labour entries yet',
              style: GoogleFonts.poppins(color: AppColors.grey)));
    }
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: labour.length,
      itemBuilder: (_, i) {
        final l = labour[i];
        return Container(
          margin: const EdgeInsets.only(bottom: 10),
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: AppColors.border),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(l.labourType,
                        style: GoogleFonts.poppins(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: AppColors.dark)),
                    const SizedBox(height: 3),
                    Text(l.remarks,
                        style: GoogleFonts.poppins(
                            fontSize: 11, color: AppColors.grey)),
                    Text(l.addedDate,
                        style: GoogleFonts.poppins(
                            fontSize: 10, color: AppColors.greyLight)),
                  ],
                ),
              ),
              Text(
                '₹${l.amount.toInt()}',
                style: GoogleFonts.poppins(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: AppColors.orange,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

// ── Add Site Screen ───────────────────────────────────────────────────────────

class AddSiteUserScreen extends StatefulWidget {
  const AddSiteUserScreen({super.key});

  @override
  State<AddSiteUserScreen> createState() => _AddSiteUserScreenState();
}

class _AddSiteUserScreenState extends State<AddSiteUserScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _contactController = TextEditingController();
  final _mobileController = TextEditingController();
  final _descController = TextEditingController();
  final _amountController = TextEditingController();
  final _startDateController = TextEditingController();
  final _endDateController = TextEditingController();
  String? _selectedSupervisor;
  bool _saving = false;

  final List<String> _supervisors = [
    'Anand Krishnan',
    'Rajan Kumar',
    'Priya Nair',
  ];

  Future<void> _pickDate(TextEditingController ctrl) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
      builder: (ctx, child) => Theme(
        data: Theme.of(ctx).copyWith(
          colorScheme: const ColorScheme.light(primary: AppColors.amber),
        ),
        child: child!,
      ),
    );
    if (picked != null) {
      ctrl.text =
          '${picked.day.toString().padLeft(2, '0')} ${['Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'][picked.month - 1]} ${picked.year}';
    }
  }

  void _save() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _saving = true);
    await Future.delayed(const Duration(seconds: 1));
    setState(() => _saving = false);
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Site saved successfully!',
            style: GoogleFonts.poppins(fontSize: 13)),
        backgroundColor: AppColors.green,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.greyBg,
      body: Column(
        children: [
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
                Text('Add New Site',
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: AppColors.white,
                    )),
              ],
            ),
          ),
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
                      AppTextField(
                        label: 'Site Name *',
                        hint: 'e.g. Sunrise Residency Block B',
                        controller: _nameController,
                        validator: (v) =>
                            v!.isEmpty ? 'Site name is required' : null,
                      ),
                      AppTextField(
                        label: 'Contact Person *',
                        hint: 'Full name',
                        controller: _contactController,
                        validator: (v) => v!.isEmpty ? 'Required' : null,
                      ),
                      AppTextField(
                        label: 'Mobile Number *',
                        hint: '+91 00000 00000',
                        controller: _mobileController,
                        keyboardType: TextInputType.phone,
                        validator: (v) {
                          if (v!.isEmpty) return 'Mobile number is required';
                          if (v.replaceAll(RegExp(r'\D'), '').length < 10) {
                            return 'Enter a valid mobile number';
                          }
                          return null;
                        },
                      ),
                      AppDropdown(
                        label: 'Supervisor *',
                        value: _selectedSupervisor,
                        items: _supervisors,
                        onChanged: (v) =>
                            setState(() => _selectedSupervisor = v),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: AppTextField(
                              label: 'Start Date *',
                              hint: 'DD Mon YYYY',
                              controller: _startDateController,
                              readOnly: true,
                              onTap: () => _pickDate(_startDateController),
                              suffixIcon: const Icon(
                                  Icons.calendar_today_outlined,
                                  size: 18,
                                  color: AppColors.grey),
                              validator: (v) =>
                                  v!.isEmpty ? 'Required' : null,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: AppTextField(
                              label: 'Target Date *',
                              hint: 'DD Mon YYYY',
                              controller: _endDateController,
                              readOnly: true,
                              onTap: () => _pickDate(_endDateController),
                              suffixIcon: const Icon(
                                  Icons.calendar_today_outlined,
                                  size: 18,
                                  color: AppColors.grey),
                              validator: (v) =>
                                  v!.isEmpty ? 'Required' : null,
                            ),
                          ),
                        ],
                      ),
                      AppTextField(
                        label: 'Estimated Amount (₹) *',
                        hint: '0.00',
                        controller: _amountController,
                        keyboardType: const TextInputType.numberWithOptions(
                            decimal: true),
                        validator: (v) =>
                            v!.isEmpty ? 'Amount is required' : null,
                      ),
                      AppTextField(
                        label: 'Description',
                        hint: 'Describe the site, scope of work...',
                        controller: _descController,
                        maxLines: 3,
                      ),
                      AppButton(
                          label: 'Save Site',
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
