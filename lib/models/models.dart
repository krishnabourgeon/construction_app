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

// ── Sample data ──────────────────────────────────────────────────────────────

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