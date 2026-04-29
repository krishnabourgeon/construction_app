import 'package:construction_app/models/models.dart';
import 'package:construction_app/view/company/add_labour_screen.dart';
import 'package:construction_app/view/company/add_material_screen.dart';
import 'package:construction_app/view/company/widgets/labour_chip.dart';
import 'package:construction_app/view/company/widgets/material_card.dart';
import 'package:construction_app/widgets/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SubStageDetailScreen extends StatefulWidget {
  final SubStageWithResources subStage;
  final String stageName;
  final VoidCallback? onUpdate;
 
  const SubStageDetailScreen({
    super.key,
    required this.subStage,
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
                          size: 14, color: Color(0xFFE9D5FF)),
                      const SizedBox(width: 5),
                      Text(widget.stageName,
                          style: GoogleFonts.poppins(
                              fontSize: 11, color: const Color(0xFFE9D5FF))),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Text(widget.subStage.name,
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: AppColors.white,
                    )),
                if (widget.subStage.description.isNotEmpty) ...[
                  const SizedBox(height: 4),
                  Text(widget.subStage.description,
                      style: GoogleFonts.poppins(
                          fontSize: 11, color: const Color(0xFFE9D5FF))),
                ],
                const SizedBox(height: 8),
                // Cost summary
                Row(
                  children: [
                    _CostChip(
                      label: 'Materials',
                      amount: widget.subStage.materialTotal,
                      color: AppColors.amberLight,
                      textColor: AppColors.amberDark,
                    ),
                    const SizedBox(width: 8),
                    _CostChip(
                      label: 'Labour',
                      amount: widget.subStage.labourTotal,
                      color: AppColors.greenLight,
                      textColor: AppColors.green,
                    ),
                  ],
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
                  subStage: widget.subStage,
                  onUpdate: () {
                    setState(() {});
                    widget.onUpdate?.call();
                  },
                ),
                // Labour Tab
                _LabourTab(
                  subStage: widget.subStage,
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
 
class _MaterialsTab extends StatelessWidget {
  final SubStageWithResources subStage;
  final VoidCallback onUpdate;
 
  const _MaterialsTab({required this.subStage, required this.onUpdate});
 
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Top bar
        Container(
          color: AppColors.white,
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('${subStage.materials.length} materials',
                  style: GoogleFonts.poppins(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: AppColors.grey)),
              GestureDetector(
                onTap: () async {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => AddMaterialScreen(
                        subStage: subStage,
                        onMaterialAdded: (material) {
                          subStage.materials.add(material);
                          onUpdate();
                        },
                      ),
                    ),
                  );
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: AppColors.amberLight,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.add, size: 14, color: AppColors.amberDark),
                      const SizedBox(width: 4),
                      Text('Add Material',
                          style: GoogleFonts.poppins(
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                              color: AppColors.amberDark)),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
 
        // Materials List
        Expanded(
          child: subStage.materials.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.inventory_2_outlined,
                          size: 48, color: AppColors.greyLight),
                      const SizedBox(height: 12),
                      Text('No materials added yet',
                          style: GoogleFonts.poppins(
                              fontSize: 13, color: AppColors.grey)),
                      const SizedBox(height: 4),
                      Text('Tap "Add Material" to get started',
                          style: GoogleFonts.poppins(
                              fontSize: 11, color: AppColors.greyLight)),
                    ],
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.all(12),
                  itemCount: subStage.materials.length,
                  itemBuilder: (_, i) {
                    final m = subStage.materials[i];
                    return MaterialCard(
                      material: m,
                      onDelete: () {
                        subStage.materials.removeAt(i);
                        onUpdate();
                      },
                    );
                  },
                ),
        ),
      ],
    );
  }
}
 
// ── Labour Tab ────────────────────────────────────────────────────────────────
 
class _LabourTab extends StatelessWidget {
  final SubStageWithResources subStage;
  final VoidCallback onUpdate;
 
  const _LabourTab({required this.subStage, required this.onUpdate});
 
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Top bar
        Container(
          color: AppColors.white,
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('${subStage.labour.length} entries',
                  style: GoogleFonts.poppins(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: AppColors.grey)),
              GestureDetector(
                onTap: () async {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => AddLabourScreen(
                        subStage: subStage,
                        onLabourAdded: (labour) {
                          subStage.labour.add(labour);
                          onUpdate();
                        },
                      ),
                    ),
                  );
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: AppColors.redLight,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.add, size: 14, color: AppColors.red),
                      const SizedBox(width: 4),
                      Text('Add Labour',
                          style: GoogleFonts.poppins(
                              fontSize: 11,
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
          child: subStage.labour.isEmpty
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
                  itemCount: subStage.labour.length,
                  itemBuilder: (_, i) {
                    final l = subStage.labour[i];
                    return LabourCard(
                      labour: l,
                      onDelete: () {
                        subStage.labour.removeAt(i);
                        onUpdate();
                      },
                    );
                  },
                ),
        ),
      ],
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
                  fontSize: 10, fontWeight: FontWeight.w700, color: textColor)),
          const SizedBox(width: 6),
          Text('₹${_formatAmount(amount)}',
              style: GoogleFonts.poppins(
                  fontSize: 11, fontWeight: FontWeight.w700, color: textColor)),
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