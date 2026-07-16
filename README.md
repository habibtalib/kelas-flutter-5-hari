# Kelas Flutter 5 Hari — MyPelajar LN 🎓

Bahan **Latihan Secara *Coaching* Aplikasi Mobil Bagi Sistem Pendidikan Tinggi Luar Negara Menggunakan Flutter Berteraskan Amalan Pengekodan Moden Dengan Bantuan *Artificial Intelligence* (AI)** — anjuran **Bahagian Pengurusan Maklumat (BPM), Kementerian Pendidikan Tinggi (KPT)**.

Nota dalam **Bahasa Melayu**, kod dalam **Bahasa Inggeris**. Sepanjang 5 hari, peserta membina **MyPelajar LN** — aplikasi mobil pendamping bagi **pendaftaran pelajar Malaysia di luar negara** — daripada asas Dart sehingga aplikasi berfungsi yang menggabungkan UI, borang, navigasi dan API.

> 📅 **Aturcara rasmi (20–24 Julai 2026):** lihat [`JADUAL.md`](./JADUAL.md) — 9 sesi, waktu sebenar, tempat. **Modul ini mengikut aturcara tersebut.**

> Inspirasi domain: sistem sebenar KPT — [MyData@EducationMalaysia4U](https://dohe.mohe.gov.my/mydata/login) (pendaftaran pelajar luar negara), [e-TimurTengah](https://dohe.mohe.gov.my/timurtengah/), [eSisraf MQA](https://www2.mqa.gov.my/esisraf/kelayakan.cfm) (semakan pengiktirafan), dan 12 [Pejabat Education Malaysia](https://jpt.mohe.gov.my/index.php/en/contact-us/education-malaysia-offices) di luar negara. Diselia oleh **Bahagian Pengantarabangsaan Pendidikan Tinggi (BPPT), JPT**.

## Projek: MyPelajar LN

Aplikasi ini membolehkan pelajar:

- **Terokai Destinasi** — senarai universiti luar negara dengan carian & tapisan wilayah
- **Baca Butiran** — status pengiktirafan (rujuk MQA), anggaran yuran (RM), pejabat EM liputan, tarikh ambilan & tutup
- **Daftar** — borang pendaftaran pelajar luar negara dengan pengesahan (No. KP, pasport, emel, telefon)
- **Jejak Pendaftaran** — status: Draf → Dihantar → Disahkan → Aktif → Tamat
- **Profil & Statistik** — ringkasan pendaftaran mengikut status

> 📊 Konteks sebenar: **54,903** pelajar Malaysia di luar negara (2024) — 14,697 tajaan, 40,206 persendirian. *(Statistik Pendidikan Tinggi 2024, Bab 6)*

## Ringkasan Kursus

Urutan mengikut aturcara rasmi: **Dart & widget asas** (Hari 1) → **layout & senarai** (Hari 2) → **navigasi, borang & `setState()`** (Hari 3) → **REST API & ralat** (Hari 4) → **projek mini & kod moden** (Hari 5).

> **Rentak harian:** Pendaftaran 8.30–9.00 · sesi pagi 9.00–1.00 · rehat 1.00–2.30 · sesi petang 2.30–5.00 · bersurai 5.00. (Hari 5 berbeza — lihat [`JADUAL.md`](./JADUAL.md).)

| Hari | Sesi | Fokus | Hasil |
|------|------|-------|-------|
| [**Hari 1**](./hari-1/) | SESI 1 | Operators, control flow, looping & function; widget asas **Text/Icon/Image**; **Container/Padding/Margin/SizedBox**; **StatelessWidget vs StatefulWidget** | Faham asas Dart + widget pertama |
| [**Hari 2**](./hari-2/) | SESI 2–3 | **Row/Column/Expanded/Flexible**, **Stack/Positioned/Align/Center**, Scaffold/AppBar · 🤖 **Slot AI: mockup UI** · **BottomNavigationBar & Drawer**, **ListView/GridView**, **Card & ListTile**, **ThemeData** | Skrin senarai destinasi bergaya |
| [**Hari 3**](./hari-3/) | SESI 4–5 | **Navigator push/pop**, **named routes**, passing data, **TextField/TextFormField** · **Input Controller**, **Button & GestureDetector** · 🤖 **Slot AI: form validation** · **`setState()` & lifecycle** | Navigasi + borang pendaftaran disahkan |
| [**Hari 4**](./hari-4/) | SESI 6–7 | REST API, **HTTP methods & JSON**, pakej `http`, **async/Future/await**, fetch · 🤖 **Slot AI: JSON→Dart model** · submit data, **status code**, **try-catch/CircularProgressIndicator** | Data dari API + pengendalian ralat |
| [**Hari 5**](./hari-5/) | SESI 8–9 | **Projek mini (hackathon)** — gabung UI+Form+Navigasi+API · 🤖 alatan AI untuk coding & debugging · **Clean Coding Principles**, **Refactoring** · demo & sijil | Aplikasi berfungsi + demo |

> **Nota:** Setiap hari **membina di atas** hari sebelumnya (kumulatif). Aplikasi rujukan lengkap ada di [`projek/mypelajar_ln/`](./projek/mypelajar_ln/).

## 🤖 Slot AI

Kursus ini **berteraskan amalan pengekodan moden dengan bantuan AI**. "Slot AI" ialah **item aturcara rasmi**, bukan bonus:

| Sesi | Slot AI |
|------|---------|
| SESI 2 (Hari 2) | Menjana layout mockup UI moden dengan prompt AI |
| SESI 5 (Hari 3) | Menulis logik Form Validation dengan bantuan AI |
| SESI 7 (Hari 4) | Menukarkan respon JSON kepada Dart Model Class |
| SESI 8–9 (Hari 5) | Memaksimumkan alatan AI untuk coding & *debugging* |

> Prinsip: **AI membantu, anda memandu.** Sentiasa semak kod yang dijana, jalankan `flutter analyze`, dan fahami sebelum terima. Lihat [`nota/08-prompt-claude-code.md`](./nota/08-prompt-claude-code.md).

## Di Luar Sukatan (Nota Bonus)

Topik berikut **tiada dalam aturcara rasmi** — dikekalkan sebagai rujukan lanjutan sahaja:

| Topik | Nota |
|-------|------|
| `provider` / `ChangeNotifier`, `shared_preferences` | [`nota/05-state-management.md`](./nota/05-state-management.md) — sukatan rasmi guna **`setState()`** (SESI 5) |
| Deployment / `flutter build apk` | [`nota/07-deployment.md`](./nota/07-deployment.md) — tiada sesi deployment dalam aturcara |

> Aplikasi rujukan `projek/mypelajar_ln` menggunakan `provider` sebagai contoh **lanjutan**. Untuk kursus, ikut **`setState()`** seperti dalam Hari 3.

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
    ├── mypelajar_ln/          # ⭐ Aplikasi rujukan (MyPelajar LN)
    ├── mock-api/
    │   └── universities.json  # Data untuk mock REST API (Hari 4)
    └── mybiasiswa_kpt/        # (arkib — versi kursus terdahulu)
```

## Cara Mula

1. Baca [`JADUAL.md`](./JADUAL.md) — aturcara rasmi 9 sesi.
2. Pasang perisian di atas; sahkan dengan `flutter doctor` (panduan penuh: [`nota/04-setup-windows.md`](./nota/04-setup-windows.md)).
3. Baca [`nota/01-kenapa-flutter.md`](./nota/01-kenapa-flutter.md) & [`nota/02-dart-asas.md`](./nota/02-dart-asas.md).
4. Ikut [Hari 1](./hari-1/) → [Hari 5](./hari-5/) mengikut urutan.
5. Rujuk aplikasi lengkap di [`projek/mypelajar_ln/`](./projek/mypelajar_ln/) bila-bila anda tersangkut.

```bash
# Menjalankan aplikasi rujukan yang lengkap
cd projek/mypelajar_ln
flutter pub get
flutter run
```

---

> ⚠️ **Penafian:** Bahan latihan. Nama & butiran biasiswa berdasarkan program sebenar KPT tetapi data (jumlah, tarikh, syarat) dipermudahkan untuk pembelajaran. Aplikasi ini **bukan** sistem rasmi KPT — rujuk [portal rasmi](https://biasiswa.mohe.gov.my/) untuk maklumat sebenar.
