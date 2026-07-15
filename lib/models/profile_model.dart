// // To parse this JSON data, do
// //
// //     final profileModel = profileModelFromJson(jsonString);

// import 'dart:convert';

// ProfileModel profileModelFromJson(String str) => ProfileModel.fromJson(json.decode(str));

// String profileModelToJson(ProfileModel data) => json.encode(data.toJson());

// class ProfileModel {
//     bool status;
//     ProfileData data;

//     ProfileModel({
//         required this.status,
//         required this.data,
//     });

//     factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
//         status: json["status"],
//         data: ProfileData.fromJson(json["data"]),
//     );

//     Map<String, dynamic> toJson() => {
//         "status": status,
//         "data": data.toJson(),
//     };
// }

// class ProfileData {
//     int id;
//     String name;
//     dynamic email;
//     String mobile;
//     String role;
//     dynamic avatar;
//     Subscription subscription;
//     Company company;
//     Registration registration;
//     App app;

//     ProfileData({
//         required this.id,
//         required this.name,
//         required this.email,
//         required this.mobile,
//         required this.role,
//         required this.avatar,
//         required this.subscription,
//         required this.company,
//         required this.registration,
//         required this.app,
//     });

//     factory ProfileData.fromJson(Map<String, dynamic> json) => ProfileData(
//         id: json["id"],
//         name: json["name"],
//         email: json["email"],
//         mobile: json["mobile"],
//         role: json["role"],
//         avatar: json["avatar"],
//         subscription: Subscription.fromJson(json["subscription"]),
//         company: Company.fromJson(json["company"]),
//         registration: Registration.fromJson(json["registration"]),
//         app: App.fromJson(json["app"]),
//     );

//     Map<String, dynamic> toJson() => {
//         "id": id,
//         "name": name,
//         "email": email,
//         "mobile": mobile,
//         "role": role,
//         "avatar": avatar,
//         "subscription": subscription.toJson(),
//         "company": company.toJson(),
//         "registration": registration.toJson(),
//         "app": app.toJson(),
//     };
// }

// class App {
//     String version;

//     App({
//         required this.version,
//     });

//     factory App.fromJson(Map<String, dynamic> json) => App(
//         version: json["version"],
//     );

//     Map<String, dynamic> toJson() => {
//         "version": version,
//     };
// }

// class Company {
//     int id;
//     String name;
//     dynamic email;
//     String phone;
//     dynamic logo;
//     dynamic companyType;
//     dynamic registrationNumber;
//     dynamic gstNumber;
//     dynamic address;
//     dynamic city;
//     dynamic state;
//     dynamic pincode;
//     int status;
//     String statusLabel;

//     Company({
//         required this.id,
//         required this.name,
//         required this.email,
//         required this.phone,
//         required this.logo,
//         required this.companyType,
//         required this.registrationNumber,
//         required this.gstNumber,
//         required this.address,
//         required this.city,
//         required this.state,
//         required this.pincode,
//         required this.status,
//         required this.statusLabel,
//     });

//     factory Company.fromJson(Map<String, dynamic> json) => Company(
//         id: json["id"],
//         name: json["name"],
//         email: json["email"],
//         phone: json["phone"],
//         logo: json["logo"],
//         companyType: json["company_type"],
//         registrationNumber: json["registration_number"],
//         gstNumber: json["gst_number"],
//         address: json["address"],
//         city: json["city"],
//         state: json["state"],
//         pincode: json["pincode"],
//         status: json["status"],
//         statusLabel: json["status_label"],
//     );

//     Map<String, dynamic> toJson() => {
//         "id": id,
//         "name": name,
//         "email": email,
//         "phone": phone,
//         "logo": logo,
//         "company_type": companyType,
//         "registration_number": registrationNumber,
//         "gst_number": gstNumber,
//         "address": address,
//         "city": city,
//         "state": state,
//         "pincode": pincode,
//         "status": status,
//         "status_label": statusLabel,
//     };
// }

// class Registration {
//     String status;
//     List<RegistrationStep> steps;

//     Registration({
//         required this.status,
//         required this.steps,
//     });

//     factory Registration.fromJson(Map<String, dynamic> json) => Registration(
//         status: json["status"],
//         steps: List<RegistrationStep>.from(json["steps"].map((x) => RegistrationStep.fromJson(x))),
//     );

//     Map<String, dynamic> toJson() => {
//         "status": status,
//         "steps": List<dynamic>.from(steps.map((x) => x.toJson())),
//     };
// }

// class RegistrationStep {
//     String key;
//     String label;
//     bool completed;

//     RegistrationStep({
//         required this.key,
//         required this.label,
//         required this.completed,
//     });

//     factory RegistrationStep.fromJson(Map<String, dynamic> json) => RegistrationStep(
//         key: json["key"],
//         label: json["label"],
//         completed: json["completed"],
//     );

//     Map<String, dynamic> toJson() => {
//         "key": key,
//         "label": label,
//         "completed": completed,
//     };
// }

// class Subscription {
//     String plan;
//     DateTime trialStartsAt;
//     DateTime trialExpiresAt;
//     int trialDaysLeft;
//     bool trialExpired;
//     String badgeLabel;
//     bool? showPaymentPopup;

//     Subscription({
//         required this.plan,
//         required this.trialStartsAt,
//         required this.trialExpiresAt,
//         required this.trialDaysLeft,
//         required this.trialExpired,
//         required this.badgeLabel,
//         this.showPaymentPopup,
//     });

//     factory Subscription.fromJson(Map<String, dynamic> json) => Subscription(
//         plan: json["plan"],
//         trialStartsAt: DateTime.parse(json["trial_starts_at"]),
//         trialExpiresAt: DateTime.parse(json["trial_expires_at"]),
//         trialDaysLeft: json["trial_days_left"],
//         trialExpired: json["trial_expired"],
//         badgeLabel: json["badge_label"],
//         showPaymentPopup: json["show_payment_popup"],
//     );

//     Map<String, dynamic> toJson() => {
//         "plan": plan,
//         "trial_starts_at": "${trialStartsAt.year.toString().padLeft(4, '0')}-${trialStartsAt.month.toString().padLeft(2, '0')}-${trialStartsAt.day.toString().padLeft(2, '0')}",
//         "trial_expires_at": "${trialExpiresAt.year.toString().padLeft(4, '0')}-${trialExpiresAt.month.toString().padLeft(2, '0')}-${trialExpiresAt.day.toString().padLeft(2, '0')}",
//         "trial_days_left": trialDaysLeft,
//         "trial_expired": trialExpired,
//         "badge_label": badgeLabel,
//         "show_payment_popup": showPaymentPopup,
//     };
// }




// To parse this JSON data, do
//
//     final profileModel = profileModelFromJson(jsonString);

import 'dart:convert';

ProfileModel profileModelFromJson(String str) => ProfileModel.fromJson(json.decode(str));

String profileModelToJson(ProfileModel data) => json.encode(data.toJson());

class ProfileModel {
    bool status;
    ProfileData data;

    ProfileModel({
        required this.status,
        required this.data,
    });

    factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
        status: json["status"],
        data: ProfileData.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "data": data.toJson(),
    };
}

class ProfileData {
    int id;
    String name;
    dynamic email;
    String mobile;
    String role;
    dynamic avatar;
    Subscription subscription;
    Company company;
    Registration registration;
    App app;

    ProfileData({
        required this.id,
        required this.name,
        required this.email,
        required this.mobile,
        required this.role,
        required this.avatar,
        required this.subscription,
        required this.company,
        required this.registration,
        required this.app,
    });

    factory ProfileData.fromJson(Map<String, dynamic> json) => ProfileData(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        mobile: json["mobile"],
        role: json["role"],
        avatar: json["avatar"],
        subscription: Subscription.fromJson(json["subscription"]),
        company: Company.fromJson(json["company"]),
        registration: Registration.fromJson(json["registration"]),
        app: App.fromJson(json["app"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "mobile": mobile,
        "role": role,
        "avatar": avatar,
        "subscription": subscription.toJson(),
        "company": company.toJson(),
        "registration": registration.toJson(),
        "app": app.toJson(),
    };
}

class App {
    String version;

    App({
        required this.version,
    });

    factory App.fromJson(Map<String, dynamic> json) => App(
        version: json["version"],
    );

    Map<String, dynamic> toJson() => {
        "version": version,
    };
}

class Company {
    int id;
    String name;
    dynamic email;
    String phone;
    dynamic logo;
    dynamic companyType;
    dynamic registrationNumber;
    dynamic gstNumber;
    dynamic address;
    dynamic city;
    dynamic state;
    dynamic pincode;
    int status;
    String statusLabel;

    Company({
        required this.id,
        required this.name,
        required this.email,
        required this.phone,
        required this.logo,
        required this.companyType,
        required this.registrationNumber,
        required this.gstNumber,
        required this.address,
        required this.city,
        required this.state,
        required this.pincode,
        required this.status,
        required this.statusLabel,
    });

    factory Company.fromJson(Map<String, dynamic> json) => Company(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        phone: json["phone"],
        logo: json["logo"],
        companyType: json["company_type"],
        registrationNumber: json["registration_number"],
        gstNumber: json["gst_number"],
        address: json["address"],
        city: json["city"],
        state: json["state"],
        pincode: json["pincode"],
        status: json["status"],
        statusLabel: json["status_label"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "phone": phone,
        "logo": logo,
        "company_type": companyType,
        "registration_number": registrationNumber,
        "gst_number": gstNumber,
        "address": address,
        "city": city,
        "state": state,
        "pincode": pincode,
        "status": status,
        "status_label": statusLabel,
    };
}

class Registration {
    String status;
    List<RegistrationStep> steps;

    Registration({
        required this.status,
        required this.steps,
    });

    factory Registration.fromJson(Map<String, dynamic> json) => Registration(
        status: json["status"],
        steps: List<RegistrationStep>.from(json["steps"].map((x) => RegistrationStep.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "steps": List<dynamic>.from(steps.map((x) => x.toJson())),
    };
}

class RegistrationStep {
    String key;
    String label;
    bool completed;

    RegistrationStep({
        required this.key,
        required this.label,
        required this.completed,
    });

    factory RegistrationStep.fromJson(Map<String, dynamic> json) => RegistrationStep(
        key: json["key"],
        label: json["label"],
        completed: json["completed"],
    );

    Map<String, dynamic> toJson() => {
        "key": key,
        "label": label,
        "completed": completed,
    };
}

class Subscription {
    String plan;
    DateTime trialStartsAt;
    DateTime trialExpiresAt;
    int trialDaysLeft;
    bool trialExpired;
    String badgeLabel;
    bool? showPaymentPopup;
    String? subscriptionStatus;

    Subscription({
        required this.plan,
        required this.trialStartsAt,
        required this.trialExpiresAt,
        required this.trialDaysLeft,
        required this.trialExpired,
        required this.badgeLabel,
        this.showPaymentPopup,
        this.subscriptionStatus,
    });

    factory Subscription.fromJson(Map<String, dynamic> json) => Subscription(
        plan: json["plan"],
        trialStartsAt: DateTime.parse(json["trial_starts_at"]),
        trialExpiresAt: DateTime.parse(json["trial_expires_at"]),
        trialDaysLeft: json["trial_days_left"],
        trialExpired: json["trial_expired"],
        badgeLabel: json["badge_label"],
        showPaymentPopup: json["show_payment_popup"],
        subscriptionStatus: json["subscription_status"],
    );

    Map<String, dynamic> toJson() => {
        "plan": plan,
        "trial_starts_at": "${trialStartsAt.year.toString().padLeft(4, '0')}-${trialStartsAt.month.toString().padLeft(2, '0')}-${trialStartsAt.day.toString().padLeft(2, '0')}",
        "trial_expires_at": "${trialExpiresAt.year.toString().padLeft(4, '0')}-${trialExpiresAt.month.toString().padLeft(2, '0')}-${trialExpiresAt.day.toString().padLeft(2, '0')}",
        "trial_days_left": trialDaysLeft,
        "trial_expired": trialExpired,
        "badge_label": badgeLabel,
        "show_payment_popup": showPaymentPopup,
    };
}