# Nota Konsep: Membina & Menerbitkan Aplikasi (Deployment)

> Selepas aplikasi siap, bagaimana nak jadikan ia fail sebenar (APK/IPA) dan terbitkan ke kedai aplikasi? Nota ini merangkumi pilihan pembinaan (build) untuk Flutter.

Rujukan ini berguna sebaik sahaja projek mini eTT Mobile anda (Hari 5) siap dan anda mahu meneruskannya ke peranti sebenar atau kedai aplikasi.

---

## Mod pembinaan

| Mod | Arahan | Guna |
|-----|--------|------|
| **Debug** | `flutter run` | Pembangunan + Hot Reload (perlahan, saiz besar) |
| **Profile** | `flutter run --profile` | Uji prestasi (profiling) |
| **Release** | `flutter build ...` | Keluaran sebenar (dioptimum, laju, kecil) |

---

## 1. Android — APK & App Bundle

```bash
# APK — untuk edaran terus / uji pada peranti
flutter build apk --release
# Fail: build/app/outputs/flutter-apk/app-release.apk

# APK berasingan mengikut seni bina (saiz lebih kecil)
flutter build apk --split-per-abi

# App Bundle (.aab) — WAJIB untuk Google Play Store
flutter build appbundle --release
# Fail: build/app/outputs/bundle/release/app-release.aab
```

**Pasang APK terus ke telefon:** salin fail `.apk` ke telefon → buka → benarkan "pasang dari sumber tidak dikenali".

Untuk Play Store, anda perlu:
- **Menandatangani (signing)** aplikasi dengan *keystore* — lihat [docs.flutter.dev/deployment/android](https://docs.flutter.dev/deployment/android).
- Akaun **Google Play Console** (bayaran sekali USD 25).

---

## 2. iOS — IPA (perlu macOS + Xcode)

```bash
flutter build ipa --release
```

- Perlu **Mac** + **Xcode** + akaun **Apple Developer** (USD 99/tahun).
- Muat naik ke App Store melalui **Transporter** atau Xcode.

---

## 3. Web (pilihan)

```bash
flutter build web --release
# Fail statik dalam: build/web/
```

Hos folder `build/web/` di mana-mana hosting statik: **Firebase Hosting**, **Vercel**, **Netlify**, **GitHub Pages**.

---

## 4. Desktop (pilihan)

```bash
flutter build windows   # .exe
flutter build macos     # .app
flutter build linux
```

---

## Ikon & Nama Aplikasi

**Nama aplikasi** (yang muncul di bawah ikon):
- Android: `android/app/src/main/AndroidManifest.xml` → `android:label`
- iOS: `ios/Runner/Info.plist` → `CFBundleDisplayName`

**Ikon aplikasi** — cara mudah guna pakej:

```bash
flutter pub add dev:flutter_launcher_icons
```

```yaml
# pubspec.yaml
flutter_launcher_icons:
  android: true
  ios: true
  image_path: "assets/icon/icon.png"   # 1024x1024
```

```bash
dart run flutter_launcher_icons
```

**Splash screen** — guna pakej `flutter_native_splash` dengan cara serupa.

---

## Senarai semak sebelum keluaran

- [ ] Tukar `applicationId` (Android) / `Bundle ID` (iOS) kepada yang unik (cth. `my.gov.kpt.ettmobile`).
- [ ] Naikkan `version:` dalam `pubspec.yaml` (cth. `1.0.0+1`).
- [ ] Set ikon & splash screen.
- [ ] Uji `flutter build ... --release` berjaya tanpa ralat.
- [ ] Buang `print()` debug & data ujian.
- [ ] Uji pada peranti **sebenar**, bukan emulator sahaja.

---

## Perkhidmatan CI/CD (lanjutan)

| Perkhidmatan | Guna |
|--------------|------|
| **Codemagic** | CI/CD khusus Flutter — bina & terbit automatik |
| **GitHub Actions** | Automasi bina/uji pada setiap push |
| **Fastlane** | Automasi keluaran ke Play/App Store |
| **Firebase App Distribution** | Edar versi ujian kepada penguji |

---

Seterusnya: [`08-prompt-claude-code.md`](./08-prompt-claude-code.md) — guna AI untuk mempercepat pembangunan Flutter.
