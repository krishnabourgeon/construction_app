import 'package:construction_app/models/get_labours_model.dart';
import 'package:construction_app/models/get_sub_stages.dart';
import 'package:construction_app/models/models.dart';
import 'package:construction_app/provider/company_provider.dart';
import 'package:construction_app/services/provider_helper_class.dart';
import 'package:construction_app/view/company/add_labour_screen.dart';
import 'package:construction_app/view/company/add_material_screen.dart';
import 'package:construction_app/view/company/widgets/labour_chip.dart';
import 'package:construction_app/view/company/widgets/material_card.dart';
import 'package:construction_app/widgets/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class SubStageDetailScreen extends StatefulWidget {
  final SubStage subStages;
  final String stageName;
  final VoidCallback? onUpdate;
 
  const SubStageDetailScreen({
    super.key,
    required this.subStages,
    required this.stageName,
    this.onUpdate,
  });
 
  @override
  State<SubStageDetailScreen> createState() => _SubStageDetailScreenState();
}
 
class _SubStageDetailScreenState extends State<SubStageDetailScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
 
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    
    Future.microtask(() {
      context.read<CompanyProvider>().getLabours(substageId: widget.subStages.id);
      context.read<CompanyProvider>().getMaterials(substageId: widget.subStages.id);
    });
  }
 
  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.greyBg,
      body: Column(
        children: [
          // ── Header ──────────────────────────────────────────────────────
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFF6D28D9), Color(0xFF5B21B6)],
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
                          size: 20, color: Color(0xFFE9D5FF)),
                      const SizedBox(width: 7),
                      Text(widget.stageName,
                          style: GoogleFonts.poppins(
                              fontSize: 16, color: const Color(0xFFE9D5FF))),
                    ],
                  ),
                ),
                const SizedBox(height: 13),
                Text(widget.subStages.substage,
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: AppColors.white,
                    )),
                if (widget.subStages.description.isNotEmpty) ...[
                  const SizedBox(height: 4),
                  Text(widget.subStages.description,
                      style: GoogleFonts.poppins(
                          fontSize: 14, color: const Color(0xFFE9D5FF))),
                ],
                const SizedBox(height: 8),
                // Cost summary
                Consumer<CompanyProvider>(
                  builder: (context, provider, child) {
                    final filteredLabours = provider.laboursList;
                    final labourTotal = filteredLabours.fold(0.0, (sum, l) => sum + (double.tryParse(l.amount) ?? 0));

                    return Row(
                      children: [
                        _CostChip(
                          label: 'Materials',
                          amount: 0.0, // Materials integration pending
                          color: AppColors.amberLight,
                          textColor: AppColors.amberDark,
                        ),
                        const SizedBox(width: 8),
                        _CostChip(
                          label: 'Labour',
                          amount: labourTotal.toDouble(),
                          color: AppColors.greenLight,
                          textColor: AppColors.green,
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
 
          // ── Tabs ────────────────────────────────────────────────────────
          Container(
            color: AppColors.white,
            child: TabBar(
              controller: _tabController,
              labelStyle: GoogleFonts.poppins(
                  fontSize: 12, fontWeight: FontWeight.w600),
              unselectedLabelColor: AppColors.grey,
              labelColor: AppColors.purple,
              indicatorColor: AppColors.purple,
              tabs: const [
                Tab(text: 'Materials'),
                Tab(text: 'Labour'),
              ],
            ),
          ),
 
          // ── Tab Views ───────────────────────────────────────────────────
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                // Materials Tab
                _MaterialsTab(
                  subStages: widget.subStages,
                  onUpdate: () {
                    setState(() {});
                    widget.onUpdate?.call();
                  },
                ),
                // Labour Tab
                _LabourTab(
                  subStages: widget.subStages,
                  onUpdate: () {
                    setState(() {});
                    widget.onUpdate?.call();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
 
// ── Materials Tab ─────────────────────────────────────────────────────────────
 
// class _MaterialsTab extends StatelessWidget {
//   final SubStage subStages;
//   final VoidCallback onUpdate;
 
//   const _MaterialsTab({required this.subStages, required this.onUpdate});
 
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         // Top bar
//         Container(
//           color: AppColors.white,
//           padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text('0 materials', // Materials integration pending
//                   style: GoogleFonts.poppins(
//                       fontSize: 12,
//                       fontWeight: FontWeight.w500,
//                       color: AppColors.grey)),
//               GestureDetector(
//                 onTap: () async {
//                   await Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (_) => AddMaterialScreen(
//                         subStages: subStages,
//                         onMaterialAdded: (material) {
//                           // subStage.materials.add(material);
//                           onUpdate();
//                         },
//                       ),
//                     ),
//                   );
//                 },
//                 child: Container(
//                   padding:
//                       const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//                   decoration: BoxDecoration(
//                     color: AppColors.amberLight,
//                     borderRadius: BorderRadius.circular(16),
//                   ),
//                   child: Row(
//                     children: [
//                       const Icon(Icons.add, size: 14, color: AppColors.amberDark),
//                       const SizedBox(width: 4),
//                       Text('Add Material',
//                           style: GoogleFonts.poppins(
//                               fontSize: 11,
//                               fontWeight: FontWeight.w700,
//                               color: AppColors.amberDark)),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
 
//         // Materials List
//         Expanded(
//           child: true // subStage.materials.isEmpty
//               ? Center(
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Icon(Icons.inventory_2_outlined,
//                           size: 48, color: AppColors.greyLight),
//                       const SizedBox(height: 12),
//                       Text('No materials added yet',
//                           style: GoogleFonts.poppins(
//                               fontSize: 13, color: AppColors.grey)),
//                       const SizedBox(height: 4),
//                       Text('Tap "Add Material" to get started',
//                           style: GoogleFonts.poppins(
//                               fontSize: 11, color: AppColors.greyLight)),
//                     ],
//                   ),
//                 )
//               :  // ListView.builder(...)
//         ),
//       ],
//     );
//   }
// }


class _MaterialsTab extends StatelessWidget {
  final SubStage subStages;
  final VoidCallback onUpdate;

  const _MaterialsTab({required this.subStages, required this.onUpdate});

  @override
  Widget build(BuildContext context) {
    return Consumer<CompanyProvider>(
      builder: (context, provider, child) {
        final materials = provider.materialsList;

        return Column(
          children: [
            // ── Top bar ─────────────────────────────
            Container(
              color: AppColors.white,
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('${materials.length} materials',
                      style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: AppColors.grey)),

                  /// ➕ Add Material
                  GestureDetector(
                    onTap: () async {
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => AddMaterialScreen(
                            subStages: subStages,
                            //onMaterialAdded: (material) {},
                          ),
                        ),
                      );

                      /// 🔥 REFRESH AFTER ADD
                      provider.getMaterials(substageId: subStages.id);
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: AppColors.amberLight,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.add, size: 16, color: AppColors.amberDark),
                          const SizedBox(width: 4),
                          Text('Add Material',
                              style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.amberDark)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // ── List ─────────────────────────────
            Expanded(
              child: provider.loaderState == LoaderState.loading && materials.isEmpty
                  ? const Center(child: CircularProgressIndicator())

                  ///  EMPTY
                  : materials.isEmpty
                      ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.inventory_2_outlined,
                                  size: 48, color: AppColors.greyLight),
                              const SizedBox(height: 12),
                              Text('No materials added yet',
                                  style: GoogleFonts.poppins(
                                      fontSize: 15, color: AppColors.grey)),
                              const SizedBox(height: 4),
                              Text('Tap "Add Material" to get started',
                                  style: GoogleFonts.poppins(
                                      fontSize: 14, color: AppColors.greyLight)),
                            ],
                          ),
                        )

                      /// ✅ LIST
                      : ListView.builder(
                          padding: const EdgeInsets.all(12),
                          itemCount: materials.length,
                          itemBuilder: (_, i) {
                            final m = materials[i];

                            return MaterialCard(
                              material: materials[i],
                              onDelete: () {
                                /// TODO: implement delete API if needed
                                onUpdate();
                              },
                            );
                          },
                        ),
            ),
          ],
        );
      },
    );
  }
}
 
// ── Labour Tab ────────────────────────────────────────────────────────────────
 
class _LabourTab extends StatelessWidget {
  final SubStage subStages;
  final VoidCallback onUpdate;
 
  const _LabourTab({required this.onUpdate, required this.subStages});
 
  @override
  Widget build(BuildContext context) {
    return Consumer<CompanyProvider>(
      builder: (context, provider, child) {
        final filteredLabours = provider.laboursList;
            
        debugPrint("SubStageDetailScreen: SubStage ID = ${subStages.id}");
        debugPrint("SubStageDetailScreen: Labours count in Provider = ${provider.laboursList.length}");

        return Column(
          children: [
            // Top bar
            Container(
              color: AppColors.white,
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('${filteredLabours.length} entries',
                      style: GoogleFonts.poppins(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: AppColors.grey)),
                  GestureDetector(
                    onTap: () async {
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => AddLabourScreen(
                            subStages: subStages,
                          ),
                        ),
                      );
                      provider.getLabours(substageId: subStages.id); // Refresh after adding
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: AppColors.redLight,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.add, size: 16, color: AppColors.red),
                          const SizedBox(width: 4),
                          Text('Add Labour',
                              style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.red)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Labour List
            Expanded(
              child: provider.loaderState == LoaderState.loading && filteredLabours.isEmpty
                  ? const Center(child: CircularProgressIndicator())
                  : filteredLabours.isEmpty
                      ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.groups_outlined,
                                  size: 48, color: AppColors.greyLight),
                              const SizedBox(height: 12),
                              Text('No labour entries yet',
                                  style: GoogleFonts.poppins(
                                      fontSize: 13, color: AppColors.grey)),
                              const SizedBox(height: 4),
                              Text('Tap "Add Labour" to get started',
                                  style: GoogleFonts.poppins(
                                      fontSize: 11, color: AppColors.greyLight)),
                            ],
                          ),
                        )
                      : ListView.builder(
                          padding: const EdgeInsets.all(12),
                          itemCount: filteredLabours.length,
                          itemBuilder: (_, i) {
                            final l = filteredLabours[i];
                            return LabourCard(
                              labour: l,
                              onDelete: () {
                                // provider.deleteLabour(l.id); // Implement if needed
                                onUpdate();
                              },
                            );
                          },
                        ),
            ),
          ],
        );
      },
    );
  }
}
 

 

class _CostChip extends StatelessWidget {
  final String label;
  final double amount;
  final Color color;
  final Color textColor;
 
  const _CostChip({
    required this.label,
    required this.amount,
    required this.color,
    required this.textColor,
  });
 
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(label,
              style: GoogleFonts.poppins(
                  fontSize: 15, fontWeight: FontWeight.w700, color: textColor)),
          const SizedBox(width: 6),
          Text('₹${_formatAmount(amount)}',
              style: GoogleFonts.poppins(
                  fontSize: 13, fontWeight: FontWeight.w700, color: textColor)),
        ],
      ),
    );
  }
 
  String _formatAmount(double v) {
    if (v >= 10000000) return '${(v / 10000000).toStringAsFixed(1)}Cr';
    if (v >= 100000) return '${(v / 100000).toStringAsFixed(1)}L';
    if (v >= 1000) return '${(v / 1000).toStringAsFixed(1)}K';
    return v.toStringAsFixed(0);
  }
}