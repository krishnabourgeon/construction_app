class AppConfig {
  static final AppConfig _instance = AppConfig._internal();
  factory AppConfig() => _instance;
  AppConfig._internal();

  // static String baseUrl = "http://appuser.templesoftware.in/public/api/";
  static String baseUrl = "https://constructions.simbillsoft.in/api/";
  static String? accessToken;
  static String? counterID;
  static int? customerId;
  static String? storeId;
  static String? userId;
  static String? role;
  static String? userName;
  static String? customerName;
  static String? customerNumber;
  static String? settings;
  static int? version = 1;

  static int? companyId;
}