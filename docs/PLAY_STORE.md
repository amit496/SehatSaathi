# Google Play Store — bina website ke (sirf app)

SehatSaathi ke liye **poori website ki zaroorat nahi**. Legal text app ke andar hai. Play Store sirf **ek public privacy link** maangta hai — ye **ek page** hai, website nahi.

---

## Aapke paas kya hai (app mein)

| Page | Kahan |
|------|--------|
| Privacy policy | Settings → Legal → Privacy policy |
| Terms | Settings → Legal → Terms of service |
| Medical disclaimer | Settings → Legal |
| Data safety guide | Settings → Legal |
| About | More → About |

---

## Play Store ke liye 3 cheezein

### 1. Gmail (zaroori)

`lib/core/constants/app_info.dart` mein apna asli email likho:

```dart
static const supportEmail = 'aapka@gmail.com';
static const privacyEmail = 'aapka@gmail.com';
```

Play Console mein bhi **yahi email** contact ke liye use karo.

### 2. Privacy policy URL (ek baar, muft)

Google ko **ek link** chahiye. Poori website nahi.

**Sabse aasaan: GitHub Pages (5 minute, free)**

1. GitHub par repo push karo (agar pehle se nahi hai)
2. Repo → **Settings** → **Pages**
3. Source: **Deploy from branch** → branch `main` → folder `/docs`
4. Save — 2–3 minute baad link milega:
   `https://YOUR_USERNAME.github.io/SehatSaathi/privacy-policy.html`
5. `docs/privacy-policy.html` mein contact email apna likh do
6. `AppInfo.playStorePrivacyUrl` mein wahi link daal do (optional, yaad ke liye)

**Dusra option:** [Google Sites](https://sites.google.com) — naya page, privacy text copy-paste, publish — link Play Console mein daal do.

### 3. Release build

```bash
flutter build appbundle --release
```

Play Console → Create app → upload AAB.

---

## Data safety form (short answers)

| Sawal | Jawab |
|--------|--------|
| Data collect/share? | **No** (offline, no server) |
| Encrypted in transit? | **N/A** |
| User delete data? | **Yes** — uninstall / in-app delete |
| Health data | On device only, user-entered |

Detail: app → **Settings → Data safety (Play Store)**

---

## Store listing text

**Short (80 char):**  
`Offline family health: medicine reminders, water, vitals log. Hindi/English.`

**Category:** Health & Fitness

**Medical note in description:**  
`Does not measure BP/sugar. Not medical advice. Data stays on your phone.`

---

## Website nahi hai — ye theek hai

- Users ko **sirf app** se sab legal text milta hai  
- Play Store ko **sirf ek URL** chahiye (GitHub Pages / Google Sites)  
- Domain khareedne ki zaroorat **nahi**

---

## Checklist

- [ ] `app_info.dart` — real Gmail  
- [ ] `privacy-policy.html` — email update  
- [ ] GitHub Pages ON → privacy URL copy  
- [ ] Play Console — privacy URL + contact email  
- [ ] Health apps declaration — not a medical device  
- [ ] Screenshots (5–6)  
- [ ] Signed AAB upload  
