import 'package:construction_app/models/models.dart';
import 'package:construction_app/models/sitesbycompanies.dart';
import 'package:construction_app/widgets/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class InfoTab extends StatefulWidget {
  // final Site site;
  final SitesbyCompany site;
 
  const InfoTab({super.key, required this.site});

  @override
  State<InfoTab> createState() => _InfoTabState();
}

class _InfoTabState extends State<InfoTab> {
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
                _infoRow('Contact Person', widget.site.contactperson),
                _infoRow('Mobile', widget.site.mobile, valueColor: const Color(0xFF2563EB)),
                _infoRow('Start Date', dateFormat.format(widget.site.startDate)),
                _infoRow('Target Date', dateFormat.format(widget.site.tentativeCompletionDate)),
                //_infoRow('Supervisor', "Anand Krishnan"),
                _infoRow(
                  'Estimated',
                  '₹${(double.tryParse(widget.site.estimateAmount) ?? 0).toStringAsFixed(0)}',
                  valueColor: const Color(0xFFEA580C),
                ),
                // _infoRow(
                //   'Actual Spent',
                //   '₹${4000000.toStringAsFixed(0)}',
                //   valueColor: const Color(0xFFDC2626),
                //   isLast: true,
                // ),
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