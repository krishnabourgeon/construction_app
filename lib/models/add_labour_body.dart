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
    DateTime addedDate;

    AddLabourBody({
        required this.substageId,
        required this.noOfLabours,
        required this.noOfDays,
        required this.amount,
        required this.remarks,
        required this.addedDate,
    });

    factory AddLabourBody.fromJson(Map<String, dynamic> json) => AddLabourBody(
        substageId: json["substage_id"],
        noOfLabours: json["no_of_labours"],
        noOfDays: json["no_of_days"],
        amount: json["amount"],
        remarks: json["remarks"],
        addedDate: DateTime.parse(json["added_date"]),
    );

    Map<String, dynamic> toJson() => {
        "substage_id": substageId,
        "no_of_labours": noOfLabours,
        "no_of_days": noOfDays,
        "amount": amount,
        "remarks": remarks,
        "added_date": "${addedDate.year.toString().padLeft(4, '0')}-${addedDate.month.toString().padLeft(2, '0')}-${addedDate.day.toString().padLeft(2, '0')}",
    };
}
