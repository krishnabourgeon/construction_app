
// import 'package:construction_app/models/get_group_model.dart';
// import 'package:construction_app/provider/company_provider.dart';
// import 'package:construction_app/widgets/app_theme.dart';
// import 'package:construction_app/widgets/common_widgets.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:provider/provider.dart';


// // ── Avatar color palette ───────────────────────────────────────────────────────

// const List<Color> _avatarBgs = [
//   Color(0xFFFEF3C7),
//   Color(0xFFDBEAFE),
//   Color(0xFFFEE2E2),
//   Color(0xFFEDE9FE),
//   Color(0xFFDCFCE7),
//   Color(0xFFFED7AA),
// ];

// const List<Color> _avatarFgs = [
//   Color(0xFFB45309),
//   Color(0xFF1D4ED8),
//   Color(0xFFB91C1C),
//   Color(0xFF6D28D9),
//   Color(0xFF15803D),
//   Color(0xFFEA580C),
// ];

// // ── Ledger Model ──────────────────────────────────────────────────────────────

// class LedgerEntry {
//   final String id;
//   final String name;
//   final String group;

//   LedgerEntry({
//     required this.id,
//     required this.name,
//     required this.group,
//   });
// }

// // ── Ledger Screen ─────────────────────────────────────────────────────────────

// class LedgerScreen extends StatefulWidget {
//   const LedgerScreen({super.key});

//   @override
//   State<LedgerScreen> createState() => _LedgerScreenState();
// }

// class _LedgerScreenState extends State<LedgerScreen> {
//   String _search = '';

//   // final List<LedgerEntry> _ledgers = [
//   //   LedgerEntry(id: '1', name: 'Cash Account', group: 'Cash in Hand'),
//   //   LedgerEntry(id: '2', name: 'HDFC Bank', group: 'Bank Accounts'),
//   //   LedgerEntry(id: '3', name: 'Sales Revenue', group: 'Income'),
//   // ];

//   // List<LedgerEntry> get _filtered => _ledgers.where((l) {
//   //       return l.name.toLowerCase().contains(_search.toLowerCase()) ||
//   //           l.group.toLowerCase().contains(_search.toLowerCase());
//   //     }).toList();

//   Future<void> _openAddLedger() async {
//     final result = await Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (_) => const AddLedgerScreen(),
//       ),
//     );

//     if (result is LedgerEntry) {
//       setState(() {
//         _ledgers.add(result);
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.greyBg,
//       body: Column(
//         children: [
//           // HEADER
//           Container(
//             color: AppColors.navy,
//             padding: EdgeInsets.only(
//               top: MediaQuery.of(context).padding.top + 16,
//               bottom: 20,
//               left: 20,
//               right: 20,
//             ),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       'Accounts',
//                       style: GoogleFonts.poppins(
//                         fontSize: 15,
//                         color: AppColors.greyLight,
//                       ),
//                     ),
//                     Text(
//                       'Ledger',
//                       style: GoogleFonts.poppins(
//                         fontSize: 22,
//                         fontWeight: FontWeight.w600,
//                         color: AppColors.white,
//                       ),
//                     ),
//                   ],
//                 ),
//                 GestureDetector(
//                   onTap: _openAddLedger,
//                   child: Container(
//                     padding: const EdgeInsets.symmetric(
//                       horizontal: 14,
//                       vertical: 8,
//                     ),
//                     decoration: BoxDecoration(
//                       color: AppColors.amber,
//                       borderRadius: BorderRadius.circular(20),
//                     ),
//                     child: Row(
//                       children: [
//                         const Icon(
//                           Icons.add,
//                           size: 18,
//                           color: AppColors.dark,
//                         ),
//                         const SizedBox(width: 4),
//                         Text(
//                           'Add',
//                           style: GoogleFonts.poppins(
//                             fontSize: 16,
//                             fontWeight: FontWeight.w600,
//                             color: AppColors.dark,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),

//           // SEARCH
//           Padding(
//             padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
//             child: TextField(
//               onChanged: (v) {
//                 setState(() {
//                   _search = v;
//                 });
//               },
//               decoration: InputDecoration(
//                 hintText: 'Search ledger',
//                 prefixIcon: const Icon(Icons.search),
//                 filled: true,
//                 fillColor: AppColors.white,
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//               ),
//             ),
//           ),

//           // LIST
//           Expanded(
//             child: ListView.builder(
//               padding: const EdgeInsets.all(16),
//               itemCount: _filtered.length,
//               itemBuilder: (_, i) {
//                 final entry = _filtered[i];

//                 return _LedgerCard(
//                   entry: entry,
//                   avatarBg: _avatarBgs[i % _avatarBgs.length],
//                   avatarFg: _avatarFgs[i % _avatarFgs.length],
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// // ── Ledger Card ───────────────────────────────────────────────────────────────

// class _LedgerCard extends StatelessWidget {
//   final LedgerEntry entry;
//   final Color avatarBg;
//   final Color avatarFg;

//   const _LedgerCard({
//     required this.entry,
//     required this.avatarBg,
//     required this.avatarFg,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final initials = entry.name.substring(0, 2).toUpperCase();

//     return Container(
//       margin: const EdgeInsets.only(bottom: 12),
//       padding: const EdgeInsets.all(14),
//       decoration: BoxDecoration(
//         color: AppColors.white,
//         borderRadius: BorderRadius.circular(16),
//       ),
//       child: Row(
//         children: [
//           Container(
//             width: 48,
//             height: 48,
//             decoration: BoxDecoration(
//               color: avatarBg,
//               borderRadius: BorderRadius.circular(14),
//             ),
//             child: Center(
//               child: Text(
//                 initials,
//                 style: GoogleFonts.poppins(
//                   fontWeight: FontWeight.w700,
//                   color: avatarFg,
//                 ),
//               ),
//             ),
//           ),

//           const SizedBox(width: 12),

//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   entry.name,
//                   style: GoogleFonts.poppins(
//                     fontSize: 15,
//                     fontWeight: FontWeight.w600,
//                   ),
//                 ),
//                 Text(
//                   entry.group,
//                   style: GoogleFonts.poppins(
//                     fontSize: 12,
//                     color: AppColors.grey,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// // ── Add Ledger Screen ─────────────────────────────────────────────────────────

// class AddLedgerScreen extends StatefulWidget {
//   const AddLedgerScreen({super.key});

//   @override
//   State<AddLedgerScreen> createState() => _AddLedgerScreenState();
// }

// class _AddLedgerScreenState extends State<AddLedgerScreen> {
//   final _formKey = GlobalKey<FormState>();

//   final TextEditingController _nameCtrl = TextEditingController();

//   Groups? _selectedGroup;

//   bool _saving = false;

//   @override
//   void initState() {
//     super.initState();

//     Future.microtask(() {
//       context.read<CompanyProvider>().getGroups(
//         (error) {
//           debugPrint(error);
//         },
//       );
//     });
//   }

//   Future<void> _save() async {
//     if (!_formKey.currentState!.validate()) return;

//     setState(() {
//       _saving = true;
//     });

//     await context.read<CompanyProvider>().addLedger(
//           name: _nameCtrl.text.trim(),
//           groupid: _selectedGroup!.id,
//         );

//     await Future.delayed(const Duration(milliseconds: 500));

//     setState(() {
//       _saving = false;
//     });

//     if (!mounted) return;

//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text(
//           'Ledger added successfully!',
//           style: GoogleFonts.poppins(),
//         ),
//       ),
//     );

//     Navigator.pop(
//       context,
//       LedgerEntry(
//         id: DateTime.now().millisecondsSinceEpoch.toString(),
//         name: _nameCtrl.text.trim(),
//         group: _selectedGroup!.name,
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     _nameCtrl.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.greyBg,
//       body: Column(
//         children: [
//           // HEADER
//           Container(
//             color: AppColors.navy,
//             padding: EdgeInsets.only(
//               top: MediaQuery.of(context).padding.top + 10,
//               bottom: 16,
//               left: 10,
//               right: 16,
//             ),
//             child: Row(
//               children: [
//                 IconButton(
//                   onPressed: () {
//                     Navigator.pop(context);
//                   },
//                   icon: const Icon(
//                     Icons.arrow_back_ios_new,
//                     color: AppColors.white,
//                   ),
//                 ),
//                 Text(
//                   'Add Ledger',
//                   style: GoogleFonts.poppins(
//                     fontSize: 18,
//                     fontWeight: FontWeight.w600,
//                     color: AppColors.white,
//                   ),
//                 ),
//               ],
//             ),
//           ),

//           // FORM
//           Expanded(
//             child: SingleChildScrollView(
//               padding: const EdgeInsets.all(16),
//               child: Form(
//                 key: _formKey,
//                 child: Container(
//                   padding: const EdgeInsets.all(20),
//                   decoration: BoxDecoration(
//                     color: AppColors.white,
//                     borderRadius: BorderRadius.circular(20),
//                   ),
//                   child: Column(
//                     children: [
//                       // NAME FIELD
//                       AppTextField(
//                         label: 'Ledger Name',
//                         hint: 'Enter ledger name',
//                         controller: _nameCtrl,
//                         validator: (v) {
//                           if (v == null || v.trim().isEmpty) {
//                             return 'Ledger name required';
//                           }
//                           return null;
//                         },
//                       ),

//                       const SizedBox(height: 18),

//                       // GROUP DROPDOWN
//                       Align(
//                         alignment: Alignment.centerLeft,
//                         child: Text(
//                           'Group',
//                           style: GoogleFonts.poppins(
//                             fontSize: 13,
//                             fontWeight: FontWeight.w600,
//                           ),
//                         ),
//                       ),

//                       const SizedBox(height: 8),

//                       Consumer<CompanyProvider>(
//                         builder: (context, provider, child) {
//                           final groups =
//                               provider.getGroupsModel?.data ?? [];

//                           return DropdownButtonFormField<Groups>(
//                             value: _selectedGroup,
//                             isExpanded: true,
//                             hint: Text(
//                               'Select Group',
//                               style: GoogleFonts.poppins(
//                                 fontSize: 13,
//                               ),
//                             ),

//                             decoration: InputDecoration(
//                               filled: true,
//                               fillColor: AppColors.white,
//                               contentPadding:
//                                   const EdgeInsets.symmetric(
//                                 horizontal: 16,
//                                 vertical: 14,
//                               ),
//                               border: OutlineInputBorder(
//                                 borderRadius:
//                                     BorderRadius.circular(12),
//                               ),
//                             ),

//                             items: groups.map((group) {
//                               return DropdownMenuItem<Groups>(
//                                 value: group,
//                                 child: Text(
//                                   group.name,
//                                   style: GoogleFonts.poppins(),
//                                 ),
//                               );
//                             }).toList(),

//                             onChanged: (value) {
//                               setState(() {
//                                 _selectedGroup = value;
//                               });
//                             },

//                             validator: (value) {
//                               if (value == null) {
//                                 return 'Please select group';
//                               }
//                               return null;
//                             },
//                           );
//                         },
//                       ),

//                       const SizedBox(height: 24),

//                       // BUTTON
//                       AppButton(
//                         label: 'Save Ledger',
//                         onPressed: _save,
//                         isLoading: _saving,
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }





import 'package:construction_app/models/edit_profile_body.dart';
import 'package:construction_app/models/get_group_model.dart';
import 'package:construction_app/models/get_ledger_model.dart';
import 'package:construction_app/provider/company_provider.dart';
import 'package:construction_app/services/provider_helper_class.dart';
import 'package:construction_app/widgets/app_theme.dart';
import 'package:construction_app/widgets/common_widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

// ── Avatar color palette ───────────────────────────────────────────────────────

const List<Color> _avatarBgs = [
  Color(0xFFFEF3C7),
  Color(0xFFDBEAFE),
  Color(0xFFFEE2E2),
  Color(0xFFEDE9FE),
  Color(0xFFDCFCE7),
  Color(0xFFFED7AA),
];

const List<Color> _avatarFgs = [
  Color(0xFFB45309),
  Color(0xFF1D4ED8),
  Color(0xFFB91C1C),
  Color(0xFF6D28D9),
  Color(0xFF15803D),
  Color(0xFFEA580C),
];

// ── Ledger Model ──────────────────────────────────────────────────────────────

class LedgerEntry {
  final String id;
  final String name;
  final String group;

  LedgerEntry({
    required this.id,
    required this.name,
    required this.group,
  });
}

// ── Ledger Screen ─────────────────────────────────────────────────────────────

class LedgerScreen extends StatefulWidget {
  const LedgerScreen({super.key});

  @override
  State<LedgerScreen> createState() => _LedgerScreenState();
}

class _LedgerScreenState extends State<LedgerScreen> {
  String _search = '';


  Future<void> _openAddLedger() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const AddLedgerScreen(),
      ),
    );

    if (result != null && mounted) {
       await context.read<CompanyProvider>().getLedger(
      (error) {
        debugPrint(error);
      },
    );
      setState(() {
        
      });
    }
  }

  @override
  void initState() {
    //context.read<CompanyProvider>().getLedger(null);
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<CompanyProvider>().getLedger(null);
    });
  }

@override
Widget build(BuildContext context) {
  return Consumer<CompanyProvider>(
    builder: (context, provider, child) {

      // LOADING
      if (provider.loaderState == LoaderState.loading) {
        return const Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      }

      // ERROR
      if (provider.loaderState == LoaderState.error) {
        return const Scaffold(
          body: Center(
            child: Text('Something went wrong'),
          ),
        );
      }

      // NULL CHECK
      final data = provider.getLedgerModel;

      if (data == null || data.data.isEmpty) {
        return Scaffold(
          backgroundColor: AppColors.greyBg,
          body: Column(
            children: [
              Container(
                color: AppColors.navy,
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).padding.top + 16,
                  bottom: 20,
                  left: 20,
                  right: 20,
                ),
                child: Row(
                  mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Accounts',
                          style: GoogleFonts.poppins(
                            fontSize: 15,
                            color: AppColors.greyLight,
                          ),
                        ),
                        Text(
                          'Ledger',
                          style: GoogleFonts.poppins(
                            fontSize: 22,
                            fontWeight: FontWeight.w600,
                            color: AppColors.white,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const Expanded(
                child: Center(
                  child: Text("No Ledger Found"),
                ),
              ),
            ],
          ),
        );
      }

      return Scaffold(
        backgroundColor: AppColors.greyBg,
        body: Column(
          children: [

            // HEADER
            Container(
              color: AppColors.navy,
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).padding.top + 16,
                bottom: 20,
                left: 20,
                right: 20,
              ),
              child: Row(
                mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Accounts',
                        style: GoogleFonts.poppins(
                          fontSize: 15,
                          color: AppColors.greyLight,
                        ),
                      ),
                      Text(
                        'Ledger',
                        style: GoogleFonts.poppins(
                          fontSize: 22,
                          fontWeight: FontWeight.w600,
                          color: AppColors.white,
                        ),
                      ),
                    ],
                  ),

                  GestureDetector(
                    onTap: _openAddLedger,
                    child: Container(
                      padding:
                          const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.amber,
                        borderRadius:
                            BorderRadius.circular(20),
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.add,
                            size: 18,
                            color: AppColors.dark,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            'Add',
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight:
                                  FontWeight.w600,
                              color: AppColors.dark,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // SEARCH
            Padding(
              padding:
                  const EdgeInsets.fromLTRB(
                      16, 12, 16, 4),
              child: TextField(
                onChanged: (v) {
                  setState(() {
                    _search = v;
                  });
                },
                decoration: InputDecoration(
                  hintText: 'Search ledger',
                  prefixIcon:
                      const Icon(Icons.search),
                  filled: true,
                  fillColor: AppColors.white,
                  border: OutlineInputBorder(
                    borderRadius:
                        BorderRadius.circular(12),
                  ),
                ),
              ),
            ),

            // LIST
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: data.data.length,
                itemBuilder: (_, i) {

                  final entry = data.data[i];

                  return _LedgerCard(
                    entry: entry,
                    avatarBg:
                        _avatarBgs[i % _avatarBgs.length],
                    avatarFg:
                        _avatarFgs[i % _avatarFgs.length],
                  );
                },
              ),
            ),
          ],
        ),
      );
    },
  );
}
}
// ── Ledger Card ───────────────────────────────────────────────────────────────

class _LedgerCard extends StatelessWidget {
  final Ledger entry;
  final Color avatarBg;
  final Color avatarFg;

  const _LedgerCard({
    required this.entry,
    required this.avatarBg,
    required this.avatarFg,
  });

  @override
  Widget build(BuildContext context) {
    final initials = entry.name.substring(0, 2).toUpperCase();

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: avatarBg,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Center(
              child: Text(
                initials,
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w700,
                  color: avatarFg,
                ),
              ),
            ),
          ),

          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  entry.name,
                  style: GoogleFonts.poppins(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  entry.groupName,
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: AppColors.grey,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ── Add Ledger Screen ─────────────────────────────────────────────────────────

class AddLedgerScreen extends StatefulWidget {
  const AddLedgerScreen({super.key});

  @override
  State<AddLedgerScreen> createState() => _AddLedgerScreenState();
}

class _AddLedgerScreenState extends State<AddLedgerScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameCtrl = TextEditingController();

  Groups? _selectedGroup;

  bool _saving = false;

  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      context.read<CompanyProvider>().getGroups(
        (error) {
          debugPrint(error);
        },
      );
    });
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _saving = true;
    });

    await context.read<CompanyProvider>().addLedger(
          name: _nameCtrl.text.trim(),
          groupid: _selectedGroup!.id,
        );

    await Future.delayed(const Duration(milliseconds: 500));

    setState(() {
      _saving = false;
    });

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Ledger added successfully!',
          style: GoogleFonts.poppins(),
        ),
      ),
    );

    Navigator.pop(
      context,
      LedgerEntry(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        name: _nameCtrl.text.trim(),
        group: _selectedGroup!.name,
      ),
    );
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.greyBg,
      body: Column(
        children: [
          // HEADER
          Container(
            color: AppColors.navy,
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top + 10,
              bottom: 16,
              left: 10,
              right: 16,
            ),
            child: Row(
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.arrow_back_ios_new,
                    color: AppColors.white,
                  ),
                ),
                Text(
                  'Add Ledger',
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: AppColors.white,
                  ),
                ),
              ],
            ),
          ),

          // FORM
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: _formKey,
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    children: [
                      // NAME FIELD
                      AppTextField(
                        label: 'Ledger Name',
                        hint: 'Enter ledger name',
                        controller: _nameCtrl,
                        validator: (v) {
                          if (v == null || v.trim().isEmpty) {
                            return 'Ledger name required';
                          }
                          return null;
                        },
                      ),

                      const SizedBox(height: 18),

                      // GROUP DROPDOWN
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Group',
                          style: GoogleFonts.poppins(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),

                      const SizedBox(height: 8),

                      Consumer<CompanyProvider>(
                        builder: (context, provider, child) {
                          final groups =
                              provider.getGroupsModel?.data ?? [];

                          return DropdownButtonFormField<Groups>(
                            value: _selectedGroup,
                            isExpanded: true,
                            hint: Text(
                              'Select Group',
                              style: GoogleFonts.poppins(
                                fontSize: 13,
                              ),
                            ),

                            decoration: InputDecoration(
                              filled: true,
                              fillColor: AppColors.white,
                              contentPadding:
                                  const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 14,
                              ),
                              border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.circular(12),
                              ),
                            ),

                            items: groups.map((group) {
                              return DropdownMenuItem<Groups>(
                                value: group,
                                child: Text(
                                  group.name,
                                  style: GoogleFonts.poppins(),
                                ),
                              );
                            }).toList(),

                            onChanged: (value) {
                              setState(() {
                                _selectedGroup = value;
                              });
                            },

                            validator: (value) {
                              if (value == null) {
                                return 'Please select group';
                              }
                              return null;
                            },
                          );
                        },
                      ),

                      const SizedBox(height: 24),

                      // BUTTON
                      AppButton(
                        label: 'Save Ledger',
                        onPressed: _save,
                        isLoading: _saving,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}