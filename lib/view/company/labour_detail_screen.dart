import 'package:construction_app/provider/company_provider.dart';
import 'package:construction_app/services/provider_helper_class.dart';
import 'package:construction_app/view/company/widgets/labour_expense_card.dart';
import 'package:construction_app/widgets/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:share_plus/share_plus.dart';

class LabourDetailScreen extends StatefulWidget {
  final int siteId;

  const LabourDetailScreen({super.key, required this.siteId});

  @override
  State<LabourDetailScreen> createState() => _LabourDetailScreenState();
}

class _LabourDetailScreenState extends State<LabourDetailScreen> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<CompanyProvider>().getTotalSpentDetail(
        siteId: widget.siteId,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<CompanyProvider>();

    //  HANDLE LOADING FIRST
    if (provider.loaderState == LoaderState.loading ||
        provider.totalSpentDetail == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    //  HANDLE ERROR
    if (provider.loaderState == LoaderState.error) {
      return const Scaffold(body: Center(child: Text('Something went wrong')));
    }

    //  NOW SAFE
    final data = provider.totalSpentDetail!;
    final labours = data.labours;

    return Scaffold(
      backgroundColor: AppColors.greyBg,
      body: Column(
        children: [
          _buildHeader(context, data.siteName),

          // Summary Card
          Container(
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF10B981), Color(0xFF059669)],
              ),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Column(
              children: [
                Text(
                  'Total Labour Paid',
                  style: GoogleFonts.poppins(
                    fontSize: 15,
                    color: Colors.white.withOpacity(0.9),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  _formatAmt(data.totalLabour.toDouble()),
                  style: GoogleFonts.poppins(
                    fontSize: 28,
                    fontWeight: FontWeight.w700,
                    color: AppColors.white,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '${labours.length} payments',
                  style: GoogleFonts.poppins(
                    fontSize: 15,
                    color: Colors.white.withOpacity(0.8),
                  ),
                ),
              ],
            ),
          ),

          // Labour List
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: labours.length,
              itemBuilder: (_, i) {
                final item = labours[i];
                return LabourExpenseCard(labour: item);
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          await _generateLabourPDFReport(
            context,
            data.siteName,
            labours,
            data.totalLabour.toDouble(),
          );
        },
        backgroundColor: AppColors.green,
        icon: const Icon(Icons.picture_as_pdf),
        label: Text(
          'Export PDF',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }


  Future<void> _generateLabourPDFReport(
  BuildContext context,
  String siteName,
  List labours,
  double totalAmount,
) async {
  final pdf = pw.Document();

  pdf.addPage(
    pw.MultiPage(
      pageFormat: PdfPageFormat.a4.landscape,
      margin: const pw.EdgeInsets.all(20),

      build: (pw.Context context) {
        return [

          /// HEADER
          pw.Container(
            padding: const pw.EdgeInsets.all(16),
            decoration: pw.BoxDecoration(
              color: PdfColors.green800,
              borderRadius: pw.BorderRadius.circular(10),
            ),
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text(
                  'Labour Expense Report',
                  style: pw.TextStyle(
                    color: PdfColors.white,
                    fontSize: 24,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),

                pw.SizedBox(height: 6),

                pw.Text(
                  siteName,
                  style: const pw.TextStyle(
                    color: PdfColors.white,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),

          pw.SizedBox(height: 20),

          /// SUMMARY
          pw.Container(
            padding: const pw.EdgeInsets.all(14),
            decoration: pw.BoxDecoration(
              color: PdfColors.green100,
              borderRadius: pw.BorderRadius.circular(10),
            ),
            child: pw.Row(
              mainAxisAlignment:
                  pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Text(
                  'Total Labour Paid',
                  style: pw.TextStyle(
                    fontWeight: pw.FontWeight.bold,
                    fontSize: 16,
                  ),
                ),

                pw.Text(
                  'Rs.${totalAmount.toStringAsFixed(0)}',
                  style: pw.TextStyle(
                    fontWeight: pw.FontWeight.bold,
                    fontSize: 18,
                    color: PdfColors.green900,
                  ),
                ),
              ],
            ),
          ),

          pw.SizedBox(height: 20),

          /// TABLE
          pw.TableHelper.fromTextArray(
            border: pw.TableBorder.all(
              color: PdfColors.grey400,
              width: 1,
            ),

            headerDecoration: const pw.BoxDecoration(
              color: PdfColors.green800,
            ),

            headerStyle: pw.TextStyle(
              color: PdfColors.white,
              fontWeight: pw.FontWeight.bold,
              fontSize: 12,
            ),

            cellStyle: const pw.TextStyle(
              fontSize: 10,
            ),

            cellPadding: const pw.EdgeInsets.all(8),

            headers: [
              'Stage',
              'Substage',
              'Labours',
              'Days',
              'Amount',
              'Date',
              'Remarks',
            ],

            data: labours.map((item) {
              return [
                item.stageName ?? '',
                item.substageName ?? '',
                item.noOfLabours.toString(),
                item.noOfDays.toString(),
                'Rs.${item.amount}',
                item.addedDate != null
                    ? DateFormat('dd MMM yyyy').format(
                        DateTime.tryParse(
                              item.addedDate.toString(),
                            ) ??
                            DateTime.now(),
                      )
                    : '',
                item.remarks ?? '',
              ];
            }).toList(),
          ),
        ];
      },
    ),
  );

  /// SAVE PDF
  final directory = await getTemporaryDirectory();

  final file = File(
    '${directory.path}/labour_report.pdf',
  );

  await file.writeAsBytes(await pdf.save());

  /// SHARE
  await Share.shareXFiles(
    [XFile(file.path)],
    text: 'Labour Expense Report - $siteName',
  );
}

  Widget _buildHeader(BuildContext context, String siteName) {
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
                  'Site Report',
                  style: GoogleFonts.poppins(
                    fontSize: 15,
                    color: AppColors.greyLight,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.greenLight,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(
                  Icons.groups,
                  color: AppColors.green,
                  size: 20,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Labour Payments',
                      style: GoogleFonts.poppins(
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                        color: AppColors.white,
                      ),
                    ),
                    Text(
                      siteName,
                      style: GoogleFonts.poppins(
                        fontSize: 15,
                        color: AppColors.grey,
                      ),
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
}

String _formatAmt(double v) {
  // if (v >= 10000000) return '₹${(v / 10000000).toStringAsFixed(1)}Cr';
  // if (v >= 100000) return '₹${(v / 100000).toStringAsFixed(1)}L';
  // if (v >= 1000) return '₹${(v / 1000).toStringAsFixed(1)}K';
  return '₹${v.toStringAsFixed(0)}';
}
