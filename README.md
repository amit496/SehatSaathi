# SehatSaathi

Offline family health companion for Android & iOS — medicines, water, vitals, mood, emergency card. **Hindi / English.** Data stays on your device.

## Features

- **Home** — health score, upcoming doses, missed-dose alerts, weekly summary
- **Medicine** — schedules, reminders, history calendar, refill alerts
- **Water** — daily goal and reminders
- **Vitals** — blood pressure and blood sugar logs with charts
- **More** — family profiles, mood, emergency info (share card), doctor appointments, reports, settings
- **App lock** — optional 4-digit PIN
- **Backup** — export / restore JSON

## Requirements

- Flutter SDK 3.x
- Android Studio or Xcode for device builds

## Setup

```bash
git clone https://github.com/amit496/SehatSaathi.git
cd SehatSaathi
flutter pub get
dart run build_runner build --delete-conflicting-outputs
```

## Run

```bash
flutter run
```

Use a **full restart** after first clone (not hot reload only).

### Android Studio

1. **File → Open** → project root (folder with `pubspec.yaml`)
2. Set **Flutter SDK** and **Dart SDK** in Settings
3. Select device → Run

## Build release

```bash
flutter build apk --release
```

## Privacy

All health data is stored locally on the device. No account or cloud required.

## License

MIT
