# Nota Rujukan: Persediaan Flutter di Windows 🪟

> Panduan pemasangan Flutter penuh untuk **Windows 10/11**. Untuk langkah bersepadu dalam aliran kelas (termasuk emulator & projek pertama), lihat juga [`../hari-1/README.md`](../hari-1/). Nota ini boleh dibaca **sebelum** hari pertama supaya persekitaran sudah siap.

---

## Ringkasan yang perlu dipasang

| # | Perisian | Tujuan |
|---|----------|--------|
| 1 | **Git for Windows** | Diperlukan oleh Flutter + kawalan versi |
| 2 | **Flutter SDK** | Rangka kerja + `flutter` CLI |
| 3 | **Android Studio** | Android SDK, platform-tools, emulator |
| 4 | **VS Code** (+ sambungan Flutter/Dart) | Editor kod (disyorkan untuk kelas) |

> **Ruang cakera:** siapkan **10GB+** kosong. Flutter + Android SDK + satu emulator memerlukan banyak ruang.

---

## Langkah 1 — Git for Windows

1. Muat turun dari [git-scm.com/download/win](https://git-scm.com/download/win).
2. Pasang dengan tetapan lalai.
3. Sahkan dalam PowerShell:
   ```powershell
   git --version
   ```

---

## Langkah 2 — Flutter SDK

1. Muat turun Flutter SDK (zip) dari [docs.flutter.dev/get-started/install/windows](https://docs.flutter.dev/get-started/install/windows).
2. **Ekstrak** ke lokasi tanpa ruang/aksara khas, contoh:
   ```
   C:\src\flutter
   ```
   > ⚠️ **Jangan** letak dalam `C:\Program Files\` (memerlukan kebenaran admin dan boleh menyebabkan masalah).
3. Tambah `C:\src\flutter\bin` ke **PATH**:
   - Tekan `Win` → cari **"Edit the system environment variables"**.
   - Klik **Environment Variables** → di bawah **User variables**, pilih **Path** → **Edit** → **New** → tambah `C:\src\flutter\bin`.
   - OK semua tetingkap.
4. **Tutup dan buka semula** PowerShell, kemudian sahkan:
   ```powershell
   flutter --version
   ```

---

## Langkah 3 — Android Studio (SDK + Emulator)

1. Muat turun dari [developer.android.com/studio](https://developer.android.com/studio) dan pasang.
2. Semasa **Setup Wizard** pertama, benarkan ia memasang **Android SDK**, **SDK Platform-Tools**, dan **Android Virtual Device (AVD)**.
3. Buka **More Actions → SDK Manager**, pastikan ini dipasang:
   - **Android SDK Command-line Tools (latest)**
   - **Android SDK Build-Tools**
   - **Android Emulator**
4. Cipta emulator: **More Actions → Virtual Device Manager → Create Device** → pilih peranti (cth. Pixel 7) → pilih imej sistem (cth. API 34) → Finish.

---

## Langkah 4 — VS Code + Sambungan

1. Pasang **VS Code** dari [code.visualstudio.com](https://code.visualstudio.com/).
2. Buka VS Code → **Extensions** (Ctrl+Shift+X) → pasang:
   - **Flutter** (oleh Dart Code) — ia turut memasang sambungan **Dart**.

---

## Langkah 5 — Terima lesen Android & sahkan

Jalankan dalam PowerShell:

```powershell
flutter doctor --android-licenses
# tekan 'y' untuk setiap lesen

flutter doctor
```

`flutter doctor` akan memaparkan status setiap komponen. Sasaran anda:

```
[√] Flutter
[√] Android toolchain - develop for Android devices
[√] Android Studio
[√] VS Code
[√] Connected device   (selepas emulator dihidupkan)
```

> Tanda `[!]` atau `[×]` bermakna ada langkah perlu dibaiki — baca mesej yang diberi. Sambungan **Chrome** dan **Visual Studio (desktop)** boleh diabaikan jika anda hanya menyasarkan Android.

---

## Langkah 6 — Projek pertama (ujian)

```powershell
flutter create ujian_flutter
cd ujian_flutter
flutter run
```

Pilih emulator anda. Jika aplikasi demo kaunter muncul — **persekitaran anda berjaya!** 🎉

Tekan `r` dalam terminal untuk **Hot Reload**, atau `R` untuk **Hot Restart**.

---

## Uji pada telefon Android sebenar (pilihan)

1. Pada telefon: **Settings → About phone** → ketik **Build number** 7 kali untuk buka **Developer options**.
2. **Developer options** → hidupkan **USB debugging**.
3. Sambung telefon ke PC dengan kabel USB → benarkan pop-up "Allow USB debugging".
4. Sahkan:
   ```powershell
   flutter devices
   ```
   Telefon anda patut disenaraikan. Jalankan `flutter run` dan pilih telefon.

---

## Masalah lazim

| Masalah | Penyelesaian |
|---------|--------------|
| `flutter` tidak dikenali | PATH belum ditetapkan / terminal belum dibuka semula |
| `Android licenses not accepted` | Jalankan `flutter doctor --android-licenses` |
| Emulator perlahan/tak buka | Hidupkan virtualization (VT-x/Hyper-V) dalam BIOS; guna imej x86_64 |
| `cmdline-tools component is missing` | Pasang **Android SDK Command-line Tools** dalam SDK Manager |
| Muat turun Gradle lambat kali pertama | Normal — build pertama memuat turun Gradle; sabar |

---

Sudah siap? Teruskan ke [Hari 1](../hari-1/) untuk membina aplikasi pertama anda.
