import 'dart:convert';
import 'dart:io';
import 'package:construction_app/models/version_model.dart';
import 'package:construction_app/services/app_config.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class VersionProvider extends ChangeNotifier {
  VersionModel? versionData;
  bool isLoading = false;
  String? error;

  Future<bool> fetchVersion() async {
    isLoading = true;
    notifyListeners();

    try {
      final url = Uri.parse("${AppConfig.baseUrl}version");
      debugPrint("🌐 VERSION API URL → $url");

      final response = await http.get(url);

      debugPrint("📡 STATUS CODE → ${response.statusCode}");
      debugPrint("📦 RESPONSE BODY → ${response.body}");

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        versionData = VersionModel.fromJson(json);

        debugPrint("✅ ANDROID VERSION (API) → ${versionData?.androidVersion}");
        debugPrint("✅ IOS VERSION (API) → ${versionData?.iosVersion}");
        debugPrint("📱 CURRENT ANDROID VERSION → ${AppConfig.version}");
        debugPrint("📱 CURRENT IOS VERSION → ${AppConfig.iosversion}");

        return true;
      } else {
        error = "Failed to fetch version";
        debugPrint("❌ ERROR → $error");
        return false;
      }
    } catch (e) {
      error = e.toString();
      debugPrint("🚨 EXCEPTION → $error");
      return false;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  bool isUpdateAvailable() {
    debugPrint("🔍 Checking update availability...");

    if (Platform.isAndroid) {
      debugPrint("📲 Platform: Android");
      return isAndroidUpdateRequired();
    }

    if (Platform.isIOS) {
      debugPrint("📲 Platform: iOS");
      return isIosUpdateRequired();
    }

    return false;
  }

  bool isAndroidUpdateRequired() {
    if (versionData == null) {
      debugPrint("⚠️ versionData is null");
      return false;
    }

    final apiVersion = versionData!.androidVersion;
    final currentVersion = AppConfig.version;

    debugPrint(
      "🤖 Comparing Android → API: $apiVersion | Current: $currentVersion",
    );

    final result = apiVersion != currentVersion;
    debugPrint("⬆️ Android Update Required? → $result");

    return result;
  }

  bool isIosUpdateRequired() {
    if (versionData == null) {
      debugPrint("⚠️ versionData is null");
      return false;
    }

    final apiVersion = versionData!.iosVersion;
    final currentVersion = AppConfig.iosversion;

    debugPrint(
      "🍎 Comparing iOS → API: $apiVersion | Current: $currentVersion",
    );

    final result = apiVersion != currentVersion;
    debugPrint("⬆️ iOS Update Required? → $result");

    return result;
  }

  Future<void> redirectToStore() async {
    String url = "";

    if (Platform.isAndroid) {
      url = "https://play.google.com/store/apps/details?id=com.bpro.app";
      debugPrint("🟢 Redirecting to Play Store → $url");
    } else if (Platform.isIOS) {
      url = "https://apps.apple.com/app/id123456789";
      debugPrint("🍎 Redirecting to App Store → $url");
    }

    if (url.isNotEmpty) {
      final uri = Uri.parse(url);

      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
        debugPrint("✅ Store Launched Successfully");
      } else {
        debugPrint("❌ Could not launch $url");
      }
    }
  }
}
