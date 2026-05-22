import 'package:construction_app/models/sitesbycompanies.dart';
import 'package:construction_app/models/stage_wise_report_model.dart';
import 'package:construction_app/provider/company_provider.dart';
import 'package:construction_app/services/provider_helper_class.dart';
import 'package:construction_app/services/shared_preference_helper.dart';
import 'package:construction_app/view/company/widgets/site_card.dart';
import 'package:construction_app/widgets/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:share_plus/share_plus.dart';

class StageWiseReportsScreen extends StatefulWidget {
  final SitesbyCompany? sites;
  const StageWiseReportsScreen({super.key, this.sites});

  @override
  State<StageWiseReportsScreen> createState() => _StageWiseReportsScreenState();
}

class _StageWiseReportsScreenState extends State<StageWiseReportsScreen> {
  SitesbyCompany? selectedSite;

    @override
  void initState() {
    super.initState();
    selectedSite = widget.sites;
    
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
        provider.getStageWiseReport(siteId: selectedSite!.id);
      }
    });
  }
  @override
  Widget build(BuildContext context) {
 
    return Scaffold(
      backgroundColor: AppColors.greyBg,
      body: Column(
        children: [
          _buildHeader(context, 'Stage-wise Reports',
              'Materials & labour breakdown'),
          
          // Site selector
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
                    labelStyle: GoogleFonts.poppins(fontSize: 16),
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
                      context.read<CompanyProvider>().getStageWiseReport(siteId: value.id);
                    }
                  },
                ),
              );
            },
          ),

          Expanded(
            child: Consumer<CompanyProvider>(
              builder: (context, provider, child) {
                final reports = provider.stageWiseReport;
                
                if (provider.loaderState == LoaderState.loading) {
                  return const Center(child: CircularProgressIndicator());
                }
                
                if (selectedSite == null) {
                  return const Center(child: Text("Please select a site to view reports"));
                }
                
                if (reports.isEmpty) {
                  return const Center(child: Text("No stage-wise reports available for this site"));
                }
                
                return ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: reports.length,
                  itemBuilder: (context, index) {
                    return _StageReportCard(report: reports[index]);
                  },
                );
              }
            ),
          ),
        ],
      ),
      floatingActionButton: Consumer<CompanyProvider>(
        builder: (context, provider, child) {
          return FloatingActionButton.extended(
            onPressed: () async {
              if (selectedSite == null) return;
              await _generateStageWisePDFReport(
                context,
                selectedSite!.sitename,
                provider.stageWiseReport,
                provider.stageWiseReport.first.totalSpent.toDouble(),
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
          );
        },
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
              Text('Reports',
                  style: GoogleFonts.poppins(
                      fontSize: 15, color: AppColors.greyLight)),
            ],
          ),
        ),
        const SizedBox(height: 10),
        Text(title,
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: AppColors.white,
            )),
        const SizedBox(height: 2),
        Text(subtitle,
            style: GoogleFonts.poppins(fontSize: 13, color: AppColors.grey)),
      ],
    ),
  );
}


  Future<void> _generateStageWisePDFReport(
  BuildContext context,
  String siteName,
  List<StageWiseReport> reports,
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
                  'Stage-wise Expense Report',
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
                  'Total Expense',
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
              'Stage Name',
              'Site Name',
              'Status',
              'Total Spent',
              'Materials',
              'Labours',
            ],

            data: reports.map((item) {
              return [
                item.stageName,
                item.siteName,
                getStatusValue(item.status),
                'Rs.${item.totalSpent}',
                'Rs.${item.materials.amount}',
                'Rs.${item.labour.amount}'
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
    '${directory.path}/stage_wise_report.pdf',
  );

  await file.writeAsBytes(await pdf.save());

  /// SHARE
  await Share.shareXFiles(
    [XFile(file.path)],
    text: 'Stage-wise Expense Report - $siteName',
  );
}

}

class _StageReportCard extends StatelessWidget {
  final StageWiseReport report;

  const _StageReportCard({required this.report});

  @override
  Widget build(BuildContext context) {
    final totalSpent = report.totalSpent.toDouble();
    final materialSpent = double.tryParse(report.materials.amount) ?? 0.0;
    final labourSpent = double.tryParse(report.labour.amount) ?? 0.0;
    final materialPercent = report.materials.percentage.toDouble();
    final labourPercent = report.labour.percentage.toDouble();

    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.border, width: 1.5),
      ),
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(report.stageName,
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: AppColors.dark,
                        )),
                    const SizedBox(height: 2),
                    Text(report.siteName,
                        style: GoogleFonts.poppins(
                            fontSize: 13, color: AppColors.grey)),
                  ],
                ),
              ),
              StatusBadge(status: getStatusValue(report.status)),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFFFEF9C3),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: const Color(0xFFFDE047)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Total Spent: ',
                    style: GoogleFonts.poppins(
                        fontSize: 12, color: const Color(0xFF854D0E))),
                Text(_formatAmt(totalSpent),
                    style: GoogleFonts.poppins(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF854D0E),
                    )),
              ],
            ),
          ),
          const SizedBox(height: 12),
          
          // Materials
          Row(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: AppColors.amberLight,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.inventory_2,
                    size: 16, color: AppColors.amberDark),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Materials (${report.materials.count})',
                            style: GoogleFonts.poppins(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: AppColors.dark)),
                        Text(_formatAmt(materialSpent),
                            style: GoogleFonts.poppins(
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                              color: AppColors.orange,
                            )),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Expanded(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(4),
                            child: LinearProgressIndicator(
                              value: materialPercent / 100,
                              backgroundColor: AppColors.greyBg,
                              valueColor: const AlwaysStoppedAnimation(
                                  AppColors.amberDark),
                              minHeight: 5,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text('${materialPercent.toStringAsFixed(0)}%',
                            style: GoogleFonts.poppins(
                                fontSize: 10, color: AppColors.grey)),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          
          // Labour
          Row(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: AppColors.greenLight,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.groups,
                    size: 16, color: AppColors.green),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Labour (${report.labour.count})',
                            style: GoogleFonts.poppins(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: AppColors.dark)),
                        Text(_formatAmt(labourSpent),
                            style: GoogleFonts.poppins(
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                              color: AppColors.orange,
                            )),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Expanded(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(4),
                            child: LinearProgressIndicator(
                              value: labourPercent / 100,
                              backgroundColor: AppColors.greyBg,
                              valueColor: const AlwaysStoppedAnimation(
                                  AppColors.green),
                              minHeight: 5,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text('${labourPercent.toStringAsFixed(0)}%',
                            style: GoogleFonts.poppins(
                                fontSize: 10, color: AppColors.grey)),
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



// class _StageReportCard extends StatelessWidget {
//   final List<StageWiseReport> reports;

//   const _StageReportCard({
//     super.key,
//     required this.reports,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(12),
//       child: SingleChildScrollView(
//         scrollDirection: Axis.horizontal,
//         physics: const BouncingScrollPhysics(),
//         child: Container(
//           decoration: BoxDecoration(
//             color: AppColors.white,
//             borderRadius: BorderRadius.circular(12),
//             border: Border.all(
//               color: Colors.grey.shade300,
//               width: 1,
//             ),
//           ),
//           child: DataTable(
//             headingRowColor: MaterialStateProperty.all(
//               const Color(0xFF16213E),
//             ),

//             headingTextStyle: GoogleFonts.poppins(
//               color: Colors.white,
//               fontWeight: FontWeight.w600,
//               fontSize: 13,
//             ),

//             dataTextStyle: GoogleFonts.poppins(
//               fontSize: 12,
//               color: Colors.black87,
//             ),

//             headingRowHeight: 55,
//             dataRowHeight: 60,
//             columnSpacing: 28,
//             horizontalMargin: 16,
//             dividerThickness: 1,

//             border: TableBorder(
//               top: BorderSide(
//                 color: Colors.grey.shade300,
//               ),
//               bottom: BorderSide(
//                 color: Colors.grey.shade300,
//               ),
//               left: BorderSide(
//                 color: Colors.grey.shade300,
//               ),
//               right: BorderSide(
//                 color: Colors.grey.shade300,
//               ),

//               horizontalInside: BorderSide(
//                 color: Colors.grey.shade300,
//                 width: 1,
//               ),

//               verticalInside: BorderSide(
//                 color: Colors.grey.shade300,
//                 width: 1,
//               ),
//             ),

//             columns: const [
//               DataColumn(
//                 label: Text('Stage Name'),
//               ),
//               DataColumn(
//                 label: Text('Site Name'),
//               ),
//               DataColumn(
//                 label: Text('Status'),
//               ),
//               DataColumn(
//                 label: Text('Total Spent'),
//               ),
//               DataColumn(
//                 label: Text('Materials'),
//               ),
//               DataColumn(
//                 label: Text('Labour'),
//               ),
//             ],

//             rows: reports.map((report) {
//               final totalSpent = report.totalSpent.toDouble();

//               final materialSpent =
//                   double.tryParse(report.materials.amount) ?? 0.0;

//               final labourSpent =
//                   double.tryParse(report.labour.amount) ?? 0.0;

//               return DataRow(
//                 cells: [
//                   DataCell(
//                     Text(report.stageName),
//                   ),

//                   DataCell(
//                     Text(report.siteName),
//                   ),

//                   DataCell(
//                     Container(
//                       padding: const EdgeInsets.symmetric(
//                         horizontal: 10,
//                         vertical: 5,
//                       ),
//                       decoration: BoxDecoration(
//                         color: report.status == 2
//                             ? Colors.green.shade100
//                             : report.status == 1
//                                 ? Colors.orange.shade100
//                                 : Colors.red.shade100,
//                         borderRadius: BorderRadius.circular(20),
//                       ),
//                       child: Text(
//                         getStatusValue(report.status),
//                         style: GoogleFonts.poppins(
//                           fontSize: 11,
//                           fontWeight: FontWeight.w500,
//                           color: report.status == 2
//                               ? Colors.green.shade800
//                               : report.status == 1
//                                   ? Colors.orange.shade800
//                                   : Colors.red.shade800,
//                         ),
//                       ),
//                     ),
//                   ),

//                   DataCell(
//                     Text(_formatAmt(totalSpent)),
//                   ),

//                   DataCell(
//                     Text(_formatAmt(materialSpent)),
//                   ),

//                   DataCell(
//                     Text(_formatAmt(labourSpent)),
//                   ),
//                 ],
//               );
//             }).toList(),
//           ),
//         ),
//       ),
//     );
//   }

  String getStatusValue(int status) {
    switch (status) {
      case 0:
        return 'Pending';

      case 1:
        return 'Progress';

      case 2:
        return 'Completed';

      default:
        return 'Pending';
    }
  }

  String _formatAmt(double v) {
    // if (v >= 10000000) {
    //   return '₹${(v / 10000000).toStringAsFixed(1)}Cr';
    // }

    // if (v >= 100000) {
    //   return '₹${(v / 100000).toStringAsFixed(1)}L';
    // }

    // if (v >= 1000) {
    //   return '₹${(v / 1000).toStringAsFixed(1)}K';
    // }

    return '₹${v.toStringAsFixed(0)}';
  }
}



//   Widget _buildHeader(BuildContext context, String title, String subtitle) {
//   return Container(
//     decoration: const BoxDecoration(
//       gradient: LinearGradient(
//         begin: Alignment.topLeft,
//         end: Alignment.bottomRight,
//         colors: [Color(0xFF1A1A2E), Color(0xFF16213E)],
//       ),
//     ),
//     padding: EdgeInsets.only(
//       top: MediaQuery.of(context).padding.top + 12,
//       bottom: 16,
//       left: 16,
//       right: 16,
//     ),
//     child: Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         GestureDetector(
//           onTap: () => Navigator.pop(context),
//           child: Row(
//             children: [
//               const Icon(Icons.arrow_back_ios_new,
//                   size: 14, color: AppColors.greyLight),
//               const SizedBox(width: 5),
//               Text('Reports',
//                   style: GoogleFonts.poppins(
//                       fontSize: 11, color: AppColors.greyLight)),
//             ],
//           ),
//         ),
//         const SizedBox(height: 10),
//         Text(title,
//             style: GoogleFonts.poppins(
//               fontSize: 18,
//               fontWeight: FontWeight.w700,
//               color: AppColors.white,
//             )),
//         const SizedBox(height: 2),
//         Text(subtitle,
//             style: GoogleFonts.poppins(fontSize: 11, color: AppColors.grey)),
//       ],
//     ),
//   );
// }




String getStatusValue(int status) {
  switch (status) {
    case 0:
      return 'Pending';
    case 1:
      return 'Progress';
    case 2:
      return 'Completed';
    default:
      return 'Pending';
  }
}



// String _formatAmt(double v) {
//   if (v >= 10000000) return '₹${(v / 10000000).toStringAsFixed(1)}Cr';
//   if (v >= 100000) return '₹${(v / 100000).toStringAsFixed(1)}L';
//   if (v >= 1000) return '₹${(v / 1000).toStringAsFixed(1)}K';
//   return '₹${v.toStringAsFixed(0)}';
// }


