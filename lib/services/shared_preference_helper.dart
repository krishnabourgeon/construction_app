// import 'dart:developer';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'app_config.dart';

// class SharedPreferenceHelper {
//   static Future<void> saveToken(String token) async {
//     final prefs = await SharedPreferences.getInstance();
//     prefs.setString("token", token);
//     AppConfig.accessToken = token;
//     log("SAVED TOKEN : $token");
//   }

//   static Future<void> saveUserID(String userId) async {
//     final prefs = await SharedPreferences.getInstance();
//     prefs.setString("user_id",  userId);
//     AppConfig.userId = userId;
//     log("SAVED USER ID : $userId");
//   }

//   static Future<void> saveRole(String role) async {
//     final prefs = await SharedPreferences.getInstance();
//     prefs.setString("role", role);
//     AppConfig.role = role;
//     log("SAVED ROLE : $role");
//   }

//   static Future<void> saveCompanyId(int companyId) async {
//     final prefs = await SharedPreferences.getInstance();
//     prefs.setInt("company_id", companyId);
//     AppConfig.companyId = companyId;
//     log("SAVED COMPANY ID : $companyId");
//   }

//   static Future<void> saveUserName(String name) async {
//     final prefs = await SharedPreferences.getInstance();
//     prefs.setString("user_name", name);
//     AppConfig.userName = name;
//     log("SAVED USER NAME : $name");
//   }
 

//   static Future<String> getUserId() async {
//     final prefs = await SharedPreferences.getInstance();
//     String id = prefs.getString("user_id") ?? "";
//     log('user_id $id');
//     AppConfig.userId = id;
//     return id;
//   }

//   static Future<String> getUserID() async {
//     final prefs = await SharedPreferences.getInstance();
//     String id = prefs.getString("user_id") ?? "";
//     log('user_id $id');
//     AppConfig.userId = id;
//     return id;
//   }
//   static Future<String> getToken() async {
//     final prefs = await SharedPreferences.getInstance();
//     String token = prefs.getString("token") ?? "";
//     log(token);
//     AppConfig.accessToken = token;
//     return token;
//   }

//   static Future<String> getRole() async {
//     final prefs = await SharedPreferences.getInstance();
//     String role = prefs.getString("role") ?? "";
//     log('role $role');
//     AppConfig.role = role;
//     return role;
//   }

//   static Future<int> getCompanyId() async {
//     final prefs = await SharedPreferences.getInstance();
//     int companyId = prefs.getInt("company_id") ?? 0;
//     log('company_id $companyId');
//     AppConfig.companyId = companyId;
//     return companyId;
//   }

//   static Future<String> getUserName() async {
//     final prefs = await SharedPreferences.getInstance();
//     String name = prefs.getString("user_name") ?? "";
//     log('user_name $name');
//     AppConfig.userName = name;
//     return name;
//   }

//   static Future<void> clearWholeData() async {
//     AppConfig.accessToken = null;
//     AppConfig.role = null;
//     AppConfig.companyId = null;
//     AppConfig.userName = null;
//     final prefs = await SharedPreferences.getInstance();
    
//     await prefs.remove("token");
//     await prefs.remove("user_id");
//     await prefs.remove("role");
//     await prefs.remove("company_id");
//     await prefs.remove("user_name");
//   }





//   static Future<bool> isFirstLaunch() async {
//     final prefs = await SharedPreferences.getInstance();
//     return prefs.getBool('is_first_launch') ?? true;
//   }

//   static Future<void> setFirstLaunchDone() async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.setBool('is_first_launch', false);
//   }

// }



import 'dart:developer';
import 'package:shared_preferences/shared_preferences.dart';
import 'app_config.dart';

class SharedPreferenceHelper {

  static Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString("token", token);
    AppConfig.accessToken = token;
    log("SAVED TOKEN : $token");
  }

  static Future<void> saveUserID(String userId) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString("user_id", userId);
    AppConfig.userId = userId;
    log("SAVED USER ID : $userId");
  }

  static Future<void> saveRole(String role) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString("role", role);
    AppConfig.role = role;
    log("SAVED ROLE : $role");
  }

  static Future<void> saveCompanyId(int companyId) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt("company_id", companyId);
    AppConfig.companyId = companyId;
    log("SAVED COMPANY ID : $companyId");
  }

  static Future<void> saveUserName(String name) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString("user_name", name);
    AppConfig.userName = name;
    log("SAVED USER NAME : $name");
  }

  static Future<String> getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    String id = prefs.getString("user_id") ?? "";
    AppConfig.userId = id;
    return id;
  }

  static Future<String> getUserID() async {
    final prefs = await SharedPreferences.getInstance();
    String id = prefs.getString("user_id") ?? "";
    AppConfig.userId = id;
    return id;
  }

  static Future<String> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("token") ?? "";
    AppConfig.accessToken = token;
    return token;
  }

  static Future<String> getRole() async {
    final prefs = await SharedPreferences.getInstance();
    String role = prefs.getString("role") ?? "";
    AppConfig.role = role;
    return role;
  }

  static Future<int> getCompanyId() async {
    final prefs = await SharedPreferences.getInstance();
    int companyId = prefs.getInt("company_id") ?? 0;
    AppConfig.companyId = companyId;
    return companyId;
  }

  static Future<String> getUserName() async {
    final prefs = await SharedPreferences.getInstance();
    String name = prefs.getString("user_name") ?? "";
    AppConfig.userName = name;
    return name;
  }

  static Future<void> clearWholeData() async {
    AppConfig.accessToken = null;
    AppConfig.role = null;
    AppConfig.companyId = null;
    AppConfig.userName = null;
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove("token");
    await prefs.remove("user_id");
    await prefs.remove("role");
    await prefs.remove("company_id");
    await prefs.remove("user_name");
  }

  static Future<bool> isFirstLaunch() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('is_first_launch') ?? true;
  }

  static Future<void> setFirstLaunchDone() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('is_first_launch', false);
  }

  // ── NEW: Phone number (for OTP flow) ─────────────────────────────────────

  static Future<void> savePhone(String phone) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('phone_number', phone);
    log('SAVED PHONE: $phone');
  }

  static Future<String> getPhone() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('phone_number') ?? '';
  }

  // ── NEW: OTP verified flag ────────────────────────────────────────────────

  static Future<void> setOtpVerified(bool verified) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('otp_verified', verified);
    log('OTP VERIFIED: $verified');
  }

  static Future<bool> isOtpVerified() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('otp_verified') ?? false;
  }



  // ── NEW: Subscription data ────────────────────────────────────────────────

  static Future<void> saveSubscriptionExpiry(DateTime expiry) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('sub_expiry', expiry.toIso8601String());
    await prefs.setBool('has_subscription', true);
  }

  static Future<DateTime?> getSubscriptionExpiry() async {
    final prefs = await SharedPreferences.getInstance();
    final str = prefs.getString('sub_expiry');
    if (str == null) return null;
    return DateTime.tryParse(str);
  }

  static Future<bool> hasSubscription() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('has_subscription') ?? false;
  }




  // ── Trial info (from login API) ────────────────────────────────────────────

static Future<void> saveTrialInfo({
  required int daysLeft,
  required bool expired,
}) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setInt('trial_days_left', daysLeft);
  await prefs.setBool('trial_expired', expired);
  log('SAVED TRIAL: daysLeft=$daysLeft, expired=$expired');
}

static Future<int> getTrialDaysLeft() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getInt('trial_days_left') ?? 0;
}

static Future<bool> getTrialExpired() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getBool('trial_expired') ?? true;
}

  /// Full clear including trial/subscription data
  static Future<void> clearAll() async {
    await clearWholeData();
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('phone_number');
    await prefs.remove('otp_verified');
    await prefs.remove('trial_start_date');
    await prefs.remove('sub_expiry');
    await prefs.remove('has_subscription');
    log('ALL DATA CLEARED');
  }
}