class SiteModel {
  final String id;
  final String name;
  final String contactPerson;
  final String mobile;
  final String startDate;
  final String targetDate;
  final double estimatedAmount;
  final String status;
  final String supervisor;
  final String description;

  SiteModel({
    required this.id,
    required this.name,
    required this.contactPerson,
    required this.mobile,
    required this.startDate,
    required this.targetDate,
    required this.estimatedAmount,
    required this.status,
    required this.supervisor,
    required this.description,
  });
}

class MaterialModel {
  final String id;
  final String siteId;
  final String siteName;
  final String materialName;
  final double quantity;
  final String unit;
  final double price;
  final double amount;
  final String supplier;
  final String addedDate;

  MaterialModel({
    required this.id,
    required this.siteId,
    required this.siteName,
    required this.materialName,
    required this.quantity,
    required this.unit,
    required this.price,
    required this.amount,
    required this.supplier,
    required this.addedDate,
  });
}

class LabourModel {
  final String id;
  final String siteId;
  final String siteName;
  final String labourType;
  final double amount;
  final String remarks;
  final String addedDate;

  LabourModel({
    required this.id,
    required this.siteId,
    required this.siteName,
    required this.labourType,
    required this.amount,
    required this.remarks,
    required this.addedDate,
  });
}

// // ── Sample data ──────────────────────────────────────────────────────────────

final List<SiteModel> sampleSites = [
  SiteModel(
    id: '1',
    name: 'Sunrise Residency – Block A',
    contactPerson: 'Rajan Kumar',
    mobile: '+91 98765 43210',
    startDate: '01 Jan 2025',
    targetDate: '30 Jun 2025',
    estimatedAmount: 4500000,
    status: 'Active',
    supervisor: 'Anand Krishnan',
    description: '3-storey residential building with basement parking.',
  ),
  SiteModel(
    id: '2',
    name: 'Metro Commercial Plaza',
    contactPerson: 'Suresh Menon',
    mobile: '+91 97654 32109',
    startDate: '15 Mar 2025',
    targetDate: '31 Dec 2025',
    estimatedAmount: 12000000,
    status: 'On Hold',
    supervisor: 'Rajan Kumar',
    description: 'Commercial complex with 4 floors and basement.',
  ),
  SiteModel(
    id: '3',
    name: 'Green Valley Villas',
    contactPerson: 'Priya Nair',
    mobile: '+91 96543 21098',
    startDate: '01 Aug 2024',
    targetDate: '28 Feb 2025',
    estimatedAmount: 7800000,
    status: 'Completed',
    supervisor: 'Anand Krishnan',
    description: 'Luxury villa project with landscaping.',
  ),
];

final List<MaterialModel> sampleMaterials = [
  MaterialModel(
    id: '1', siteId: '1', siteName: 'Sunrise Residency – Block A',
    materialName: 'Cement (OPC 53)', quantity: 50, unit: 'Bag',
    price: 450, amount: 22500, supplier: 'Ramco Cement', addedDate: '13 Apr 2025',
  ),
  MaterialModel(
    id: '2', siteId: '1', siteName: 'Sunrise Residency – Block A',
    materialName: 'TMT Steel Bars', quantity: 2000, unit: 'Kg',
    price: 56, amount: 112000, supplier: 'SAIL Steel', addedDate: '12 Apr 2025',
  ),
  MaterialModel(
    id: '3', siteId: '2', siteName: 'Metro Commercial Plaza',
    materialName: 'Bricks (9×4×3)', quantity: 5000, unit: 'Nos',
    price: 7, amount: 35000, supplier: 'Local Manufacturer', addedDate: '11 Apr 2025',
  ),
  MaterialModel(
    id: '4', siteId: '1', siteName: 'Sunrise Residency – Block A',
    materialName: 'River Sand', quantity: 6, unit: 'Load',
    price: 3000, amount: 18000, supplier: 'Local Quarry', addedDate: '10 Apr 2025',
  ),
];

final List<LabourModel> sampleLabour = [
  LabourModel(
    id: '1', siteId: '1', siteName: 'Sunrise Residency – Block A',
    labourType: 'Mason', amount: 15000,
    remarks: 'Weekly payment for head mason', addedDate: '12 Apr 2025',
  ),
  LabourModel(
    id: '2', siteId: '1', siteName: 'Sunrise Residency – Block A',
    labourType: 'Helper (×4)', amount: 20000,
    remarks: 'Weekly wages for 4 helpers', addedDate: '12 Apr 2025',
  ),
  LabourModel(
    id: '3', siteId: '2', siteName: 'Metro Commercial Plaza',
    labourType: 'Electrician', amount: 8500,
    remarks: 'Wiring — 1st floor', addedDate: '10 Apr 2025',
  ),
];


class UserModel {
  final String id;
  final String name;
  final String phone;
  final String email;
  final String role;
  final String status;
  final String? initials;

  UserModel({
    required this.id,
    required this.name,
    required this.phone,
    required this.email,
    required this.role,
    required this.status,
     this.initials,
  });
}

// Sample Data
List<UserModel> sampleUsers = [
  UserModel(
    id: '1',
    name: 'Anand Krishnan',
    phone: '9876543210',
    email: 'anand@mail.com',
    role: 'Supervisor',
    status: 'Active',
    initials: 'AK',
  ),
  UserModel(
    id: '2',
    name: 'Priya Nair',
    phone: '9876543211',
    email: 'priya@mail.com',
    role: 'Manager',
    status: 'Inactive',
    initials: 'PN',
  ),
];




// ─── models.dart ────────────────────────────────────────────────────────────

enum SiteStatus { active, onHold, completed }
enum StageStatus { notStarted, pending, active, done, onHold }

// class Site {
//   final String id;
//   final String name;
//   final String contact;
//   final String phone;
//   final String startDate;
//   final String targetDate;
//   final String supervisor;
//   final double estimatedBudget;
//   final double actualSpent;
//   final String description;
//   final SiteStatus status;
//   final List<Stage> stages;

//   Site({
//     required this.id,
//     required this.name,
//     required this.contact,
//     required this.phone,
//     required this.startDate,
//     required this.targetDate,
//     required this.supervisor,
//     required this.estimatedBudget,
//     required this.actualSpent,
//     required this.description,
//     required this.status,
//     required this.stages,
//   });

//   double get budgetProgress => actualSpent / estimatedBudget;

//   List<MaterialEntry> get allMaterials =>
//       stages.expand((s) => s.allMaterials).toList();

//   List<LabourEntry> get allLabour =>
//       stages.expand((s) => s.allLabour).toList();

//   double get totalMaterialsCost =>
//       allMaterials.fold(0, (sum, m) => sum + m.totalAmount);

//   double get totalLabourCost =>
//       allLabour.fold(0, (sum, l) => sum + l.amount);
// }


// class Site {
//   final String id;
//   final String name;
//   final String contactPerson;
//   final String mobile;
//   final DateTime startDate;
//   final DateTime targetDate;
//   final String supervisor;
//   final double estimatedAmount;
//   final double actualSpent;
//   final String status;
//   final String description;
//   final List<WorkingStage> stages;
 
//   Site({
//     required this.id,
//     required this.name,
//     required this.contactPerson,
//     required this.mobile,
//     required this.startDate,
//     required this.targetDate,
//     required this.supervisor,
//     required this.estimatedAmount,
//     required this.actualSpent,
//     required this.status,
//     required this.description,
//     required this.stages,
//   });
 
//   double get budgetProgress => (actualSpent / estimatedAmount * 100).clamp(0, 100);
// }
 

//  class WorkingStage {
//   final String id;
//   final String name;
//   final String description;
//   final String status;
//   final List<SubStage> subStages;
//   final List<MaterialEntry> materials;
//   final List<LabourEntry> labour;
 
//   WorkingStage({
//     required this.id,
//     required this.name,
//     required this.description,
//     required this.status,
//     this.subStages = const [],
//     this.materials = const [],
//     this.labour = const [],
//   });
 
//   double get totalMaterialCost =>
//       materials.fold(0.0, (sum, m) => sum + m.totalAmount) +
//       subStages.fold(0.0, (sum, s) => sum + s.totalMaterialCost);
 
//   double get totalLabourCost =>
//       labour.fold(0.0, (sum, l) => sum + l.amount) +
//       subStages.fold(0.0, (sum, s) => sum + s.totalLabourCost);
// }

// class Stage {
//   final String id;
//   final String name;
//   final String description;
//   final StageStatus status;
//   final List<SubStage> subStages;
//   final List<MaterialEntry> directMaterials;
//   final List<LabourEntry> directLabour;

//   Stage({
//     required this.id,
//     required this.name,
//     required this.description,
//     required this.status,
//     this.subStages = const [],
//     this.directMaterials = const [],
//     this.directLabour = const [],
//   });

//   bool get hasSubStages => subStages.isNotEmpty;

//   List<MaterialEntry> get allMaterials => [
//         ...directMaterials,
//         ...subStages.expand((s) => s.materials),
//       ];

//   List<LabourEntry> get allLabour => [
//         ...directLabour,
//         ...subStages.expand((s) => s.labour),
//       ];

//   double get totalMaterials =>
//       allMaterials.fold(0, (sum, m) => sum + m.totalAmount);

//   double get totalLabour =>
//       allLabour.fold(0, (sum, l) => sum + l.amount);
// }

// class SubStage {
//   final String id;
//   final String name;
//   final String description;
//   final StageStatus status;
//   final List<MaterialEntry> materials;
//   final List<LabourEntry> labour;
//   final String parentStageName;

//   SubStage({
//     required this.id,
//     required this.name,
//     required this.description,
//     required this.status,
//     required this.parentStageName,
//     this.materials = const [],
//     this.labour = const [],
//   });
// }

// class MaterialEntry {
//   final String id;
//   final String name;
//   final double quantity;
//   final String unit;
//   final double pricePerUnit;
//   final String supplier;
//   final String date;
//   final String stageName;
//   final String? subStageName;

//   MaterialEntry({
//     required this.id,
//     required this.name,
//     required this.quantity,
//     required this.unit,
//     required this.pricePerUnit,
//     required this.stageName,
//     this.subStageName,
//     this.supplier = '',
//     this.date = '',
//   });

//   double get totalAmount => quantity * pricePerUnit;

//   String get locationLabel =>
//       subStageName != null ? '$stageName › $subStageName' : stageName;
// }

// class LabourEntry {
//   final String id;
//   final String workerName;
//   final String labourType;
//   final double amount;
//   final String date;
//   final String remarks;
//   final String stageName;
//   final String? subStageName;

//   LabourEntry({
//     required this.id,
//     required this.workerName,
//     required this.labourType,
//     required this.amount,
//     required this.stageName,
//     this.subStageName,
//     this.date = '',
//     this.remarks = '',
//   });

//   String get locationLabel =>
//       subStageName != null ? '$stageName › $subStageName' : stageName;
// }

// // ─── Sample Data ────────────────────────────────────────────────────────────

// // final List<Site> sampleSites = [
// //   Site(
// //     id: 's1',
// //     name: 'Sunrise Residency',
// //     contact: 'Rajan Kumar',
// //     phone: '+91 98765 43210',
// //     startDate: '01 Jan 2025',
// //     targetDate: '30 Jun 2025',
// //     supervisor: 'Anand Krishnan',
// //     estimatedBudget: 4500000,
// //     actualSpent: 2880000,
// //     description:
// //         'G+2 residential building, 6 units per floor. RCC framed structure with brick masonry walls and basement parking.',
// //     status: SiteStatus.active,
// //     stages: [
// //       Stage(
// //         id: 'st1',
// //         name: 'Foundation Work',
// //         description: 'Excavation, PCC & RCC footing',
// //         status: StageStatus.done,
// //         subStages: [
// //           SubStage(
// //             id: 'ss1',
// //             name: 'Excavation',
// //             description: 'Dig to 2m depth',
// //             status: StageStatus.done,
// //             parentStageName: 'Foundation Work',
// //             materials: [
// //               MaterialEntry(
// //                 id: 'm1',
// //                 name: 'M-Sand',
// //                 quantity: 9,
// //                 unit: 'Load',
// //                 pricePerUnit: 6000,
// //                 stageName: 'Foundation Work',
// //                 subStageName: 'Excavation',
// //                 date: '10 Jan 2025',
// //               ),
// //             ],
// //             labour: [
// //               LabourEntry(
// //                 id: 'l1',
// //                 workerName: 'Excavation Team',
// //                 labourType: 'Helper',
// //                 amount: 18000,
// //                 stageName: 'Foundation Work',
// //                 subStageName: 'Excavation',
// //                 date: '08 Jan 2025',
// //                 remarks: '2m depth excavation for foundation area — 6 workers × 3 days',
// //               ),
// //             ],
// //           ),
// //           SubStage(
// //             id: 'ss2',
// //             name: 'PCC Laying',
// //             description: 'Plain cement concrete base',
// //             status: StageStatus.done,
// //             parentStageName: 'Foundation Work',
// //             materials: [
// //               MaterialEntry(
// //                 id: 'm2',
// //                 name: 'River Sand',
// //                 quantity: 3,
// //                 unit: 'Load',
// //                 pricePerUnit: 6000,
// //                 stageName: 'Foundation Work',
// //                 subStageName: 'PCC Laying',
// //                 date: '12 Jan 2025',
// //               ),
// //             ],
// //             labour: [
// //               LabourEntry(
// //                 id: 'l2',
// //                 workerName: 'Ramesh & Team',
// //                 labourType: 'Mason',
// //                 amount: 12000,
// //                 stageName: 'Foundation Work',
// //                 subStageName: 'PCC Laying',
// //                 date: '14 Jan 2025',
// //               ),
// //             ],
// //           ),
// //           SubStage(
// //             id: 'ss3',
// //             name: 'Footing',
// //             description: 'RCC footing with steel bars',
// //             status: StageStatus.done,
// //             parentStageName: 'Foundation Work',
// //             materials: [
// //               MaterialEntry(
// //                 id: 'm3',
// //                 name: 'Cement (OPC 53 Grade)',
// //                 quantity: 120,
// //                 unit: 'Bag',
// //                 pricePerUnit: 700,
// //                 stageName: 'Foundation Work',
// //                 subStageName: 'Footing',
// //                 supplier: 'Local Depot',
// //                 date: '15 Jan 2025',
// //               ),
// //               MaterialEntry(
// //                 id: 'm4',
// //                 name: 'Steel (Fe-500)',
// //                 quantity: 1800,
// //                 unit: 'Kg',
// //                 pricePerUnit: 70,
// //                 stageName: 'Foundation Work',
// //                 subStageName: 'Footing',
// //                 supplier: 'Rajan Steel',
// //               ),
// //             ],
// //             labour: [
// //               LabourEntry(
// //                 id: 'l3',
// //                 workerName: 'Suresh Contractor',
// //                 labourType: 'Contractor',
// //                 amount: 150000,
// //                 stageName: 'Foundation Work',
// //                 subStageName: 'Footing',
// //                 date: '18 Jan 2025',
// //                 remarks: 'Full footing RCC work including shuttering, bending, pouring',
// //               ),
// //             ],
// //           ),
// //         ],
// //       ),
// //       Stage(
// //         id: 'st2',
// //         name: 'Column & Slab',
// //         description: 'RCC columns and floor slabs G+2',
// //         status: StageStatus.active,
// //         directMaterials: [
// //           MaterialEntry(
// //             id: 'm5',
// //             name: 'Cement (OPC 53 Grade)',
// //             quantity: 400,
// //             unit: 'Bag',
// //             pricePerUnit: 700,
// //             stageName: 'Column & Slab',
// //             date: '20 Feb 2025',
// //           ),
// //           MaterialEntry(
// //             id: 'm6',
// //             name: 'Steel Bars (Fe-500)',
// //             quantity: 8000,
// //             unit: 'Kg',
// //             pricePerUnit: 70,
// //             stageName: 'Column & Slab',
// //             supplier: 'Krishna Steel',
// //           ),
// //         ],
// //         directLabour: [
// //           LabourEntry(
// //             id: 'l4',
// //             workerName: 'Steel Benders (4 workers)',
// //             labourType: 'Steel Bender',
// //             amount: 96000,
// //             stageName: 'Column & Slab',
// //             date: '05 Mar 2025',
// //           ),
// //           LabourEntry(
// //             id: 'l5',
// //             workerName: 'Column Shuttering Team',
// //             labourType: 'Carpenter',
// //             amount: 144000,
// //             stageName: 'Column & Slab',
// //             date: '10 Mar 2025',
// //           ),
// //           LabourEntry(
// //             id: 'l6',
// //             workerName: 'Concrete Pouring Crew',
// //             labourType: 'Mason',
// //             amount: 180000,
// //             stageName: 'Column & Slab',
// //             date: '15 Mar 2025',
// //             remarks: 'G+2 slab pouring — 3 floors including ground beam',
// //           ),
// //         ],
// //       ),
// //       Stage(
// //         id: 'st3',
// //         name: 'Brick Masonry',
// //         description: 'Wall construction & plastering',
// //         status: StageStatus.pending,
// //       ),
// //     ],
// //   ),
// //   Site(
// //     id: 's2',
// //     name: 'Metro Commercial Plaza',
// //     contact: 'Suresh Menon',
// //     phone: '+91 97654 32109',
// //     startDate: '15 Mar 2025',
// //     targetDate: '15 Dec 2025',
// //     supervisor: 'Vinod Thomas',
// //     estimatedBudget: 12000000,
// //     actualSpent: 0,
// //     description: 'Commercial complex with ground floor retail and 3 office floors.',
// //     status: SiteStatus.onHold,
// //     stages: [],
// //   ),
// //   Site(
// //     id: 's3',
// //     name: 'Green Valley Villas',
// //     contact: 'Priya Nair',
// //     phone: '+91 96543 21098',
// //     startDate: '01 Jun 2024',
// //     targetDate: '31 Dec 2024',
// //     supervisor: 'Biju Varghese',
// //     estimatedBudget: 3200000,
// //     actualSpent: 3200000,
// //     description: '4 independent villas, duplex style, with individual gardens.',
// //     status: SiteStatus.completed,
// //     stages: [],
// //   ),
// // ];




class Site {
  final String id;
  final String name;
  final String contactPerson;
  final String mobile;
  final DateTime startDate;
  final DateTime targetDate;
  final String supervisor;
  final double estimatedAmount;
  final double actualSpent;
  final String status;
  final String description;
  final List<WorkingStage> stages;
 
  Site({
    required this.id,
    required this.name,
    required this.contactPerson,
    required this.mobile,
    required this.startDate,
    required this.targetDate,
    required this.supervisor,
    required this.estimatedAmount,
    required this.actualSpent,
    required this.status,
    required this.description,
    required this.stages,
  });
 
  double get budgetProgress => (actualSpent / estimatedAmount * 100).clamp(0, 100);
}
 
class WorkingStage {
  final String id;
  final String name;
  final String description;
  final String status;
  final List<SubStage> subStages;
  final List<MaterialEntry> materials;
  final List<LabourEntry> labour;
 
  WorkingStage({
    required this.id,
    required this.name,
    required this.description,
    required this.status,
    this.subStages = const [],
    this.materials = const [],
    this.labour = const [],
  });
 
  double get totalMaterialCost =>
      materials.fold(0.0, (sum, m) => sum + m.totalAmount) +
      subStages.fold(0.0, (sum, s) => sum + s.totalMaterialCost);
 
  double get totalLabourCost =>
      labour.fold(0.0, (sum, l) => sum + l.amount) +
      subStages.fold(0.0, (sum, s) => sum + s.totalLabourCost);
}
 
class SubStage {
  final String id;
  final String name;
  final String description;
  final String status;
  final List<MaterialEntry> materials;
  final List<LabourEntry> labour;
 
  SubStage({
    required this.id,
    required this.name,
    required this.description,
    required this.status,
    this.materials = const [],
    this.labour = const [],
  });
 
  double get totalMaterialCost => materials.fold(0.0, (sum, m) => sum + m.totalAmount);
  double get totalLabourCost => labour.fold(0.0, (sum, l) => sum + l.amount);
}
 
class MaterialEntry {
  final String id;
  final String name;
  final double quantity;
  final String unit;
  final double pricePerUnit;
  final String? supplier;
  final DateTime date;
  final String stageName;
  final String? subStageName;
  final String siteName;
 
  MaterialEntry({
    required this.id,
    required this.name,
    required this.quantity,
    required this.unit,
    required this.pricePerUnit,
    this.supplier,
    required this.date,
    required this.stageName,
    this.subStageName,
    required this.siteName,
  });
 
  double get totalAmount => quantity * pricePerUnit;
}
 
class LabourEntry {
  final String id;
  final String type;
  final String? workerName;
  final double amount;
  final String? remarks;
  final DateTime date;
  final String stageName;
  final String? subStageName;
  final String siteName;
 
  LabourEntry({
    required this.id,
    required this.type,
    this.workerName,
    required this.amount,
    this.remarks,
    required this.date,
    required this.stageName,
    this.subStageName,
    required this.siteName,
  });
}


List<Site> getSampleSites() {
  return [
    Site(
      id: 's1',
      name: 'Sunrise Residency',
      contactPerson: 'Rajan Kumar',
      mobile: '+91 98765 43210',
      startDate: DateTime(2025, 1, 1),
      targetDate: DateTime(2025, 6, 30),
      supervisor: 'Anand Krishnan',
      estimatedAmount: 4500000,
      actualSpent: 2880000,
      status: 'Active',
      description: 'G+2 residential building with 6 units per floor. RCC framed structure with brick masonry walls and basement parking.',
      stages: [
        WorkingStage(
          id: 'st1',
          name: 'Foundation Work',
          description: 'Excavation, PCC & RCC footing',
          status: 'Done',
          subStages: [
            SubStage(
              id: 'sub1',
              name: 'Excavation',
              description: 'Dig to 2m depth as per drawing',
              status: 'Done',
              materials: [
                MaterialEntry(
                  id: 'm1',
                  name: 'Diesel',
                  quantity: 120,
                  unit: 'Litre',
                  pricePerUnit: 95,
                  supplier: 'Local Dealer',
                  date: DateTime(2025, 1, 5),
                  stageName: 'Foundation Work',
                  subStageName: 'Excavation',
                  siteName: 'Sunrise Residency',
                ),
              ],
              labour: [
                LabourEntry(
                  id: 'l1',
                  type: 'Helper',
                  workerName: 'Excavation Team',
                  amount: 18000,
                  remarks: '8 workers × 5 days',
                  date: DateTime(2025, 1, 5),
                  stageName: 'Foundation Work',
                  subStageName: 'Excavation',
                  siteName: 'Sunrise Residency',
                ),
              ],
            ),
            SubStage(
              id: 'sub2',
              name: 'PCC Laying',
              description: 'Plain cement concrete base 1:4:8',
              status: 'Done',
              materials: [
                MaterialEntry(
                  id: 'm2',
                  name: 'Cement (OPC 53)',
                  quantity: 40,
                  unit: 'Bag',
                  pricePerUnit: 450,
                  supplier: 'Ramco',
                  date: DateTime(2025, 1, 8),
                  stageName: 'Foundation Work',
                  subStageName: 'PCC Laying',
                  siteName: 'Sunrise Residency',
                ),
              ],
              labour: [
                LabourEntry(
                  id: 'l2',
                  type: 'Mason',
                  workerName: 'PCC Team',
                  amount: 12000,
                  remarks: 'PCC laying work',
                  date: DateTime(2025, 1, 8),
                  stageName: 'Foundation Work',
                  subStageName: 'PCC Laying',
                  siteName: 'Sunrise Residency',
                ),
              ],
            ),
            SubStage(
              id: 'sub3',
              name: 'Footing',
              description: 'RCC footing with TMT steel bars',
              status: 'Done',
              materials: [
                MaterialEntry(
                  id: 'm3',
                  name: 'TMT Steel Bars',
                  quantity: 3500,
                  unit: 'Kg',
                  pricePerUnit: 56,
                  supplier: 'SAIL',
                  date: DateTime(2025, 1, 12),
                  stageName: 'Foundation Work',
                  subStageName: 'Footing',
                  siteName: 'Sunrise Residency',
                ),
                MaterialEntry(
                  id: 'm4',
                  name: 'Cement (OPC 53)',
                  quantity: 80,
                  unit: 'Bag',
                  pricePerUnit: 450,
                  supplier: 'Ramco',
                  date: DateTime(2025, 1, 12),
                  stageName: 'Foundation Work',
                  subStageName: 'Footing',
                  siteName: 'Sunrise Residency',
                ),
              ],
              labour: [
                LabourEntry(
                  id: 'l3',
                  type: 'Mason (Head)',
                  workerName: 'RCC Footing Team',
                  amount: 150000,
                  remarks: '6 workers × 16 days',
                  date: DateTime(2025, 1, 12),
                  stageName: 'Foundation Work',
                  subStageName: 'Footing',
                  siteName: 'Sunrise Residency',
                ),
              ],
            ),
          ],
        ),
        WorkingStage(
          id: 'st2',
          name: 'Column & Slab',
          description: 'RCC columns and floor slabs G+2',
          status: 'Active',
          materials: [
            MaterialEntry(
              id: 'm5',
              name: 'Cement (OPC 53)',
              quantity: 300,
              unit: 'Bag',
              pricePerUnit: 450,
              supplier: 'Ramco',
              date: DateTime(2025, 2, 1),
              stageName: 'Column & Slab',
              siteName: 'Sunrise Residency',
            ),
            MaterialEntry(
              id: 'm6',
              name: 'TMT Steel (Fe500)',
              quantity: 8000,
              unit: 'Kg',
              pricePerUnit: 56,
              supplier: 'SAIL',
              date: DateTime(2025, 2, 1),
              stageName: 'Column & Slab',
              siteName: 'Sunrise Residency',
            ),
          ],
          labour: [
            LabourEntry(
              id: 'l4',
              type: 'Mason (Head)',
              workerName: 'Head Mason',
              amount: 35000,
              remarks: 'Column & beam work, 2 weeks',
              date: DateTime(2025, 2, 1),
              stageName: 'Column & Slab',
              siteName: 'Sunrise Residency',
            ),
            LabourEntry(
              id: 'l5',
              type: 'Helper',
              workerName: 'Helper Workers (6)',
              amount: 126000,
              remarks: 'Slab casting team, 3 weeks',
              date: DateTime(2025, 2, 5),
              stageName: 'Column & Slab',
              siteName: 'Sunrise Residency',
            ),
          ],
        ),
        WorkingStage(
          id: 'st3',
          name: 'Brick Masonry',
          description: 'Wall construction & plastering',
          status: 'Pending',
        ),
      ],
    ),
  ];
}