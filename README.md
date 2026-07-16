# Kelas Flutter 5 Hari — MyBiasiswa KPT 🎓

Kursus latihan amali **Flutter** untuk pemula, dengan nota dalam **Bahasa Melayu** dan kod dalam **Bahasa Inggeris**. Sepanjang 5 hari, peserta akan membina **MyBiasiswa KPT** — sebuah aplikasi mobil untuk menyemak dan memohon **biasiswa Kementerian Pendidikan Tinggi (KPT)** — daripada kosong sehingga aplikasi lengkap yang menyambung ke API dan boleh dibina (`build`) sebagai fail APK Android.

> Inspirasi domain: [biasiswa.mohe.gov.my](https://biasiswa.mohe.gov.my/) & [mohe.gov.my](https://www.mohe.gov.my/) — permohonan biasiswa & penajaan KPT (MyBrainSc, MyBrain 2.0, BYDPA, HLP, SLAI, BKOKU, MIS, dll).

## Projek: MyBiasiswa KPT

Aplikasi ini membolehkan pelajar:

- **Semak Biasiswa** — senarai biasiswa KPT dengan carian & tapisan kategori
- **Baca Butiran** — syarat kelayakan, elaun bulanan (RM), CGPA minimum, tarikh tutup
- **Mohon** — borang permohonan dengan pengesahan (No. KP, emel, CGPA, institusi)
- **Jejak Permohonan** — status: Draf → Dihantar → Dalam Semakan → Temuduga → Diluluskan/Ditolak
- **Dashboard & Profil** — ringkasan permohonan mengikut status

## Ringkasan Kursus

Urutan kursus: **asas & UI** (Hari 1) → **navigasi & borang** (Hari 2) → **state & simpanan** (Hari 3) → **API & async** (Hari 4) → **login, dashboard & build** (Hari 5).

> **Rentak harian:** setiap hari dibahagikan kepada **teori (pagi)** dan **lab amali (petang)** — kira-kira separuh masa setiap satu. Soal jawab dialu-alukan bila-bila masa.

| Hari | Fokus | Hasil |
|------|-------|-------|
| [**Hari 1**](./hari-1/) | Persediaan Flutter, Dart asas, widget teras (Scaffold/Column/Card), tema KPT, model `Scholarship`, `ListView.builder` | Aplikasi berjalan memaparkan senarai biasiswa |
| [**Hari 2**](./hari-2/) | Navigasi (`Navigator`), skrin butiran, `Form` + `TextFormField` + validation, dropdown institusi | Skrin butiran + borang permohonan yang disahkan |
| [**Hari 3**](./hari-3/) | State management (`provider`/`ChangeNotifier`), simpanan tempatan (`shared_preferences`), badge status, carian & tapisan | Permohonan disimpan & kekal + skrin "Permohonan Saya" |
| [**Hari 4**](./hari-4/) | Async (`Future`/`await`), REST API (`http`), JSON, loading/error state, pull-to-refresh | Data biasiswa dari API (dengan *fallback* tempatan) |
| [**Hari 5**](./hari-5/) | Navigasi bawah, login ringkas, dashboard, ikon/nama app, `flutter build apk` | Aplikasi lengkap + fail APK boleh dipasang |

> **Nota:** Setiap hari **membina di atas** hari sebelumnya (kumulatif). Kod akhir lengkap ada di [`projek/mybiasiswa_kpt/`](./projek/mybiasiswa_kpt/).

## Nota Konsep (Latar Belakang)

Sebelum & sepanjang coding, folder [`nota/`](./nota/) mengandungi nota konsep ringkas dalam Bahasa Melayu:

- [**Kenapa Flutter?**](./nota/01-kenapa-flutter.md) — kelebihan, bila sesuai, contoh syarikat sebenar
- [**Asas Bahasa Dart**](./nota/02-dart-asas.md) — pembolehubah, null safety, fungsi, kelas, async
- [**Flutter vs Rangka Kerja Lain**](./nota/03-flutter-vs-lain.md) — vs React Native / Native / Ionic
- [**Persediaan Windows**](./nota/04-setup-windows.md) 🪟 — pasang Flutter SDK, VS Code, emulator *(dibina dalam Hari 1)*
- [**Pengurusan State**](./nota/05-state-management.md) — setState vs provider vs Riverpod/Bloc
- [**Pakej & pub.dev**](./nota/06-package-pub-dev.md) — `pubspec.yaml`, `flutter pub`, cara nilai pakej
- [**Deployment**](./nota/07-deployment.md) — build APK/IPA/web, ikon, senarai semak keluaran
- [**Contoh Prompt Claude Code**](./nota/08-prompt-claude-code.md) 🤖 — guna AI untuk pembangunan Flutter

## Keperluan Sistem

- **Windows 10/11 (64-bit)** — sasaran utama panduan ini (juga berfungsi pada macOS/Linux)
- Minimum **8GB RAM** (disyorkan; emulator Android memerlukan memori)
- **10GB+** ruang cakera kosong (Flutter SDK + Android SDK + emulator)
- Sambungan internet untuk `flutter pub get` & muat turun SDK

## Perisian yang Diperlukan

| Perisian | Tujuan | Pautan |
|----------|--------|--------|
| Flutter SDK | Rangka kerja + `flutter` CLI | [docs.flutter.dev/get-started](https://docs.flutter.dev/get-started/install) |
| VS Code (+ sambungan Flutter/Dart) | Editor kod | [code.visualstudio.com](https://code.visualstudio.com/) |
| Android Studio | Android SDK + emulator | [developer.android.com/studio](https://developer.android.com/studio) |
| Peranti Android (pilihan) | Uji pada telefon sebenar (USB debugging) | — |
| Git | Kawalan versi | [git-scm.com](https://git-scm.com/) |

> **Pengesahan:** Selepas pemasangan, jalankan `flutter doctor` — ia menyemak semua keperluan dan menunjukkan apa yang perlu dibaiki. Langkah penuh ada dalam [Hari 1](./hari-1/).

## Susunan Teknologi (Tech Stack)

| Lapisan | Teknologi |
|---------|-----------|
| Rangka kerja | Flutter (Material 3) |
| Bahasa | Dart |
| State management | `provider` (ChangeNotifier) |
| Simpanan tempatan | `shared_preferences` |
| Rangkaian / API | `http` |
| Format tarikh & nombor | `intl` |
| Sasaran build | Android (APK/AAB), boleh diperluas ke iOS/web |

## Entiti Domain

**`Scholarship`** (medan Bahasa Inggeris):
- `id`, `code` (MYBRAINSC/BYDPA/HLP…), `name`, `provider`
- `category` (enum: praPerkhidmatan / dalamPerkhidmatan / bantuanKewangan / antarabangsa)
- `studyLevel` (enum: sijil / diploma / bachelor / master / phd / postDoctoral)
- `fieldOfStudy`, `monthlyAllowance` (RM), `tuitionCoverage`, `minCgpa`, `maxAge`
- `applicationDeadline`, `isOpen`, `description`, `requirements`, `websiteUrl`

**`ScholarshipApplication`**:
- `id` (APP-0001…), `scholarshipId`, `applicantName`, `icNumber`, `email`, `phone`, `institution`, `currentCgpa`
- `status` (enum: draft / submitted / underReview / interview / approved / rejected), `submittedAt`, `notes`

**`Institution`** (untuk dropdown): UM, USM, UKM, UPM, UTM, UiTM, UUM, UMS, UNIMAS, UIAM.

## Slaid

Deck slaid dijana melalui **prompt Claude** — lihat [`slides/PROMPT.md`](./slides/PROMPT.md). Ini memastikan slaid sentiasa selaras dengan modul terkini. Warna jenama: navy `#1A2B5C` + emas `#D4A017`.

## Struktur Repositori

```
kelas-flutter-5-hari/
├── README.md                  # Fail ini
├── CLAUDE.md                  # Panduan untuk Claude Code
├── nota/                      # Nota konsep (Bahasa Melayu)
│   ├── 01-kenapa-flutter.md … 08-prompt-claude-code.md
├── hari-1/                    # Modul harian (README + snippets/lab.md)
│   └── snippets/lab.md
├── hari-2/  …  hari-5/        # (struktur sama, kumulatif)
├── slides/
│   ├── PROMPT.md              # Prompt reka bentuk slaid untuk Claude
│   └── README.md
└── projek/
    ├── README.md
    ├── mybiasiswa_kpt/        # Aplikasi Flutter lengkap (hasil akhir)
    └── mock-api/
        └── scholarships.json  # Data untuk mock REST API (Hari 4)
```

## Cara Mula

1. Pasang perisian di atas (langkah penuh dalam [Hari 1](./hari-1/)).
2. Sahkan dengan `flutter doctor`.
3. Baca [`nota/01-kenapa-flutter.md`](./nota/01-kenapa-flutter.md) & [`nota/02-dart-asas.md`](./nota/02-dart-asas.md).
4. Ikut [Hari 1](./hari-1/) → [Hari 5](./hari-5/) mengikut urutan.
5. Rujuk aplikasi lengkap di [`projek/mybiasiswa_kpt/`](./projek/mybiasiswa_kpt/) bila-bila anda tersangkut.

```bash
# Menjalankan aplikasi rujukan yang lengkap
cd projek/mybiasiswa_kpt
flutter pub get
flutter run
```

---

> ⚠️ **Penafian:** Bahan latihan. Nama & butiran biasiswa berdasarkan program sebenar KPT tetapi data (jumlah, tarikh, syarat) dipermudahkan untuk pembelajaran. Aplikasi ini **bukan** sistem rasmi KPT — rujuk [portal rasmi](https://biasiswa.mohe.gov.my/) untuk maklumat sebenar.
