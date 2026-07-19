# Kelas Flutter 5 Hari — eTT Mobile 🎓

Bahan **Latihan Secara *Coaching* Aplikasi Mobil Bagi Sistem Pendidikan Tinggi Luar Negara Menggunakan Flutter Berteraskan Amalan Pengekodan Moden Dengan Bantuan *Artificial Intelligence* (AI)** — anjuran **Bahagian Pengurusan Maklumat (BPM), Kementerian Pendidikan Tinggi (KPT)**.

Nota dalam **Bahasa Melayu**, kod dalam **Bahasa Inggeris**. Sepanjang 5 hari, peserta membina **eTT Mobile** — aplikasi mobil *companion* latihan bagi sistem **e-Timur Tengah (eTT)**, membolehkan pelajar meneliti & memohon program pengajian di universiti **Mesir** & **Maghribi (Morocco)** — daripada asas Dart sehingga aplikasi berfungsi yang menggabungkan UI, borang, navigasi dan API. Sepanjang perjalanan itu, alatan AI (Claude Code, ChatGPT, GitHub Copilot) turut diguna secara semula jadi untuk mempercepatkan penulisan kod & *debugging* — bahagian biasa cara kita bekerja, bukan sesi berasingan.

> 📅 **Aturcara rasmi (20–24 Julai 2026):** lihat [`JADUAL.md`](./JADUAL.md) — 9 sesi, waktu sebenar, tempat. **Modul ini mengikut aturcara tersebut.**

> Inspirasi domain: sistem sebenar KPT — [e-TimurTengah](https://dohe.mohe.gov.my/timurtengah/) (permohonan pelajar ke Mesir & Maghribi, sejak 2014). Diselia oleh **Bahagian Pengantarabangsaan Pendidikan Tinggi (BPPT), JPT**.

## Projek: eTT Mobile

Aplikasi ini membolehkan pelajar:

- **Terokai Program** — senarai tawaran pengajian (universiti + bidang) di Mesir & Maghribi dengan carian & tapisan negara
- **Baca Butiran** — kelayakan (SPM/STAM), anggaran kos (RM), bulan ambilan, kuota tempat, nota pengiktirafan
- **Mohon** — borang permohonan dengan pengesahan (No. KP, emel, telefon), pilih **1 negara + 1 bidang** + sehingga **3 pilihan universiti**, senarai semak dokumen
- **Jejak Permohonan** — status: Draf → Dihantar → Dalam Semakan → Layak/Tidak Layak → Tawaran → Diterima/Ditolak
- **Profil & Statistik** — ringkasan permohonan mengikut status

## Ringkasan Kursus

Urutan mengikut aturcara rasmi: **Dart & widget asas** (Hari 1) → **layout & senarai** (Hari 2) → **navigasi, borang & `setState()`** (Hari 3) → **REST API & ralat** (Hari 4) → **projek mini & kod moden** (Hari 5).

> **Rentak harian:** Pendaftaran 8.30–9.00 · sesi pagi 9.00–1.00 · rehat 1.00–2.30 · sesi petang 2.30–5.00 · bersurai 5.00. (Hari 5 berbeza — lihat [`JADUAL.md`](./JADUAL.md).)

| Hari | Sesi | Fokus | Hasil |
|------|------|-------|-------|
| [**Hari 1**](./hari-1/) | SESI 1 | Operators, control flow, looping & function; widget asas **Text/Icon/Image**; **Container/Padding/Margin/SizedBox**; **StatelessWidget vs StatefulWidget** | Faham asas Dart + widget pertama |
| [**Hari 2**](./hari-2/) | SESI 2–3 | **Row/Column/Expanded/Flexible**, **Stack/Positioned/Align/Center**, Scaffold/AppBar, menjana mockup UI dengan bantuan AI, **BottomNavigationBar & Drawer**, **ListView/GridView**, **Card & ListTile**, **ThemeData** | Skrin senarai destinasi bergaya |
| [**Hari 3**](./hari-3/) | SESI 4–5 | **Navigator push/pop**, **named routes**, passing data, **TextField/TextFormField** · **Input Controller**, **Button & GestureDetector**, menulis logik *form validation* dengan bantuan AI · **`setState()` & lifecycle** | Navigasi + borang pendaftaran disahkan |
| [**Hari 4**](./hari-4/) | SESI 6–7 | REST API, **HTTP methods & JSON**, pakej `http`, **async/Future/await**, fetch, menukar respons JSON kepada Dart model dengan bantuan AI · submit data, **status code**, **try-catch/CircularProgressIndicator** | Data dari API + pengendalian ralat |
| [**Hari 5**](./hari-5/) | SESI 8–9 | **Projek mini (hackathon)** — gabung UI+Form+Navigasi+API, dibantu AI untuk coding & debugging · **Clean Coding Principles**, **Refactoring** · demo & sijil | Aplikasi berfungsi + demo |

> **Nota:** Setiap hari **membina di atas** hari sebelumnya (kumulatif). Aplikasi rujukan lengkap ada di [`projek/ett_mobile/`](./projek/ett_mobile/). Sepanjang kursus, prinsipnya sama: **AI membantu, anda memandu** — sentiasa semak kod yang dijana, jalankan `flutter analyze`, dan fahami sebelum terima (lihat [`nota/08-prompt-claude-code.md`](./nota/08-prompt-claude-code.md)).

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

Definisi penuh: [`projek/ett_mobile/lib/models/`](./projek/ett_mobile/lib/models/).

**`Programme`** (entiti utama — satu tawaran universiti + bidang, medan Bahasa Inggeris):
- `id` (ETT-001…), `universityName`, `country` ("Egypt" | "Morocco"), `city`
- `fieldOfStudy`, `studyLevel` (enum `StudyLevel`: foundation / diploma / bachelor)
- `category` (enum `EntryCategory`: spm / stam / both — kategori sijil yang layak memohon)
- `estimatedAnnualCostMyr` — ⚠️ **ilustrasi sahaja**
- `intakeMonth`, `recognitionNote` (membawa kaveat kos ilustrasi)
- `quotaSeats` — ⚠️ **ilustrasi sahaja**, kecuali laluan Maghribi (15 tempat rasmi)

**`Application`** (permohonan pelajar — dicipta dalam apl):
- `id` (ETT-2026-0001…), `fullName`, `icNumber`, `email`, `phoneNumber`
- `academicCategory` (SPM/STAM), `academicSummary`
- `country` (**1 negara**) + `fieldOfStudy` (**1 bidang**) — peraturan sebenar eTT
- `universityChoiceIds` — **sehingga 3** id `Programme` (pilihan universiti dalam bidang tersebut)
- `uploadedDocuments` (senarai semak label dokumen), `status` (enum `ApplicationStatus`: draft / submitted / underReview / eligible / notEligible / offered / accepted / rejected), `submittedAt`

> ⚠️ Peraturan sebenar eTT: **SATU negara + SATU bidang** setiap permohonan; dalam bidang itu pelajar boleh menyusun sehingga 3 pilihan universiti. Status guna istilah sebenar **LAYAK / TIDAK LAYAK**.

## Fakta Domain eTT (disahkan)

Data kursus dibina atas fakta sebenar berikut:

- **Bidang terhad.** eTT hanya menawarkan bidang tertentu: **Perubatan, Pergigian, Farmasi, dan Pengajian Islam** (termasuk Syariah, Usuluddin, Ulum Islamiah, Bahasa Arab, Qiraat). Bukan semua bidang.
- **Laluan kemasukan.** Terbuka kepada lepasan **SPM** (laluan sains kesihatan + Ulum Islamiah) dan **STAM** (laluan pengajian Islam di Al-Azhar).
- **Kelayakan.** Semakan guna istilah rasmi **LAYAK / TIDAK LAYAK**, kira-kira 7 hari bekerja selepas permohonan ditutup. Hanya pemohon LAYAK memuat naik dokumen sokongan.
- **Portal sebenar:** Mesir → [`dohe.mohe.gov.my/timurtengah`](https://dohe.mohe.gov.my/timurtengah/) · Maghribi → [`dohe.mohe.gov.my/morocco`](https://dohe.mohe.gov.my/morocco/). Semakan pengiktirafan kelayakan → **eSisraf (MQA)**, [`www2.mqa.gov.my/esisraf`](https://www2.mqa.gov.my/esisraf/kelayakan.cfm).

| Universiti | Bandar | Bidang (via eTT) | Nota |
|-----------|--------|------------------|------|
| Universiti Al-Azhar | Kaherah, Mesir | Perubatan, Pergigian, Ulum Islamiah (SPM); Syariah, Usuluddin, Bahasa Arab (STAM) | Diasaskan ~970M; satu-satunya destinasi pengajian Islam eTT |
| Universiti Alexandria | Iskandariah, Mesir | Perubatan, Pergigian, Farmasi | — |
| Universiti Ain Shams | Kaherah, Mesir | Perubatan | — |
| Universiti Mansoura | Mansoura, Mesir | Perubatan, Farmasi | — |
| Universiti Tanta | Tanta, Mesir | Perubatan, Pergigian | — |
| Universite Al Quaraouiyine | Fes, Maghribi | Usuluddin, Syariah | Diasaskan 859M — universiti tertua di dunia yang masih beroperasi (UNESCO/Guinness) |
| Universiti Mohammed V | Rabat, Maghribi | *(pemadanan ilustrasi)* | Universiti sebenar; pemadanan bidang ilustrasi latihan |

> **Maghribi (Morocco):** data nipis — hanya **Al Quaraouiyine** disahkan sebagai destinasi; Mohammed V/Hassan II ialah pemadanan **ilustrasi**. Laluan Maghribi ialah **biasiswa kerajaan Maghribi** dengan **15 tempat** (angka rasmi sesi 2025/26); penempatan ditentukan kerajaan Maghribi.
>
> **Sumber:** Syarat_Mesir (portal eTT rasmi), Panduan Permohonan Morocco, pengumuman JPT/TCER sesi 2025/26. **Semua kos & kuota lain adalah ilustrasi.**

## Slaid

Deck **reveal.js** sedia guna: [`slides/flutter-training.html`](./slides/flutter-training.html) — **185 slaid** mengikut aturcara rasmi (9 sesi), dengan **175 nota penceramah** (tekan `S`). Buka terus dalam pelayar; tiada pelayan diperlukan.

Nota penceramah juga tersedia sebagai teks: [`hari-N/nota-penceramah.md`](./hari-1/nota-penceramah.md) + [`slides/nota-penceramah.md`](./slides/nota-penceramah.md). Untuk menjana semula deck, lihat [`slides/README.md`](./slides/README.md).

Warna: navy `#1A2B5C` + emas `#D4A017` — **pilihan reka bentuk kursus, bukan palet rasmi KPT** (KPT tidak menerbitkan garis panduan jenama awam).

## Struktur Repositori

```
kelas-flutter-5-hari/
├── JADUAL.md                  # ⭐ Aturcara rasmi (9 sesi) — sumber kebenaran
├── README.md                  # Fail ini
├── CLAUDE.md                  # Panduan untuk Claude Code
├── nota/                      # Nota konsep (Bahasa Melayu)
│   ├── 01-kenapa-flutter.md … 08-prompt-claude-code.md
├── hari-1/                    # Modul harian
│   ├── README.md              #   nota kuliah (ikut SESI + waktu)
│   ├── nota-penceramah.md     #   nota penceramah (dari slaid)
│   └── snippets/              #   lab.md + contoh kod
├── hari-2/  …  hari-5/        # (struktur sama, kumulatif)
├── slides/
│   ├── flutter-training.html  # Deck reveal.js (185 slaid)
│   ├── _build/                # Bahagian modular + _SPEC.md
│   ├── nota-penceramah.md     # Nota penceramah (pembuka & penutup)
│   ├── PROMPT.md              # Prompt jana semula deck
│   └── vendor/reveal/         # reveal.js tempatan
└── projek/
    ├── README.md
    ├── ett_mobile/            # ⭐ Aplikasi rujukan (eTT Mobile)
    ├── mock-api/
    │   └── programmes.json    # Data untuk mock REST API (Hari 4)
    └── mybiasiswa_kpt/        # (arkib — versi kursus terdahulu)
```

## Cara Mula

1. Baca [`JADUAL.md`](./JADUAL.md) — aturcara rasmi 9 sesi.
2. Pasang perisian di atas; sahkan dengan `flutter doctor` (panduan penuh: [`nota/04-setup-windows.md`](./nota/04-setup-windows.md)).
3. Baca [`nota/01-kenapa-flutter.md`](./nota/01-kenapa-flutter.md) & [`nota/02-dart-asas.md`](./nota/02-dart-asas.md).
4. Ikut [Hari 1](./hari-1/) → [Hari 5](./hari-5/) mengikut urutan.
5. Rujuk aplikasi lengkap di [`projek/ett_mobile/`](./projek/ett_mobile/) bila-bila anda tersangkut.

```bash
# Menjalankan aplikasi rujukan yang lengkap
cd projek/ett_mobile
flutter pub get
flutter run
```
