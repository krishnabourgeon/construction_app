import 'dart:io';

import 'package:construction_app/models/total_recevied_detail_model.dart';
import 'package:construction_app/provider/company_provider.dart';
import 'package:construction_app/services/provider_helper_class.dart';
import 'package:construction_app/view/company/material_detail_screen.dart';
import 'package:construction_app/view/company/widgets/receipt_card.dart';
import 'package:construction_app/widgets/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class TotalReceivedDetailScreen extends StatefulWidget {
  final int siteId;

  const TotalReceivedDetailScreen({super.key, required this.siteId});

  @override
  State<TotalReceivedDetailScreen> createState() =>
      _TotalReceivedDetailScreenState();
}

class _TotalReceivedDetailScreenState extends State<TotalReceivedDetailScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<CompanyProvider>().getTotalReceivedDetail(
        siteId: widget.siteId,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<CompanyProvider>();

    //  HANDLE LOADING FIRST
    if (provider.loaderState == LoaderState.loading ||
        provider.totalReceived == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    //  HANDLE ERROR
    if (provider.loaderState == LoaderState.error) {
      return const Scaffold(body: Center(child: Text('Something went wrong')));
    }

    //  NOW SAFE
    final data = provider.totalReceived!;

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
                  'Total Amount Received',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    color: Colors.white.withOpacity(0.9),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  _formatAmt(data.totalReceived.toDouble()),
                  style: GoogleFonts.poppins(
                    fontSize: 28,
                    fontWeight: FontWeight.w700,
                    color: AppColors.white,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '${data.payments.length} receipts',
                  style: GoogleFonts.poppins(
                    fontSize: 13,
                    color: Colors.white.withOpacity(0.8),
                  ),
                ),
              ],
            ),
          ),

          // Receipts List
          // Expanded(
          //   child: ListView.builder(
          //     padding: const EdgeInsets.all(16),
          //     itemCount: data.payments.length,
          //     itemBuilder: (_, i) {
          //       final receipt = data.payments[i];
          //       return ReceiptCard(payments: data.payments);
          //     },
          //   ),
          // ),
          // Padding(
          //   padding: const EdgeInsets.all(16),
          //   child: ReceiptCard(
          //     payments: data.payments,
          //   ),
          // ),

          Expanded(
            child: ListView.builder(
              itemCount: data.payments.length,
              padding: const EdgeInsets.all(16),
              itemBuilder: (_, i) {
                final receipt = data.payments[i];
                return ReceiptCard(receipt: receipt);
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          final provider = context.read<CompanyProvider>();

          if (provider.totalReceived == null) return;

          await _generateTotalReceivedPDFReport(
            context,
            provider.totalReceived!.siteName,
            provider.totalReceived!.payments,
            provider.totalReceived!.totalReceived.toDouble(),
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


  Future<void> _generateTotalReceivedPDFReport(
  BuildContext context,
  String siteName,
  List<Payment> payments,
  double totalReceived,
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
                  'Total Received Report',
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

          /// SUMMARY CARD
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
                  'Total Amount Received',
                  style: pw.TextStyle(
                    fontWeight: pw.FontWeight.bold,
                    fontSize: 16,
                  ),
                ),

                pw.Text(
                  'Rs.${totalReceived.toStringAsFixed(0)}',
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
              'SL No',
              'Date',
              // 'Received From',
              'Payment Mode',
              // 'Reference No',
              'Amount',
            ],

            data: List.generate(payments.length, (index) {
              final item = payments[index];

              return [
                '${index + 1}',

                item.paymentDate != null
                    ? DateFormat('dd MMM yyyy')
                        .format(item.paymentDate)
                        : "N/A",

                //item.receivedFrom ?? '-',

                item.paymentMode ?? '-',

                //item.referenceNo ?? '-',

                'Rs.${item.amount}',
              ];
            }),
          ),
        ];
      },
    ),
  );

  /// SAVE PDF
  final directory = await getTemporaryDirectory();

  final file = File(
    '${directory.path}/total_received_report.pdf',
  );

  await file.writeAsBytes(await pdf.save());

  /// SHARE PDF
  await Share.shareXFiles(
    [XFile(file.path)],
    text: 'Total Received Report - $siteName',
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
                  Icons.trending_up,
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
                      'Total Received',
                      style: GoogleFonts.poppins(
                        fontSize: 18,
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

  String _formatAmt(double v) {
    // if (v >= 10000000) return '₹${(v / 10000000).toStringAsFixed(1)}Cr';
    // if (v >= 100000) return '₹${(v / 100000).toStringAsFixed(1)}L';
    // if (v >= 1000) return '₹${(v / 1000).toStringAsFixed(1)}K';
    return '₹${v.toStringAsFixed(0)}';
  }
}
