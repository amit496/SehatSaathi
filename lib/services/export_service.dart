import 'dart:io';

import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:share_plus/share_plus.dart';

import '../data/models/enums.dart';
import '../data/repositories/health_repository.dart';

class ExportService {
  ExportService(this._repo);

  final HealthRepository _repo;

  Future<void> shareCsv({
    required String profileUuid,
    required String profileName,
    required bool isPro,
  }) async {
    if (!isPro) throw StateError('pro_required');

    final bp = await _repo.vitalsFor(
      profileUuid,
      VitalsType.bloodPressure,
      limit: 500,
    );
    final sugar = await _repo.vitalsFor(
      profileUuid,
      VitalsType.bloodSugar,
      limit: 500,
    );
    final doses = await _repo.doseLogsForProfile(profileUuid, limit: 500);
    final moods = await _repo.moodsForProfile(profileUuid, limit: 200);
    final medicines = await _repo.medicinesFor(profileUuid);

    final buffer = StringBuffer('section,date,value,note\n');
    for (final m in medicines) {
      buffer.writeln(
        'medicine,,${_escape(m.name)} — ${m.dose},${m.times.join(";")}',
      );
    }
    for (final d in doses) {
      buffer.writeln(
        'dose,${d.dateKey} ${d.scheduledTime},${d.status.name},med#${d.medicineId}',
      );
    }
    for (final v in bp) {
      buffer.writeln(
        'bp,${v.recordedAt.toIso8601String()},${v.systolic}/${v.diastolic},${_escape(v.note)}',
      );
    }
    for (final v in sugar) {
      buffer.writeln(
        'sugar,${v.recordedAt.toIso8601String()},${v.sugarMgDl},${_escape(v.note)}',
      );
    }
    for (final m in moods) {
      buffer.writeln(
        'mood,${m.dateKey},${m.mood.name},${_escape(m.note)}',
      );
    }

    await Share.share(buffer.toString(), subject: 'SehatSaathi — $profileName');
  }

  Future<void> sharePdf({
    required String profileUuid,
    required String profileName,
    required bool isPro,
  }) async {
    if (!isPro) throw StateError('pro_required');

    final bp = await _repo.vitalsFor(
      profileUuid,
      VitalsType.bloodPressure,
      limit: 80,
    );
    final sugar = await _repo.vitalsFor(
      profileUuid,
      VitalsType.bloodSugar,
      limit: 80,
    );
    final doses = await _repo.doseLogsForProfile(profileUuid, limit: 100);
    final medicines = await _repo.medicinesFor(profileUuid);
    final emergency = await _repo.emergencyFor(profileUuid);
    final moods = await _repo.moodsForProfile(profileUuid, limit: 30);

    final doc = pw.Document();
    doc.addPage(
      pw.MultiPage(
        build: (context) => [
          pw.Header(
            level: 0,
            child: pw.Text(
              'SehatSaathi Health Report',
              style: pw.TextStyle(fontSize: 22, fontWeight: pw.FontWeight.bold),
            ),
          ),
          pw.Text('Profile: $profileName'),
          pw.Text(
            'Generated: ${DateFormat.yMMMd().add_jm().format(DateTime.now())}',
          ),
          pw.SizedBox(height: 12),
          pw.Text(
            'Disclaimer: For logging purposes only. Not medical advice.',
            style: const pw.TextStyle(fontSize: 10),
          ),
          pw.SizedBox(height: 16),
          if (emergency != null) ...[
            pw.Text('Emergency',
                style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
            pw.Text('Blood group: ${emergency.bloodGroup}'),
            pw.Text(
              'Contact: ${emergency.contactName} ${emergency.contactPhone}',
            ),
            pw.Text('Allergies: ${emergency.allergies}'),
            pw.SizedBox(height: 12),
          ],
          pw.Text('Medicines',
              style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
          ...medicines.map(
            (m) => pw.Text('${m.name} — ${m.dose} at ${m.times.join(", ")}'),
          ),
          pw.SizedBox(height: 12),
          pw.Text('Recent doses',
              style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
          ...doses.take(40).map(
                (d) => pw.Text(
                  '${d.dateKey} ${d.scheduledTime} — ${d.status.name}',
                ),
              ),
          pw.SizedBox(height: 12),
          pw.Text('Blood pressure',
              style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
          ...bp.map(
            (v) => pw.Text(
              '${DateFormat.MMMd().format(v.recordedAt)} — ${v.systolic}/${v.diastolic} mmHg',
            ),
          ),
          pw.SizedBox(height: 12),
          pw.Text('Blood sugar',
              style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
          ...sugar.map(
            (v) => pw.Text(
              '${DateFormat.MMMd().format(v.recordedAt)} — ${v.sugarMgDl} mg/dL',
            ),
          ),
          pw.SizedBox(height: 12),
          pw.Text('Mood',
              style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
          ...moods.map(
            (m) => pw.Text('${m.dateKey} — ${m.mood.name}${m.note.isNotEmpty ? ": ${m.note}" : ""}'),
          ),
        ],
      ),
    );

    final dir = await getTemporaryDirectory();
    final file = File('${dir.path}/sehat_report_${profileUuid.hashCode}.pdf');
    await file.writeAsBytes(await doc.save());
    await Share.shareXFiles([XFile(file.path)], subject: 'SehatSaathi report');
  }

  static String _escape(String s) => '"${s.replaceAll('"', "'")}"';
}
