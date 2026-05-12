import 'package:construction_app/provider/company_provider.dart';
import 'package:construction_app/services/provider_helper_class.dart';
import 'package:construction_app/view/company/labour_detail_screen.dart';
import 'package:construction_app/view/company/material_detail_screen.dart';
import 'package:construction_app/widgets/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class TotalSpentDetailScreen extends StatefulWidget {
  final int siteId;


  const TotalSpentDetailScreen({
    super.key,
    required this.siteId,
  });

  @override
  State<TotalSpentDetailScreen> createState() => _TotalSpentDetailScreenState();
}

class _TotalSpentDetailScreenState extends State<TotalSpentDetailScreen> {

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

    return Scaffold(
      backgroundColor: AppColors.greyBg,
      body: Column(
        children: [
          _buildHeader(context,provider.totalSpentDetail!.siteName),
          
          // Summary Card
          Container(
                margin: const EdgeInsets.all(16),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFFEF4444), Color(0xFFDC2626)],
                  ),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Column(
                  children: [
                    Text('Total Amount Spent',
                        style: GoogleFonts.poppins(
                            fontSize: 18,
                            color: Colors.white.withOpacity(0.9),
                            fontWeight: FontWeight.w500)),
                    const SizedBox(height: 6),
                    Text(_formatAmt(provider.totalSpentDetail!.totalSpent.toDouble()),
                        style: GoogleFonts.poppins(
                          fontSize: 28,
                          fontWeight: FontWeight.w700,
                          color: AppColors.white,
                        )),
                  ],
                ),
          ),

          // Breakdown Cards
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: [
                Text('Expense Breakdown',
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: AppColors.dark,
                    )),
                const SizedBox(height: 12),

                // Materials Card
                GestureDetector(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => MaterialsDetailScreen(
                        siteId: widget.siteId,
                      ),
                    ),
                  ),
                  child: Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: AppColors.border, width: 1.5),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(
                            color: AppColors.amberLight,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Icon(Icons.inventory_2,
                              color: AppColors.amberDark, size: 24),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Materials',
                                  style: GoogleFonts.poppins(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.dark)),
                              const SizedBox(height: 4),
                              // Row(
                              //   children: [
                              //     Expanded(
                              //       child: ClipRRect(
                              //         borderRadius: BorderRadius.circular(4),
                              //         child: LinearProgressIndicator(
                              //           value: m / 100,
                              //           backgroundColor: AppColors.greyBg,
                              //           valueColor: const AlwaysStoppedAnimation(
                              //               AppColors.amberDark),
                              //           minHeight: 5,
                              //         ),
                              //       ),
                              //     ),
                              //     const SizedBox(width: 8),
                              //     Text('${materialPercent.toStringAsFixed(0)}%',
                              //         style: GoogleFonts.poppins(
                              //             fontSize: 10, color: AppColors.grey)),
                              //   ],
                              // ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(_formatAmt(provider.totalSpentDetail!.totalMaterials.toDouble()),
                                style: GoogleFonts.poppins(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.orange,
                                )),
                                SizedBox(height: 10,),
                            const Icon(Icons.arrow_forward_ios,
                                size: 14, color: AppColors.greyLight),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 12),

                // Labour Card
                GestureDetector(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => LabourDetailScreen(
                        siteId: widget.siteId,
                      ),
                    ),
                  ),
                  child: Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: AppColors.border, width: 1.5),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(
                            color: AppColors.greenLight,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Icon(Icons.groups,
                              color: AppColors.green, size: 24),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Labour',
                                  style: GoogleFonts.poppins(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.dark)),
                              const SizedBox(height: 4),
                              // Row(
                              //   children: [
                              //     Expanded(
                              //       child: ClipRRect(
                              //         borderRadius: BorderRadius.circular(4),
                              //         child: LinearProgressIndicator(
                              //           value: labourPercent / 100,
                              //           backgroundColor: AppColors.greyBg,
                              //           valueColor: const AlwaysStoppedAnimation(
                              //               AppColors.green),
                              //           minHeight: 5,
                              //         ),
                              //       ),
                              //     ),
                              //     const SizedBox(width: 8),
                              //     Text('${labourPercent.toStringAsFixed(0)}%',
                              //         style: GoogleFonts.poppins(
                              //             fontSize: 10, color: AppColors.grey)),
                              //   ],
                              // ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(_formatAmt(provider.totalSpentDetail!.totalLabour.toDouble()),
                                style: GoogleFonts.poppins(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.orange,
                                )),
                                SizedBox(height: 10,),
                            const Icon(Icons.arrow_forward_ios,
                                size: 14, color: AppColors.greyLight),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
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
                        fontSize: 16, color: AppColors.greyLight)),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.redLight,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(Icons.trending_down,
                    color: AppColors.red, size: 25),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Total Spent',
                        style: GoogleFonts.poppins(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: AppColors.white,
                        )),
                    Text(siteName,
                        style: GoogleFonts.poppins(
                            fontSize: 16, color: AppColors.grey)),
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