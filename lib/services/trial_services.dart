import 'dart:developer';
import 'package:shared_preferences/shared_preferences.dart';

class TrialService {
  static const String _trialStartKey = 'trial_start_date';
  static const String _hasActiveSubscriptionKey = 'has_active_subscription';
  static const String _subscriptionExpiryKey = 'subscription_expiry_date';
  static const int _trialDurationDays = 1;

  /// Call this once when the user completes registration
  static Future<void> startTrial() async {
    final prefs = await SharedPreferences.getInstance();
    final alreadyStarted = prefs.getString(_trialStartKey);
    if (alreadyStarted != null) return; // Don't restart if already running

    final now = DateTime.now().toIso8601String();
    await prefs.setString(_trialStartKey, now);
    log('Trial started at $now');
  }

  /// Returns how many days remain in the trial (0 if expired)
  static Future<int> trialDaysRemaining() async {
    final prefs = await SharedPreferences.getInstance();
    final startStr = prefs.getString(_trialStartKey);
    if (startStr == null) return _trialDurationDays; // Not started yet

    final startDate = DateTime.parse(startStr);
    final elapsed = DateTime.now().difference(startDate).inDays;
    final remaining = _trialDurationDays - elapsed;
    return remaining < 0 ? 0 : remaining;
  }

  /// Returns true if the trial is still active
  static Future<bool> isTrialActive() async {
    final days = await trialDaysRemaining();
    return days > 0;
  }

  /// Returns true if the user has a paid subscription
  static Future<bool> hasActiveSubscription() async {
    final prefs = await SharedPreferences.getInstance();
    final hasSub = prefs.getBool(_hasActiveSubscriptionKey) ?? false;
    if (!hasSub) return false;

    // Check expiry
    final expiryStr = prefs.getString(_subscriptionExpiryKey);
    if (expiryStr == null) return false;

    final expiry = DateTime.parse(expiryStr);
    return DateTime.now().isBefore(expiry);
  }

  /// Call this after successful payment
  static Future<void> activateSubscription({int durationMonths = 1}) async {
    final prefs = await SharedPreferences.getInstance();
    final expiry =
        DateTime.now().add(Duration(days: 30 * durationMonths)).toIso8601String();
    await prefs.setBool(_hasActiveSubscriptionKey, true);
    await prefs.setString(_subscriptionExpiryKey, expiry);
    log('Subscription activated until $expiry');
  }

  /// Returns true if user can access the app (trial OR paid subscription)
  static Future<bool> canAccessApp() async {
    final trialActive = await isTrialActive();
    final subActive = await hasActiveSubscription();
    return trialActive || subActive;
  }

  /// Returns days left on paid subscription
  static Future<int> subscriptionDaysRemaining() async {
    final prefs = await SharedPreferences.getInstance();
    final expiryStr = prefs.getString(_subscriptionExpiryKey);
    if (expiryStr == null) return 0;

    final expiry = DateTime.parse(expiryStr);
    final remaining = expiry.difference(DateTime.now()).inDays;
    return remaining < 0 ? 0 : remaining;
  }

  /// Get a combined status object
  static Future<SubscriptionStatus> getStatus() async {
    final trialActive = await isTrialActive();
    final trialDays = await trialDaysRemaining();
    final hasSub = await hasActiveSubscription();
    final subDays = await subscriptionDaysRemaining();

    return SubscriptionStatus(
      isTrialActive: trialActive,
      trialDaysRemaining: trialDays,
      hasActiveSubscription: hasSub,
      subscriptionDaysRemaining: subDays,
    );
  }

  static Future<void> clearSubscriptionData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_trialStartKey);
    await prefs.remove(_hasActiveSubscriptionKey);
    await prefs.remove(_subscriptionExpiryKey);
  }
}

class SubscriptionStatus {
  final bool isTrialActive;
  final int trialDaysRemaining;
  final bool hasActiveSubscription;
  final int subscriptionDaysRemaining;

  const SubscriptionStatus({
    required this.isTrialActive,
    required this.trialDaysRemaining,
    required this.hasActiveSubscription,
    required this.subscriptionDaysRemaining,
  });

  /// Can the user access the app?
  bool get canAccess => isTrialActive || hasActiveSubscription;

  /// How many days left (trial or subscription)?
  int get daysLeft =>
      hasActiveSubscription ? subscriptionDaysRemaining : trialDaysRemaining;

  String get statusLabel {
    if (hasActiveSubscription) return 'Pro';
    if (isTrialActive) return 'Free Trial';
    return 'Expired';
  }
}