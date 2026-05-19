/// App metadata for About screen and Play Store listings.
class AppInfo {
  AppInfo._();

  static const name = 'SehatSaathi';
  static const version = '1.0.0';
  static const buildNumber = '1';
  static const packageId = 'com.sehatsaathi.app';

  /// Your real Gmail — required for Play Store (no website needed).
  static const developerName = 'SehatSaathi';
  static const supportEmail = 'gautamamit557@gmail.com';
  static const privacyEmail = 'gautamamit557@gmail.com';

  /// Optional: only if you enable GitHub Pages (see docs/PLAY_STORE.md).
  /// Leave empty while developing — privacy policy is fully inside the app.
  static const String? playStorePrivacyUrl = null;

  static bool get hasPlayStorePrivacyUrl =>
      playStorePrivacyUrl != null && playStorePrivacyUrl!.isNotEmpty;

  static String get versionLabel => '$version ($buildNumber)';
}
