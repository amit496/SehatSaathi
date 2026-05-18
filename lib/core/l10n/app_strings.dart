import '../../data/models/enums.dart';

class AppStrings {
  AppStrings(this.language);

  final AppLanguage language;

  bool get isHindi => language == AppLanguage.hi;

  String get appName => isHindi ? 'सेहतसाथी' : 'SehatSaathi';

  String get tagline =>
      isHindi ? 'ऑफ़लाइन परिवार स्वास्थ्य साथी' : 'Offline Family Health Companion';

  String get privacyTagline => isHindi
      ? 'आपका डेटा आपके फ़ोन पर रहता है।'
      : 'Your data stays on your device.';

  String get dashboard => isHindi ? 'होम' : 'Home';
  String get medicine => isHindi ? 'दवा' : 'Medicine';
  String get water => isHindi ? 'पानी' : 'Water';
  String get vitals => isHindi ? 'रिपोर्ट' : 'Vitals';
  String get more => isHindi ? 'और' : 'More';

  String greeting(String name) =>
      isHindi ? 'नमस्ते, $name' : 'Hello, $name';

  String get todaySummary => isHindi ? 'आज का सारांश' : "Today's summary";
  String get healthScore => isHindi ? 'स्वास्थ्य स्कोर' : 'Health score';
  String get upcomingReminders =>
      isHindi ? 'आगामी रिमाइंडर' : 'Upcoming reminders';
  String get quickActions => isHindi ? 'त्वरित कार्य' : 'Quick actions';
  String get addMedicine => isHindi ? 'दवा जोड़ें' : 'Add medicine';
  String get editMedicine => isHindi ? 'दवा संपादित' : 'Edit medicine';
  String get logWater => isHindi ? 'पानी जोड़ें' : 'Log water';
  String get logBp => isHindi ? 'बीपी लिखें' : 'Log BP';
  String get logSugar => isHindi ? 'शुगर लिखें' : 'Log sugar';

  String get familyProfiles =>
      isHindi ? 'परिवार प्रोफ़ाइल' : 'Family profiles';
  String get emergencyInfo =>
      isHindi ? 'आपातकालीन जानकारी' : 'Emergency info';
  String get moodWellness => isHindi ? 'मूड और कल्याण' : 'Mood & wellness';
  String get healthReports => isHindi ? 'स्वास्थ्य रिपोर्ट' : 'Health reports';
  String get settings => isHindi ? 'सेटिंग्स' : 'Settings';

  String get disclaimer => isHindi
      ? 'यह ऐप बीपी या शुगर मापता नहीं है — केवल रिकॉर्ड के लिए। डॉक्टर से सलाह लें।'
      : 'This app does not measure BP or sugar. For logging only. Consult your doctor.';

  String get notMedicalAdvice => isHindi
      ? 'चिकित्सा सलाह नहीं — केवल व्यक्तिगत ट्रैकिंग।'
      : 'Not medical advice — personal tracking only.';

  String relationLabel(ProfileRelation r) {
    if (!isHindi) {
      return switch (r) {
        ProfileRelation.self => 'Self',
        ProfileRelation.mother => 'Mother',
        ProfileRelation.father => 'Father',
        ProfileRelation.child => 'Child',
        ProfileRelation.spouse => 'Spouse',
        ProfileRelation.other => 'Other',
      };
    }
    return switch (r) {
      ProfileRelation.self => 'खुद',
      ProfileRelation.mother => 'माँ',
      ProfileRelation.father => 'पिता',
      ProfileRelation.child => 'बच्चा',
      ProfileRelation.spouse => 'पति/पत्नी',
      ProfileRelation.other => 'अन्य',
    };
  }

  String get skip => isHindi ? 'छोड़ें' : 'Skip';
  String get next => isHindi ? 'आगे' : 'Next';
  String get getStarted => isHindi ? 'शुरू करें' : 'Get started';
  String get chooseLanguage =>
      isHindi ? 'भाषा चुनें' : 'Choose language';
  String get addProfile => isHindi ? 'प्रोफ़ाइल जोड़ें' : 'Add profile';
  String get editProfile => isHindi ? 'प्रोफ़ाइल संपादित' : 'Edit profile';
  String get profileName => isHindi ? 'नाम' : 'Name';
  String get relation => isHindi ? 'रिश्ता' : 'Relation';
  String get deleteProfile => isHindi ? 'प्रोफ़ाइल हटाएँ' : 'Delete profile';

  String get markTaken => isHindi ? 'ली' : 'Taken';
  String get markSkipped => isHindi ? 'छोड़ी' : 'Skipped';
  String get snooze => isHindi ? 'स्नूज़' : 'Snooze';
  String get dailyGoal => isHindi ? 'दैनिक लक्ष्य' : 'Daily goal';
  String get ml => 'ml';
  String get customAmount => isHindi ? 'कस्टम मात्रा' : 'Custom amount';
  String get changeGoal => isHindi ? 'लक्ष्य बदलें' : 'Change goal';
  String get waterReminders => isHindi ? 'पानी रिमाइंडर' : 'Water reminders';
  String get editReminderTimes =>
      isHindi ? 'रिमाइंडर समय' : 'Reminder times';

  String get exportPdf => isHindi ? 'PDF निर्यात' : 'Export PDF';
  String get exportCsv => isHindi ? 'CSV निर्यात' : 'Export CSV';
  String get proFeature =>
      isHindi ? 'Pro में उपलब्ध' : 'Available in Pro';

  String get medicineHistory =>
      isHindi ? 'दवा इतिहास' : 'Medicine history';
  String get addMedicineFirst => isHindi
      ? 'पहले कम से कम एक दवा जोड़ें'
      : 'Add at least one medicine first';
  String get chooseMedicineForHistory => isHindi
      ? 'किस दवा का इतिहास देखें?'
      : 'Which medicine history?';
  String get refillReminder =>
      isHindi ? 'रिफिल रिमाइंडर' : 'Refill reminder';
  String get refillReminderHint => isHindi
      ? 'जब दवा खत्म होने वाली हो'
      : 'Alert when supply is running low';

  String get general => isHindi ? 'सामान्य' : 'General';
  String get darkMode => isHindi ? 'डार्क मोड' : 'Dark mode';
  String get dataBackup => isHindi ? 'डेटा और बैकअप' : 'Data & backup';
  String get backupJson => isHindi ? 'बैकअप (JSON)' : 'Backup (JSON)';
  String get backupHint => isHindi
      ? 'सारा डेटा साझा करें'
      : 'Share all app data';
  String get restoreBackup => isHindi ? 'बैकअप से पुनर्स्थापित' : 'Restore backup';
  String get restoreHint => isHindi
      ? 'मौजूदा डेटा बदल देगा'
      : 'Replaces current data';
  String get restoreConfirm => isHindi
      ? 'यह इस फ़ोन का सारा डेटा बदल देगा। जारी रखें?'
      : 'This replaces all data on this device. Continue?';
  String get restoreSuccess =>
      isHindi ? 'बैकअप पुनर्स्थापित' : 'Backup restored';
  String get restoreFailed =>
      isHindi ? 'पुनर्स्थापना विफल' : 'Restore failed';

  String get notifications => isHindi ? 'सूचनाएँ' : 'Notifications';
  String get snoozeDuration => isHindi ? 'स्नूज़ अवधि' : 'Snooze duration';
  String get notificationRestartHint => isHindi
      ? 'इंस्टॉल के बाद पूर्ण रीस्टार्ट ज़रूरी (हॉट रीस्टार्ट नहीं)।'
      : 'Full app restart required after install (not hot restart).';

  String get legal => isHindi ? 'कानूनी' : 'Legal';
  String get privacyPolicy => isHindi ? 'गोपनीयता नीति' : 'Privacy policy';
  String get proDemo => 'Pro (demo)';
  String get proDemoHint => isHindi
      ? 'PDF/CSV और अनलिमिटेड प्रोफ़ाइल'
      : 'PDF/CSV & unlimited profiles';
  String get showOnboardingAgain =>
      isHindi ? 'ऑनबोर्डिंग दोबारा' : 'Show onboarding again';

  String get cancel => isHindi ? 'रद्द' : 'Cancel';
  String get save => isHindi ? 'सहेजें' : 'Save';
  String get continueLabel => isHindi ? 'जारी रखें' : 'Continue';

  String get moodHistory => isHindi ? 'मूड इतिहास' : 'Mood history';
  String get enableWaterReminders => isHindi
      ? 'पानी रिमाइंडर चालू करें'
      : 'Enable water reminders';
  String get setupReminders =>
      isHindi ? 'रिमाइंडर सेट करें' : 'Set up reminders';

  String get missedDoses =>
      isHindi ? 'छूटी हुई दवा' : 'Missed doses';
  String missedDosesCount(int n) => isHindi
      ? '$n खुराक छूट गई — अभी लें या छोड़ें'
      : '$n dose(s) missed — mark taken or skip';
  String get weeklySummary =>
      isHindi ? 'साप्ताहिक सारांश' : 'Weekly summary';
  String get medicineAdherence =>
      isHindi ? 'दवा अनुपालन' : 'Medicine adherence';
  String get waterIntake => isHindi ? 'पानी' : 'Water';
  String get shareEmergencyCard =>
      isHindi ? 'आपात कार्ड साझा करें' : 'Share emergency card';
  String get emergencyCardSubject =>
      isHindi ? 'सेहतसाथी — आपात जानकारी' : 'SehatSaathi — Emergency info';
  String get doctorVisits =>
      isHindi ? 'डॉक्टर अपॉइंटमेंट' : 'Doctor appointments';
  String get addVisit => isHindi ? 'अपॉइंटमेंट जोड़ें' : 'Add appointment';
  String get doctorName => isHindi ? 'डॉक्टर का नाम' : 'Doctor name';
  String get clinic => isHindi ? 'क्लिनिक / अस्पताल' : 'Clinic / hospital';
  String get visitNotes => isHindi ? 'नोट' : 'Notes';
  String get visitDateTime => isHindi ? 'तारीख और समय' : 'Date & time';
  String get noVisits =>
      isHindi ? 'कोई अपॉइंटमेंट नहीं' : 'No appointments yet';
  String get appLock => isHindi ? 'ऐप लॉक (PIN)' : 'App lock (PIN)';
  String get appLockHint => isHindi
      ? '4 अंकों का PIN'
      : '4-digit PIN';
  String get setPin => isHindi ? 'नया PIN सेट करें' : 'Set new PIN';
  String get confirmPin => isHindi ? 'PIN दोबारा दर्ज करें' : 'Confirm PIN';
  String get enterPin => isHindi ? 'PIN दर्ज करें' : 'Enter PIN';
  String get pinMismatch =>
      isHindi ? 'PIN मेल नहीं खाता' : 'PINs do not match';
  String get wrongPin => isHindi ? 'गलत PIN' : 'Wrong PIN';
  String get disableAppLock =>
      isHindi ? 'ऐप लॉक बंद करें' : 'Disable app lock';
  String get changePin => isHindi ? 'PIN बदलें' : 'Change PIN';

  String get tutorial => isHindi ? 'ऐप गाइड' : 'App guide';
  String get tutorialSubtitle => isHindi
      ? 'मुख्य सुविधाएँ कैसे उपयोग करें'
      : 'How to use the main features';
  String get tutorialSectionHint => isHindi
      ? 'हर सुविधा के लिए चरण-दर-चरण गाइड'
      : 'Step-by-step guides for every feature';
  String get tutorialTopicCount =>
      isHindi ? '8 विषय • हिंदी / English' : '8 topics • Hindi / English';
  String get tutorialBrowseTopics =>
      isHindi ? 'विषय चुनें' : 'Browse topics';
  String get openAppGuide =>
      isHindi ? 'पूरी गाइड खोलें' : 'Open full guide';
  String get tutorialReplayHint => isHindi
      ? 'भाषा और प्रोफ़ाइल सेटअप दोबारा'
      : 'Language & profile setup again';

  List<String> get tutorialTopicLabels => [
        dashboard,
        medicine,
        water,
        vitals,
        familyProfiles,
        emergencyInfo,
        dataBackup,
        settings,
      ];

  List<String> get tutorialHomeSteps => isHindi
      ? [
          'होम पर स्वास्थ्य स्कोर, पानी की प्रगति और बाकी दवाएँ देखें।',
          'छूटी खुराक पर टैप करके दवा स्क्रीन खोलें।',
          'साप्ताहिक सारांश से पिछले 7 दिन का अनुपालन देखें।',
          'त्वरित कार्य से दवा, पानी या विटल्स लॉग करें।',
        ]
      : [
          'Home shows your health score, water progress, and pending doses.',
          'Tap a missed-dose alert to open the Medicine tab.',
          'Open Weekly summary for the last 7 days of adherence.',
          'Use quick actions to log medicine, water, or vitals.',
        ];

  List<String> get tutorialMedicineSteps => isHindi
      ? [
          '+ बटन से दवा का नाम, खुराक और समय जोड़ें।',
          'रिमाइंडर सूचना पर Taken, Skipped या Snooze चुनें।',
          'इतिहास कैलेंडर से पिछले दिनों की स्थिति देखें।',
          'रिफिल रिमाइंडर चालू करें जब स्टॉक कम हो।',
        ]
      : [
          'Tap + to add a medicine with dose times and schedule.',
          'From a reminder, mark Taken, Skipped, or Snooze.',
          'Open history calendar to review past days.',
          'Enable refill reminders when supply runs low.',
        ];

  List<String> get tutorialWaterSteps => isHindi
      ? [
          'दैनिक लक्ष्य (ml) सेट करें और गिलास बटन से पानी जोड़ें।',
          'कस्टम मात्रा से अन्य मात्रा लॉग करें।',
          'पानी टैब में रिमाइंडर समय संपादित करें।',
        ]
      : [
          'Set a daily goal (ml) and tap glass buttons to log water.',
          'Use custom amount for other quantities.',
          'Edit reminder times on the Water tab.',
        ];

  List<String> get tutorialVitalsSteps => isHindi
      ? [
          'बीपी या शुगर रिकॉर्ड जोड़ें — ऐप माप नहीं करता, केवल लॉग।',
          'चार्ट से रुझान देखें और डॉक्टर को दिखाने के लिए रिपोर्ट निर्यात करें।',
          'हमेशा अपने डॉक्टर से सलाह लें।',
        ]
      : [
          'Log BP or sugar readings — the app does not measure, only records.',
          'Use charts for trends; export reports to share with your doctor.',
          'Always consult your healthcare provider.',
        ];

  List<String> get tutorialFamilySteps => isHindi
      ? [
          'और → परिवार प्रोफ़ाइल से सदस्य जोड़ें।',
          'प्रोफ़ाइल बदलने पर दवा, पानी और विटल्स उसी के अनुसार बदलते हैं।',
          'Pro में असीमित प्रोफ़ाइल (डेमो सेटिंग्स में चालू करें)।',
        ]
      : [
          'Go to More → Family profiles to add members.',
          'Switching profile updates medicine, water, and vitals for that person.',
          'Pro unlocks unlimited profiles (enable in Settings demo).',
        ];

  List<String> get tutorialEmergencySteps => isHindi
      ? [
          'आपात जानकारी में संपर्क, एलर्जी और नोट भरें।',
          'कार्ड साझा करें ताकि परिवार तुरंत जानकारी देख सके।',
          'मूड और डॉक्टर अपॉइंटमेंट भी और मेनू में हैं।',
        ]
      : [
          'Fill emergency contacts, allergies, and notes.',
          'Share the emergency card so family can see details quickly.',
          'Mood tracking and doctor appointments are also under More.',
        ];

  List<String> get tutorialBackupSteps => isHindi
      ? [
          'सेटिंग्स → बैकअप (JSON) से सारा डेटा निर्यात करें।',
          'नई फ़ोन पर पुनर्स्थापित करने से पहले फ़ाइल सुरक्षित रखें।',
          'पुनर्स्थापना इस डिवाइस का मौजूदा डेटा बदल देती है।',
        ]
      : [
          'Settings → Backup (JSON) exports all your data.',
          'Keep the file safe before restoring on a new phone.',
          'Restore replaces all current data on this device.',
        ];

  List<String> get tutorialSettingsSteps => isHindi
      ? [
          'डार्क मोड और हिंदी/अंग्रेज़ी भाषा बदलें।',
          'ऐप लॉक से 4 अंकों का PIN सेट करें।',
          'स्नूज़ अवधि और नोटिफ़िकेशन अनुमति जाँचें।',
          'ऑनबोर्डिंग दोबारा देखने के लिए सेटिंग्स में विकल्प है।',
        ]
      : [
          'Change dark mode and switch between Hindi and English.',
          'Set a 4-digit PIN with App lock.',
          'Adjust snooze duration and allow notification permission.',
          'Replay onboarding anytime from Settings.',
        ];

  static AppStrings of(AppLanguage lang) => AppStrings(lang);
}
