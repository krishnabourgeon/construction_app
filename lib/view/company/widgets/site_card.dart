// // ─── widgets/site_card.dart ──────────────────────────────────────────────────
// import 'package:construction_app/models/models.dart';
// import 'package:construction_app/widgets/app_theme.dart';
// import 'package:flutter/material.dart';

// class SiteCard extends StatelessWidget {
//   final Site site;
//   final VoidCallback onTap;

//   const SiteCard({super.key, required this.site, required this.onTap});

//   Color get _accentColor {
//     switch (site.status) {
//       case SiteStatus.active:
//         return AppColors.amber;
//       case SiteStatus.onHold:
//         return const Color(0xFF3B82F6);
//       case SiteStatus.completed:
//         return const Color(0xFF16A34A);
//     }
//   }

//   String get _statusLabel {
//     switch (site.status) {
//       case SiteStatus.active:
//         return 'Active';
//       case SiteStatus.onHold:
//         return 'On Hold';
//       case SiteStatus.completed:
//         return 'Completed';
//     }
//   }

//   Color get _statusBg {
//     switch (site.status) {
//       case SiteStatus.active:
//         return AppColors.greenBg;
//       case SiteStatus.onHold:
//         return AppColors.blueBg;
//       case SiteStatus.completed:
//         return AppColors.grayBg;
//     }
//   }

//   Color get _statusText {
//     switch (site.status) {
//       case SiteStatus.active:
//         return AppColors.greenText;
//       case SiteStatus.onHold:
//         return AppColors.blueText;
//       case SiteStatus.completed:
//         return AppColors.grayText;
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         margin: const EdgeInsets.only(bottom: 10),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(14),
//           border: Border(
//             left: BorderSide(color: _accentColor, width: 3),
//             top: const BorderSide(color: AppColors.border),
//             right: const BorderSide(color: AppColors.border),
//             bottom: const BorderSide(color: AppColors.border),
//           ),
//         ),
//         child: Column(
//           children: [
//             Padding(
//               padding: const EdgeInsets.all(13),
//               child: Row(
//                 children: [
//                   Container(
//                     width: 32,
//                     height: 32,
//                     decoration: BoxDecoration(
//                       color: _statusBg,
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                     alignment: Alignment.center,
//                     child: Text(
//                       site.name[0],
//                       style: TextStyle(
//                         fontSize: 13,
//                         fontWeight: FontWeight.w700,
//                         color: _statusText,
//                       ),
//                     ),
//                   ),
//                   const SizedBox(width: 9),
//                   Expanded(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           site.name,
//                           style: const TextStyle(
//                             fontSize: 13,
//                             fontWeight: FontWeight.w600,
//                             color: AppColors.textPrimary,
//                           ),
//                         ),
//                         const SizedBox(height: 2),
//                         Text(
//                           '${site.contact} • ${site.phone}',
//                           style: const TextStyle(
//                             fontSize: 10,
//                             color: AppColors.textSecondary,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   Container(
//                     padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
//                     decoration: BoxDecoration(
//                       color: _statusBg,
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                     child: Text(
//                       _statusLabel,
//                       style: TextStyle(
//                         fontSize: 9,
//                         fontWeight: FontWeight.w700,
//                         color: _statusText,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             if (site.status == SiteStatus.active) ...[
//               Padding(
//                 padding: const EdgeInsets.fromLTRB(13, 0, 13, 12),
//                 child: Column(
//                   children: [
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text(
//                           '₹${(site.actualSpent / 100000).toStringAsFixed(1)}L / ₹${(site.estimatedBudget / 100000).toStringAsFixed(0)}L',
//                           style: const TextStyle(fontSize: 11, color: AppColors.textSecondary),
//                         ),
//                         Text(
//                           '${(site.budgetProgress * 100).toStringAsFixed(0)}%',
//                           style: const TextStyle(
//                             fontSize: 11,
//                             fontWeight: FontWeight.w600,
//                             color: AppColors.orange,
//                           ),
//                         ),
//                       ],
//                     ),
//                     const SizedBox(height: 4),
//                     ClipRRect(
//                       borderRadius: BorderRadius.circular(3),
//                       child: LinearProgressIndicator(
//                         value: site.budgetProgress,
//                         minHeight: 5,
//                         backgroundColor: AppColors.border,
//                         valueColor: const AlwaysStoppedAnimation<Color>(AppColors.amber),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ],
//         ),
//       ),
//     );
//   }
// }



import 'package:construction_app/models/models.dart';
import 'package:construction_app/widgets/app_theme.dart';
import 'package:flutter/material.dart';

class SiteCard extends StatelessWidget {
  final Site site;
  final VoidCallback onTap;
 
  const SiteCard({super.key, required this.site, required this.onTap});
 
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
        side: const BorderSide(color: Color(0xFFE5E7EB), width: 1.5),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14),
        child: Container(
          decoration: const BoxDecoration(
            color: AppColors.white,
            border: Border(left: BorderSide(color: Color(0xFFF59E0B), width: 4)),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(14),
              bottomLeft: Radius.circular(14),
            ),
          ),
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      site.name,
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF1C1917),
                      ),
                    ),
                  ),
                  StatusBadge(status: site.status),
                ],
              ),
              const SizedBox(height: 4),
              Text(
                '${site.contactPerson} • ${site.mobile}',
                style: const TextStyle(fontSize: 11, color: Color(0xFF9CA3AF)),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'Budget',
                      style: const TextStyle(fontSize: 10, color: Color(0xFF9CA3AF)),
                    ),
                  ),
                  Text(
                    '₹${_formatAmount(site.estimatedAmount)}',
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFFEA580C),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              LinearProgressIndicator(
                value: site.budgetProgress / 100,
                backgroundColor: const Color(0xFFE5E7EB),
                valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFFF59E0B)),
              ),
              const SizedBox(height: 3),
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  '${site.budgetProgress.toStringAsFixed(0)}% spent',
                  style: const TextStyle(fontSize: 10, color: Color(0xFF9CA3AF)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
 
  String _formatAmount(double amount) {
    if (amount >= 10000000) return '${(amount / 10000000).toStringAsFixed(1)}Cr';
    if (amount >= 100000) return '${(amount / 100000).toStringAsFixed(1)}L';
    return amount.toStringAsFixed(0);
  }
}
 
class StatusBadge extends StatelessWidget {
  final String status;
 
  const StatusBadge({super.key, required this.status});
 
  @override
  Widget build(BuildContext context) {
    Color bgColor;
    Color textColor;
 
    switch (status.toLowerCase()) {
      case 'active':
        bgColor = const Color(0xFFDCFCE7);
        textColor = const Color(0xFF15803D);
        break;
      case 'pending':
        bgColor = const Color(0xFFFEF3C7);
        textColor = const Color(0xFFB45309);
        break;
      case 'on hold':
        bgColor = const Color(0xFFDBEAFE);
        textColor = const Color(0xFF1D4ED8);
        break;
      default:
        bgColor = const Color(0xFFF3F4F6);
        textColor = const Color(0xFF6B7280);
    }
 
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 3),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        status,
        style: TextStyle(
          fontSize: 9,
          fontWeight: FontWeight.w700,
          color: textColor,
        ),
      ),
    );
  }
}