import '../../core/constants/app_info.dart';
import 'legal_document_screen.dart';

class LegalContent {
  LegalContent._();

  static List<LegalSection> privacyPolicy(bool hi) => hi ? _privacyHi : _privacyEn;
  static List<LegalSection> termsOfService(bool hi) => hi ? _termsHi : _termsEn;
  static List<LegalSection> medicalDisclaimer(bool hi) =>
      hi ? _medicalHi : _medicalEn;
  static List<LegalSection> dataSafety(bool hi) => hi ? _dataSafetyHi : _dataSafetyEn;
  static List<LegalSection> permissionsInfo(bool hi) =>
      hi ? _permissionsHi : _permissionsEn;

  static const _privacyEn = [
    LegalSection(
      title: '1. Overview',
      body:
          'SehatSaathi ("we", "our", "the app") is an offline family health companion. '
          'This Privacy Policy explains how information is handled when you use the Android/iOS app. '
          'Last updated: May 2026.',
    ),
    LegalSection(
      title: '2. No account required',
      body:
          'We do not require you to create an account, sign in, or provide an email address to use the app. '
          'We do not operate cloud servers that store your health records by default.',
    ),
    LegalSection(
      title: '3. Information stored on your device',
      body:
          'Data you enter is saved locally on your phone using on-device storage, including:\n'
          '• Medicine names, schedules, dose logs, and refill reminders\n'
          '• Water intake and daily goals\n'
          '• Blood pressure and blood sugar readings (manual entry only)\n'
          '• Mood notes and wellness logs\n'
          '• Family profile names and relationships\n'
          '• Emergency contacts, allergies, and medical notes\n'
          '• Doctor appointment details\n'
          '• App settings (language, theme, PIN hash, reminder preferences)',
    ),
    LegalSection(
      title: '4. Information we do NOT collect',
      body:
          'By default, the app does not:\n'
          '• Upload your health data to our servers\n'
          '• Sell your personal information\n'
          '• Use third-party advertising or analytics SDKs\n'
          '• Track your location\n'
          '• Access your contacts, SMS, or call logs\n'
          '• Read messages or photos except when you explicitly pick a backup file',
    ),
    LegalSection(
      title: '5. Permissions (Android)',
      body:
          'The app may request:\n'
          '• Notifications — medicine, water, refill, and appointment reminders you configure\n'
          '• Exact alarms — reliable reminder timing on Android 12+\n'
          '• Vibrate — optional alert feedback\n'
          '• Boot completed — reschedule reminders after device restart\n'
          '• Read media/images — only when you choose a backup JSON file to restore\n\n'
          'You can deny permissions; some reminder features may not work without notifications.',
    ),
    LegalSection(
      title: '6. Backup and sharing',
      body:
          'When you export a backup (JSON) or share an emergency card / PDF / CSV report, '
          'you choose where that file goes (email, WhatsApp, Drive, etc.). '
          'We do not receive those files. You are responsible for securing shared exports.',
    ),
    LegalSection(
      title: '7. App lock',
      body:
          'If you enable App Lock, a PIN is stored on-device as a one-way hash. '
          'We cannot recover your PIN. Disabling the lock removes the stored hash.',
    ),
    LegalSection(
      title: '8. Children',
      body:
          'The app is a general family health tool, not directed at children under 13 to use alone. '
          'Parents or guardians may create profiles for family members. '
          'We do not knowingly collect personal information from children over the internet because data stays on-device.',
    ),
    LegalSection(
      title: '9. Data retention and deletion',
      body:
          'Data remains on your device until you delete it in the app, restore a backup (which replaces data), '
          'or uninstall the app. Uninstalling removes local app data from your device.',
    ),
    LegalSection(
      title: '10. Security',
      body:
          'We recommend using your device screen lock and optional in-app PIN. '
          'No method of electronic storage is 100% secure; protect physical access to your phone.',
    ),
    LegalSection(
      title: '11. Changes',
      body:
          'We may update this policy. Material changes will be reflected in the app and on the Play Store listing. '
          'Continued use after updates means you accept the revised policy.',
    ),
    LegalSection(
      title: '12. Contact',
      body:
          'This policy is available inside the app (Settings → Privacy policy). '
          'No separate website is required to use SehatSaathi.\n\n'
          'Contact: ${AppInfo.supportEmail}\n'
          'Developer: ${AppInfo.developerName}',
    ),
  ];

  static const _privacyHi = [
    LegalSection(
      title: '1. परिचय',
      body:
          'सेहतसाथी ("हम", "ऐप") एक ऑफ़लाइन परिवार स्वास्थ्य साथी है। '
          'यह गोपनीयता नीति बताती है कि ऐप उपयोग पर जानकारी कैसे संभाली जाती है। '
          'अंतिम अपडेट: मई 2026।',
    ),
    LegalSection(
      title: '2. अकाउंट की ज़रूरत नहीं',
      body:
          'ऐप चलाने के लिए अकाउंट, साइन-इन या ईमेल देना ज़रूरी नहीं। '
          'डिफ़ॉल्ट रूप से आपका स्वास्थ्य डेटा हमारे सर्वर पर नहीं जाता।',
    ),
    LegalSection(
      title: '3. डिवाइस पर संग्रहीत जानकारी',
      body:
          'आपकी दर्ज जानकारी फ़ोन पर स्थानीय रूप से सहेजी जाती है, जैसे:\n'
          '• दवा, समय, खुराक लॉग, रिफिल रिमाइंडर\n'
          '• पानी की मात्रा और दैनिक लक्ष्य\n'
          '• बीपी और शुगर रिकॉर्ड (केवल मैन्युअल)\n'
          '• मूड और कल्याण नोट\n'
          '• परिवार प्रोफ़ाइल\n'
          '• आपातकालीन संपर्क, एलर्जी, नोट\n'
          '• डॉक्टर अपॉइंटमेंट\n'
          '• ऐप सेटिंग्स (भाषा, थीम, PIN हैश, रिमाइंडर)',
    ),
    LegalSection(
      title: '4. जो हम एकत्र नहीं करते',
      body:
          'डिफ़ॉल्ट रूप से ऐप:\n'
          '• डेटा सर्वर पर अपलोड नहीं करता\n'
          '• व्यक्तिगत जानकारी नहीं बेचता\n'
          '• विज्ञापन/एनालिटिक्स SDK नहीं उपयोग करता\n'
          '• लोकेशन ट्रैक नहीं करता\n'
          '• संपर्क, SMS, कॉल लॉग नहीं पढ़ता\n'
          '• बैकअप फ़ाइल तबही जब आप खुद चुनें',
    ),
    LegalSection(
      title: '5. अनुमतियाँ (Android)',
      body:
          'ऐप ये अनुमतियाँ माँग सकता है:\n'
          '• सूचनाएँ — आपके सेट किए रिमाइंडर\n'
          '• सटीक अलार्म — समय पर रिमाइंडर\n'
          '• वाइब्रेशन — अलर्ट\n'
          '• बूट के बाद — रिमाइंडर दोबारा शेड्यूल\n'
          '• मीडिया — केवल बैकअप JSON चुनने पर\n\n'
          'अनुमति न दें तो कुछ रिमाइंडर काम नहीं कर सकते।',
    ),
    LegalSection(
      title: '6. बैकअप और साझा करना',
      body:
          'JSON बैकअप, आपात कार्ड, PDF/CSV निर्यात पर आप तय करते हैं कि फ़ाइल कहाँ जाए। '
          'हमें वे फ़ाइलें नहीं मिलतीं। साझा फ़ाइल की सुरक्षा आपकी ज़िम्मेदारी है।',
    ),
    LegalSection(
      title: '7. ऐप लॉक',
      body:
          'PIN डिवाइस पर हैश के रूप में रहता है। हम PIN पुनर्प्राप्त नहीं कर सकते।',
    ),
    LegalSection(
      title: '8. बच्चे',
      body:
          'ऐप 13 वर्ष से कम बच्चों के लिए अकेले उपयोग हेतु नहीं बनाया गया। '
          'अभिभावक परिवार प्रोफ़ाइल बना सकते हैं। इंटरनेट पर बच्चों का डेटा हम एकत्र नहीं करते।',
    ),
    LegalSection(
      title: '9. डेटा हटाना',
      body:
          'डेटा तब तक रहता है जब तक आप ऐप में हटाएँ, बैकअप रिस्टोर करें, या ऐप अनइंस्टॉल करें।',
    ),
    LegalSection(
      title: '10. सुरक्षा',
      body:
          'फ़ोन स्क्रीन लॉक और ऐप PIN का उपयोग करें। फ़ोन की शारीरिक सुरक्षा भी ज़रूरी है।',
    ),
    LegalSection(
      title: '11. बदलाव',
      body:
          'नीति अपडेट हो सकती है। ऐप और Play Store लिस्टिंग में दिखेगा।',
    ),
    LegalSection(
      title: '12. संपर्क',
      body:
          'पूरी नीति ऐप में है (सेटिंग्स → गोपनीयता नीति)। अलग वेबसाइट ज़रूरी नहीं।\n\n'
          'संपर्क: ${AppInfo.supportEmail}\n'
          'डेवलपर: ${AppInfo.developerName}',
    ),
  ];

  static const _termsEn = [
    LegalSection(
      title: '1. Acceptance',
      body:
          'By installing or using SehatSaathi, you agree to these Terms of Service and our Privacy Policy. '
          'If you do not agree, do not use the app.',
    ),
    LegalSection(
      title: '2. Description of service',
      body:
          'SehatSaathi helps you track medicines, hydration, vitals, mood, and family health information offline. '
          'Features include reminders, reports, emergency card sharing, and optional JSON backup.',
    ),
    LegalSection(
      title: '3. Not medical advice',
      body:
          'The app is for personal record-keeping and reminders only. It does not diagnose, treat, or prevent disease. '
          'It does not measure blood pressure, blood sugar, or other vitals. '
          'Always seek advice from a qualified healthcare professional for medical decisions.',
    ),
    LegalSection(
      title: '4. Your responsibility',
      body:
          'You are responsible for the accuracy of data you enter, following prescriptions, and how you use reminders. '
          'Missed reminders or incorrect entries are not the developer\'s fault. '
          'In emergencies, call local emergency services — do not rely on this app alone.',
    ),
    LegalSection(
      title: '5. License',
      body:
          'We grant you a personal, non-exclusive, non-transferable license to use the app on your devices in accordance with these terms and applicable store rules.',
    ),
    LegalSection(
      title: '6. Pro features',
      body:
          'Some features (e.g. PDF/CSV export, unlimited profiles) may be marked Pro or demo. '
          'Pricing and availability on Google Play may change. Purchases, if offered later, follow Google Play billing terms.',
    ),
    LegalSection(
      title: '7. Backup',
      body:
          'You are solely responsible for backup files you create or restore. '
          'Restoring a backup replaces existing app data on that device.',
    ),
    LegalSection(
      title: '8. Disclaimer of warranties',
      body:
          'The app is provided "as is" without warranties of any kind. We do not guarantee uninterrupted or error-free operation.',
    ),
    LegalSection(
      title: '9. Limitation of liability',
      body:
          'To the maximum extent permitted by law, the developer is not liable for indirect, incidental, or consequential damages '
          'arising from use of the app, including health outcomes, data loss, or missed doses.',
    ),
    LegalSection(
      title: '10. Changes and termination',
      body:
          'We may modify or discontinue features. You may stop using the app by uninstalling it.',
    ),
    LegalSection(
      title: '11. Governing law',
      body:
          'These terms are governed by the laws of India, without regard to conflict-of-law principles, '
          'unless mandatory local consumer laws apply in your country.',
    ),
    LegalSection(
      title: '12. Contact',
      body: 'Questions: ${AppInfo.supportEmail}',
    ),
  ];

  static const _termsHi = [
    LegalSection(
      title: '1. स्वीकृति',
      body:
          'सेहतसाथी इंस्टॉल/उपयोग करने पर आप इन सेवा की शर्तों और गोपनीयता नीति से सहमत हैं।',
    ),
    LegalSection(
      title: '2. सेवा का विवरण',
      body:
          'ऐप दवा, पानी, विटल्स, मूड और परिवार स्वास्थ्य जानकारी ऑफ़लाइन ट्रैक करने में मदद करता है।',
    ),
    LegalSection(
      title: '3. चिकित्सा सलाह नहीं',
      body:
          'ऐप केवल व्यक्तिगत रिकॉर्ड और रिमाइंडर के लिए है। रोग का निदान/इलाज नहीं करता। '
          'बीपी/शुगर मापता नहीं। चिकित्सा निर्णय हेतु हमेशा डॉक्टर से सलाह लें।',
    ),
    LegalSection(
      title: '4. आपकी ज़िम्मेदारी',
      body:
          'दर्ज डेटा की सटीकता, दवा पालन और रिमाइंडर उपयोग आपकी ज़िम्मेदारी है। '
          'आपात स्थिति में स्थानीय आपात सेवा कॉल करें।',
    ),
    LegalSection(
      title: '5. लाइसेंस',
      body: 'व्यक्तिगत, गैर-विशेष अधिकार से ऐप उपयोग की अनुमति।',
    ),
    LegalSection(
      title: '6. Pro सुविधाएँ',
      body: 'Pro सुविधाएँ बदल सकती हैं। भविष्य की खरीद Google Play नियमों के अधीन।',
    ),
    LegalSection(
      title: '7. बैकअप',
      body: 'बैकअप फ़ाइल की सुरक्षा और रिस्टोर परिणाम आपकी ज़िम्मेदारी।',
    ),
    LegalSection(
      title: '8. वारंटी अस्वीकरण',
      body: 'ऐप "जैसा है" आधार पर दिया जाता है।',
    ),
    LegalSection(
      title: '9. दायित्व सीमा',
      body:
          'कानून द्वारा अनुमत अधिकतम सीमा तक डेवलपर अप्रत्यक्ष हानि के लिए उत्तरदायी नहीं।',
    ),
    LegalSection(
      title: '10. बदलाव',
      body: 'सुविधाएँ बदल या बंद हो सकती हैं। अनइंस्टॉल करके उपयोग बंद कर सकते हैं।',
    ),
    LegalSection(
      title: '11. लागू कानून',
      body: 'भारत के कानून लागू, जब तक स्थानीय उपभोक्ता कानून अनिवार्य न हो।',
    ),
    LegalSection(
      title: '12. संपर्क',
      body: 'प्रश्न: ${AppInfo.supportEmail}',
    ),
  ];

  static const _medicalEn = [
    LegalSection(
      body:
          'IMPORTANT: SehatSaathi is not a medical device and is not registered with any health regulator as a diagnostic tool.',
    ),
    LegalSection(
      title: 'What this app does',
      body:
          '• Reminds you to take medicines you configure\n'
          '• Logs water, BP, sugar, mood, and appointments you enter manually\n'
          '• Calculates a simple daily adherence score for motivation only\n'
          '• Stores everything locally on your phone',
    ),
    LegalSection(
      title: 'What this app does NOT do',
      body:
          '• Measure blood pressure, heart rate, or blood glucose\n'
          '• Provide diagnosis, prescription, or treatment plans\n'
          '• Replace your doctor, nurse, or pharmacist\n'
          '• Guarantee correct dose or timing — verify with your prescriber',
    ),
    LegalSection(
      title: 'Emergency',
      body:
          'For medical emergencies, contact your local emergency number immediately. '
          'The emergency card feature only shares information you entered — it does not alert services.',
    ),
    LegalSection(
      title: 'Health score',
      body:
          'The daily health score is an estimate based on logged doses and water. '
          'It is not a clinical assessment. Do not use it for medical decisions.',
    ),
  ];

  static const _medicalHi = [
    LegalSection(
      body:
          'महत्वपूर्ण: सेहतसाथी चिकित्सा उपकरण नहीं है और निदान हेतु पंजीकृत नहीं है।',
    ),
    LegalSection(
      title: 'ऐप क्या करता है',
      body:
          '• दवा रिमाइंडर\n'
          '• पानी, बीपी, शुगर, मूड, अपॉइंटमेंट का मैन्युअल लॉग\n'
          '• प्रेरणा हेतु सरल दैनिक स्कोर\n'
          '• सब कुछ फ़ोन पर स्थानीय',
    ),
    LegalSection(
      title: 'ऐप क्या नहीं करता',
      body:
          '• बीपी/शुगर/हृदय गति मापना\n'
          '• निदान या इलाज योजना\n'
          '• डॉक्टर/नर्स की जगह लेना\n'
          '• खुराक की गारंटी — डॉक्टर से पुष्टि करें',
    ),
    LegalSection(
      title: 'आपातकाल',
      body: 'आपात में तुरंत स्थानीय आपात नंबर पर कॉल करें। ऐप सेवाओं को अलर्ट नहीं करता।',
    ),
    LegalSection(
      title: 'स्वास्थ्य स्कोर',
      body: 'दैनिक स्कोर केवल अनुमान है, चिकित्सा मूल्यांकन नहीं।',
    ),
  ];

  static const _dataSafetyEn = [
    LegalSection(
      title: 'Summary for Google Play Data safety',
      body:
          'Use this page when completing the Play Console "Data safety" form. '
          'SehatSaathi is designed as offline-first with no server upload by default.',
    ),
    LegalSection(
      title: 'Data collected by developer',
      body: 'None — no data is transmitted to the developer\'s servers in the default app.',
    ),
    LegalSection(
      title: 'Data stored on device (not collected remotely)',
      body:
          'Health & fitness: medicine logs, vitals, water, mood (user-entered)\n'
          'Personal info: profile names, emergency contacts (user-entered)\n'
          'App activity: settings, reminder preferences\n'
          'All optional and deletable by uninstalling the app.',
    ),
    LegalSection(
      title: 'Data sharing',
      body:
          'Not shared with third parties by the app automatically. '
          'User-initiated share/backup exports are under user control.',
    ),
    LegalSection(
      title: 'Encryption',
      body:
          'Data is stored in the app\'s private storage on the device. '
          'Optional device encryption and app PIN are recommended. '
          'Backup JSON files are not encrypted unless you encrypt the file yourself.',
    ),
    LegalSection(
      title: 'Deletion',
      body:
          'Users can delete profiles and records in-app, clear data via restore, or uninstall the app to remove all local data.',
    ),
    LegalSection(
      title: 'Play Console answers (typical)',
      body:
          '• Does your app collect or share user data? → No (for default offline use)\n'
          '• Is all data encrypted in transit? → N/A (no transmission)\n'
          '• Can users request data deletion? → Yes, uninstall app or delete in-app data\n'
          '• Health apps declaration: required in Play Console\n'
          '• Privacy policy URL: use free GitHub Pages (see docs/PLAY_STORE.md) — one page only, not a full website',
    ),
  ];

  static const _dataSafetyHi = [
    LegalSection(
      title: 'Google Play डेटा सुरक्षा सारांश',
      body:
          'Play Console "Data safety" फ़ॉर्म भरते समय इस पृष्ठ का उपयोग करें। '
          'सेहतसाथी ऑफ़लाइन-प्रथम है।',
    ),
    LegalSection(
      title: 'डेवलपर द्वारा एकत्र डेटा',
      body: 'कोई नहीं — डिफ़ॉल्ट में सर्वर पर डेटा नहीं जाता।',
    ),
    LegalSection(
      title: 'डिवाइस पर डेटा',
      body: 'दवा, विटल्स, पानी, मूड, प्रोफ़ाइल, आपात जानकारी — उपयोगकर्ता द्वारा दर्ज।',
    ),
    LegalSection(
      title: 'साझा करना',
      body: 'ऐप स्वतः तीसरे पक्ष को नहीं भेजता। बैकअप/शेयर उपयोगकर्ता नियंत्रित।',
    ),
    LegalSection(
      title: 'एन्क्रिप्शन',
      body: 'ऐप की निजी स्टोरेज। बैकअप JSON स्वयं एन्क्रिप्ट नहीं।',
    ),
    LegalSection(
      title: 'हटाना',
      body: 'ऐप में हटाएँ या अनइंस्टॉल करें।',
    ),
    LegalSection(
      title: 'Play Console उत्तर (सामान्य)',
      body:
          '• डेटा एकत्र/साझा? → नहीं\n'
          '• ट्रांज़िट एन्क्रिप्शन? → लागू नहीं\n'
          '• हटाने का अनुरोध? → हाँ, अनइंस्टॉल\n'
          '• स्वास्थ्य ऐप घोषणा: Play Console में भरें\n'
          '• गोपनीयता URL: मुफ़्त GitHub Pages (docs/PLAY_STORE.md) — पूरी वेबसाइट नहीं चाहिए',
    ),
  ];

  static const _permissionsEn = [
    LegalSection(
      title: 'POST_NOTIFICATIONS',
      body: 'Shows medicine, water, refill, visit, and missed-dose reminders you set.',
    ),
    LegalSection(
      title: 'SCHEDULE_EXACT_ALARM / USE_EXACT_ALARM',
      body: 'Delivers reminders at the exact times you choose on Android 12+.',
    ),
    LegalSection(
      title: 'RECEIVE_BOOT_COMPLETED',
      body: 'Reschedules reminders after your phone restarts.',
    ),
    LegalSection(
      title: 'VIBRATE',
      body: 'Optional vibration when a notification arrives.',
    ),
    LegalSection(
      title: 'READ_MEDIA_IMAGES',
      body:
          'Used only when you pick a backup .json file from storage to restore. '
          'The app does not scan your gallery otherwise.',
    ),
  ];

  static const _permissionsHi = [
    LegalSection(
      title: 'सूचनाएँ',
      body: 'आपके सेट किए दवा, पानी, रिफिल और अपॉइंटमेंट रिमाइंडर।',
    ),
    LegalSection(
      title: 'सटीक अलार्म',
      body: 'Android 12+ पर सही समय पर रिमाइंडर।',
    ),
    LegalSection(
      title: 'बूट के बाद',
      body: 'फ़ोन रीस्टार्ट के बाद रिमाइंडर दोबारा।',
    ),
    LegalSection(
      title: 'वाइब्रेशन',
      body: 'वैकल्पिक कंपन।',
    ),
    LegalSection(
      title: 'मीडिया पढ़ना',
      body: 'केवल बैकअप JSON फ़ाइल चुनने पर।',
    ),
  ];
}
