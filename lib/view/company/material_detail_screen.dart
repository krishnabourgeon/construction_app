
import 'dart:io';

import 'package:construction_app/provider/company_provider.dart';
import 'package:construction_app/services/provider_helper_class.dart';
import 'package:construction_app/view/company/widgets/material_expense_card.dart';
import 'package:construction_app/widgets/app_theme.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/material.dart' as pw;
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:share_plus/share_plus.dart';


class MaterialsDetailScreen extends StatefulWidget {
  final int siteId;
  const MaterialsDetailScreen({
    super.key,
    required this.siteId,
  });

  @override
  State<MaterialsDetailScreen> createState() => _MaterialsDetailScreenState();
}

class _MaterialsDetailScreenState extends State<MaterialsDetailScreen> {

    @override
void initState() {
  super.initState();

  WidgetsBinding.instance.addPostFrameCallback((_) {
    context.read<CompanyProvider>()
        .getTotalSpentDetail(siteId: widget.siteId);
  });
}
  @override
  Widget build(BuildContext context) {

    final provider = context.watch<CompanyProvider>();

    // ✅ HANDLE LOADING FIRST
    if (provider.loaderState == LoaderState.loading ||
        provider.totalSpentDetail == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    // ✅ HANDLE ERROR
    if (provider.loaderState == LoaderState.error) {
      return const Scaffold(
        body: Center(child: Text('Something went wrong')),
      );
    }

    // ✅ NOW SAFE
    final data = provider.totalSpentDetail!;
    final materials = data.materials;
    
    

    return Scaffold(
      backgroundColor: AppColors.greyBg,
      body: Column(
        children: [
          _buildHeader(context,data.siteName),
          
          // Summary Card
          Container(
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFFF59E0B), Color(0xFFD97706)],
              ),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Column(
              children: [
                Text('Total Materials Spent',
                    style: GoogleFonts.poppins(
                        fontSize: 18,
                        color: Colors.white.withOpacity(0.9),
                        fontWeight: FontWeight.w500)),
                const SizedBox(height: 6),
                Text(_formatAmt(data.totalMaterials.toDouble()),
                    style: GoogleFonts.poppins(
                      fontSize: 28,
                      fontWeight: FontWeight.w700,
                      color: AppColors.white,
                    )),
                const SizedBox(height: 4),
                // Text('${sampleMaterials.length} transactions',
                //     style: GoogleFonts.poppins(
                //         fontSize: 12, color: Colors.white.withOpacity(0.8))),
              ],
            ),
          ),

          

          // Materials Table
          Expanded(
            child: ListView.builder(
              itemCount: materials.length,
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              itemBuilder: (context, index) {
                final mat = materials[index];
                return MaterialExpenseCard(materials: mat);
              },
            ),
          ),
          // // ✅ FINAL CLEAN VERSION
          //   SingleChildScrollView(
          //     scrollDirection: Axis.horizontal,
          //     child: MaterialExpenseCard(materials: materials)),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          _generatePDFReport(context, data.siteName, data.materials, data.totalMaterials.toDouble());
        },
        //_generatePDFReport(context, data.siteName,data.materials),
        backgroundColor: AppColors.blue,
        icon: const Icon(Icons.picture_as_pdf),
        label: Text(
          'Export PDF',
          style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
        ),
      ),
    );
  }


  Future<void> _generatePDFReport(
  BuildContext context,
  String siteName,
  List materials,
  double totalAmount,
) async {
  final pdf = pw.Document();

  pdf.addPage(
    pw.MultiPage(
      pageFormat: PdfPageFormat.a4,
      margin: const pw.EdgeInsets.all(24),
      build: (pw.Context context) {
        return [
          // HEADER
          pw.Container(
            padding: const pw.EdgeInsets.all(16),
            decoration: pw.BoxDecoration(
              color: PdfColors.blue900,
              borderRadius: pw.BorderRadius.circular(10),
            ),
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text(
                  'Materials Expense Report',
                  style: pw.TextStyle(
                    color: PdfColors.white,
                    fontSize: 22,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
                pw.SizedBox(height: 5),
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

          // SUMMARY
          pw.Container(
            padding: const pw.EdgeInsets.all(14),
            decoration: pw.BoxDecoration(
              color: PdfColors.amber100,
              borderRadius: pw.BorderRadius.circular(10),
            ),
            child: pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Text(
                  'Total Materials Spent',
                  style: pw.TextStyle(
                    fontSize: 16,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
                pw.Text(
                  'Rs.${totalAmount.toStringAsFixed(0)}',
                  style: pw.TextStyle(
                    fontSize: 18,
                    fontWeight: pw.FontWeight.bold,
                    color: PdfColors.green800,
                  ),
                ),
              ],
            ),
          ),

          pw.SizedBox(height: 20),

          // TABLE
          pw.TableHelper.fromTextArray(
            border: pw.TableBorder.all(
              color: PdfColors.grey400,
            ),
            headerStyle: pw.TextStyle(
              fontWeight: pw.FontWeight.bold,
              color: PdfColors.white,
            ),
            headerDecoration: const pw.BoxDecoration(
              color: PdfColors.blueGrey800,
            ),
            cellAlignment: pw.Alignment.centerLeft,
            cellPadding: const pw.EdgeInsets.all(8),
            headers: [
              'Date',
              'Material',
              'Qty',
              'Amount',
            ],
            data: materials.map((item) {
              return [
                DateFormat('dd-MM-yyyy').format(item.addedDate),
                item.materialName ?? '',
                item.qty.toString(),
                'Rs.${item.amount}',
              ];
            }).toList(),
          ),
        ];
      },
    ),
  );

  // SAVE FILE
  final directory = await getTemporaryDirectory();

  final file = File(
    '${directory.path}/materials_report.pdf',
  );

  await file.writeAsBytes(await pdf.save());

  // SHARE TO WHATSAPP
  await Share.shareXFiles(
    [XFile(file.path)],
    text: 'Materials Expense Report - $siteName',
  );
}
  

  Widget _buildHeader(BuildContext context,String siteName) {
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
                Text('Site Report',
                    style: GoogleFonts.poppins(
                        fontSize: 15, color: AppColors.greyLight)),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.amberLight,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(Icons.inventory_2,
                    color: AppColors.amberDark, size: 25),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Materials Expense',
                        style: GoogleFonts.poppins(
                          fontSize: 17,
                          fontWeight: FontWeight.w700,
                          color: AppColors.white,
                        )),
                    Text(siteName,
                        style: GoogleFonts.poppins(
                            fontSize: 15, color: AppColors.grey)),
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
  if (v >= 10000000) return '₹${(v / 10000000).toStringAsFixed(1)}Cr';
  if (v >= 100000) return '₹${(v / 100000).toStringAsFixed(1)}L';
  if (v >= 1000) return '₹${(v / 1000).toStringAsFixed(1)}K';
  return '₹${v.toStringAsFixed(0)}';
}
}