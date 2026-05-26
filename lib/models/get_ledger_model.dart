// To parse this JSON data, do
//
//     final getLedgerModel = getLedgerModelFromJson(jsonString);

import 'dart:convert';

GetLedgerModel getLedgerModelFromJson(String str) => GetLedgerModel.fromJson(json.decode(str));

String getLedgerModelToJson(GetLedgerModel data) => json.encode(data.toJson());

class GetLedgerModel {
    bool status;
    String message;
    List<Ledger> data;

    GetLedgerModel({
        required this.status,
        required this.message,
        required this.data,
    });

    factory GetLedgerModel.fromJson(Map<String, dynamic> json) => GetLedgerModel(
        status: json["status"],
        message: json["message"],
        data: List<Ledger>.from(json["data"].map((x) => Ledger.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class Ledger {
    int id;
    String name;
    int groupId;
    String groupName;
    String initials;

    Ledger({
        required this.id,
        required this.name,
        required this.groupId,
        required this.groupName,
        required this.initials,
    });

    factory Ledger.fromJson(Map<String, dynamic> json) => Ledger(
        id: json["id"],
        name: json["name"],
        groupId: json["group_id"],
        groupName: json["group_name"],
        initials: json["initials"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "group_id": groupId,
        "group_name": groupName,
        "initials": initials,
    };
}
