import 'package:construction_app/models/models.dart';
import 'package:construction_app/view/company/widgets/info_tab.dart';
import 'package:construction_app/view/company/widgets/stages_tab.dart';
import 'package:flutter/material.dart';

class SiteDetailScreen extends StatefulWidget {
  final Site site;
 
  const SiteDetailScreen({super.key, required this.site});
 
  @override
  State<SiteDetailScreen> createState() => _SiteDetailScreenState();
}
 
class _SiteDetailScreenState extends State<SiteDetailScreen> with SingleTickerProviderStateMixin {
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
      appBar: AppBar(
        title: Text(widget.site.name),
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: const Color(0xFFF59E0B),
          labelColor: const Color(0xFFF59E0B),
          unselectedLabelColor: const Color(0xFF9CA3AF),
          labelStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
          tabs: const [
            Tab(text: 'Info'),
            Tab(text: 'Working Stages'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          InfoTab(site: widget.site),
          WorkingStagesTab(site: widget.site),
        ],
      ),
    );
  }
}
 
