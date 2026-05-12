import 'dart:io';

import 'package:construction_app/models/site_detail_report_model.dart';
import 'package:construction_app/view/company/labour_detail_screen.dart';
import 'package:construction_app/view/company/material_detail_screen.dart';
import 'package:construction_app/view/company/total_received-detail_screen.dart';
import 'package:construction_app/view/company/total_spent_detail_screen.dart';
import 'package:construction_app/view/company/widgets/progress_circle.dart';
import 'package:construction_app/widgets/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:share_plus/share_plus.dart';

class SiteDetailReportScreen extends StatelessWidget {
  final SiteDetailReportData site;

  const SiteDetailReportScreen({super.key, required this.site});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.greyBg,
      body: Column(
        children: [
          _buildHeader(context, site.siteName, 'Detailed Financial Report'),

          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Financial Summary
                  Container(
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFF3B82F6), Color(0xFF1D4ED8)],
                      ),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        _buildWhiteStat(
                          'Estimated Budget',
                          _formatAmt(site.financialSummary.estimatedBudget),
                        ),
                        const Divider(color: Colors.white24, height: 20),
                        _buildWhiteStat(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) =>
                                    TotalSpentDetailScreen(siteId: site.siteId),
                              ),
                            );
                          },
                          'Total Spent',
                          _formatAmt(site.financialSummary.totalSpent),
                        ),
                        const Divider(color: Colors.white24, height: 20),
                        _buildWhiteStat(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => TotalReceivedDetailScreen(
                                  siteId: site.siteId,
                                ),
                              ),
                            );
                          },
                          'Total Received',
                          _formatAmt(site.financialSummary.totalReceived),
                        ),
                        const Divider(color: Colors.white24, height: 20),
                        _buildWhiteStat(
                          'Balance',
                          _formatAmt(site.financialSummary.balance),
                          valueColor: site.financialSummary.balance >= 0
                              ? AppColors.greenLight
                              : AppColors.redLight,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Material & Labour Breakdown
                  Text(
                    'Expense Breakdown',
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: AppColors.dark,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) =>
                                    MaterialsDetailScreen(siteId: site.siteId),
                              ),
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.all(14),
                            decoration: BoxDecoration(
                              color: AppColors.amberLight,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: AppColors.amberDark,
                                width: 1.5,
                              ),
                            ),
                            child: Column(
                              children: [
                                const Icon(
                                  Icons.inventory_2,
                                  color: AppColors.amberDark,
                                  size: 28,
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  'Materials',
                                  style: GoogleFonts.poppins(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.amberDark,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  _formatAmt(
                                    site.expenseBreakdown.materials.amount,
                                  ),
                                  style: GoogleFonts.poppins(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.amberDark,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) =>
                                    LabourDetailScreen(siteId: site.siteId),
                              ),
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.all(14),
                            decoration: BoxDecoration(
                              color: AppColors.greenLight,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: AppColors.green,
                                width: 1.5,
                              ),
                            ),
                            child: Column(
                              children: [
                                const Icon(
                                  Icons.groups,
                                  color: AppColors.green,
                                  size: 28,
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  'Labour',
                                  style: GoogleFonts.poppins(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.green,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  _formatAmt(
                                    site.expenseBreakdown.labour.amount,
                                  ),
                                  style: GoogleFonts.poppins(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.green,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Stages Progress
                  Text(
                    'Project Progress',
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: AppColors.dark,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: AppColors.border, width: 1.5),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ProgressCircle(
                          label: 'Completed',
                          value: site.projectProgress.completed,
                          total: site.projectProgress.totalStages,
                          color: AppColors.green,
                        ),
                        ProgressCircle(
                          label: 'In Progress',
                          value: site.projectProgress.inProgress,
                          total: site.projectProgress.totalStages,
                          color: AppColors.orange,
                        ),
                        ProgressCircle(
                          label: 'Budget Used',
                          value: (site.projectProgress.budgetUsedPct)
                              .toInt(),
                          total: 100,
                          color: AppColors.blue,
                          suffix: '%',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _generatePDFReport(context, site),
        backgroundColor: AppColors.blue,
        icon: const Icon(Icons.picture_as_pdf),
        label: Text(
          'Export PDF',
          style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
        ),
      ),
    );
  }

  // Widget _buildWhiteStat(
  //   String label,
  //   String value, {
  //   Color? valueColor,
  //   VoidCallback? onTap,
  // }) {
  //   return InkWell(
  //     onTap: onTap,
  //     child: Row(
  //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //       children: [
  //         Text(
  //           label,
  //           style: GoogleFonts.poppins(
  //             fontSize: 18,
  //             color: Colors.white.withOpacity(0.9),
  //             fontWeight: FontWeight.w500,
  //           ),
  //         ),
  //         Text(
  //           value,
  //           style: GoogleFonts.poppins(
  //             fontSize: 18,
  //             fontWeight: FontWeight.w700,
  //             color: valueColor ?? AppColors.white,
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  Widget _buildWhiteStat(
  String label,
  String value, {
  Color? valueColor,
  VoidCallback? onTap,
}) {
  final bool isNavigable = onTap != null;

  return InkWell(
    onTap: onTap,
    borderRadius: BorderRadius.circular(8),
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Label + tap hint
          Row(
            children: [
              Text(
                label,
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  color: Colors.white.withOpacity(0.9),
                  fontWeight: FontWeight.w500,
                ),
              ),
              if (isNavigable) ...[
                const SizedBox(width: 6),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      Text(
                        'Details',
                        style: GoogleFonts.poppins(
                          fontSize: 10,
                          color: Colors.white70,
                        ),
                      ),
                      const SizedBox(width: 2),
                      const Icon(
                        Icons.arrow_forward_ios,
                        size: 9,
                        color: Colors.white70,
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),

          // Value
          Text(
            value,
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: valueColor ?? AppColors.white,
            ),
          ),
        ],
      ),
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
                const Icon(
                  Icons.arrow_back_ios_new,
                  size: 20,
                  color: AppColors.greyLight,
                ),
                const SizedBox(width: 5),
                Text(
                  'Back',
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    color: AppColors.greyLight,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Text(
            title,
            style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: AppColors.white,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            subtitle,
            style: GoogleFonts.poppins(fontSize: 15, color: AppColors.grey),
          ),
        ],
      ),
    );
  }

  String _formatAmt(double v) {
    // if (v >= 10000000) return '₹${(v / 10000000).toStringAsFixed(1)}Cr';
    // if (v >= 100000) return '₹${(v / 100000).toStringAsFixed(1)}L';
    // if (v >= 1000) return '₹${(v / 1000).toStringAsFixed(1)}K';
    return '₹${v.toStringAsFixed(0)}';
  }

  // ══════════════════════════════════════════════════════════════════════════════
  // PDF GENERATION
  // ══════════════════════════════════════════════════════════════════════════════

  // Future<void> _generatePDFReport(
  //     BuildContext context,  SiteDetailReportData site) async {
  //   final pdf = pw.Document();

  //   pdf.addPage(
  //     pw.Page(
  //       build: (pw.Context context) {
  //         return pw.Column(
  //           crossAxisAlignment: pw.CrossAxisAlignment.start,
  //           children: [
  //             pw.Text('Site Financial Report',
  //                 style:
  //                     pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold)),
  //             pw.SizedBox(height: 10),
  //             pw.Text(site.siteName, style: const pw.TextStyle(fontSize: 18)),
  //             pw.SizedBox(height: 20),
  //             pw.Divider(),
  //             pw.SizedBox(height: 10),
  //             _pdfRow('Estimated Budget', _formatAmt(site.financialSummary.estimatedBudget).replaceAll('₹', 'Rs.')),
  //             _pdfRow('Total Spent', _formatAmt(site.financialSummary.totalSpent).replaceAll('₹', 'Rs.')),
  //             _pdfRow('Total Received', _formatAmt(site.financialSummary.totalReceived).replaceAll('₹', 'Rs.')),
  //             _pdfRow('Balance', _formatAmt(site.financialSummary.balance).replaceAll('₹', 'Rs.')),
  //             pw.SizedBox(height: 20),
  //             pw.Divider(),
  //             pw.SizedBox(height: 10),
  //             pw.Text('Expense Breakdown',
  //                 style:
  //                     pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold)),
  //             pw.SizedBox(height: 10),
  //             _pdfRow('Materials', _formatAmt(site.expenseBreakdown.materials.amount).replaceAll('₹', 'Rs.')),
  //             _pdfRow('Labour', _formatAmt(site.expenseBreakdown.labour.amount).replaceAll('₹', 'Rs.')),
  //           ],
  //         );
  //       },
  //     ),
  //   );

  //   await Printing.layoutPdf(
  //       onLayout: (PdfPageFormat format) async => pdf.save());
  // }

  // pw.Widget _pdfRow(String label, String value) {
  //   return pw.Padding(
  //     padding: const pw.EdgeInsets.symmetric(vertical: 4),
  //     child: pw.Row(
  //       mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
  //       children: [
  //         pw.Text(label),
  //         pw.Text(value, style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
  //       ],
  //     ),
  //   );
  // }

  Future<void> _generatePDFReport(
    BuildContext context,
    SiteDetailReportData site,
  ) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text(
                'Site Financial Report',
                style: pw.TextStyle(
                  fontSize: 24,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
              pw.SizedBox(height: 10),

              pw.Text(site.siteName, style: const pw.TextStyle(fontSize: 18)),

              pw.SizedBox(height: 20),
              pw.Divider(),
              pw.SizedBox(height: 10),

              _pdfRow(
                'Estimated Budget',
                _formatAmt(
                  site.financialSummary.estimatedBudget,
                ).replaceAll('₹', 'Rs.'),
              ),

              _pdfRow(
                'Total Spent',
                _formatAmt(
                  site.financialSummary.totalSpent,
                ).replaceAll('₹', 'Rs.'),
              ),

              _pdfRow(
                'Total Received',
                _formatAmt(
                  site.financialSummary.totalReceived,
                ).replaceAll('₹', 'Rs.'),
              ),

              _pdfRow(
                'Balance',
                _formatAmt(
                  site.financialSummary.balance,
                ).replaceAll('₹', 'Rs.'),
              ),

              pw.SizedBox(height: 20),
              pw.Divider(),
              pw.SizedBox(height: 10),

              pw.Text(
                'Expense Breakdown',
                style: pw.TextStyle(
                  fontSize: 16,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),

              pw.SizedBox(height: 10),

              _pdfRow(
                'Materials',
                _formatAmt(
                  site.expenseBreakdown.materials.amount,
                ).replaceAll('₹', 'Rs.'),
              ),

              _pdfRow(
                'Labour',
                _formatAmt(
                  site.expenseBreakdown.labour.amount,
                ).replaceAll('₹', 'Rs.'),
              ),
            ],
          );
        },
      ),
    );

    // Save PDF file
    final output = await getTemporaryDirectory();

    final file = File("${output.path}/${site.siteName}_report.pdf");

    await file.writeAsBytes(await pdf.save());

    // Share PDF
    await Share.shareXFiles([
      XFile(file.path),
    ], text: 'Site Financial Report - ${site.siteName}');
  }


  pw.Widget _pdfRow(String label, String value) {
    return pw.Padding(
      padding: const pw.EdgeInsets.symmetric(vertical: 4),
      child: pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        children: [
          pw.Text(label),
          pw.Text(value, style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
        ],
      ),
    );
  }
}
