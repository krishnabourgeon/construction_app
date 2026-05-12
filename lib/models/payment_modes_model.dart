// To parse this JSON data, do
//
//     final paymentModesModel = paymentModesModelFromJson(jsonString);

import 'dart:convert';

PaymentModesModel paymentModesModelFromJson(String str) => PaymentModesModel.fromJson(json.decode(str));

String paymentModesModelToJson(PaymentModesModel data) => json.encode(data.toJson());

class PaymentModesModel {
    bool status;
    String message;
    List<PaymentModes> data;

    PaymentModesModel({
        required this.status,
        required this.message,
        required this.data,
    });

    factory PaymentModesModel.fromJson(Map<String, dynamic> json) => PaymentModesModel(
        status: json["status"],
        message: json["message"],
        data: List<PaymentModes>.from(json["data"].map((x) => PaymentModes.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class PaymentModes {
    int id;
    String name;
    int isActive;
    DateTime createdAt;
    DateTime updatedAt;

    PaymentModes({
        required this.id,
        required this.name,
        required this.isActive,
        required this.createdAt,
        required this.updatedAt,
    });

    factory PaymentModes.fromJson(Map<String, dynamic> json) => PaymentModes(
        id: json["id"],
        name: json["name"],
        isActive: json["is_active"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "is_active": isActive,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
    };

    @override
    bool operator ==(Object other) =>
        identical(this, other) ||
        other is PaymentModes &&
            runtimeType == other.runtimeType &&
            id == other.id;

    @override
    int get hashCode => id.hashCode;
}
