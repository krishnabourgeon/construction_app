// To parse this JSON data, do
//
//     final versionModel = versionModelFromJson(jsonString);

import 'dart:convert';

VersionModel versionModelFromJson(String str) => VersionModel.fromJson(json.decode(str));

String versionModelToJson(VersionModel data) => json.encode(data.toJson());

class VersionModel {
    bool success;
    String androidVersion;
    String iosVersion;

    VersionModel({
        required this.success,
        required this.androidVersion,
        required this.iosVersion,
    });

    factory VersionModel.fromJson(Map<String, dynamic> json) => VersionModel(
        success: json["success"],
        androidVersion: json["android_version"],
        iosVersion: json["ios_version"],
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "android_version": androidVersion,
        "ios_version": iosVersion,
    };
}
