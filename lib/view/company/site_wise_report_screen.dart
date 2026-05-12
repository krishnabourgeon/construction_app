import 'package:construction_app/models/site_detail_report_model.dart';
import 'package:construction_app/models/sitesbycompanies.dart';
import 'package:construction_app/provider/company_provider.dart';
import 'package:construction_app/services/provider_helper_class.dart';
import 'package:construction_app/services/shared_preference_helper.dart';
import 'package:construction_app/view/company/site_detail_report_screen.dart';
import 'package:construction_app/view/company/widgets/mini_stat.dart';
import 'package:construction_app/widgets/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class SiteWiseReportsScreen extends StatefulWidget {
  final SitesbyCompany? site;
  SiteWiseReportsScreen({super.key, this.site});

  @override
  State<SiteWiseReportsScreen> createState() => _SiteWiseReportsScreenState();
}

class _SiteWiseReportsScreenState extends State<SiteWiseReportsScreen> {
  SitesbyCompany? selectedSite;

  @override
  void initState() {
    super.initState();
    selectedSite = widget.site;
    
    Future.microtask(() async {
      final provider = context.read<CompanyProvider>();
      
      // Ensure sites are loaded
      if (provider.sitesList.isEmpty) {
        final companyId = await SharedPreferenceHelper.getCompanyId();
        await provider.sitesbycompanies(companyId: companyId);
      }
      
      // If no site was passed, use the first one from the list
      if (selectedSite == null && provider.sitesList.isNotEmpty) {
        setState(() {
          selectedSite = provider.sitesList.first;
        });
      }
      
      if (selectedSite != null) {
        provider.getSiteDetailReport(siteId: selectedSite!.id);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.greyBg,
      body: Column(
        children: [
          _buildHeader(context, 'Site-wise Reports', 'Financial breakdown by site'),
          
          // Site Selector Dropdown
          Consumer<CompanyProvider>(
            builder: (context, provider, child) {
              final sites = provider.sitesList;
              if (sites.isEmpty) return const SizedBox.shrink();
              
              return Container(
                color: AppColors.white,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: DropdownButtonFormField<SitesbyCompany>(
                  value: selectedSite,
                  decoration: InputDecoration(
                    labelText: 'Select Site',
                    labelStyle: GoogleFonts.poppins(fontSize: 14),
                    filled: true,
                    fillColor: AppColors.greyFill,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: AppColors.border),
                    ),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  ),
                  items: sites.map((site) {
                    return DropdownMenuItem(
                      value: site,
                      child: Text(site.sitename, style: GoogleFonts.poppins(fontSize: 14)),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedSite = value;
                    });
                    if (value != null) {
                      context.read<CompanyProvider>().getSiteDetailReport(siteId: value.id);
                    }
                  },
                ),
              );
            },
          ),

          Expanded(
            child: Consumer<CompanyProvider>(
              builder: (context, provider, child) {
                final reportData = provider.siteDetailReport;
                
                if (provider.loaderState == LoaderState.loading) {
                  return const Center(child: CircularProgressIndicator());
                }
                
                if (selectedSite == null) {
                  return const Center(child: Text("Please select a site to view report"));
                }
                
                if (reportData == null) {
                  return const Center(child: Text("No report data available for this site"));
                }
                
                return SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: _SiteReportCard(
                      site: reportData,
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => SiteDetailReportScreen(site: reportData),
                        ),
                      ),
                    ),
                  ),
                );
              }
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context, String title, String subtitle) {
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
        bottom: 16,
        left: 16,
        right: 16,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Row(
              children: [
                const Icon(Icons.arrow_back_ios_new,
                    size: 20, color: AppColors.greyLight),
                const SizedBox(width: 5),
                Text('Back',
                    style: GoogleFonts.poppins(
                        fontSize: 18, color: AppColors.greyLight)),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Text(title,
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: AppColors.white,
              )),
          const SizedBox(height: 2),
          Text(subtitle,
              style: GoogleFonts.poppins(fontSize: 15, color: AppColors.grey)),
        ],
      ),
    );
  }
}

class _SiteReportCard extends StatelessWidget {
  final SiteDetailReportData site;
  final VoidCallback onTap;
 
  const _SiteReportCard({required this.site, required this.onTap});
 
  @override
  Widget build(BuildContext context) {
    final estimated = site.financialSummary.estimatedBudget;
    final spent = site.financialSummary.totalSpent;
    final received = site.financialSummary.totalReceived;
    final balance = site.financialSummary.balance;
    final spentPercent = (estimated > 0) ? (spent / estimated * 100).clamp(0, 100) : 0.0;
 
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: AppColors.border, width: 1.5),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(site.siteName,
                                style: GoogleFonts.poppins(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.dark,
                                )),
                            const SizedBox(height: 4),
                          ],
                        ),
                      ),
                      const Icon(Icons.arrow_forward_ios, size: 24),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppColors.greyBg,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: MiniStat(
                            label: 'Estimated',
                            value: _formatAmt(estimated),
                            color: AppColors.blue,
                          ),
                        ),
                        Expanded(
                          child: MiniStat(
                            label: 'Spent',
                            value: _formatAmt(spent),
                            color: AppColors.orange,
                          ),
                        ),
                        Expanded(
                          child: MiniStat(
                            label: 'Received',
                            value: _formatAmt(received),
                            color: AppColors.green,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text('Balance: ',
                              style: GoogleFonts.poppins(
                                  fontSize: 15, color: AppColors.dark)),
                          Text(_formatAmt(balance),
                              style: GoogleFonts.poppins(
                                fontSize: 17,
                                fontWeight: FontWeight.w700,
                                color: balance >= 0
                                    ? AppColors.green
                                    : AppColors.red,
                              )),
                        ],
                      ),
                      Text('${site.projectProgress.completed}/${site.projectProgress.totalStages} stages done',
                          style: GoogleFonts.poppins(
                              fontSize: 15, color: AppColors.greyLight)),
                    ],
                  ),
                  const SizedBox(height: 6),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: LinearProgressIndicator(
                      value: spentPercent / 100,
                      backgroundColor: AppColors.greyBg,
                      valueColor: AlwaysStoppedAnimation(
                        spentPercent > 100
                            ? AppColors.red
                            : spentPercent > 90
                                ? AppColors.orange
                                : AppColors.green,
                      ),
                      minHeight: 6,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text('${spentPercent.toStringAsFixed(1)}% of budget utilized',
                      style: GoogleFonts.poppins(
                          fontSize: 14, color: AppColors.greyLight)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatAmt(double v) {
    if (v >= 10000000) return '₹${(v / 10000000).toStringAsFixed(1)}Cr';
    if (v >= 100000) return '₹${(v / 100000).toStringAsFixed(1)}L';
    if (v >= 1000) return '₹${(v / 1000).toStringAsFixed(1)}K';
    return '₹${v.toStringAsFixed(0)}';
  }
}