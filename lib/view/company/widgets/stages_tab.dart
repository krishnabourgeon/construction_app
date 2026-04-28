import 'package:construction_app/models/models.dart';
import 'package:construction_app/view/company/add_resource_screen.dart';
import 'package:construction_app/view/company/widgets/site_card.dart';
import 'package:construction_app/widgets/app_theme.dart';
import 'package:flutter/material.dart';

class WorkingStagesTab extends StatefulWidget {
  final Site site;
  const WorkingStagesTab({super.key, required this.site});
 
  @override
  State<WorkingStagesTab> createState() => WorkingStagesTabState();
}
class WorkingStagesTabState extends State<WorkingStagesTab> {
  String? expandedStageId;
 
  @override
  Widget build(BuildContext context) {
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
                    '${widget.site.stages.length} stages',
                    style: const TextStyle(fontSize: 10, color: Color(0xFF9CA3AF)),
                  ),
                ],
              ),
              ElevatedButton.icon(
                onPressed: () {
                  // Add stage
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
            itemCount: widget.site.stages.length,
            itemBuilder: (context, index) {
              final stage = widget.site.stages[index];
              final isExpanded = expandedStageId == stage.id;
 
              return _StageCard(
                stage: stage,
                siteName: widget.site.name,
                isExpanded: isExpanded,
                onToggle: () {
                  setState(() {
                    expandedStageId = isExpanded ? null : stage.id;
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
  final WorkingStage stage;
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
                      '${stage.name[0]}',
                      style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: Colors.white),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          stage.name,
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
                  StatusBadge(status: stage.status),
                  const SizedBox(width: 7),
                  IconButton(
                    icon: const Icon(Icons.edit, size: 16),
                    color: const Color(0xFF9CA3AF),
                    onPressed: () {
                      // Edit stage
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
                          '₹${(stage.totalMaterialCost / 100000).toStringAsFixed(1)}L',
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
                          '₹${(stage.totalLabourCost / 100000).toStringAsFixed(1)}L',
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
          if (stage.subStages.isNotEmpty)
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
                onPressed: () {},
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
 
  Widget _buildSubStageCard(BuildContext context, SubStage subStage) {
    return Container(
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
                subStage.name,
                style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Color(0xFF1C1917)),
              ),
              StatusBadge(status: subStage.status),
            ],
          ),
          const SizedBox(height: 2),
          Text(
            subStage.description,
            style: const TextStyle(fontSize: 10, color: Color(0xFF9CA3AF)),
          ),
          const SizedBox(height: 6),
          Row(
            children: [
              const Text('Mat: ', style: TextStyle(fontSize: 10, color: Color(0xFF9CA3AF))),
              Text(
                '₹${subStage.totalMaterialCost.toStringAsFixed(0)}',
                style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: Color(0xFFB45309)),
              ),
              const SizedBox(width: 8),
              const Text('•', style: TextStyle(fontSize: 10, color: Color(0xFF9CA3AF))),
              const SizedBox(width: 8),
              const Text('Lab: ', style: TextStyle(fontSize: 10, color: Color(0xFF9CA3AF))),
              Text(
                '₹${subStage.totalLabourCost.toStringAsFixed(0)}',
                style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: Color(0xFFB91C1C)),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddResourceScreen(
                          resourceType: 'Material',
                          stageName: stage.name,
                          subStageName: subStage.name,
                          siteName: siteName,
                        ),
                      ),
                    );
                  },
                  icon: const Icon(Icons.add, size: 9),
                  label: const Text('Add Material'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFEF3C7),
                    foregroundColor: const Color(0xFFB45309),
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    textStyle: const TextStyle(fontSize: 10, fontWeight: FontWeight.w600),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                ),
              ),
              const SizedBox(width: 6),
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddResourceScreen(
                          resourceType: 'Labour',
                          stageName: stage.name,
                          subStageName: subStage.name,
                          siteName: siteName,
                        ),
                      ),
                    );
                  },
                  icon: const Icon(Icons.add, size: 9),
                  label: const Text('Add Labour'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFEE2E2),
                    foregroundColor: const Color(0xFFB91C1C),
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    textStyle: const TextStyle(fontSize: 10, fontWeight: FontWeight.w600),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                ),
              ),
            ],
          ),
        ],
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
                  onTap: () {},
                  child: const Text(
                    '+ Add sub-stages instead',
                    style: TextStyle(fontSize: 10, color: Color(0xFF7C3AED), fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddResourceScreen(
                          resourceType: 'Material',
                          stageName: stage.name,
                          siteName: siteName,
                        ),
                      ),
                    );
                  },
                  icon: const Icon(Icons.add, size: 10),
                  label: const Text('Add Material'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFEF3C7),
                    foregroundColor: const Color(0xFFB45309),
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    textStyle: const TextStyle(fontSize: 10, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              const SizedBox(width: 7),
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddResourceScreen(
                          resourceType: 'Labour',
                          stageName: stage.name,
                          siteName: siteName,
                        ),
                      ),
                    );
                  },
                  icon: const Icon(Icons.add, size: 10),
                  label: const Text('Add Labour'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFEE2E2),
                    foregroundColor: const Color(0xFFB91C1C),
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    textStyle: const TextStyle(fontSize: 10, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              const SizedBox(width: 7),
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.add, size: 10),
                  label: const Text('Sub-stage'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFEDE9FE),
                    foregroundColor: const Color(0xFF6D28D9),
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    textStyle: const TextStyle(fontSize: 10, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
 
  Color _getStageColor(String status) {
    switch (status.toLowerCase()) {
      case 'done':
        return const Color(0xFF16A34A);
      case 'active':
        return const Color(0xFF3B82F6);
      case 'pending':
        return const Color(0xFF6B7280);
      default:
        return const Color(0xFF9CA3AF);
    }
  }
}