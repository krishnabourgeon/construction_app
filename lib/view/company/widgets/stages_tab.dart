import 'package:construction_app/models/get_stages_model.dart';
import 'package:construction_app/models/get_sub_stages.dart';
import 'package:construction_app/models/models.dart';
import 'package:construction_app/models/sitesbycompanies.dart';
import 'package:construction_app/provider/company_provider.dart';
import 'package:construction_app/view/company/add_resource_screen.dart';
import 'package:construction_app/view/company/add_stage_screen.dart';
import 'package:construction_app/view/company/add_substages_screen.dart';
import 'package:construction_app/view/company/edit_stage_screen.dart';
import 'package:construction_app/view/company/sub_stage_detail_screen.dart';
import 'package:construction_app/view/company/widgets/site_card.dart';
import 'package:construction_app/widgets/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WorkingStagesTab extends StatefulWidget {
  final SitesbyCompany site;
  const WorkingStagesTab({super.key, required this.site});
 
  @override
  State<WorkingStagesTab> createState() => WorkingStagesTabState();
}
class WorkingStagesTabState extends State<WorkingStagesTab> {
  String? expandedStageId;


   @override
  void initState() {
    super.initState();

    Future.microtask(() {
      context.read<CompanyProvider>().getStages(siteId: widget.site.id);
      context.read<CompanyProvider>().getSubStages(siteId: widget.site.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<CompanyProvider>();
    return Column(
      children: [
        // Sticky top bar
        Container(
          color: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Working Stages',
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: Color(0xFF1C1917)),
                  ),
                  Text(
                    '${provider.stagesList.length} stages',
                    style: const TextStyle(fontSize: 10, color: Color(0xFF9CA3AF)),
                  ),
                ],
              ),
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => AddStageScreen(siteName: widget.site.sitename, siteId: widget.site.id),
                    ),
                  );  

                },
                icon: const Icon(Icons.add, size: 14),
                label: const Text('Add Stage'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFF59E0B),
                  foregroundColor: const Color(0xFF1C1917),
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
                  textStyle: const TextStyle(fontSize: 11, fontWeight: FontWeight.w700),
                ),
              ),
            ],
          ),
        ),
        const Divider(height: 1, thickness: 1.5, color: Color(0xFFE5E7EB)),
        // Stages list
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
            itemCount: provider.subStagesList.length,
            itemBuilder: (context, index) {
              final stage = provider.subStagesList[index];
              final isExpanded = expandedStageId == stage.id.toString();
 
              return _StageCard(
                stage: stage,
                siteName: widget.site.sitename,
                isExpanded: isExpanded,
                onToggle: () {
                  setState(() {
                    expandedStageId = expandedStageId == stage.id.toString() ? null : stage.id.toString();
                  });
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
 
class _StageCard extends StatelessWidget {
  final SubStages stage;
  final String siteName;
  final bool isExpanded;
  final VoidCallback onToggle;
 
  const _StageCard({
    required this.stage,
    required this.siteName,
    required this.isExpanded,
    required this.onToggle,
  });
 
  @override
  Widget build(BuildContext context) {

    
    String getStatusLabel(int status) {
      switch (status) {
        case 0:
          return 'Not Started';
        case 1:
          return 'Active';
        case 2:
          return 'Done';
        default:
          return 'Not Started';
      }
    }

    bool hasSubstageBool(int value) => value == 1;
    final statusText = getStatusLabel(stage.status);
    return Card(
      color: AppColors.white,
      margin: const EdgeInsets.only(bottom: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
        side: const BorderSide(color: Color(0xFFE5E7EB), width: 1.5),
      ),
      child: Column(
        children: [
          InkWell(
            onTap: onToggle,
            child: Padding(
              padding: const EdgeInsets.all(13),
              child: Row(
                children: [
                  Container(
                    width: 34,
                    height: 34,
                    decoration: BoxDecoration(
                      color: _getStageColor(stage.status),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      '${stage.stage[0]}',
                      style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: Colors.white),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          stage.stage,
                          style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Color(0xFF1C1917)),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          stage.description,
                          style: const TextStyle(fontSize: 10, color: Color(0xFF9CA3AF)),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  StatusBadge(status: stage.statusLabel),
                  const SizedBox(width: 7),
                  IconButton(
                    icon: const Icon(Icons.edit, size: 16),
                    color: const Color(0xFF9CA3AF),
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => EditStageScreen(stageName: stage.stage, stageDesc: stage.description, stageStatus: stage.statusLabel, ),));
                    },
                  ),
                  Icon(
                    isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                    color: const Color(0xFF9CA3AF),
                  ),
                ],
              ),
            ),
          ),
          if (isExpanded) _buildExpandedBody(context),
        ],
      ),
    );
  }
 
  Widget _buildExpandedBody(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(top: BorderSide(color: Color(0xFFF3F4F6))),
      ),
      child: Column(
        children: [
          // Cost pills
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 10),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(9),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFEF9C3),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      children: [
                        Text(
                          '₹${(0.0 / 100000).toStringAsFixed(1)}L',
                          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: Color(0xFF854D0E)),
                        ),
                        const SizedBox(height: 1),
                        const Text(
                          'MATERIALS',
                          style: TextStyle(fontSize: 9, fontWeight: FontWeight.w700, color: Color(0xFFA16207)),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(9),
                    decoration: BoxDecoration(
                      color: const Color(0xFFDCFCE7),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      children: [
                        Text(
                          '₹${(0.0 / 100000).toStringAsFixed(1)}L',
                          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: Color(0xFF15803D)),
                        ),
                        const SizedBox(height: 1),
                        const Text(
                          'LABOUR',
                          style: TextStyle(fontSize: 9, fontWeight: FontWeight.w700, color: Color(0xFF166534)),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
 
          // Sub-stages or direct add buttons
          if (stage.hasSubstage == 1 || stage.subStages.isNotEmpty)
            _buildSubStages(context)
          else
            _buildDirectAddButtons(context),
        ],
      ),
    );
  }
 
  Widget _buildSubStages(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(13, 0, 13, 13),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                '🔀 SUB-STAGES',
                style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: Color(0xFF9CA3AF)),
              ),
              TextButton.icon(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) => AddSubStageScreen(stageName: stage.stage, siteId: stage.siteId, stageId: stage.id,),
                  ));
                },
                icon: const Icon(Icons.add, size: 10),
                label: const Text('Add Sub-stage'),
                style: TextButton.styleFrom(
                  backgroundColor: const Color(0xFFEDE9FE),
                  foregroundColor: const Color(0xFF6D28D9),
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  textStyle: const TextStyle(fontSize: 10, fontWeight: FontWeight.w700),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          ...stage.subStages.map((sub) => _buildSubStageCard(context, sub)),
        ],
      ),
    );
  }
 
  Widget _buildSubStageCard(BuildContext context, SubStage subStages) {
    return InkWell(
      onTap: () {
        final dummySubStage = SubStageWithResources(
          id: subStages.id.toString(),
          stageId: subStages.stageId.toString(),
          name: subStages.substage,
          description: subStages.description,
          status: subStages.statusLabel,
        );

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => SubStageDetailScreen(stageName: stage.stage, subStage: dummySubStage),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 7),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: const Color(0xFFF9FAFB),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: const Color(0xFFE5E7EB)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  subStages.substage,
                  style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Color(0xFF1C1917)),
                ),
                StatusBadge(status: subStages.statusLabel),
              ],
            ),
            const SizedBox(height: 2),
            Text(
              subStages.description,
              style: const TextStyle(fontSize: 10, color: Color(0xFF9CA3AF)),
            ),
            const SizedBox(height: 6),
            // Row(
            //   children: [
            //     const Text('Mat: ', style: TextStyle(fontSize: 10, color: Color(0xFF9CA3AF))),
            //     Text(
            //       '₹${subStage.totalMaterialCost.toStringAsFixed(0)}',
            //       style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: Color(0xFFB45309)),
            //     ),
            //     const SizedBox(width: 8),
            //     const Text('•', style: TextStyle(fontSize: 10, color: Color(0xFF9CA3AF))),
            //     const SizedBox(width: 8),
            //     const Text('Lab: ', style: TextStyle(fontSize: 10, color: Color(0xFF9CA3AF))),
            //     Text(
            //       '₹${subStage.totalLabourCost.toStringAsFixed(0)}',
            //       style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: Color(0xFFB91C1C)),
            //     ),
            //   ],
            // ),
            // const SizedBox(height: 8),
            // Row(
            //   children: [
            //     Expanded(
            //       child: ElevatedButton.icon(
            //         onPressed: () {
            //           Navigator.push(
            //             context,
            //             MaterialPageRoute(
            //               builder: (context) => AddResourceScreen(
            //                 resourceType: 'Material',
            //                 stageName: stage.stage,
            //                 subStageName: "", // Update this once sub-stages are available
            //                 siteName: siteName,
            //               ),
            //             ),
            //           );
            //         },
            //         icon: const Icon(Icons.add, size: 9),
            //         label: const Text('Add Material'),
            //         style: ElevatedButton.styleFrom(
            //           backgroundColor: const Color(0xFFFEF3C7),
            //           foregroundColor: const Color(0xFFB45309),
            //           padding: const EdgeInsets.symmetric(vertical: 6),
            //           textStyle: const TextStyle(fontSize: 10, fontWeight: FontWeight.w600),
            //           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            //         ),
            //       ),
            //     ),
                // const SizedBox(width: 6),
                // Expanded(
                //   child: ElevatedButton.icon(
                //     onPressed: () {
                //       Navigator.push(
                //         context,
                //         MaterialPageRoute(
                //           builder: (context) => AddResourceScreen(
                //             resourceType: 'Labour',
                //             stageName: stage.stage,
                //             subStageName: "", // Update this once sub-stages are available
                //             siteName: siteName,
                //           ),
                //         ),
                //       );
                //     },
                //     icon: const Icon(Icons.add, size: 9),
                //     label: const Text('Add Labour'),
                //     style: ElevatedButton.styleFrom(
                //       backgroundColor: const Color(0xFFFEE2E2),
                //       foregroundColor: const Color(0xFFB91C1C),
                //       padding: const EdgeInsets.symmetric(vertical: 6),
                //       textStyle: const TextStyle(fontSize: 10, fontWeight: FontWeight.w600),
                //       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                //     ),
                //   ),
                // ),
            //   ],
            // ),
          ],
        ),
      ),
    );
  }
 
  Widget _buildDirectAddButtons(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(13, 0, 13, 13),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: const Color(0xFFF9FAFB),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: const Color(0xFFE5E7EB), style: BorderStyle.solid, width: 1.5),
            ),
            child: Column(
              children: [
                const Text(
                  'No sub-stages — adding directly to this stage',
                  style: TextStyle(fontSize: 11, color: Color(0xFF9CA3AF)),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 4),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddSubStageScreen(stageName: stage.stage, siteId: stage.siteId, stageId: stage.id,),
                      ),
                    );
                  },
                  child: const Text(
                    '+ Add sub-stages instead',
                    style: TextStyle(fontSize: 10, color: Color(0xFF7C3AED), fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
          ),
          //const SizedBox(height: 8),
          // Row(
          //   children: [
              // Expanded(
              //   child: ElevatedButton.icon(
              //     onPressed: () {
              //       Navigator.push(
              //         context,
              //         MaterialPageRoute(
              //           builder: (context) => AddResourceScreen(
              //             resourceType: 'Material',
              //             stageName: stage.stage,
              //             siteName: siteName,
              //           ),
              //         ),
              //       );
              //     },
              //     icon: const Icon(Icons.add, size: 10),
              //     label: const Text('Add Material'),
              //     style: ElevatedButton.styleFrom(
              //       backgroundColor: const Color(0xFFFEF3C7),
              //       foregroundColor: const Color(0xFFB45309),
              //       padding: const EdgeInsets.symmetric(vertical: 8),
              //       textStyle: const TextStyle(fontSize: 10, fontWeight: FontWeight.w600),
              //     ),
              //   ),
              // ),
              // const SizedBox(width: 7),
              // Expanded(
              //   child: ElevatedButton.icon(
              //     onPressed: () {
              //       Navigator.push(
              //         context,
              //         MaterialPageRoute(
              //           builder: (context) => AddResourceScreen(
              //             resourceType: 'Labour',
              //             stageName: stage.stage,
              //             siteName: siteName,
              //           ),
              //         ),
              //       );
              //     },
              //     icon: const Icon(Icons.add, size: 10),
              //     label: const Text('Add Labour'),
              //     style: ElevatedButton.styleFrom(
              //       backgroundColor: const Color(0xFFFEE2E2),
              //       foregroundColor: const Color(0xFFB91C1C),
              //       padding: const EdgeInsets.symmetric(vertical: 8),
              //       textStyle: const TextStyle(fontSize: 10, fontWeight: FontWeight.w600),
              //     ),
              //   ),
              // ),
              // const SizedBox(width: 7),
              // Expanded(
              //   child: ElevatedButton.icon(
              //     onPressed: () {
              //       Navigator.push(
              //         context,
              //         MaterialPageRoute(
              //           builder: (context) => AddSubStageScreen(
              //             stageName: stage.stage,
              //             siteId: stage.siteId,
              //             stageId: stage.id,
              //           ),
              //         ),
              //       );
              //     },
              //     icon: const Icon(Icons.add, size: 10),
              //     label: const Text('Sub-stage'),
              //     style: ElevatedButton.styleFrom(
              //       backgroundColor: const Color(0xFFEDE9FE),
              //       foregroundColor: const Color(0xFF6D28D9),
              //       padding: const EdgeInsets.symmetric(vertical: 8),
              //       textStyle: const TextStyle(fontSize: 10, fontWeight: FontWeight.w600),
              //     ),
              //   ),
              // ),
          //   ],
          // ),
        ],
      ),
    );
  }
 
  Color _getStageColor(int status) {
    switch (status) {
      case 2:
        return const Color(0xFF16A34A);
      case 1:
        return const Color(0xFF3B82F6);
      case 0:
        return const Color(0xFF6B7280);
      default:
        return const Color(0xFF9CA3AF);
    }
  }
}