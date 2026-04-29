// // ─── widgets/info_tab.dart ───────────────────────────────────────────────────
// import 'package:construction_app/models/models.dart';
// import 'package:construction_app/widgets/app_theme.dart';
// import 'package:flutter/material.dart';

// class InfoTab extends StatelessWidget {
//   final Site site;
//   const InfoTab({super.key, required this.site});

//   @override
//   Widget build(BuildContext context) {
//     final progress = site.budgetProgress;
//     return ListView(
//       padding: const EdgeInsets.all(12),
//       children: [
//         _infoCard([
//           _infoRow('Contact', site.contact),
//           _infoRow('Mobile', site.phone, highlight: true),
//           _infoRow('Start Date', site.startDate),
//           _infoRow('Target Date', site.targetDate),
//           _infoRow('Supervisor', site.supervisor),
//           _infoRow('Estimated', '₹${(site.estimatedBudget / 100000).toStringAsFixed(0)},00,000',
//               valueColor: AppColors.orange),
//           _infoRow('Actual Spent', '₹${(site.actualSpent / 100000).toStringAsFixed(1)}L',
//               valueColor: Colors.red.shade600),
//         ]),
//         const SizedBox(height: 10),
//         Container(
//           padding: const EdgeInsets.all(14),
//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(14),
//             border: Border.all(color: AppColors.border),
//           ),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const Text('Description',
//                   style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
//               const SizedBox(height: 5),
//               Text(
//                 site.description,
//                 style: const TextStyle(fontSize: 12, color: AppColors.textMuted, height: 1.7),
//               ),
//             ],
//           ),
//         ),
//         const SizedBox(height: 10),
//         Container(
//           padding: const EdgeInsets.all(14),
//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(14),
//             border: Border.all(color: AppColors.border),
//           ),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   const Text('Budget Progress',
//                       style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600)),
//                   Text('${(progress * 100).toStringAsFixed(0)}%',
//                       style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: AppColors.orange)),
//                 ],
//               ),
//               const SizedBox(height: 7),
//               ClipRRect(
//                 borderRadius: BorderRadius.circular(4),
//                 child: LinearProgressIndicator(
//                   value: progress,
//                   minHeight: 8,
//                   backgroundColor: AppColors.border,
//                   valueColor: const AlwaysStoppedAnimation<Color>(AppColors.amber),
//                 ),
//               ),
//               const SizedBox(height: 5),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text('₹${(site.actualSpent / 100000).toStringAsFixed(1)}L spent',
//                       style: const TextStyle(fontSize: 10, color: AppColors.textSecondary)),
//                   Text('₹${((site.estimatedBudget - site.actualSpent) / 100000).toStringAsFixed(1)}L left',
//                       style: const TextStyle(fontSize: 10, color: AppColors.textSecondary)),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _infoCard(List<Widget> rows) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(14),
//         border: Border.all(color: AppColors.border),
//       ),
//       child: Column(children: rows),
//     );
//   }

//   Widget _infoRow(String label, String value,
//       {Color? valueColor, bool highlight = false}) {
//     return Container(
//       padding: const EdgeInsets.symmetric(vertical: 9),
//       decoration: const BoxDecoration(
//         border: Border(bottom: BorderSide(color: Color(0xFFF3F4F6))),
//       ),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text(label,
//               style: const TextStyle(fontSize: 11, color: AppColors.textSecondary)),
//           Flexible(
//             child: Text(
//               value,
//               textAlign: TextAlign.right,
//               style: TextStyle(
//                 fontSize: 12,
//                 fontWeight: FontWeight.w500,
//                 color: highlight
//                     ? const Color(0xFF2563EB)
//                     : valueColor ?? AppColors.textPrimary,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
 


 import 'package:construction_app/models/models.dart';
import 'package:construction_app/widgets/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class InfoTab extends StatelessWidget {
  // final Site site;
 
  const InfoTab({super.key});
 
  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('dd MMM yyyy');
 
    return ListView(
      padding: const EdgeInsets.all(12),
      children: [
        Card(
          color: AppColors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 14),
            child: Column(
              children: [
                _infoRow('Contact Person', "Rajan Kumar"),
                _infoRow('Mobile', "9876543210", valueColor: const Color(0xFF2563EB)),
                _infoRow('Start Date', dateFormat.format(DateTime.parse("2025-01-01"))),
                _infoRow('Target Date', dateFormat.format(DateTime.parse("2025-06-30"))),
                _infoRow('Supervisor', "Anand Krishnan"),
                _infoRow(
                  'Estimated',
                  '₹${4500000.toStringAsFixed(0)}',
                  valueColor: const Color(0xFFEA580C),
                ),
                _infoRow(
                  'Actual Spent',
                  '₹${4000000.toStringAsFixed(0)}',
                  valueColor: const Color(0xFFDC2626),
                  isLast: true,
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 10),
        Card(
          color: AppColors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Description',
                  style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: Color(0xFF374151)),
                ),
                const SizedBox(height: 5),
                Text(
                  "G+2 residential building with 6 units per floor. RCC framed structure with brick masonry walls and basement parking.",
                  style: const TextStyle(fontSize: 12, color: Color(0xFF6B7280), height: 1.7),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 10),
        Card(
          color: AppColors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Budget Progress',
                      style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: Color(0xFF374151)),
                    ),
                    Text(
                      '${4500000}%',
                      style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: Color(0xFFEA580C)),
                    ),
                  ],
                ),
                const SizedBox(height: 7),
                LinearProgressIndicator(
                  value: 4500000 / 100,
                  backgroundColor: const Color(0xFFE5E7EB),
                  valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFFF59E0B)),
                  minHeight: 8,
                ),
                const SizedBox(height: 6),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '₹${(4500000 / 100000).toStringAsFixed(1)}L spent',
                      style: const TextStyle(fontSize: 10, color: Color(0xFF9CA3AF)),
                    ),
                    Text(
                      '₹${((4500000 - 4000000) / 100000).toStringAsFixed(1)}L remaining',
                      style: const TextStyle(fontSize: 10, color: Color(0xFF9CA3AF)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
 
  Widget _infoRow(String key, String value, {Color? valueColor, bool isLast = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 9),
      decoration: BoxDecoration(
        border: isLast ? null : const Border(bottom: BorderSide(color: Color(0xFFF3F4F6))),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(key, style: const TextStyle(fontSize: 11, color: Color(0xFF9CA3AF))),
          Flexible(
            child: Text(
              value,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: valueColor ?? const Color(0xFF1C1917),
              ),
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }
}