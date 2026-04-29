// To parse this JSON data, do
//
//     final addLabourBody = addLabourBodyFromJson(jsonString);

import 'dart:convert';

AddLabourBody addLabourBodyFromJson(String str) => AddLabourBody.fromJson(json.decode(str));

String addLabourBodyToJson(AddLabourBody data) => json.encode(data.toJson());

class AddLabourBody {
    int substageId;
    int noOfLabours;
    int noOfDays;
    int amount;
    String remarks;

    AddLabourBody({
        required this.substageId,
        required this.noOfLabours,
        required this.noOfDays,
        required this.amount,
        required this.remarks,
    });

    factory AddLabourBody.fromJson(Map<String, dynamic> json) => AddLabourBody(
        substageId: json["substage_id"],
        noOfLabours: json["no_of_labours"],
        noOfDays: json["no_of_days"],
        amount: json["amount"],
        remarks: json["remarks"],
    );

    Map<String, dynamic> toJson() => {
        "substage_id": substageId,
        "no_of_labours": noOfLabours,
        "no_of_days": noOfDays,
        "amount": amount,
        "remarks": remarks,
    };
}
