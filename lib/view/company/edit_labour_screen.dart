// import 'package:construction_app/models/get_labours_model.dart';
// import 'package:construction_app/provider/company_provider.dart';
// import 'package:construction_app/services/provider_helper_class.dart';
// import 'package:construction_app/widgets/app_theme.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:provider/provider.dart';

// class EditLabourScreen extends StatefulWidget {
//   final LabourData labour;

//   const EditLabourScreen({
//     super.key,
//     required this.labour,
//   });

//   @override
//   State<EditLabourScreen> createState() => _EditLabourScreenState();
// }

// class _EditLabourScreenState extends State<EditLabourScreen> {
//   final _formKey = GlobalKey<FormState>();
//   late final TextEditingController _noOfLaboursCtrl;
//   late final TextEditingController _noOfDaysCtrl;
//   late final TextEditingController _amountCtrl;
//   late final TextEditingController _remarksCtrl;
//   late final TextEditingController _dateCtrl;
//   late DateTime _selectedDate;

//   @override
//   void initState() {
//     super.initState();
//     _noOfLaboursCtrl =
//         TextEditingController(text: widget.labour.noOfLabours.toString());
//     _noOfDaysCtrl = TextEditingController(
//         text: widget.labour.noOfDays?.toString() ?? '');
//     _amountCtrl =
//         TextEditingController(text: widget.labour.amount.toString());
//     _remarksCtrl =
//         TextEditingController(text: widget.labour.remarks ?? '');
//     _selectedDate = widget.labour.addedDate ?? DateTime.now();
//     _dateCtrl = TextEditingController(text: _formatDate(_selectedDate));
//   }

//   @override
//   void dispose() {
//     _noOfLaboursCtrl.dispose();
//     _noOfDaysCtrl.dispose();
//     _amountCtrl.dispose();
//     _remarksCtrl.dispose();
//     _dateCtrl.dispose();
//     super.dispose();
//   }

//   String _formatDate(DateTime date) {
//     final months = [
//       'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
//       'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
//     ];
//     return '${date.day.toString().padLeft(2, '0')} ${months[date.month - 1]} ${date.year}';
//   }

//   Future<void> _pickDate() async {
//     final picked = await showDatePicker(
//       context: context,
//       initialDate: _selectedDate,
//       firstDate: DateTime(2020),
//       lastDate: DateTime.now(),
//       builder: (ctx, child) => Theme(
//         data: Theme.of(ctx).copyWith(
//           colorScheme: const ColorScheme.light(primary: AppColors.red),
//         ),
//         child: child!,
//       ),
//     );
//     if (picked != null) {
//       setState(() {
//         _selectedDate = picked;
//         _dateCtrl.text = _formatDate(picked);
//       });
//     }
//   }

//   void _save() async {
//     if (!_formKey.currentState!.validate()) return;

//     final provider = context.read<CompanyProvider>();

//     await provider.updateLabour(
//       Id: widget.labour.id,
//       substageid:widget.labour.substageId,
//       no_of_labours: int.tryParse(_noOfLaboursCtrl.text) ?? 0,
//       no_of_days: int.tryParse(_noOfDaysCtrl.text) ?? 0,
//       amount: double.parse(_amountCtrl.text),  
//       onFailure: (error) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text(error), backgroundColor: AppColors.red),
//         );
//       },
//     );

//     if (!mounted) return;

//     if (provider.loaderState == LoaderState.loaded &&
//         provider.errorToast == null) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content:
//               Text('Labour updated ✓', style: GoogleFonts.poppins(fontSize: 13)),
//           backgroundColor: AppColors.green,
//           behavior: SnackBarBehavior.floating,
//           shape:
//               RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//         ),
//       );
//       Navigator.pop(context);
//     }
//   }

//   // void _confirmDelete() {
//   //   showDialog(
//   //     context: context,
//   //     builder: (ctx) => AlertDialog(
//   //       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
//   //       title: Row(
//   //         children: [
//   //           Container(
//   //             padding: const EdgeInsets.all(8),
//   //             decoration: BoxDecoration(
//   //               color: AppColors.red.withOpacity(0.1),
//   //               borderRadius: BorderRadius.circular(8),
//   //             ),
//   //             child: Icon(Icons.delete_outline, color: AppColors.red, size: 20),
//   //           ),
//   //           const SizedBox(width: 10),
//   //           Text('Delete Entry',
//   //               style: GoogleFonts.poppins(
//   //                   fontSize: 15, fontWeight: FontWeight.w600)),
//   //         ],
//   //       ),
//   //       content: RichText(
//   //         text: TextSpan(
//   //           style: GoogleFonts.poppins(fontSize: 13, color: AppColors.grey),
//   //           children: [
//   //             const TextSpan(text: 'Are you sure you want to delete the entry for '),
//   //             TextSpan(
//   //               text: '${widget.labour.noOfLabours} Labours',
//   //               style: GoogleFonts.poppins(
//   //                   fontWeight: FontWeight.w600, color: AppColors.dark),
//   //             ),
//   //             const TextSpan(text: '? This action cannot be undone.'),
//   //           ],
//   //         ),
//   //       ),
//   //       actions: [
//   //         TextButton(
//   //           onPressed: () => Navigator.pop(ctx),
//   //           child: Text('Cancel',
//   //               style: GoogleFonts.poppins(color: AppColors.grey)),
//   //         ),
//   //         ElevatedButton(
//   //           onPressed: () async {
//   //             Navigator.pop(ctx);
//   //             final provider = context.read<CompanyProvider>();
//   //             await provider.deleteLabour(
//   //               labourId: widget.labour.id,
//   //               onFailure: (err) {
//   //                 ScaffoldMessenger.of(context).showSnackBar(
//   //                   SnackBar(
//   //                       content: Text(err), backgroundColor: AppColors.red),
//   //                 );
//   //               },
//   //             );
//   //             if (!mounted) return;
//   //             if (provider.loaderState == LoaderState.loaded &&
//   //                 provider.errorToast == null) {
//   //               ScaffoldMessenger.of(context).showSnackBar(
//   //                 SnackBar(
//   //                   content: Text('Labour entry deleted',
//   //                       style: GoogleFonts.poppins(fontSize: 13)),
//   //                   backgroundColor: AppColors.red,
//   //                   behavior: SnackBarBehavior.floating,
//   //                   shape: RoundedRectangleBorder(
//   //                       borderRadius: BorderRadius.circular(10)),
//   //                 ),
//   //               );
//   //               Navigator.pop(context);
//   //             }
//   //           },
//   //           style: ElevatedButton.styleFrom(
//   //             backgroundColor: AppColors.red,
//   //             foregroundColor: AppColors.white,
//   //             shape: RoundedRectangleBorder(
//   //                 borderRadius: BorderRadius.circular(10)),
//   //           ),
//   //           child: Text('Delete',
//   //               style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
//   //         ),
//   //       ],
//   //     ),
//   //   );
//   // }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.greyBg,
//       body: Column(
//         children: [
//           // ── Header ──────────────────────────────────────────────────────
//           Container(
//             decoration: const BoxDecoration(
//               gradient: LinearGradient(
//                 begin: Alignment.topLeft,
//                 end: Alignment.bottomRight,
//                 colors: [Color(0xFF1A1A2E), Color(0xFF16213E)],
//               ),
//             ),
//             padding: EdgeInsets.only(
//               top: MediaQuery.of(context).padding.top + 12,
//               bottom: 16,
//               left: 16,
//               right: 16,
//             ),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     GestureDetector(
//                       onTap: () => Navigator.pop(context),
//                       child: Row(
//                         children: [
//                           const Icon(Icons.arrow_back_ios_new,
//                               size: 20, color: AppColors.greyLight),
//                           const SizedBox(width: 5),
//                           Text('Labour Details',
//                               style: GoogleFonts.poppins(
//                                   fontSize: 15, color: AppColors.greyLight)),
//                         ],
//                       ),
//                     ),
//                     // // Delete button in header
//                     // GestureDetector(
//                     //   onTap: _confirmDelete,
//                     //   child: Container(
//                     //     padding: const EdgeInsets.symmetric(
//                     //         horizontal: 10, vertical: 6),
//                     //     decoration: BoxDecoration(
//                     //       color: AppColors.red.withOpacity(0.15),
//                     //       borderRadius: BorderRadius.circular(8),
//                     //       border: Border.all(
//                     //           color: AppColors.red.withOpacity(0.3), width: 1),
//                     //     ),
//                     //     child: Row(
//                     //       children: [
//                     //         Icon(Icons.delete_outline,
//                     //             size: 15,
//                     //             color: AppColors.red.withOpacity(0.85)),
//                     //         const SizedBox(width: 4),
//                     //         Text('Delete',
//                     //             style: GoogleFonts.poppins(
//                     //                 fontSize: 12,
//                     //                 color: AppColors.red.withOpacity(0.85),
//                     //                 fontWeight: FontWeight.w500)),
//                     //       ],
//                     //     ),
//                     //   ),
//                     // ),
//                   ],
//                 ),
//                 const SizedBox(height: 10),
//                 Text('Edit Labour',
//                     style: GoogleFonts.poppins(
//                       fontSize: 18,
//                       fontWeight: FontWeight.w700,
//                       color: AppColors.white,
//                     )),
//                 const SizedBox(height: 8),
//                 // Summary chip
//                 Container(
//                   padding:
//                       const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
//                   decoration: BoxDecoration(
//                     color: AppColors.redLight,
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                   child: Row(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       const Icon(Icons.groups, size: 18, color: AppColors.red),
//                       const SizedBox(width: 5),
//                       Text(
//                         '${widget.labour.noOfLabours} Labours · ₹${widget.labour.amount}',
//                         style: GoogleFonts.poppins(
//                             fontSize: 13,
//                             fontWeight: FontWeight.w600,
//                             color: AppColors.red),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),

//           // ── Form Body ───────────────────────────────────────────────────
//           Expanded(
//             child: SingleChildScrollView(
//               padding: const EdgeInsets.all(12),
//               child: Form(
//                 key: _formKey,
//                 child: Column(
//                   children: [
//                     // ── Summary card ───────────────────────────────────────
//                     Container(
//                       width: double.infinity,
//                       margin: const EdgeInsets.only(bottom: 12),
//                       padding: const EdgeInsets.symmetric(
//                           horizontal: 16, vertical: 12),
//                       decoration: BoxDecoration(
//                         gradient: const LinearGradient(
//                           colors: [Color(0xFF1A1A2E), Color(0xFF16213E)],
//                           begin: Alignment.topLeft,
//                           end: Alignment.bottomRight,
//                         ),
//                         borderRadius: BorderRadius.circular(14),
//                       ),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text('Current Amount',
//                                   style: GoogleFonts.poppins(
//                                       fontSize: 11,
//                                       color: AppColors.greyLight)),
//                               Text(
//                                 '₹${widget.labour.amount}',
//                                 style: GoogleFonts.poppins(
//                                     fontSize: 20,
//                                     fontWeight: FontWeight.w700,
//                                     color: AppColors.red),
//                               ),
//                             ],
//                           ),
//                           Column(
//                             crossAxisAlignment: CrossAxisAlignment.end,
//                             children: [
//                               Text('Labours · Days',
//                                   style: GoogleFonts.poppins(
//                                       fontSize: 11,
//                                       color: AppColors.greyLight)),
//                               Text(
//                                 '${widget.labour.noOfLabours} · ${widget.labour.noOfDays ?? '-'}',
//                                 style: GoogleFonts.poppins(
//                                     fontSize: 13,
//                                     fontWeight: FontWeight.w500,
//                                     color: AppColors.greyLight),
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),

//                     // ── Main form card ─────────────────────────────────────
//                     Container(
//                       decoration: BoxDecoration(
//                         color: AppColors.white,
//                         borderRadius: BorderRadius.circular(14),
//                         border:
//                             Border.all(color: AppColors.border, width: 1.5),
//                       ),
//                       padding: const EdgeInsets.all(16),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           _buildLabel('Number of Labours *'),
//                           const SizedBox(height: 6),
//                           TextFormField(
//                             controller: _noOfLaboursCtrl,
//                             style: GoogleFonts.poppins(fontSize: 13),
//                             decoration: _inputDecoration('e.g. 10'),
//                             keyboardType: TextInputType.number,
//                             validator: (v) =>
//                                 v!.isEmpty ? 'Required' : null,
//                           ),
//                           const SizedBox(height: 14),

//                           _buildLabel('Number of Days *'),
//                           const SizedBox(height: 6),
//                           TextFormField(
//                             controller: _noOfDaysCtrl,
//                             style: GoogleFonts.poppins(fontSize: 13),
//                             decoration: _inputDecoration('e.g. 5'),
//                             keyboardType: TextInputType.number,
//                             validator: (v) =>
//                                 v!.isEmpty ? 'Required' : null,
//                           ),
//                           const SizedBox(height: 14),

//                           _buildLabel('Amount (₹) *'),
//                           const SizedBox(height: 6),
//                           TextFormField(
//                             controller: _amountCtrl,
//                             style: GoogleFonts.poppins(fontSize: 13),
//                             decoration: _inputDecoration('0.00'),
//                             keyboardType:
//                                 const TextInputType.numberWithOptions(
//                                     decimal: true),
//                             validator: (v) =>
//                                 v!.isEmpty ? 'Required' : null,
//                           ),
//                           const SizedBox(height: 14),

//                           _buildLabel('Remarks'),
//                           const SizedBox(height: 6),
//                           TextFormField(
//                             controller: _remarksCtrl,
//                             style: GoogleFonts.poppins(fontSize: 13),
//                             decoration: _inputDecoration(
//                                 'Payment details, work scope...'),
//                             maxLines: 3,
//                           ),
//                           const SizedBox(height: 14),

//                           _buildLabel('Date *'),
//                           const SizedBox(height: 6),
//                           TextFormField(
//                             controller: _dateCtrl,
//                             style: GoogleFonts.poppins(fontSize: 13),
//                             decoration:
//                                 _inputDecoration('DD Mon YYYY').copyWith(
//                               suffixIcon: const Icon(Icons.calendar_today,
//                                   size: 18, color: AppColors.grey),
//                             ),
//                             readOnly: true,
//                             onTap: _pickDate,
//                             validator: (v) =>
//                                 v!.isEmpty ? 'Required' : null,
//                           ),
//                           const SizedBox(height: 20),

//                           SizedBox(
//                             width: double.infinity,
//                             child: ElevatedButton(
//                               onPressed: _save,
//                               style: ElevatedButton.styleFrom(
//                                 backgroundColor: AppColors.red,
//                                 foregroundColor: AppColors.white,
//                                 padding:
//                                     const EdgeInsets.symmetric(vertical: 14),
//                                 shape: RoundedRectangleBorder(
//                                     borderRadius: BorderRadius.circular(12)),
//                                 elevation: 0,
//                               ),
//                               child: Consumer<CompanyProvider>(
//                                 builder: (context, provider, child) {
//                                   return provider.loaderState ==
//                                           LoaderState.loading
//                                       ? const CircularProgressIndicator(
//                                           color: Colors.white)
//                                       : Text('Update Labour',
//                                           style: GoogleFonts.poppins(
//                                               fontSize: 14,
//                                               fontWeight: FontWeight.w700));
//                                 },
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildLabel(String text) {
//     return Text(text,
//         style: GoogleFonts.poppins(
//             fontSize: 11, fontWeight: FontWeight.w600, color: AppColors.dark));
//   }

//   InputDecoration _inputDecoration(String hint) {
//     return InputDecoration(
//       hintText: hint,
//       filled: true,
//       fillColor: AppColors.greyFill,
//       contentPadding:
//           const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
//       border: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(10),
//         borderSide: const BorderSide(color: AppColors.border, width: 1.5),
//       ),
//       enabledBorder: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(10),
//         borderSide: const BorderSide(color: AppColors.border, width: 1.5),
//       ),
//       focusedBorder: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(10),
//         borderSide: const BorderSide(color: AppColors.red, width: 1.5),
//       ),
//       hintStyle:
//           GoogleFonts.poppins(fontSize: 12, color: AppColors.greyLight),
//     );
//   }
// }







import 'package:construction_app/models/get_labours_model.dart';
import 'package:construction_app/provider/company_provider.dart';
import 'package:construction_app/services/provider_helper_class.dart';
import 'package:construction_app/widgets/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class EditLabourScreen extends StatefulWidget {
  final LabourData labour;

  const EditLabourScreen({
    super.key,
    required this.labour,
  });

  @override
  State<EditLabourScreen> createState() => _EditLabourScreenState();
}

class _EditLabourScreenState extends State<EditLabourScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _noOfLaboursCtrl;
  late final TextEditingController _noOfDaysCtrl;
  late final TextEditingController _amountCtrl;

  @override
  void initState() {
    super.initState();
    _noOfLaboursCtrl =
        TextEditingController(text: widget.labour.noOfLabours.toString());
    _noOfDaysCtrl = TextEditingController(
        text: widget.labour.noOfDays?.toString() ?? '');
    _amountCtrl =
        TextEditingController(text: widget.labour.amount.toString());
  }

  @override
  void dispose() {
    _noOfLaboursCtrl.dispose();
    _noOfDaysCtrl.dispose();
    _amountCtrl.dispose();
    super.dispose();
  }

  void _save() async {
    if (!_formKey.currentState!.validate()) return;

    final provider = context.read<CompanyProvider>();

    await provider.updateLabour(
      Id: widget.labour.id,
      substageid: widget.labour.substageId,
      no_of_labours: int.tryParse(_noOfLaboursCtrl.text) ?? 0,
      no_of_days: int.tryParse(_noOfDaysCtrl.text) ?? 0,
      amount: double.parse(_amountCtrl.text),
      onFailure: (error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(error), backgroundColor: AppColors.red),
        );
      },
    );

    if (!mounted) return;

    if (provider.loaderState == LoaderState.loaded &&
        provider.errorToast == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Labour updated ✓',
              style: GoogleFonts.poppins(fontSize: 13)),
          backgroundColor: AppColors.green,
          behavior: SnackBarBehavior.floating,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
      );
      Navigator.pop(context);
    }
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
                      Text('Labour Details',
                          style: GoogleFonts.poppins(
                              fontSize: 15, color: AppColors.greyLight)),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Text('Edit Labour',
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: AppColors.white,
                    )),
                const SizedBox(height: 8),
                // Summary chip
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: AppColors.redLight,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.groups, size: 18, color: AppColors.red),
                      const SizedBox(width: 5),
                      Text(
                        '${widget.labour.noOfLabours} Labours · ₹${widget.labour.amount}',
                        style: GoogleFonts.poppins(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: AppColors.red),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // ── Form Body ───────────────────────────────────────────────────
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(12),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    // ── Summary card ───────────────────────────────────────
                    Container(
                      width: double.infinity,
                      margin: const EdgeInsets.only(bottom: 12),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 12),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFF1A1A2E), Color(0xFF16213E)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Current Amount',
                                  style: GoogleFonts.poppins(
                                      fontSize: 11,
                                      color: AppColors.greyLight)),
                              Text(
                                '₹${widget.labour.amount}',
                                style: GoogleFonts.poppins(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.red),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text('Labours · Days',
                                  style: GoogleFonts.poppins(
                                      fontSize: 11,
                                      color: AppColors.greyLight)),
                              Text(
                                '${widget.labour.noOfLabours} · ${widget.labour.noOfDays ?? '-'}',
                                style: GoogleFonts.poppins(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.greyLight),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    // ── Main form card ─────────────────────────────────────
                    Container(
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(
                            color: AppColors.border, width: 1.5),
                      ),
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildLabel('Number of Labours *'),
                          const SizedBox(height: 6),
                          TextFormField(
                            controller: _noOfLaboursCtrl,
                            style: GoogleFonts.poppins(fontSize: 13),
                            decoration: _inputDecoration('e.g. 10'),
                            keyboardType: TextInputType.number,
                            validator: (v) =>
                                v!.isEmpty ? 'Required' : null,
                          ),
                          const SizedBox(height: 14),

                          _buildLabel('Number of Days *'),
                          const SizedBox(height: 6),
                          TextFormField(
                            controller: _noOfDaysCtrl,
                            style: GoogleFonts.poppins(fontSize: 13),
                            decoration: _inputDecoration('e.g. 5'),
                            keyboardType: TextInputType.number,
                            validator: (v) =>
                                v!.isEmpty ? 'Required' : null,
                          ),
                          const SizedBox(height: 14),

                          _buildLabel('Amount (₹) *'),
                          const SizedBox(height: 6),
                          TextFormField(
                            controller: _amountCtrl,
                            style: GoogleFonts.poppins(fontSize: 13),
                            decoration: _inputDecoration('0.00'),
                            keyboardType:
                                const TextInputType.numberWithOptions(
                                    decimal: true),
                            validator: (v) =>
                                v!.isEmpty ? 'Required' : null,
                          ),
                          const SizedBox(height: 20),

                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: _save,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.red,
                                foregroundColor: AppColors.white,
                                padding: const EdgeInsets.symmetric(
                                    vertical: 14),
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.circular(12)),
                                elevation: 0,
                              ),
                              child: Consumer<CompanyProvider>(
                                builder: (context, provider, child) {
                                  return provider.loaderState ==
                                          LoaderState.loading
                                      ? const CircularProgressIndicator(
                                          color: Colors.white)
                                      : Text('Update Labour',
                                          style: GoogleFonts.poppins(
                                              fontSize: 14,
                                              fontWeight:
                                                  FontWeight.w700));
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Text(text,
        style: GoogleFonts.poppins(
            fontSize: 11,
            fontWeight: FontWeight.w600,
            color: AppColors.dark));
  }

  InputDecoration _inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      filled: true,
      fillColor: AppColors.greyFill,
      contentPadding:
          const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: AppColors.border, width: 1.5),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: AppColors.border, width: 1.5),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: AppColors.red, width: 1.5),
      ),
      hintStyle:
          GoogleFonts.poppins(fontSize: 12, color: AppColors.greyLight),
    );
  }
}