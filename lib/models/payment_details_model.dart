// To parse this JSON data, do
//
//     final paymentDetailsModel = paymentDetailsModelFromJson(jsonString);

import 'dart:convert';

PaymentDetailsModel paymentDetailsModelFromJson(String str) => PaymentDetailsModel.fromJson(json.decode(str));

String paymentDetailsModelToJson(PaymentDetailsModel data) => json.encode(data.toJson());

class PaymentDetailsModel {
    bool status;
    List<PaymentDetails> data;

    PaymentDetailsModel({
        required this.status,
        required this.data,
    });

    factory PaymentDetailsModel.fromJson(Map<String, dynamic> json) => PaymentDetailsModel(
        status: json["status"],
        data: List<PaymentDetails>.from(json["data"].map((x) => PaymentDetails.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class PaymentDetails {
    int id;
    String name;
    String durationType;
    int durationDays;
    String price;
    String? originalPrice;
    int? discountPercent;
    String? badge;
    List<String> features;
    String priceLabel;
    String? originalPriceLabel;
    String periodLabel;
    String? saveLabel;

    PaymentDetails({
        required this.id,
        required this.name,
        required this.durationType,
        required this.durationDays,
        required this.price,
        required this.originalPrice,
        required this.discountPercent,
        required this.badge,
        required this.features,
        required this.priceLabel,
        required this.originalPriceLabel,
        required this.periodLabel,
        required this.saveLabel,
    });

    factory PaymentDetails.fromJson(Map<String, dynamic> json) => PaymentDetails(
        id: json["id"],
        name: json["name"],
        durationType: json["duration_type"],
        durationDays: json["duration_days"],
        price: json["price"],
        originalPrice: json["original_price"],
        discountPercent: json["discount_percent"],
        badge: json["badge"],
        features: List<String>.from(json["features"].map((x) => x)),
        priceLabel: json["price_label"],
        originalPriceLabel: json["original_price_label"],
        periodLabel: json["period_label"],
        saveLabel: json["save_label"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "duration_type": durationType,
        "duration_days": durationDays,
        "price": price,
        "original_price": originalPrice,
        "discount_percent": discountPercent,
        "badge": badge,
        "features": List<dynamic>.from(features.map((x) => x)),
        "price_label": priceLabel,
        "original_price_label": originalPriceLabel,
        "period_label": periodLabel,
        "save_label": saveLabel,
    };
}
