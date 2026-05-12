// To parse this JSON data, do
//
//     final getPaymentModel = getPaymentModelFromJson(jsonString);

import 'dart:convert';

GetPaymentModel getPaymentModelFromJson(String str) => GetPaymentModel.fromJson(json.decode(str));

String getPaymentModelToJson(GetPaymentModel data) => json.encode(data.toJson());

class GetPaymentModel {
    bool status;
    String message;
    List<GetPayment> data;

    GetPaymentModel({
        required this.status,
        required this.message,
        required this.data,
    });

    factory GetPaymentModel.fromJson(Map<String, dynamic> json) => GetPaymentModel(
        status: json["status"],
        message: json["message"],
        data: List<GetPayment>.from(json["data"].map((x) => GetPayment.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class GetPayment {
    int id;
    int companyId;
    int siteId;
    String siteName;
    int stageId;
    String stageName;
    DateTime paymentDate;
    dynamic amount;
    dynamic paymentModeId;
    dynamic paymentMode;
    String? remarks;
    dynamic paymentType;
    String paymentTypeLabel;
    DateTime createdAt;
    DateTime updatedAt;

    GetPayment({
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

    factory GetPayment.fromJson(Map<String, dynamic> json) => GetPayment(
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
