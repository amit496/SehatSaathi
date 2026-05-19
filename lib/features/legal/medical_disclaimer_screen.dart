import 'package:flutter/material.dart';

import '../../core/l10n/app_strings.dart';
import 'legal_content.dart';
import 'legal_document_screen.dart';

class MedicalDisclaimerScreen extends StatelessWidget {
  const MedicalDisclaimerScreen({super.key, required this.strings});

  final AppStrings strings;

  @override
  Widget build(BuildContext context) {
    return LegalDocumentScreen(
      pageTitle: strings.medicalDisclaimer,
      sections: LegalContent.medicalDisclaimer(strings.isHindi),
    );
  }
}
