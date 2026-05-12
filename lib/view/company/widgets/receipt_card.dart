import 'package:construction_app/models/total_recevied_detail_model.dart';
import 'package:construction_app/widgets/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class ReceiptCard extends StatelessWidget {
  final Payment receipt;

  const ReceiptCard({super.key, required this.receipt});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border, width: 1.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Text(receipt.,
              //     style: GoogleFonts.poppins(
              //         fontSize: 11,
              //         fontWeight: FontWeight.w600,
              //         color: AppColors.grey)),
              Text(_formatAmt(double.parse(receipt.amount)),
                  style: GoogleFonts.poppins(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: AppColors.green,
                  )),
            ],
          ),
          const SizedBox(height: 8),
          if (receipt.stageName != null)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: AppColors.purpleLight,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(receipt.stageName!,
                  style: GoogleFonts.poppins(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: AppColors.purple)),
            ),
          const SizedBox(height: 6),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: _getPaymentModeColor(receipt.paymentMode??"n/a").withOpacity(0.15),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(receipt.paymentMode??"n/a",
                    style: GoogleFonts.poppins(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: _getPaymentModeColor(receipt.paymentMode??"n/a"))),
              ),
              Text(DateFormat('dd MMM yyyy').format(receipt.paymentDate),
                  style: GoogleFonts.poppins(
                      fontSize: 13, color: AppColors.greyLight)),
            ],
          ),
          if (receipt.remarks!= null) ...[
            const SizedBox(height: 6),
            Text(receipt.remarks!,
                style: GoogleFonts.poppins(
                    fontSize: 13, color: AppColors.greyLight)),
          ],
        ],
      ),
    );
  }
 Color _getPaymentModeColor(String mode) {
    switch (mode.toLowerCase()) {
      case 'cash':
        return AppColors.amberDark;
      case 'online':
      case 'upi':
      case 'neft/rtgs':
        return AppColors.blue;
      case 'cheque':
        return AppColors.purple;
      default:
        return AppColors.grey;
    }
  }
  String _formatAmt(double v) {
  // if (v >= 10000000) return '₹${(v / 10000000).toStringAsFixed(1)}Cr';
  // if (v >= 100000) return '₹${(v / 100000).toStringAsFixed(1)}L';
  // if (v >= 1000) return '₹${(v / 1000).toStringAsFixed(1)}K';
  return '₹${v.toStringAsFixed(0)}';
}

}

// import 'package:construction_app/models/total_recevied_detail_model.dart';
// import 'package:construction_app/widgets/app_theme.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:intl/intl.dart';

// class ReceiptCard extends StatelessWidget {
//   final List<Payment> payments;

//   const ReceiptCard({super.key, required this.payments});

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
//             border: Border.all(color: AppColors.border, width: 1.5),
//           ),
//           child: DataTable(
//             headingRowColor: MaterialStateProperty.all(const Color(0xFF16213E)),
//             headingTextStyle: GoogleFonts.poppins(
//               color: AppColors.white,
//               fontSize: 13,
//               fontWeight: FontWeight.w600,
//             ),
//             dataTextStyle: GoogleFonts.poppins(
//               color: Colors.black87,
//               fontSize: 12,
//               fontWeight: FontWeight.w500,
//             ),
//             headingRowHeight: 55,
//             dataRowHeight: 65,
//             columnSpacing: 24,
//             horizontalMargin: 16,
//             dividerThickness: 1,
//             border: TableBorder(
//               top: BorderSide(color: Colors.grey.shade300),
//               bottom: BorderSide(color: Colors.grey.shade300),
//               left: BorderSide(color: Colors.grey.shade300),
//               right: BorderSide(color: Colors.grey.shade300),
//               horizontalInside: BorderSide(color: Colors.grey.shade300),
//               verticalInside: BorderSide(color: Colors.grey.shade300),
//             ),
//             columns: const [
//               DataColumn(label: Text('Amount')),
//               DataColumn(label: Text('Stage')),
//               DataColumn(label: Text('Payment Mode')),
//               DataColumn(label: Text('Date')),
//               DataColumn(label: Text('Remarks')),
//             ],
//             rows: payments.map((receipt) {
//               return DataRow(
//                 cells: [
//                   DataCell(
//                     Text(
//                       _formatAmt(double.tryParse(receipt.amount) ?? 0.0),
//                       style: const TextStyle(
//                         color: AppColors.green,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ),
//                   DataCell(Text(receipt.stageName ?? '-')),
//                   DataCell(Text(receipt.paymentMode ?? 'N/A')),
//                   DataCell(
//                     Text(DateFormat('dd MMM yyyy').format(receipt.paymentDate)),
//                   ),
//                   DataCell(Text(receipt.remarks ?? '')),
//                 ],
//               );
//             }).toList(),
//           ),
//         ),
//       ),
//     );
//   }

//   Color _getPaymentModeColor(String mode) {
//     switch (mode.toLowerCase()) {
//       case 'cash':
//         return AppColors.amberDark;
//       case 'online':
//       case 'upi':
//       case 'neft/rtgs':
//         return AppColors.blue;
//       case 'cheque':
//         return AppColors.purple;
//       default:
//         return AppColors.grey;
//     }
//   }

//   String _formatAmt(double v) {
//     if (v >= 10000000) return '₹${(v / 10000000).toStringAsFixed(1)}Cr';
//     if (v >= 100000) return '₹${(v / 100000).toStringAsFixed(1)}L';
//     if (v >= 1000) return '₹${(v / 1000).toStringAsFixed(1)}K';
//     return '₹${v.toStringAsFixed(0)}';
//   }
// }
