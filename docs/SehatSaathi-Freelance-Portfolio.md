# SehatSaathi — Freelance Portfolio Document

**Developer:** Amit Gautam  
**Contact:** gautamamit557@gmail.com  
**Project:** SehatSaathi (सेहतसाथी)  
**Version:** 1.0.0  
**Platform:** Android (iOS-ready Flutter codebase)  
**Package:** com.sehatsaathi.app  

---

## 1. Executive summary

**SehatSaathi** is an **offline-first family health companion** mobile app built with **Flutter**. It helps users track medicines, hydration, vitals, mood, and emergency information — with **Hindi and English** support. All health data stays **on the device**; no account or cloud server is required.

This document is prepared for **freelance clients**, **portfolio reviews**, and **job proposals** on platforms such as Upwork, Fiverr, and LinkedIn.

**One-line pitch (English):**  
*Offline family health app — medicine reminders, water & vitals logging, emergency card, bilingual UI, Play Store–ready.*

**One-line pitch (Hindi):**  
*ऑफ़लाइन परिवार स्वास्थ्य ऐप — दवा रिमाइंडर, पानी, बीपी/शुगर लॉग, आपात कार्ड, हिंदी/अंग्रेज़ी।*

---

## 2. Problem & solution

### Problem
- Families forget medicine doses and water intake.
- Health records are scattered (paper, WhatsApp, memory).
- Many users want **privacy** — no signup, no cloud upload.
- Hindi-speaking users need a **simple, local-language** tool.

### Solution
SehatSaathi provides:
- Scheduled **medicine reminders** with taken/skipped/snooze actions.
- **Water** daily goals and optional reminders.
- **Manual vitals logging** (BP, blood sugar) with charts — *app does not measure vitals*.
- **Family profiles** for multiple members.
- **Emergency information card** (shareable).
- **Doctor appointment** reminders.
- **JSON backup** — user controls export/restore.
- **Optional app lock** (4-digit PIN).
- **Legal pages** inside the app (privacy policy, terms, medical disclaimer).

---

## 3. Key features (for clients)

| Module | What it does |
|--------|----------------|
| **Home** | Daily health score, pending doses, missed-dose alerts, quick actions |
| **Medicine** | Add/edit medicines, schedules, dose history calendar, refill alerts |
| **Water** | Log intake, daily goal, reminder times |
| **Vitals** | BP & sugar logs, trend charts, export reports (Pro) |
| **More** | Family profiles, mood, emergency info, doctor visits, reports |
| **Settings** | Language (EN/HI), backup/restore, notifications, app lock, legal info |
| **Onboarding** | 4-step setup: welcome, language, profile, reminders |

---

## 4. Technical stack

| Layer | Technology |
|-------|------------|
| Framework | Flutter 3.x (Dart) |
| State management | Riverpod |
| Local database | Isar (offline storage) |
| Notifications | flutter_local_notifications, exact alarms |
| Charts | fl_chart |
| Backup / share | JSON export, share_plus, PDF/CSV (Pro) |
| Localization | Custom Hindi / English strings |
| Architecture | Feature-based folders, repository pattern |

**Highlights for technical clients:**
- Offline-first — no backend required for core features.
- Debounced notification scheduling (performance-optimized).
- Play Store checklist and privacy policy HTML included in repo.
- Release APK / AAB build ready.

---

## 5. Privacy & compliance

- **No account** required.
- **No default cloud upload** of health data.
- Data stored **locally** on the device.
- In-app **Privacy Policy**, **Terms of Service**, **Medical Disclaimer**, **Data Safety** guide.
- Contact email: **gautamamit557@gmail.com**
- Optional public privacy URL via GitHub Pages (`docs/privacy-policy.html`).

**Important disclaimer (always state to clients):**  
This app is **not a medical device**. It does not diagnose, treat, or measure vitals. It is for **personal logging and reminders only**.

---

## 6. My role (what I delivered)

- Full **UI/UX** implementation (Material 3, light theme, bilingual).
- **Database** design and Isar models.
- **Notification** scheduling (medicine, water, refill, visits).
- **Onboarding**, settings, backup/restore flows.
- **Bug fixes**: navigation, blank screens, performance (notification debounce).
- **Legal & Play Store** documentation (`docs/PLAY_STORE.md`, privacy HTML).
- **Release build** (APK / app bundle).

---

## 7. Demo & assets (fill before sending)

| Asset | Link / location |
|-------|------------------|
| Source code | GitHub: *(add your repo URL)* |
| Demo video (2–3 min) | *(YouTube / Drive link)* |
| Screenshots (6–8) | *(attach to proposal or portfolio)* |
| Test APK | `build/app/outputs/flutter-apk/app-release.apk` |
| Privacy policy (web) | GitHub Pages: *(optional URL)* |

**Suggested demo flow for video:**
1. Splash → Onboarding (4 screens) → Home  
2. Add medicine → reminder  
3. Log water  
4. Vitals chart  
5. More → Emergency / Family  
6. Settings → Privacy policy / Backup  

---

## 8. Freelance positioning

### Who should hire me based on this project?
- Clinics / pharmacies wanting a **reminder + log** app.
- Startups needing a **health MVP** (offline, fast).
- NGOs / elder-care apps (family profiles, emergency card).
- Agencies needing a **proven Flutter health template**.

### Services I can offer (using this as proof)
- Custom Flutter mobile apps (Android / iOS).
- Offline-first apps with local database.
- Push / local notification systems.
- Hindi + English apps for Indian market.
- Play Store submission support (privacy, listing text).

### Profile title suggestions
- Flutter Developer | Health & Offline Mobile Apps  
- Mobile App Developer | Flutter | Healthcare MVP  

---

## 9. Proposal template (copy & customize)

```
Subject: Flutter developer — shipped offline health app (portfolio)

Hi [Client name],

I built SehatSaathi, an offline family health app in Flutter:
• Medicine reminders & dose history
• Water tracking & vitals logs (manual entry)
• Family profiles & emergency share card
• Hindi/English, local database, JSON backup
• Privacy policy & Play Store docs included

Demo: [your video link]
GitHub: [your repo link]
APK for testing: [Drive link]

For your project "[project title]" I can deliver:
[list 2–3 features from their job post]

Timeline: [X weeks] | Budget: [your rate]

Happy to do a short call or screen-share walkthrough.

Best regards,
Amit Gautam
gautamamit557@gmail.com
```

---

## 10. Screenshot checklist (for portfolio)

1. Home — health score & upcoming doses  
2. Medicine list + add medicine  
3. Water progress ring  
4. Vitals chart (BP or sugar)  
5. Family profiles  
6. Emergency card / share  
7. Settings — backup & legal section  
8. Onboarding — language / profile screen  

*Tip: Use phone mockups in Canva or Figma for a professional look.*

---

## 11. FAQ for clients

**Q: Does it need a server?**  
A: No. Core app works fully offline. Optional: add cloud later for sync.

**Q: Can you white-label this for our brand?**  
A: Yes. UI, name, colors, and features can be customized.

**Q: Is it on Play Store?**  
A: Ready for submission; listing assets and privacy URL can be completed.

**Q: Does it measure BP or sugar?**  
A: No. Users enter values manually. App shows charts and reminders only.

**Q: How is data secured?**  
A: Stored on device; optional PIN lock; backup file is user-controlled.

---

## 12. Contact

**Name:** Amit Gautam  
**Email:** gautamamit557@gmail.com  
**Project:** SehatSaathi  
**Repository:** /Applications/flutter/SehatSaathi (local) — publish to GitHub for public link  

---

*Document generated for freelance & portfolio use. Update demo links and GitHub URL before sharing with clients.*
