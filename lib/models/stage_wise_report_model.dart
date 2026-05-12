// To parse this JSON data, do
//
//     final stageWiseReportModel = stageWiseReportModelFromJson(jsonString);

import 'dart:convert';

StageWiseReportModel stageWiseReportModelFromJson(String str) => StageWiseReportModel.fromJson(json.decode(str));

String stageWiseReportModelToJson(StageWiseReportModel data) => json.encode(data.toJson());

class StageWiseReportModel {
    bool status;
    String message;
    List<StageWiseReport> data;

    StageWiseReportModel({
        required this.status,
        required this.message,
        required this.data,
    });

    factory StageWiseReportModel.fromJson(Map<String, dynamic> json) => StageWiseReportModel(
        status: json["status"],
        message: json["message"],
        data: List<StageWiseReport>.from(json["data"].map((x) => StageWiseReport.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class StageWiseReport {
    int stageId;
    String stageName;
    String siteName;
    int status;
    int totalSpent;
    Labour materials;
    Labour labour;

    StageWiseReport({
        required this.stageId,
        required this.stageName,
        required this.siteName,
        required this.status,
        required this.totalSpent,
        required this.materials,
        required this.labour,
    });

    factory StageWiseReport.fromJson(Map<String, dynamic> json) => StageWiseReport(
        stageId: json["stage_id"],
        stageName: json["stage_name"],
        siteName: json["site_name"],
        status: json["status"],
        totalSpent: json["total_spent"],
        materials: Labour.fromJson(json["materials"]),
        labour: Labour.fromJson(json["labour"]),
    );

    Map<String, dynamic> toJson() => {
        "stage_id": stageId,
        "stage_name": stageName,
        "site_name": siteName,
        "status": status,
        "total_spent": totalSpent,
        "materials": materials.toJson(),
        "labour": labour.toJson(),
    };
}

class Labour {
    int count;
    String amount;
    int percentage;

    Labour({
        required this.count,
        required this.amount,
        required this.percentage,
    });

    factory Labour.fromJson(Map<String, dynamic> json) => Labour(
        count: json["count"],
        amount: json["amount"],
        percentage: json["percentage"],
    );

    Map<String, dynamic> toJson() => {
        "count": count,
        "amount": amount,
        "percentage": percentage,
    };
}
