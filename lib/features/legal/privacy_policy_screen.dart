import 'package:flutter/material.dart';

import '../../core/l10n/app_strings.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key, required this.strings});

  final AppStrings strings;

  @override
  Widget build(BuildContext context) {
    final body = strings.isHindi ? _hi : _en;

    return Scaffold(
      appBar: AppBar(title: Text(strings.privacyPolicy)),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: body
            .map(
              (p) => Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: Text(p, style: const TextStyle(height: 1.5)),
              ),
            )
            .toList(),
      ),
    );
  }

  static const _en = [
    'SehatSaathi stores your health data locally on your device. We do not require an account and do not upload your data to our servers by default.',
    'Data you enter may include medicine schedules, water intake, blood pressure and sugar readings, mood notes, and emergency contacts.',
    'This app does not measure vital signs and does not provide medical advice. Always consult a qualified healthcare professional.',
    'Optional backup exports a JSON file that you control. Restore replaces all app data on this device.',
    'Notifications are used only for reminders you configure (medicine, water, refill).',
    'Pro features (export PDF/CSV, unlimited profiles) are optional and processed on-device.',
    'Contact: For privacy questions, use the email listed on the Play Store listing when published.',
  ];

  static const _hi = [
    'सेहतसाथी आपका स्वास्थ्य डेटा आपके फ़ोन पर स्थानीय रूप से रखता है। हमें अकाउंट की ज़रूरत नहीं और डिफ़ॉल्ट रूप से डेटा सर्वर पर नहीं भेजा जाता।',
    'आप जो जानकारी डालते हैं उसमें दवा समय, पानी, बीपी/शुगर रिकॉर्ड, मूड नोट और आपातकालीन संपर्क शामिल हो सकते हैं।',
    'यह ऐप वाइटल साइन नहीं मापता और चिकित्सा सलाह नहीं देता। हमेशा डॉक्टर से सलाह लें।',
    'वैकल्पिक बैकअप JSON फ़ाइल बनाता है जिसे आप नियंत्रित करते हैं। रिस्टोर करने पर इस डिवाइस का सारा ऐप डेटा बदल जाता है।',
    'नोटिफ़िकेशन केवल आपके सेट किए रिमाइंडर (दवा, पानी, रिफिल) के लिए हैं।',
    'Pro सुविधाएँ (PDF/CSV, अनलिमिटेड प्रोफ़ाइल) वैकल्पिक हैं और डिवाइस पर ही होती हैं।',
  ];
}
