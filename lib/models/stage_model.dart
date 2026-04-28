class SubStageModel {
  final String id;
  final String name;
  final String description;

  SubStageModel({required this.id, required this.name, required this.description});
}

class StageMaterialModel {
  final String id;
  final String materialName;
  final double quantity;
  final String unit;
  final double price;
  final double amount;
  final String supplier;
  final String addedDate;

  StageMaterialModel({
    required this.id, required this.materialName, required this.quantity,
    required this.unit, required this.price, required this.amount,
    required this.supplier, required this.addedDate,
  });
}

class StageLabourModel {
  final String id;
  final String labourType;
  final double amount;
  final String remarks;
  final String addedDate;

  StageLabourModel({
    required this.id, required this.labourType, required this.amount,
    required this.remarks, required this.addedDate,
  });
}

class WorkingStageModel {
  final String id;
  final String siteId;
  String name;
  String description;
  String status;
  List<SubStageModel> subStages;
  List<StageMaterialModel> materials;
  List<StageLabourModel> labour;

  WorkingStageModel({
    required this.id, required this.siteId, required this.name,
    required this.description, required this.status,
    this.subStages = const [],
    this.materials = const [],
    this.labour = const [],
  });
}

// Sample data
List<WorkingStageModel> sampleStages = [
  WorkingStageModel(
    id: '1', siteId: '1', name: 'Foundation Work',
    description: 'Excavation, PCC & footing', status: 'Done',
    subStages: [
      SubStageModel(id: 's1', name: 'Excavation', description: 'Dig to 2m depth'),
      SubStageModel(id: 's2', name: 'PCC Laying', description: 'Plain cement concrete base'),
      SubStageModel(id: 's3', name: 'Footing', description: 'RCC footing with steel'),
    ],
    materials: [
      StageMaterialModel(id: 'm1', materialName: 'Cement (OPC 53)', quantity: 30, unit: 'Bag', price: 450, amount: 13500, supplier: 'Ramco Cement', addedDate: '10 Apr 2025'),
      StageMaterialModel(id: 'm2', materialName: 'TMT Steel Bars', quantity: 500, unit: 'Kg', price: 56, amount: 28000, supplier: 'SAIL Steel', addedDate: '10 Apr 2025'),
      StageMaterialModel(id: 'm3', materialName: 'River Sand', quantity: 2, unit: 'Load', price: 3000, amount: 6000, supplier: 'Local Quarry', addedDate: '08 Apr 2025'),
    ],
    labour: [
      StageLabourModel(id: 'l1', labourType: 'Mason (Head)', amount: 12000, remarks: 'Footing work', addedDate: '10 Apr 2025'),
      StageLabourModel(id: 'l2', labourType: 'Helper (x3)', amount: 9000, remarks: 'Excavation work', addedDate: '08 Apr 2025'),
    ],
  ),
  WorkingStageModel(
    id: '2', siteId: '1', name: 'Column & Slab',
    description: 'RCC columns and floor slabs', status: 'Active',
    subStages: [],
    materials: [
      StageMaterialModel(id: 'm4', materialName: 'Cement (OPC 53)', quantity: 50, unit: 'Bag', price: 450, amount: 22500, supplier: 'Ramco Cement', addedDate: '13 Apr 2025'),
    ],
    labour: [
      StageLabourModel(id: 'l3', labourType: 'Mason', amount: 15000, remarks: 'Column casting', addedDate: '12 Apr 2025'),
    ],
  ),
  WorkingStageModel(id: '3', siteId: '1', name: 'Brick Masonry', description: 'Wall construction', status: 'Pending'),
  WorkingStageModel(id: '4', siteId: '1', name: 'Plastering & Finishing', description: 'Internal & external plaster', status: 'Pending'),
];
