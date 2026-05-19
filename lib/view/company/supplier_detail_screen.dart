import 'package:construction_app/models/supplier_detail_model.dart';
import 'package:construction_app/models/supplier_model.dart';
import 'package:construction_app/provider/company_provider.dart';
import 'package:construction_app/services/provider_helper_class.dart';
import 'package:construction_app/widgets/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class SupplierDetailScreen extends StatefulWidget {
  final Supplier supplier;
  final Color avatarBg;
  final Color avatarFg;

  const SupplierDetailScreen({
    super.key,
    required this.supplier,
    required this.avatarBg,
    required this.avatarFg,
  });

  @override
  State<SupplierDetailScreen> createState() => _SupplierDetailScreenState();
}

class _SupplierDetailScreenState extends State<SupplierDetailScreen> {
  String get _initials {
    final parts = widget.supplier.name.trim().split(RegExp(r'\s+'));
    if (parts.length >= 2) return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
    if (widget.supplier.name.length >= 2) return widget.supplier.name.substring(0, 2).toUpperCase();
    return widget.supplier.name.toUpperCase();
  }

  // double get _totalAmount =>
  //     _dummyMaterials.fold(0, (sum, m) => sum + m.amount);

  // String _fmt(double v) {
  //   if (v >= 10000000) return '₹${(v / 10000000).toStringAsFixed(2)}Cr';
  //   if (v >= 100000)   return '₹${(v / 100000).toStringAsFixed(2)}L';
  //   if (v >= 1000)     return '₹${(v / 1000).toStringAsFixed(1)}K';
  //   return '₹${v.toStringAsFixed(0)}';
  // }


  String _fmt(double v) {
  return '₹${v.toStringAsFixed(0)}';
}


    void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<CompanyProvider>().getSupplierDetail(supplierId:widget.supplier.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    Future<void> _call(String phone) async {
    await launchUrl(Uri(scheme: 'tel', path: phone));
  }
    return Scaffold(
      backgroundColor: AppColors.greyBg,
      body: Column(
        children: [
          _buildHeader(context),
          Expanded(
            child: Consumer<CompanyProvider>(
              builder: (context, provider, child) {
                if (provider.loaderState == LoaderState.loading) {
                  return const Center(child: CircularProgressIndicator());
                }
                final supplierDetail = provider.supplierDetail;
                return SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildContactCard(supplierDetail),
                      const SizedBox(height: 14),
                      _buildStatsRow(supplierDetail),
                      const SizedBox(height: 18),
                      _buildMaterialsSection(supplierDetail),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // ── Header ──────────────────────────────────────────────────────────────────
  Widget _buildHeader(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF1A1A2E), Color(0xFF16213E)],
        ),
      ),
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top + 12,
        bottom: 24,
        left: 16,
        right: 16,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Back row
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Row(
              children: [
                const Icon(Icons.arrow_back_ios_new,
                    size: 20, color: AppColors.greyLight),
                const SizedBox(width: 6),
                Text('Suppliers',
                    style: GoogleFonts.poppins(
                        fontSize: 18, color: AppColors.greyLight)),
              ],
            ),
          ),
          const SizedBox(height: 20),
          // Avatar + info
          Row(
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: widget.avatarBg,
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Center(
                  child: Text(_initials,
                      style: GoogleFonts.poppins(
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        color: widget.avatarFg,
                      )),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.supplier.name,
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: AppColors.white,
                        )),
                    const SizedBox(height: 5),
                    Row(
                      children: [
                        _badge('Supplier', AppColors.amberLight, AppColors.amberDark),
                        const SizedBox(width: 6),
                        //_badge('Active', const Color(0xFFDCFCE7), const Color(0xFF15803D)),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _badge(String label, Color bg, Color fg) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
        decoration:
            BoxDecoration(color: bg, borderRadius: BorderRadius.circular(8)),
        child: Text(label,
            style: GoogleFonts.poppins(
                fontSize: 11, fontWeight: FontWeight.w600, color: fg)),
      );

  // ── Contact Card ─────────────────────────────────────────────────────────────
  Widget _buildContactCard(SupplierDetailData? supplierDetail) {
    Future<void> _call(String phone) async {
    await launchUrl(Uri(scheme: 'tel', path: phone));
  }
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        children: [
          _infoRow(
            icon: Icons.phone_outlined,
            iconBg: AppColors.blueLight,
            iconColor: AppColors.blue,
            label: 'Contact Number',
            value: supplierDetail?.contactNo ?? '',
            onTap: () => _call(supplierDetail?.contactNo ?? ''),
          ),
          const Divider(height: 1, color: Color(0xFFF3F4F6)),
          _infoRow(
            icon: Icons.location_on_outlined,
            iconBg: AppColors.greenLight,
            iconColor: AppColors.green,
            label: 'Address',
            value: supplierDetail?.address ?? '',
            isLast: true,
          ),
        ],
      ),
    );
  }

  Widget _infoRow({
    required IconData icon,
    required Color iconBg,
    required Color iconColor,
    required String label,
    required String value,
    bool isLast = false,
    VoidCallback? onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: InkWell(
        onTap: onTap,
        child: Row(
          children: [
            Container(
              width: 38,
              height: 38,
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
                  const SizedBox(height: 2),
                  Text(value,
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: AppColors.dark,
                      )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ── Stats Row ────────────────────────────────────────────────────────────────
  Widget _buildStatsRow(SupplierDetailData? supplierDetail) {
    return Row(
      children: [
        Expanded(
          child: _statCard(
            icon: Icons.shopping_bag_outlined,
            iconBg: AppColors.blueLight,
            iconColor: AppColors.blue,
            label: 'Total Orders',
            value: supplierDetail?.totalOrders.toString() ?? '',
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _statCard(
            icon: Icons.currency_rupee,
            iconBg: AppColors.orangeLight,
            iconColor: AppColors.orange,
            label: 'Total Spent',
            value: _fmt(supplierDetail?.totalSpent.toDouble() ?? 0),
          ),
        ),
      ],
    );
  }

  Widget _statCard({
    required IconData icon,
    required Color iconBg,
    required Color iconColor,
    required String label,
    required String value,
  }) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
                color: iconBg, borderRadius: BorderRadius.circular(12)),
            child: Icon(icon, color: iconColor, size: 20),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label,
                    style: GoogleFonts.poppins(
                        fontSize: 11, color: AppColors.grey)),
                const SizedBox(height: 2),
                Text(value,
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: iconColor,
                    ),
                    overflow: TextOverflow.ellipsis),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ── Materials Section ────────────────────────────────────────────────────────
  Widget _buildMaterialsSection(SupplierDetailData? supplierDetail) {
    if (supplierDetail == null) return const SizedBox.shrink();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Materials Supplied',
            style: GoogleFonts.poppins(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: AppColors.dark,
            )),
        const SizedBox(height: 10),
        ...supplierDetail.materials.map((m) => _materialCard(m)),
      ],
    );
  }

  Widget _materialCard(MaterialDetails m) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: AppColors.amberLight,
              borderRadius: BorderRadius.circular(13),
            ),
            child: const Icon(Icons.inventory_2_outlined,
                color: AppColors.amberDark, size: 22),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(m.materialName,
                    style: GoogleFonts.poppins(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: AppColors.dark,
                    )),
                const SizedBox(height: 3),
                Text(m.siteName ?? '',
                    style: GoogleFonts.poppins(
                        fontSize: 11, color: AppColors.grey)),
                const SizedBox(height: 2),
                Text('${m.addedDate.day.toString().padLeft(2, '0')} ${_monthName(m.addedDate.month)} ${m.addedDate.year}',
                    style: GoogleFonts.poppins(
                        fontSize: 11, color: AppColors.greyLight)),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(_fmt(double.tryParse(m.amount) ?? 0),
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: AppColors.orange,
                  )),
              const SizedBox(height: 4),
              Text('${m.qty} ${m.unit}',
                  style: GoogleFonts.poppins(
                      fontSize: 11, color: AppColors.greyLight)),
            ],
          ),
        ],
      ),
    );
  }

  String _monthName(int month) {
    const months = ['Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'];
    return months[month - 1];
  }
}
