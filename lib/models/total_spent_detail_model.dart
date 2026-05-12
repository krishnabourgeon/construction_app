// To parse this JSON data, do
//
//     final totalSpentDetailModel = totalSpentDetailModelFromJson(jsonString);

import 'dart:convert';

TotalSpentDetailModel totalSpentDetailModelFromJson(String str) => TotalSpentDetailModel.fromJson(json.decode(str));

String totalSpentDetailModelToJson(TotalSpentDetailModel data) => json.encode(data.toJson());

class TotalSpentDetailModel {
    bool status;
    String message;
    TotalSpent data;

    TotalSpentDetailModel({
        required this.status,
        required this.message,
        required this.data,
    });

    factory TotalSpentDetailModel.fromJson(Map<String, dynamic> json) => TotalSpentDetailModel(
        status: json["status"],
        message: json["message"],
        data: TotalSpent.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data.toJson(),
    };
}

class TotalSpent {
    String siteName;
    int totalMaterials;
    int totalLabour;
    int totalSpent;
    List<TotalMaterials> materials;
    List<TotalLabours> labours;

    TotalSpent({
        required this.siteName,
        required this.totalMaterials,
        required this.totalLabour,
        required this.totalSpent,
        required this.materials,
        required this.labours,
    });

    factory TotalSpent.fromJson(Map<String, dynamic> json) => TotalSpent(
        siteName: json["site_name"],
        totalMaterials: json["total_materials"],
        totalLabour: json["total_labour"],
        totalSpent: json["total_spent"],
        materials: List<TotalMaterials>.from(json["materials"].map((x) => TotalMaterials.fromJson(x))),
        labours: List<TotalLabours>.from(json["labours"].map((x) => TotalLabours.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "site_name": siteName,
        "total_materials": totalMaterials,
        "total_labour": totalLabour,
        "total_spent": totalSpent,
        "materials": List<dynamic>.from(materials.map((x) => x.toJson())),
        "labours": List<dynamic>.from(labours.map((x) => x.toJson())),
    };
}

class TotalLabours {
    int id;
    String stageName;
    String substageName;
    int noOfLabours;
    int noOfDays;
    String amount;
    dynamic addedDate;
    dynamic remarks;

    TotalLabours({
        required this.id,
        required this.stageName,
        required this.substageName,
        required this.noOfLabours,
        required this.noOfDays,
        required this.amount,
        required this.addedDate,
        required this.remarks,
    });

    factory TotalLabours.fromJson(Map<String, dynamic> json) => TotalLabours(
        id: json["id"],
        stageName: json["stage_name"],
        substageName: json["substage_name"],
        noOfLabours: json["no_of_labours"],
        noOfDays: json["no_of_days"],
        amount: json["amount"],
        addedDate: json["added_date"],
        remarks: json["remarks"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "stage_name": stageName,
        "substage_name": substageName,
        "no_of_labours": noOfLabours,
        "no_of_days": noOfDays,
        "amount": amount,
        "added_date": addedDate,
        "remarks": remarks,
    };
}

class TotalMaterials {
    int id;
    String materialName;
    String stageName;
    String substageName;
    String qty;
    String price;
    String amount;
    DateTime addedDate;
    String suppliername;
    String unitname;

    TotalMaterials({
        required this.id,
        required this.materialName,
        required this.stageName,
        required this.substageName,
        required this.qty,
        required this.price,
        required this.amount,
        required this.addedDate,
        required this.suppliername,
        required this.unitname,
    });

    factory TotalMaterials.fromJson(Map<String, dynamic> json) => TotalMaterials(
        id: json["id"],
        materialName: json["material_name"],
        stageName: json["stage_name"],
        substageName: json["substage_name"],
        qty: json["qty"],
        price: json["price"],
        amount: json["amount"],
        addedDate: DateTime.parse(json["added_date"]),
        suppliername: json["supplier_name"] ?? "N/A",
        unitname: json["unit_name"] ?? "N/A",
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "material_name": materialName,
        "stage_name": stageName,
        "substage_name": substageName,
        "qty": qty,
        "price": price,
        "amount": amount,
        "added_date": "${addedDate.year.toString().padLeft(4, '0')}-${addedDate.month.toString().padLeft(2, '0')}-${addedDate.day.toString().padLeft(2, '0')}",
        "supplier_name": suppliername,
        "unit_name": unitname,
    };
}
