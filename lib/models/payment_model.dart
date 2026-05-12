// To parse this JSON data, do
//
//     final paymentModel = paymentModelFromJson(jsonString);

import 'dart:convert';

PaymentModel paymentModelFromJson(String str) => PaymentModel.fromJson(json.decode(str));

String paymentModelToJson(PaymentModel data) => json.encode(data.toJson());

class PaymentModel {
    bool status;
    String message;
    Data data;

    PaymentModel({
        required this.status,
        required this.message,
        required this.data,
    });

    factory PaymentModel.fromJson(Map<String, dynamic> json) => PaymentModel(
        status: json["status"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data.toJson(),
    };
}

class Data {
    int id;
    int companyId;
    int siteId;
    String siteName;
    int stageId;
    String stageName;
    DateTime paymentDate;
    int amount;
    dynamic paymentModeId;
    dynamic paymentMode;
    String? remarks;
    int paymentType;
    String paymentTypeLabel;
    DateTime createdAt;
    DateTime updatedAt;

    Data({
        required this.id,
        required this.companyId,
        required this.siteId,
        required this.siteName,
        required this.stageId,
        required this.stageName,
        required this.paymentDate,
        required this.amount,
        required this.paymentModeId,
        required this.paymentMode,
        this.remarks,
        required this.paymentType,
        required this.paymentTypeLabel,
        required this.createdAt,
        required this.updatedAt,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        companyId: json["company_id"],
        siteId: json["site_id"],
        siteName: json["site_name"],
        stageId: json["stage_id"],
        stageName: json["stage_name"],
        paymentDate: DateTime.parse(json["payment_date"]),
        amount: json["amount"],
        paymentModeId: json["payment_mode_id"],
        paymentMode: json["payment_mode"],
        remarks: json["remarks"],
        paymentType: json["payment_type"],
        paymentTypeLabel: json["payment_type_label"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "company_id": companyId,
        "site_id": siteId,
        "site_name": siteName,
        "stage_id": stageId,
        "stage_name": stageName,
        "payment_date": "${paymentDate.year.toString().padLeft(4, '0')}-${paymentDate.month.toString().padLeft(2, '0')}-${paymentDate.day.toString().padLeft(2, '0')}",
        "amount": amount,
        "payment_mode_id": paymentModeId,
        "payment_mode": paymentMode,
        "remarks": remarks,
        "payment_type": paymentType,
        "payment_type_label": paymentTypeLabel,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
    };
}
