import 'package:construction_app/models/models.dart';
import 'package:construction_app/models/sitesbycompanies.dart';
import 'package:construction_app/provider/company_provider.dart';
import 'package:construction_app/services/provider_helper_class.dart';
import 'package:construction_app/services/shared_preference_helper.dart';
import 'package:construction_app/view/company/add_site_screen.dart';
import 'package:construction_app/view/company/site_detail_screen.dart';
import 'package:construction_app/view/company/widgets/site_card.dart';
import 'package:construction_app/widgets/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class SitesScreen extends StatefulWidget {
  const SitesScreen({super.key});

  @override
  State<SitesScreen> createState() => _SitesScreenState();
}

class _SitesScreenState extends State<SitesScreen> {
  String _search = '';
  //final List<Site> dummysites = getSampleSites();

  // List<SiteModel> get _filtered => sampleSites
  //     .where((s) =>
  //         s.name.toLowerCase().contains(_search.toLowerCase()) ||
  //         s.contactPerson.toLowerCase().contains(_search.toLowerCase()))
  //     .toList();


@override
void initState() {
  super.initState();

  Future.microtask(() async {
    final companyId = await SharedPreferenceHelper.getCompanyId();
    if (mounted) {
      context.read<CompanyProvider>().sitesbycompanies(companyId: companyId);
    }
    context.read<CompanyProvider>().getSupervisors();
  });
}

// void loadSupervisors() async {
//   final result = await context.read<CompanyProvider>().getSupervisors();
//   setState(() {
   
//   });
// }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.greyBg,
      body: Column(
        children: [
          // Header
          Container(
            color: AppColors.navy,
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top + 16,
              bottom: 20,
              left: 20,
              right: 20,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Management',
                        style: GoogleFonts.poppins(
                            fontSize: 15, color: AppColors.greyLight)),
                    Text('Sites',
                        style: GoogleFonts.poppins(
                          fontSize: 22,
                          fontWeight: FontWeight.w600,
                          color: AppColors.white,
                        )),
                  ],
                ),
                GestureDetector(
                  onTap: () => Navigator.push(context,
                      MaterialPageRoute(builder: (_) => const AddSiteScreen())),
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                    decoration: BoxDecoration(
                      color: AppColors.amber,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.add, size: 18, color: AppColors.dark),
                        const SizedBox(width: 4),
                        Text('Add Site',
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: AppColors.dark,
                            )),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Search bar
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
            child: TextField(
              onChanged: (v) => setState(() => _search = v),
              style: GoogleFonts.poppins(fontSize: 15),
              decoration: InputDecoration(
                hintText: 'Search sites...',
                filled: true,
                fillColor: AppColors.white,
                prefixIcon:
                    const Icon(Icons.search, color: AppColors.grey, size: 20),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: AppColors.border),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: AppColors.border),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide:
                      const BorderSide(color: AppColors.amber, width: 2),
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 12),
              ),
            ),
          ),

          // List
          Expanded(
            child: Consumer<CompanyProvider>(
              builder: (context, provider, child) {
                final sites = provider.sitesList;
                if (provider.loaderState == LoaderState.loading && sites.isEmpty) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (sites.isEmpty) {
                  return const Center(child: Text('No sites found'));
                }
                return ListView.builder(
                  padding: const EdgeInsets.all(12),
                  itemCount: sites.length,
                  itemBuilder: (context, index) {
                    // Using index % dummysites.length to avoid range error if dummysites is shorter
                   // final dummysite = dummysites[index % dummysites.length];
                    final site = sites[index];
                    return SiteCard(
                      site: site,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SiteDetailScreen(
                              site: site,
                             // dummysite: dummysite,
                            ),
                          ),
                        );
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
 