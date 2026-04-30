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
    prefs.setString("user_id",  userId);
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
    log('user_id $id');
    AppConfig.userId = id;
    return id;
  }

  static Future<String> getUserID() async {
    final prefs = await SharedPreferences.getInstance();
    String id = prefs.getString("user_id") ?? "";
    log('user_id $id');
    AppConfig.userId = id;
    return id;
  }
  static Future<String> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("token") ?? "";
    log(token);
    AppConfig.accessToken = token;
    return token;
  }

  static Future<String> getRole() async {
    final prefs = await SharedPreferences.getInstance();
    String role = prefs.getString("role") ?? "";
    log('role $role');
    AppConfig.role = role;
    return role;
  }

  static Future<int> getCompanyId() async {
    final prefs = await SharedPreferences.getInstance();
    int companyId = prefs.getInt("company_id") ?? 0;
    log('company_id $companyId');
    AppConfig.companyId = companyId;
    return companyId;
  }

  static Future<String> getUserName() async {
    final prefs = await SharedPreferences.getInstance();
    String name = prefs.getString("user_name") ?? "";
    log('user_name $name');
    AppConfig.userName = name;
    return name;
  }

  static Future<void> clearWholeData() async {
    AppConfig.accessToken = null;
    AppConfig.role = null;
    AppConfig.companyId = null;
    AppConfig.userName = null;
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }
}
