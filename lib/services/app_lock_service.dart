import 'dart:convert';

import 'package:crypto/crypto.dart';

import '../data/models/app_settings.dart';
import 'isar_service.dart';

class AppLockService {
  AppLockService._();

  static String hashPin(String pin) {
    final bytes = utf8.encode(pin);
    return sha256.convert(bytes).toString();
  }

  static Future<bool> verifyPin(String pin) async {
    final settings = await IsarService.settings();
    if (settings.pinHash == null) return false;
    return hashPin(pin) == settings.pinHash;
  }

  static Future<void> setPin(String pin) async {
    final settings = await IsarService.settings();
    settings.pinHash = hashPin(pin);
    settings.appLockEnabled = true;
    await IsarService.saveSettings(settings);
  }

  static Future<void> disableLock() async {
    final settings = await IsarService.settings();
    settings.appLockEnabled = false;
    settings.pinHash = null;
    await IsarService.saveSettings(settings);
  }

  static Future<bool> isLockEnabled() async {
    final settings = await IsarService.settings();
    return settings.appLockEnabled && settings.pinHash != null;
  }

  static Future<void> patchDefaults(AppSettings settings) {
    return Future.value();
  }
}
