# Hari 5 — Projek Mini, Amalan Kod Moden & Penutup

Selamat datang ke hari terakhir kursus **Flutter 5 Hari**! Sepanjang Hari 1–4 anda telah mengumpul empat kemahiran teras: membina **UI** dengan widget & layout, menavigasi antara **skrin**, mengambil input pengguna melalui **borang (Form)**, dan menyambung ke **API** sebenar dengan penanganan *loading*/*error*. Hari ini kita gabungkan **kesemuanya** dalam satu sesi *hackathon* kecil — bukan menyalin kod yang sudah biasa, tetapi mengaplikasikannya pada **domain baharu**: **eTT Mobile**, aplikasi pendamping ringkas untuk sistem e-Timur Tengah (eTT) — permohonan pelajar Malaysia ke universiti di Mesir & Maghribi (Morocco).

Hari ini **BUKAN** tentang log masuk, dashboard, atau menghasilkan fail APK — ia tentang **membina sesuatu yang berfungsi di bawah tekanan masa** (seperti dalam kerja sebenar), kemudian **menggilapkannya** dengan prinsip kod bersih (*clean code*) dan *refactoring*, sebelum **mendemonstrasikannya** kepada rakan sekelas.

Dokumen ini direka untuk dibaca **secara solo** — jika anda terlepas sesi bersama jurulatih, atau mahu semak semula sebelum/selepas kelas, setiap bahagian di bawah cukup lengkap untuk diikuti sendiri, langkah demi langkah, tanpa perlu tengok slaid.

> **Rujukan projek "siap"/rujukan:** `projek/ett_mobile/lib/` mengandungi versi **lengkap** eTT Mobile — termasuk `models/`, `data/`, `services/`, `screens/`, dan `widgets/` yang boleh anda guna terus sebagai **rangka permulaan (starter)** untuk projek mini hari ini. Folder `providers/` dalam projek itu menggunakan pakej `provider` untuk state dikongsi antara skrin — untuk hackathon hari ini, bina skrin anda dengan **`setState()`**, seperti yang diajar pada SESI 5.

---

> 📱 **Demo interaktif dalam aplikasi.** Konsep hari ini ada demo yang boleh anda **jalankan & main-main** pada telefon/emulator — ubah kawalan, lihat kesannya serta-merta:
>
> Refactoring (Sebelum vs Selepas)
>
> Jalankan galeri demo: `cd projek/ett_mobile && flutter run -t lib/demos_main.dart` → pilih **Hari 5**. Kod: [`projek/ett_mobile/lib/demos/hari5/`](../projek/ett_mobile/lib/demos/hari5/).

## Fokus Hari Ini

| Topik | Dokumentasi Rasmi |
|-------|--------------------|
| Menggabungkan UI + Form + Navigasi + API | [docs.flutter.dev/cookbook](https://docs.flutter.dev/cookbook) |
| AI-assisted coding & debugging | [`nota/08-prompt-claude-code.md`](../nota/08-prompt-claude-code.md) |
| Panduan gaya Dart (Effective Dart) | [dart.dev/effective-dart](https://dart.dev/effective-dart) |
| Amalan prestasi & `const` | [docs.flutter.dev/perf/best-practices](https://docs.flutter.dev/perf/best-practices) |
| Pemformatan kod (`dart format`) | [dart.dev/tools/dart-format](https://dart.dev/tools/dart-format) |
| Analisis statik (`flutter analyze`) | [dart.dev/tools/dart-analyze](https://dart.dev/tools/dart-analyze) |
| Peraturan *lint* (`flutter_lints`) | [pub.dev/packages/flutter_lints](https://pub.dev/packages/flutter_lints) |

---

## Jadual Masa Hari Ini

Perhatikan **rentak berbeza** hari ini — sesi pagi lebih panjang, rehat lebih lewat:

| Masa | Sesi | Fokus |
|------|------|-------|
| 8.30 – 9.00 pagi | Pendaftaran & Minum Pagi | — |
| **9.00 pagi – 12.15 tgh hari** | **SESI 8** | Projek Mini Terbimbing (Bahagian 1) — *hackathon*: UI + Form + Navigasi + API, dibantu AI |
| 1.00 – 2.45 petang | Rehat & Makan Tengah Hari | *(lebih lewat berbanding hari lain)* |
| **2.45 – 5.00 petang** | **SESI 9** | Projek Mini (Bahagian 2) + Clean Code + Refactoring + Demo + Sijil |
| 5.00 petang | Bersurai | Tamat kursus |

---

## Imbas Kembali Hari 1–4

Sebelum kita mula, mari sahkan apa yang anda **sudah boleh buat**:

| Hari | Kemahiran yang Dikuasai |
|------|--------------------------|
| **Hari 1** | Asas Dart (operator, `if/else`, `switch`, `for`/`while`, *function*); widget asas `Text`, `Icon`, `Image`, `Container`, `Padding`, `SizedBox`; beza `StatelessWidget` vs `StatefulWidget` |
| **Hari 2** | Susun atur (`Row`, `Column`, `Expanded`, `Flexible`, `Stack`, `Align`); `Scaffold`/`AppBar`; navigasi `BottomNavigationBar`/`Drawer`; senarai (`ListView.builder`, `GridView`); `Card`/`ListTile`; kemasan (`TextStyle`, `ThemeData`) |
| **Hari 3** | `Navigator.push`/`pop`, *named routes*, menghantar data antara skrin; `TextField`/`TextFormField`; *Input Controller*; `Button`/`GestureDetector`; **`setState()`** & kitaran hayat `StatefulWidget` |
| **Hari 4** | Konsep REST API (GET/POST/PUT/DELETE, JSON); pakej `http`; `async`/`Future`/`await`; menarik data (*fetch*) & menghantar data (*submit*); `try-catch`, `CircularProgressIndicator`, paparan ralat |

**Hari ini, anda gabungkan SEMUA baris di atas dalam satu aplikasi berfungsi.** Itulah makna "projek mini" — bukan topik baharu, tetapi **sintesis** empat hari pembelajaran. Kalau mana-mana konsep dalam jadual di atas rasa kabur, sekarang masa terbaik untuk buka semula `README.md` hari berkenaan — hari ini **guna** kesemuanya sekali gus.

---

## Projek Mini: eTT Mobile

**eTT Mobile** ialah aplikasi pendamping ringkas yang mencerminkan konsep sistem sebenar KPT — **e-Timur Tengah (eTT)**, sistem Bahagian Pengantarabangsaan Pendidikan Tinggi (BPPT), JPT — tempat pelajar lepasan **SPM**/**STAM** memohon ke universiti di **Mesir** & **Maghribi**. Peserta akan membina:

1. **Senarai tawaran pengajian** — tawaran universiti+bidang (negara, bandar, bidang pengajian, kategori kemasukan, kos anggaran, kuota) diambil daripada API.
2. **Skrin butiran** — maklumat penuh satu tawaran, dengan butang "Mohon Sekarang".
3. **Borang permohonan** — nama, No. KP, emel, telefon, kategori sijil (SPM/STAM), **1 negara + 1 bidang** (peraturan sebenar eTT), sehingga 3 pilihan universiti, senarai semak dokumen, dengan pengesahan (*validation*).
4. **Skrin "Permohonan Saya"** — senarai permohonan yang telah dihantar, lengkap dengan cip status.

### Apa yang disediakan (starter) vs apa yang anda bina

Untuk memuatkan projek ini dalam ~3 jam, **model data, data contoh, dan lapisan servis API sudah disediakan** — tumpuan hari ini ialah membina **skrin & navigasi**, bukan menaip semula struktur data:

| Sudah disediakan (salin/guna terus) | Anda bina sendiri hari ini |
|--------------------------------------|------------------------------|
| `models/programme.dart`, `models/application.dart` | `screens/programme_list_screen.dart` (`StatefulWidget` + `setState`) |
| `data/sample_programmes.dart`, `data/document_checklist.dart` | `screens/programme_detail_screen.dart` |
| `services/programme_service.dart` (fetch API + fallback) | `screens/application_form_screen.dart` (Form + validation) |
| `widgets/programme_card.dart`, `widgets/status_badge.dart` | `screens/my_applications_screen.dart` (senarai + `setState` untuk tambah) |
| `theme.dart` (warna navy/emas) | `screens/home_screen.dart` (rangka utama + `setState` untuk kongsi senarai permohonan) |

> **Rujuk:** `projek/ett_mobile/lib/models/`, `lib/data/`, `lib/services/`, `lib/widgets/` untuk fail sedia ada. Folder `providers/` dan penggunaan `provider` dalam `main.dart`/`screens/` projek rujukan itu ialah corak state dikongsi — untuk hackathon hari ini, simpan senarai permohonan sebagai medan `List<Application>` dalam `State` skrin utama (`HomeScreen`) dan hantar/kemas kini melalui `setState`, atau *callback* fungsi antara skrin (teknik "menghantar data" yang sudah anda pelajari Hari 3).

### Struktur data ringkas

```dart
enum StudyLevel { foundation, diploma, bachelor }        // BM: Asasi/Diploma/Ijazah Sarjana Muda
enum EntryCategory { spm, stam, both }                    // BM: SPM/STAM/SPM atau STAM
enum ApplicationStatus {
  draft, submitted, underReview, eligible, notEligible, offered, accepted, rejected
}
// BM: Draf / Dihantar / Dalam Semakan / Layak / Tidak Layak / Tawaran / Diterima / Ditolak

class Programme {
  String id; String universityName;
  String country;                  // "Egypt" | "Morocco"
  String city; String fieldOfStudy;
  StudyLevel studyLevel; EntryCategory category;
  double estimatedAnnualCostMyr;   // ILUSTRASI
  String intakeMonth; String recognitionNote;
  int quotaSeats;                  // ILUSTRASI (kecuali laluan Maghribi: 15, angka rasmi)
}

class Application {
  String id; String fullName; String icNumber; String email; String phoneNumber;
  EntryCategory academicCategory;  // sijil yang dipegang pemohon
  String academicSummary;          // cth. "SPM 2025 — 9A"
  String country;                  // SATU negara (peraturan sebenar eTT)
  String fieldOfStudy;             // SATU bidang (peraturan sebenar eTT)
  List<String> universityChoiceIds;// 1–3 id Programme (pilihan universiti)
  List<String> uploadedDocuments;
  ApplicationStatus status; DateTime? submittedAt;
}
```

---

## Peta Projek — Fail, Skrin & Susunan Pembinaan

Sebelum menaip sebarang kod, luangkan **5 minit** untuk faham bentuk akhir projek ini. Aplikasi hari ini mempunyai **5 skrin** dalam **satu aliran data mudah**: `HomeScreen` menyimpan senarai permohonan (`List<Application>`) dan mengalirkannya ke bawah melalui *callback* — corak "lift state up" yang anda sentuh sedikit di Hari 3, sekarang digunakan penuh.

```text
lib/
├── models/                     ✅ SUDAH SEDIA — salin terus
│   ├── programme.dart
│   └── application.dart
├── data/                       ✅ SUDAH SEDIA — salin terus
│   ├── sample_programmes.dart
│   └── document_checklist.dart
├── services/                   ✅ SUDAH SEDIA — salin terus
│   └── programme_service.dart
├── widgets/                    ✅ SUDAH SEDIA — salin terus
│   ├── programme_card.dart
│   └── status_badge.dart
├── theme.dart                  ✅ SUDAH SEDIA — salin terus
└── screens/                    🔨 ANDA BINA hari ini
    ├── home_screen.dart              (rangka: tab + state kongsi)
    ├── programme_list_screen.dart    (Latihan 1 lab)
    ├── programme_detail_screen.dart  (Latihan 2 lab)
    ├── application_form_screen.dart  (Latihan 3 lab)
    └── my_applications_screen.dart   (Latihan 4 lab)
```

Aliran skrin (dan **siapa hantar apa kepada siapa**):

```text
HomeScreen (state: List<Application> _applications)
  │
  ├─▶ ProgrammeListScreen (onApplicationSubmitted callback)
  │      │  ambil List<Programme> daripada ProgrammeService
  │      │  tekan kad → Navigator.push
  │      ▼
  │    ProgrammeDetailScreen (programme, onApplicationSubmitted)
  │      │  tekan "Mohon Sekarang" → Navigator.push
  │      ▼
  │    ApplicationFormScreen (programme, onSubmitted)
  │      │  hantar borang sah → widget.onSubmitted(application) → pop()
  │      ▼  (callback "naik" balik ke HomeScreen)
  │    HomeScreen._addApplication() → setState() → _applications bertambah
  │
  └─▶ MyApplicationsScreen (applications: _applications)
         memaparkan semula senarai yang sama, terus dikemas kini
```

**Kenapa `HomeScreen` yang simpan `_applications`, bukan `MyApplicationsScreen` sendiri?** Kerana **dua** skrin berbeza perlu tahu tentangnya — borang perlu **menambah** rekod, dan "Permohonan Saya" perlu **memaparkannya**. Kalau `_applications` disimpan dalam `MyApplicationsScreen`, `ApplicationFormScreen` tiada cara untuk mencapainya (ia bukan *ancestor* dalam pepohon widget). Letak state di titik **paling rendah yang masih menjadi ibu bapa kepada SEMUA widget yang perlukannya** — di sini, itu ialah `HomeScreen`. Ini prinsip Flutter rasmi dipanggil ["lifting state up"](https://docs.flutter.dev/data-and-backend/state-mgmt/simple).

### Susunan Pembinaan Bercadang (9.00 – 12.15)

Bina mengikut urutan ini — setiap peringkat **bergantung** kepada yang sebelumnya, jadi jangan langkau:

| Masa | Bina | Kenapa urutan ini |
|------|------|---------------------|
| 9.00 – 9.20 | Taklimat, salin `models`/`data`/`services`/`widgets`/`theme.dart`, cipta `HomeScreen` rangka kosong | Tanpa lapisan data, tiada apa untuk dipaparkan |
| 9.20 – 10.15 | `ProgrammeListScreen` — fetch API + `ListView.builder` | Skrin pertama pengguna nampak; membuktikan sambungan data berfungsi |
| 10.15 – 11.00 | `ProgrammeDetailScreen` + navigasi daripada kad | Perlukan `Programme` yang **sudah** boleh dipaparkan (langkah atas) sebelum boleh navigasi kepadanya |
| 11.00 – 12.00 | `ApplicationFormScreen` + validation + hantar balik ke `HomeScreen` | Borang perlu tahu `Programme` mana dipilih (daripada skrin butiran) sebelum ia boleh diisi awal |
| 12.00 – 12.15 | `MyApplicationsScreen` (jika sempat) + semak status | Skrin paparan sahaja — paling mudah, letak akhir jika masa suntuk |

> **Jangan panik jika tidak siap 100% menjelang 12.15** — SESI 9 bermula dengan meneruskan/menyelesaikan projek ini. Ini normal dalam *hackathon* sebenar; keutamaan yang jelas (jadual di atas) lebih penting daripada kelajuan.

### Ringkasan setakat ini: `StatelessWidget` atau `StatefulWidget`?

Sebelum mula menaip, tentukan dahulu jenis widget setiap skrin — kesilapan biasa ialah jadikan **semua** skrin `StatefulWidget` "untuk selamat", walaupun sebahagian tidak perlukannya:

| Skrin | Jenis | Sebab |
|-------|-------|-------|
| `HomeScreen` | `StatefulWidget` | Menyimpan `_currentTab` dan `_applications` — kedua-duanya **berubah** semasa aplikasi berjalan |
| `ProgrammeListScreen` | `StatefulWidget` | `_programmes` dan `_isLoading` berubah **selepas** `initState()` (bila `fetchProgrammes()` selesai) |
| `ProgrammeDetailScreen` | `StatelessWidget` | Menerima satu `Programme` yang **tidak berubah** sepanjang hayat skrin ini — sekadar papar |
| `ApplicationFormScreen` | `StatefulWidget` | Nilai `TextEditingController`, dropdown, dan checkbox berubah setiap kali pengguna menaip/memilih |
| `MyApplicationsScreen` | `StatelessWidget` | Hanya **memaparkan** senarai yang dihantar masuk daripada `HomeScreen` — tiada state sendiri |

Peraturan ringkas: jika skrin/widget perlu **ingat** sesuatu yang berubah semasa ia dipaparkan (input pengguna, hasil `Future`, kaunter), ia `StatefulWidget`. Jika ia sekadar **melukis** data yang diterima daripada `widget.x` tanpa pernah mengubahnya sendiri, ia `StatelessWidget`.

---

## SESI 8 (9.00 pagi – 12.15 tgh hari) — Projek Mini Terbimbing (Bahagian 1)

### Brif Projek

> Anda seorang pembangun *junior* di sebuah syarikat teknologi pendidikan. Klien (BPPT, KPT) mahu **prototaip berfungsi** aplikasi permohonan eTT dalam masa **satu pagi**. Ia tidak perlu cantik — ia perlu **BERFUNGSI**: pengguna boleh lihat senarai tawaran pengajian, buka butiran, isi & hantar borang permohonan, dan lihat senarai permohonan mereka.

Ini corak sebenar *hackathon* — masa terhad, keutamaan jelas, dan bantuan alat AI **digalakkan sepenuhnya**.

### Skop Minimum Berdaya-laku (MVP)

Fokus **hanya** pada 4 perkara ini — jangan tergoda untuk menambah ciri lain dahulu. Setiap bahagian di bawah ada **rangka permulaan (skeleton)** — salin ke fail anda, kemudian isi bahagian bertanda `// TODO`. Versi **penuh, langkah demi langkah** setiap skeleton ini ada dalam [`snippets/lab.md`](./snippets/lab.md).

#### 8.1 — Senarai tawaran pengajian (`ProgrammeListScreen`)

`ListView.builder` memaparkan `ProgrammeCard` (widget sedia ada), data diambil melalui `ProgrammeService().fetchProgrammes()` dengan `CircularProgressIndicator` semasa memuat. Ini mesti `StatefulWidget` kerana data berubah **selepas** `build()` pertama (ia mula kosong, kemudian terisi bila API selesai).

```dart
class ProgrammeListScreen extends StatefulWidget {
  const ProgrammeListScreen({super.key, required this.onApplicationSubmitted});

  final ValueChanged<Application> onApplicationSubmitted;

  @override
  State<ProgrammeListScreen> createState() => _ProgrammeListScreenState();
}

class _ProgrammeListScreenState extends State<ProgrammeListScreen> {
  List<Programme> _programmes = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    // TODO: panggil ProgrammeService().fetchProgrammes(), kemudian setState()
    // untuk isi _programmes dan set _isLoading = false.
    // INGAT: semak `if (!mounted) return;` SEBELUM setState selepas await —
    // pengguna mungkin sudah tinggalkan skrin ini semasa API masih menunggu.
  }

  @override
  Widget build(BuildContext context) {
    // TODO: jika _isLoading, papar Center(child: CircularProgressIndicator()).
    // TODO: jika tidak, papar ListView.builder — satu ProgrammeCard bagi
    // setiap Programme, dengan onTap yang Navigator.push ke
    // ProgrammeDetailScreen(programme: p, onApplicationSubmitted: ...).
    return const SizedBox.shrink();
  }
}
```

> Susunan `Row`/`Column` dalam kad begini memang mudah jadi leceh nak kemaskan — tapi anda **tidak perlu** tulis semula, `ProgrammeCard` sudah siap dalam `widgets/programme_card.dart`. Kalau anda mahu ubah suainya, cuba minta AI: *"Bina Row untuk ProgrammeCard: bendera negara, Column (universityName, fieldOfStudy), Expanded, dan kos RM di hujung kanan. Guna KptTheme.navy untuk tajuk."* Semak hasilnya dan jalankan `flutter analyze` sebelum terima.

#### 8.2 — Skrin butiran (`ProgrammeDetailScreen`)

`Navigator.push` dari kad → papar semua maklumat tawaran + butang "Mohon Sekarang". Skrin ini **statik** — data sudah lengkap sebaik ia diterima, tiada apa yang berubah selepas dipaparkan — jadi cukup `StatelessWidget`.

```dart
class ProgrammeDetailScreen extends StatelessWidget {
  const ProgrammeDetailScreen({
    super.key,
    required this.programme,
    required this.onApplicationSubmitted,
  });

  final Programme programme;
  final ValueChanged<Application> onApplicationSubmitted;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(programme.universityName)),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          // TODO: papar flagEmoji, fieldOfStudy, city+countryLabel,
          // CategoryPill(category: programme.category), kos anggaran
          // (guna intl NumberFormat.currency seperti ProgrammeCard),
          // quotaSeats, intakeMonth, dan recognitionNote.
          // TODO: FilledButton.icon "Mohon Sekarang" — Navigator.push ke
          // ApplicationFormScreen(programme: programme, onSubmitted: ...).
        ],
      ),
    );
  }
}
```

#### 8.3 — Borang permohonan (`ApplicationFormScreen`)

`Form` + `TextFormField` (nama, No. KP, emel, telefon, ringkasan keputusan) + `DropdownButtonFormField` (kategori sijil SPM/STAM) dengan **validator** untuk setiap medan, ditambah senarai semak dokumen dan sehingga **3 pilihan universiti** dalam negara+bidang yang sama (`programme.country` + `programme.fieldOfStudy` menetapkan **1 negara + 1 bidang**, mengikut peraturan sebenar eTT — pilihan 2 & 3 hanya boleh universiti **lain** dengan negara+bidang yang **sama**).

```dart
class ApplicationFormScreen extends StatefulWidget {
  const ApplicationFormScreen({
    super.key,
    required this.programme,        // menetapkan negara + bidang (1+1)
    required this.allProgrammes,    // untuk cari calon Pilihan 2 & 3
    required this.onSubmitted,
  });

  final Programme programme;
  final List<Programme> allProgrammes;
  final ValueChanged<Application> onSubmitted;

  @override
  State<ApplicationFormScreen> createState() => _ApplicationFormScreenState();
}

class _ApplicationFormScreenState extends State<ApplicationFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();
  // TODO: controller sama untuk No. KP, emel, telefon, ringkasan keputusan.
  EntryCategory? _academicCategory;
  String? _choice2;
  String? _choice3;

  @override
  void initState() {
    super.initState();
    // TODO: kira senarai calon Pilihan 2/3 daripada widget.allProgrammes —
    // tapis p.country == widget.programme.country DAN
    // p.fieldOfStudy == widget.programme.fieldOfStudy DAN p.id berbeza.
  }

  // TODO: dispose() semua TextEditingController.
  // TODO: _validateIc, _validateEmail, _validatePhone (String? Function(String?)).

  void _submit() {
    // TODO: sahkan _formKey.currentState!.validate(); jika tidak sah, return.
    // TODO: bina Application baharu (id unik, status: submitted,
    // submittedAt: DateTime.now(), universityChoiceIds gabungan
    // widget.programme.id + _choice2 + _choice3 bukan-null).
    // TODO: panggil widget.onSubmitted(application), papar SnackBar,
    // Navigator.of(context).pop().
  }

  @override
  Widget build(BuildContext context) {
    // TODO: Scaffold + Form(key: _formKey) + ListView berisi kesemua
    // TextFormField, DropdownButtonFormField kategori sijil, dua
    // DropdownButtonFormField pilihan 2 & 3, CheckboxListTile senarai
    // dokumen (ettDocumentChecklist), dan FilledButton.icon "Hantar".
    return const Scaffold(body: SizedBox.shrink());
  }
}
```

> Menulis `validator` untuk No. KP/emel/telefon dari kosong memang makan masa — sini tempat AI paling berguna. Terangkan format yang anda mahu (cth. "12 digit selepas buang tanda `-`") dan minta ia jana logik validasi yang sepadan, kemudian uji dengan beberapa input salah untuk pastikan ia menolak dengan betul.

#### 8.4 — "Permohonan Saya" (`MyApplicationsScreen`)

Senarai permohonan yang telah dihantar, dengan cip warna memaparkan status (`ApplicationStatus`) melalui widget sedia ada `StatusBadge`. Skrin ini **hanya memaparkan** data yang dihantar masuk daripada `HomeScreen` — tiada state sendiri, jadi `StatelessWidget` memadai.

```dart
class MyApplicationsScreen extends StatelessWidget {
  const MyApplicationsScreen({super.key, required this.applications});

  final List<Application> applications;

  @override
  Widget build(BuildContext context) {
    // TODO: jika applications.isEmpty, papar mesej "Belum ada permohonan.".
    // TODO: jika tidak, ListView.builder — satu Card bagi setiap Application:
    // countryLabel + fieldOfStudy, StatusBadge(status: application.status),
    // fullName, dan submittedAt (format dengan intl DateFormat).
    return const SizedBox.shrink();
  }
}
```

### Senarai Semak / Rubrik

Gunakan senarai ini untuk sahkan projek anda "SIAP" sebelum tengah hari:

- [ ] Aplikasi `flutter run` **tanpa ralat merah** (*red screen*).
- [ ] Senarai tawaran dipaparkan daripada `ProgrammeService` (bukan disalin terus dalam `build()`).
- [ ] Keadaan **loading** dipaparkan semasa data sedang diambil.
- [ ] Menekan kad tawaran **menavigasi** ke skrin butiran dengan **data yang betul** dihantar.
- [ ] Borang permohonan mempunyai **sekurang-kurangnya 4 medan** dengan `validator` yang menolak input kosong/tidak sah, dan menguatkuasakan **1 negara + 1 bidang**.
- [ ] Menekan "Hantar" pada borang yang **sah** menambah satu rekod ke senarai "Permohonan Saya" dan kembali ke skrin sebelumnya.
- [ ] Skrin "Permohonan Saya" memaparkan **sekurang-kurangnya**: nama universiti/bidang, status (dengan warna), dan tarikh hantar.
- [ ] `flutter analyze` — sifar isu (atau isu diketahui & difahami sebabnya).
- [ ] Setiap ahli pasukan **faham** setiap baris kod yang dijana AI dalam projek mereka.

### Jadual Troubleshooting

Bila kod tersekat — dan ia akan berlaku semasa *hackathon* — AI (ChatGPT, GitHub Copilot, Claude Code) ialah rakan *debugging* yang pantas, asalkan anda beri konteks penuh: tampal **mesej ralat lengkap** bersama kod fungsi yang relevan (bukan seluruh fail), dan tanya puncanya:

```text
Saya dapat ralat ini bila menekan butang "Hantar":
[tampal MESEJ RALAT PENUH]
Ini kod fail application_form_screen.dart yang berkaitan:
[tampal KOD yang relevan sahaja — bukan seluruh fail]
Apakah puncanya, dan bagaimana membaikinya?
```

Jalankan `flutter analyze` selepas setiap cadangan diterima, minta AI **terangkan** bahagian yang tidak jelas sebelum diteruskan, dan `commit` kerap (`git commit`) supaya anda boleh patah balik jika satu cadangan merosakkan sesuatu. Templat prompt lengkap: [`nota/08-prompt-claude-code.md`](../nota/08-prompt-claude-code.md).

Ralat biasa yang akan muncul semasa *hackathon* — kenal pasti dan baiki dengan cepat:

| Ralat / Gejala | Punca Biasa | Pembaikan |
|-----------------|-------------|-----------|
| `setState() called after dispose()` | Panggil `setState` selepas skrin ditutup (cth. dalam callback `http` yang lewat pulang) | Semak `if (!mounted) return;` sebelum `setState` dalam kod *async* |
| `Null check operator used on a null value` | Guna `!` pada nilai yang mungkin `null` (cth. `_academicCategory!` sebelum dropdown dipilih) | Sahkan nilai tidak `null` dahulu (`if (x != null)`), atau guna `validator` borang untuk halang penghantaran awal |
| `RenderFlex overflowed by X pixels` | `Row`/`Column` cuba memuatkan kandungan lebih besar daripada ruang tersedia | Bungkus widget yang "melimpah" dengan `Expanded`/`Flexible`, atau guna `Wrap` untuk kandungan berbilang baris |
| Permintaan API sentiasa gagal / *timeout* | Tiada sambungan internet, URL salah, atau CORS (bila diuji di web) | Sahkan URL & sambungan; gunakan `try/catch` + fallback data tempatan (seperti `ProgrammeService`) supaya kelas tidak terhenti |
| `MissingPluginException` | Pakej memerlukan *hot restart* (bukan sekadar *hot reload*) selepas ditambah, atau platform belum disokong sepenuhnya | Lakukan **hot restart** penuh (`R` besar di terminal / butang restart) selepas `flutter pub get` pakej baharu |
| Perubahan kod tidak kelihatan langsung | *Hot reload* (`r`) tidak mencukupi untuk perubahan `main()`, `initState`, atau struktur kelas | Guna **hot restart** (`R`) untuk perubahan struktur; *hot reload* hanya untuk perubahan `build()` kecil |
| `type 'Null' is not a subtype of type 'String'` semasa `fromJson` | Medan JSON tiada/`null` tetapi model mengharapkan nilai bukan-null | Jadikan medan model `String?` (boleh null) atau beri nilai lalai (`json['x'] as String? ?? ''`) |
| `DropdownButtonFormField` papar skrin merah "There should be exactly one item with [DropdownButton]'s value" | `initialValue`/`value` dropdown tidak sepadan dengan **mana-mana** `item` dalam senarai (cth. selepas negara ditukar, bidang lama tiada dalam senarai baharu) | Set semula nilai bergantung (`_choice2`/`_choice3` dsb.) kepada `null` setiap kali nilai induk (negara/bidang) berubah |
| Widget baharu tidak nampak langsung selepas diekstrak ke kelas berasingan | Lupa panggil kelas baharu dalam `build()` induk, atau *typo* nama kelas | Semak import & panggilan widget; `flutter analyze` akan tangkap kelas yang tidak digunakan |
| Kad/borang kelihatan **sama** untuk semua item senarai | Guna pembolehubah **global**/tetap dalam `itemBuilder` bukan `items[index]` | Pastikan setiap rujukan data dalam `itemBuilder` guna parameter `index` yang betul |
| `The argument type 'Null' can't be assigned to the parameter type 'String'` pada `Navigator.push` | Lupa `required` parameter semasa `MaterialPageRoute(builder: (_) => XScreen())` | Semak setiap parameter `required` skrin destinasi dihantar — `flutter analyze` akan tunjuk baris tepat |
| `setState()` dipanggil tetapi UI tidak berubah | `setState` dipanggil dalam skrin **berbeza** daripada yang memaparkan data (cth. dalam `ApplicationFormScreen` cuba ubah senarai yang disimpan dalam `HomeScreen`) | Guna *callback* (`onSubmitted`) untuk "naikkan" perubahan ke `State` yang **memiliki** data, jangan cuba ubah state skrin lain terus |

---

## SESI 9 (2.45 – 5.00 petang) — Projek Mini (Bahagian 2), Amalan Kod Moden & Penutup

### Menyelesaikan Projek & Troubleshooting

30–45 minit pertama: teruskan/siapkan MVP daripada SESI 8. Guna semula jadual *troubleshooting* di atas jika tersekat. Jurulatih akan pusing membantu pasukan yang tersekat. Jika projek anda **sudah** siap, mulakan Latihan 6 (refactor) dalam lab lebih awal — jangan tunggu.

### Clean Coding Principles dalam Flutter

Kod yang **berfungsi** sahaja tidak cukup — kod yang **boleh dibaca & diselenggara** orang lain (atau diri anda sendiri 6 bulan akan datang) sama pentingnya. Bahagian ini terangkan **lapan** prinsip, setiap satu dengan contoh **sebelum → selepas** yang boleh anda banding terus dengan kod projek mini anda pagi tadi.

#### 1. Penamaan bermakna

Nama pembolehubah/fungsi/kelas patut menerangkan **tujuannya** — pembaca sepatutnya faham apa ia buat **tanpa** perlu buka `build()`nya.

```dart
// ❌ SEBELUM — nama x, y, e, check tidak beritahu apa-apa
bool check(String x, String y) {
  return x == 'both' || x == y;
}

double calc(double a, int b) {
  return a * b;
}
```

```dart
// ✅ SELEPAS — nama menerangkan domain eTT sebenar
bool entryCategoryAccepts(EntryCategory offered, EntryCategory applicant) {
  return offered == EntryCategory.both || offered == applicant;
}

double estimatedTotalTuitionFee(double annualFeeMyr, int yearsOfStudy) {
  return annualFeeMyr * yearsOfStudy;
}
```

Bandingkan dengan kod sebenar: `EntryCategory.accepts(applicant)` dalam `models/programme.dart` — nama kaedah itu sendiri **membaca seperti ayat Bahasa Inggeris**: "does this category accept that applicant?".

#### 2. Widget kecil (satu widget = satu tanggungjawab)

Setiap widget patut buat **satu** perkara. `build()` yang cuba paparkan "kad + status + butang + dialog" sekali gus ialah petanda ia perlu dipecahkan.

```dart
// ❌ SEBELUM — satu widget cuba buat SEMUANYA: kad, status, DAN butang aksi
class ApplicationRow extends StatelessWidget {
  const ApplicationRow({super.key, required this.application});
  final Application application;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Text(application.fieldOfStudy),
          Container(
            padding: const EdgeInsets.all(4),
            color: application.status.color,
            child: Text(application.status.label),
          ),
          Row(
            children: [
              TextButton(onPressed: () {}, child: const Text('Kemas Kini')),
              IconButton(onPressed: () {}, icon: const Icon(Icons.delete)),
            ],
          ),
        ],
      ),
    );
  }
}
```

```dart
// ✅ SELEPAS — tiga widget kecil, setiap satu satu tanggungjawab jelas
class ApplicationRow extends StatelessWidget {
  const ApplicationRow({super.key, required this.application});
  final Application application;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Text(application.fieldOfStudy),
          StatusBadge(status: application.status),   // ← guna widget sedia ada
          const _ApplicationActionsRow(),
        ],
      ),
    );
  }
}

class _ApplicationActionsRow extends StatelessWidget {
  const _ApplicationActionsRow();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        TextButton(onPressed: () {}, child: const Text('Kemas Kini')),
        IconButton(onPressed: () {}, icon: const Icon(Icons.delete)),
      ],
    );
  }
}
```

#### 3. `const` constructor bila datanya tetap

Tandakan widget yang datanya **tidak akan berubah** dengan `const` — Flutter langkau *rebuild* untuk widget itu sepenuhnya, walaupun ibu bapanya dibina semula berulang kali.

```dart
// ❌ SEBELUM — Flutter terpaksa bina semula ikon & sempadan setiap kali
// AppBar/parent rebuild, walaupun kandungannya TIDAK PERNAH berubah
Icon(Icons.school, size: 40, color: Color(0xFF1A2B5C))
SizedBox(height: 12)
Divider(color: Colors.grey, thickness: 1)
```

```dart
// ✅ SELEPAS — `const` beritahu Flutter "widget ini tetap, jangan bina semula"
const Icon(Icons.school, size: 40, color: Color(0xFF1A2B5C))
const SizedBox(height: 12)
const Divider(color: Colors.grey, thickness: 1)
```

> **Nota dari slaid:** lint `prefer_const_constructors` (sebahagian daripada `flutter_lints`, aktif lalai dalam projek Flutter baharu) akan **mencadangkan** `const` secara automatik dalam VS Code — garis bawah kuning di bawah constructor. **Terima cadangannya.**

#### 4. Elak *nesting* dalam

`Row` dalam `Column` dalam `Padding` dalam `Container` dalam `Row`... yang terlalu dalam (lebih 3–4 lapisan) sukar dibaca — mata pembaca hilang jejak lapisan mana sedang dibina.

```dart
// ❌ SEBELUM — 5 lapisan nesting untuk SATU keping maklumat kos
Padding(
  padding: const EdgeInsets.all(16),
  child: Container(
    decoration: BoxDecoration(border: Border.all()),
    child: Row(
      children: [
        Column(
          children: [
            Row(
              children: [
                Icon(Icons.payments),
                Text('Kos anggaran'),
              ],
            ),
          ],
        ),
      ],
    ),
  ),
);
```

```dart
// ✅ SELEPAS — ekstrak sub-pokok kepada widget berasingan, satu lapisan jelas
Padding(
  padding: const EdgeInsets.all(16),
  child: _CostInfoBox(costLabel: 'Kos anggaran'),
);

class _CostInfoBox extends StatelessWidget {
  const _CostInfoBox({required this.costLabel});
  final String costLabel;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(border: Border.all()),
      child: Row(
        children: [const Icon(Icons.payments), Text(costLabel)],
      ),
    );
  }
}
```

#### 5. Ekstrak *widget* — bukan sekadar *method* (`_buildX()`)

Bila bahagian UI kompleks atau boleh diguna semula, jadikan ia **kelas** `StatelessWidget`/`StatefulWidget` — **bukan** sekadar kaedah pembantu yang memulangkan `Widget`.

```dart
// ❌ Kelihatan lebih pantas ditaip, tetapi 3 kelemahan:
// (1) masih dijalankan semula setiap kali build() induk dipanggil,
// (2) TIDAK BOLEH const, (3) TIDAK BOLEH diguna semula di skrin lain.
Widget _buildCategoryPill(EntryCategory category) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
    child: Text(category.label),
  );
}
```

```dart
// ✅ Kelas widget berasingan — BOLEH const, BOLEH dilangkau rebuild,
// BOLEH diimport & diguna semula di ProgrammeDetailScreen, ProgrammeCard, dll.
class CategoryPill extends StatelessWidget {
  const CategoryPill({super.key, required this.category});
  final EntryCategory category;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      child: Text(category.label),
    );
  }
}
```

Ini **soalan temu duga Flutter yang popular** — [`snippets/refactor_before_after.dart`](./snippets/refactor_before_after.dart) mengupas alasan penuh (skop *rebuild*, `const`, guna semula) dengan contoh boleh jalan.

#### 6. Tanggungjawab tunggal (*Single Responsibility Principle*) di peringkat kelas

Satu kelas/fungsi = **satu sebab untuk berubah**. Kalau `ProgrammeListScreen` juga memanggil API, memformat tarikh, DAN mengurus navigasi — ubah **mana-mana satu** sebab (cth. tukar sumber API) berisiko merosakkan yang lain.

```dart
// ❌ SEBELUM — satu kelas urus fetch API, format paparan, DAN navigasi
class ProgrammeListScreen extends StatefulWidget {
  // ... di dalam State:
  Future<void> _load() async {
    final response = await http.get(Uri.parse('https://...'));
    // parse JSON terus di sini, format tarikh terus di sini,
    // logik retry terus di sini...
  }
}
```

```dart
// ✅ SELEPAS — setiap lapisan satu tanggungjawab, seperti projek sebenar
// ProgrammeService   → HANYA urus panggilan API + fallback (services/)
// Programme.fromJson → HANYA urus penukaran JSON→objek (models/)
// ProgrammeListScreen → HANYA urus PAPARAN & navigasi (screens/)
class ProgrammeListScreen extends StatefulWidget {
  // ... di dalam State:
  Future<void> _load() async {
    final data = await ProgrammeService().fetchProgrammes(); // satu baris
    if (!mounted) return;
    setState(() => _programmes = data);
  }
}
```

#### 7. Struktur folder konsisten

`models/` (struktur data), `data/` (data statik/contoh), `services/` (panggilan API), `widgets/` (komponen kecil boleh guna semula), `screens/` (satu skrin penuh) — **struktur sebenar** `projek/ett_mobile/lib/`. Kalau anda letak `ProgrammeCard` terus dalam `programme_list_screen.dart`, ia berfungsi — tetapi bila `ProgrammeDetailScreen` juga perlukannya, anda terpaksa `import` fail skrin lain (pelik) atau salin-tampal kod (buruk). Letak dalam `widgets/` dari awal mengelakkan kedua-duanya.

#### 8. Komen jelaskan "KENAPA", bukan "APA"

Komen yang menerangkan *apa* cepat lapuk (kod sudah tunjuk apa ia buat); komen yang menerangkan *kenapa* kekal berguna kerana ia bawa maklumat yang **tiada** dalam kod itu sendiri.

```dart
// ❌ komen "apa" — tidak berguna, kod sudah jelas
// tambah 1 pada kaunter
counter++;

// ❌ komen "apa" — ulang semula apa yang nama function sudah cakap
// fetch programmes from the API
Future<List<Programme>> fetchProgrammes() async { ... }
```

```dart
// ✅ komen "kenapa" — jelaskan sebab keputusan dibuat
// Guna fallback tempatan supaya kelas boleh diteruskan tanpa internet.
Future<List<Programme>> _fallback() async {
  await Future.delayed(const Duration(milliseconds: 600));
  return sampleProgrammes;
}

// ✅ komen "kenapa" — nyatakan peraturan bisnes yang TIDAK jelas daripada kod
// Peraturan sebenar eTT: 1 negara + 1 bidang setiap permohonan.
// Pilihan 2 & 3 hanya boleh universiti LAIN dalam negara+bidang yang SAMA.
final candidates = allProgrammes.where(
  (p) => p.country == programme.country && p.fieldOfStudy == programme.fieldOfStudy,
);
```

### Ringkasan: Format & Lint Automatik

Dua prinsip terakhir **tidak perlu ditulis sendiri** — jalankan alat sebelum setiap commit:

```bash
# Jalankan sebelum setiap commit — tabiat kod bersih
dart format .
flutter analyze
```

`dart format .` seragamkan gaya (indent, jarak, kedudukan koma) di seluruh projek — tiada perdebatan gaya peribadi. `flutter analyze` semak `analysis_options.yaml` (peraturan `flutter_lints`, aktif lalai dalam projek Flutter baharu) dan **mesti** melaporkan `No issues found!` sebelum anda anggap kod "siap".

**Ringkasan setakat ini:** lapan prinsip di atas boleh disingkatkan kepada satu soalan yang anda tanya diri sendiri setiap kali menulis kod baharu — *"kalau rakan sekelas baca baris ini enam bulan akan datang, tanpa saya di sebelahnya, adakah dia faham APA ia buat dan KENAPA?"* Nama yang jelas, widget kecil, `const`, struktur `models/`/`services`/`screens` yang konsisten — semuanya menyumbang kepada jawapan "ya".

---

### Amalan Refactoring — Contoh Berpandu

*Refactoring* bermaksud **mengubah struktur kod tanpa mengubah kelakuannya** — kod berfungsi sama, tetapi lebih bersih. Latihan hari ini: ambil satu widget/skrin **besar** anda bina pagi tadi, dan **pecahkan**.

**Corak sebenar dalam projek rujukan:** `ProgrammeCard` (`widgets/programme_card.dart`) dan `StatusBadge` (`widgets/status_badge.dart`) **BUKAN** ditulis terus dalam `ProgrammeListScreen`/`MyApplicationsScreen` — kedua-duanya diekstrak sebagai kelas `StatelessWidget` berasingan yang diguna semula merentasi beberapa skrin.

#### Contoh berpandu: `ProgrammeDetailScreen` (SEBELUM)

Bayangkan anda tulis bahagian "kos & pengiktirafan" terus dalam `build()` skrin butiran, seperti ini:

```dart
// SEBELUM — semuanya terus dalam build() ProgrammeDetailScreen
@override
Widget build(BuildContext context) {
  final rm = NumberFormat.currency(locale: 'ms_MY', symbol: 'RM', decimalDigits: 0);

  return Scaffold(
    appBar: AppBar(title: Text(programme.universityName)),
    body: ListView(
      padding: const EdgeInsets.all(20),
      children: [
        // ... header (bendera, nama, bidang) di atas ...
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: KptTheme.navy.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: KptTheme.navy.withValues(alpha: 0.15)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Kos Anggaran', style: TextStyle(fontWeight: FontWeight.bold)),
              Text('${rm.format(programme.estimatedAnnualCostMyr)} / tahun'),
              const SizedBox(height: 8),
              Text('Nota Pengiktirafan', style: TextStyle(fontWeight: FontWeight.bold)),
              Text(programme.recognitionNote, style: const TextStyle(fontSize: 13)),
            ],
          ),
        ),
        // ... butang "Mohon Sekarang" di bawah ...
      ],
    ),
  );
}
```

**Langkah *refactoring*:**

1. **Kenal pasti bahagian yang cukup kompleks untuk difahami sendiri** — kotak "kos & pengiktirafan" di atas ialah satu **konsep visual** (~15 baris) yang boleh dijelaskan dalam satu ayat: "papar kos anggaran dan nota pengiktirafan sesuatu tawaran".
2. **Cipta kelas `StatelessWidget` baharu** untuk bahagian itu; pindahkan kod, tukar rujukan `programme` kepada parameter *constructor*.
3. **Tambah `const`** pada *constructor* baharu jika sesuai.
4. **Ganti** kod asal dalam `build()` induk dengan pemanggilan widget baharu.

```dart
// SELEPAS — widget baharu, diekstrak
class _CostAndRecognitionBox extends StatelessWidget {
  const _CostAndRecognitionBox({required this.programme});

  final Programme programme;

  @override
  Widget build(BuildContext context) {
    final rm = NumberFormat.currency(locale: 'ms_MY', symbol: 'RM', decimalDigits: 0);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: KptTheme.navy.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: KptTheme.navy.withValues(alpha: 0.15)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Kos Anggaran', style: TextStyle(fontWeight: FontWeight.bold)),
          Text('${rm.format(programme.estimatedAnnualCostMyr)} / tahun'),
          const SizedBox(height: 8),
          const Text('Nota Pengiktirafan', style: TextStyle(fontWeight: FontWeight.bold)),
          Text(programme.recognitionNote, style: const TextStyle(fontSize: 13)),
        ],
      ),
    );
  }
}
```

```dart
// build() induk kini SATU baris untuk bahagian ini — mudah dibaca
// sebagai "senarai kandungan" skrin.
body: ListView(
  padding: const EdgeInsets.all(20),
  children: [
    // ... header di atas ...
    _CostAndRecognitionBox(programme: programme),
    // ... butang "Mohon Sekarang" di bawah ...
  ],
),
```

5. **Jalankan `flutter analyze` + uji semula secara visual** — kelakuan **mesti kekal sama**. Skrin patut kelihatan **IDENTIK**, hanya struktur kod di sebalik tabir yang berubah.

Lihat contoh **kedua** yang lebih lengkap (kad `ProgrammeCard` penuh, sebelum → selepas dengan tiga widget diekstrak) di:

**[`snippets/refactor_before_after.dart`](./snippets/refactor_before_after.dart)** — fail ini boleh dijalankan terus (`flutter run`) untuk lihat SEBELUM dan SELEPAS berdampingan.

Ringkasan langkah *refactoring* (guna untuk **mana-mana** bahagian projek anda):

1. Kenal pasti bahagian `build()` yang **berulang** (dipakai di > 1 tempat) atau **cukup kompleks** untuk difahami sendiri (biasanya > 15–20 baris untuk satu "konsep visual").
2. Cipta kelas `StatelessWidget` baharu untuk bahagian itu; pindahkan kod, tukar rujukan `widget.x`/medan induk kepada parameter *constructor*.
3. Tambah `const` pada *constructor* baharu (dan pada tempat ia dipanggil, jika datanya tetap).
4. Ganti kod asal dalam `build()` induk dengan pemanggilan widget baharu.
5. Jalankan `flutter analyze` + uji semula secara visual — kelakuan **mesti kekal sama**.

### Demo & Penutup

#### Apa itu "SIAP"? (Rubrik Demo)

Sebelum naik demo, sahkan **setiap** baris berikut — ini kriteria "SIAP" untuk hari ini, bukan sekadar "kod jalan":

| Kriteria | Bukti konkrit |
|----------|----------------|
| **Berfungsi hujung-ke-hujung** | Senarai → butiran → borang → "Permohonan Saya" boleh dilalui **tanpa** *red screen*, dari `flutter run` bersih |
| **Data sebenar, bukan hard-code** | `ProgrammeListScreen` papar data daripada `ProgrammeService`, bukan senarai `Text` ditaip terus dalam `build()` |
| **Validation berfungsi** | Cuba hantar borang dengan medan kosong/No. KP 5 digit → mesej ralat **mesti** muncul, borang **tidak** hilang ke skrin lain |
| **Peraturan domain dikuatkuasakan** | Permohonan yang dihantar mempunyai **satu** `country` + **satu** `fieldOfStudy`, dan 1–3 `universityChoiceIds` |
| **Sekurang-kurangnya satu *refactor*** | Ada sekurang-kurangnya satu widget yang diekstrak menjadi kelas berasingan (rujuk bahagian *Refactoring* di atas) |
| **Kod bersih** | `flutter analyze` → `No issues found!`; `dart format .` telah dijalankan |
| **Anda faham kod anda** | Boleh terangkan **setiap** baris — termasuk yang dijana AI — kepada rakan sekelas/jurulatih tanpa teragak-agak |

**Format demo (2–3 minit setiap orang/pasukan):**

1. **Masalah** (30 saat) — apa yang aplikasi anda selesaikan, siapa penggunanya.
2. **Jalan lalu (walkthrough)** (90 saat) — tunjuk aliran utama secara langsung: senarai → butiran → borang → permohonan saya.
3. **Apa seterusnya** (30 saat) — jika ada masa tambahan, apa yang anda akan tambah/baiki (rujuk senarai Cabaran dalam lab).

**Memberi & menerima maklum balas:**

- Fokus maklum balas pada **kejelasan** (adakah mudah difahami penonton) dan **satu** cadangan penambahbaikan konkrit — bukan senarai panjang kritikan.
- Bila menerima maklum balas: dengar penuh dahulu, jangan bertahan (*defensive*) — tulis nota, tanya soalan susulan jika tidak jelas.

Selepas semua demo selesai — **sesi maklum balas umum & penyampaian sijil**.

---

## Penutup Kursus

**Tahniah!** Anda telah menamatkan kursus **Flutter 5 Hari**. Imbas kembali perjalanan lima hari anda:

| Hari | Apa yang Dipelajari |
|------|----------------------|
| **Hari 1** | Asas Dart & widget asas Flutter — `Text`, `Icon`, `Image`, `Container`, `StatelessWidget`/`StatefulWidget` |
| **Hari 2** | Seni bina layout (`Row`/`Column`/`Stack`), struktur UI (`Scaffold`/`AppBar`), senarai dinamik (`ListView`/`GridView`), kemasan (`ThemeData`) |
| **Hari 3** | Navigasi berbilang skrin, borang input (`Form`/`TextFormField`), pengurusan *state* asas dengan `setState()` |
| **Hari 4** | Sambungan REST API sebenar, `async`/`await`, pengendalian ralat & keadaan *loading* |
| **Hari 5** | **Projek mini bersepadu** (UI+Form+Navigasi+API), Clean Coding Principles, *Refactoring*, dan demo aplikasi |

Anda kini boleh membina aplikasi mudah alih **berfungsi penuh** dari kosong menggunakan Flutter — mengambil data daripada pelayan, membenarkan pengguna berinteraksi melalui borang, dan menavigasi antara berbilang skrin dengan kemas.

### Langkah Seterusnya

Aplikasi yang anda bina sepanjang kursus ini sengaja **ringkas**. Berikut topik pendalaman yang disyorkan, mengikut keutamaan, untuk diteroka **selepas** kursus tamat:

1. **Pengurusan *state* lebih berskala** — `setState()` sesuai untuk aplikasi kecil; untuk aplikasi lebih besar, terokai [**`provider`**](https://pub.dev/packages/provider) (rujuk [`nota/05-state-management.md`](../nota/05-state-management.md) dan corak sebenar dalam `projek/ett_mobile/lib/providers/`) atau [**Riverpod**](https://riverpod.dev) (evolusi `provider` dengan keselamatan jenis lebih baik).
2. **Navigasi deklaratif** — pakej [**go_router**](https://pub.dev/packages/go_router) untuk navigasi berasaskan URL/route yang lebih berskala, termasuk *deep linking*.
3. **Penyimpanan kekal (persistence)** — [**shared_preferences**](https://pub.dev/packages/shared_preferences) untuk data ringkas tempatan, atau **Firebase Firestore**/**Supabase** untuk data yang perlu dikongsi merentasi peranti.
4. **Pengesahan sebenar (Authentication)** — [**Firebase Authentication**](https://firebase.google.com/docs/auth) untuk log masuk sebenar (emel/kata laluan, Google Sign-In, OTP).
5. **Ujian (Testing)** — *widget test* & *unit test* (`flutter test`) supaya perubahan kod masa depan tidak merosakkan ciri sedia ada.
6. **CI/CD automatik** — [**Codemagic**](https://codemagic.io) (khusus Flutter) atau **GitHub Actions** untuk membina & menguji aplikasi secara automatik setiap kali kod ditolak.
7. **Membina & menerbitkan aplikasi sebenar** — `flutter build apk`/`appbundle`, *signing*, dan penerbitan ke **Google Play Store**. Panduan penuh: [`nota/07-deployment.md`](../nota/07-deployment.md).
8. **Notifikasi push** — **Firebase Cloud Messaging (FCM)** untuk memberitahu pengguna apabila status berubah.

### Sumber Pembelajaran Lanjutan

- 📘 [Dokumentasi rasmi Flutter](https://docs.flutter.dev)
- 📘 [Dokumentasi rasmi Dart](https://dart.dev/guides)
- 📘 [Effective Dart — panduan gaya kod](https://dart.dev/effective-dart)
- [pub.dev](https://pub.dev) — direktori pakej rasmi Flutter/Dart
- [Flutter YouTube — Widget of the Week](https://www.youtube.com/playlist?list=PLjxrf2q8roU23XGwz3Km7sQZFTdB996iG)
- [Firebase for Flutter](https://firebase.google.com/docs/flutter/setup)
- [Riverpod — dokumentasi rasmi](https://riverpod.dev)

Anda kini mempunyai asas yang kukuh untuk terus membina aplikasi Flutter — sama ada meneruskan eTT Mobile sendiri, atau memulakan projek baharu. Jangan takut untuk terus bereksperimen, baca dokumentasi rasmi apabila tersekat, guna alat AI secara bijak, dan yang paling penting — **teruskan membina**. Selamat maju jaya!

---

_Disediakan oleh **Habib** — [bespokesb.com](https://bespokesb.com)_

---

## Nota Tambahan (fakta ringkas dari slaid)

- **Prompt JSON → model:** sertakan **JSON contoh sebenar** (tampal satu objek penuh), bukan sekadar penerangan medan — AI menghasilkan model jauh lebih tepat bila ia nampak data sebenar.
- **Lint `prefer_const_constructors`** — inilah peraturan `flutter_lints` yang mencadangkan `const` secara automatik. Terima cadangannya.
- 💡 *"Kenapa ekstrak **widget**, bukan kaedah `_buildX()`?"* ialah **soalan temu duga Flutter yang popular** — fahami sebabnya (skop rebuild, `const`, guna semula), bukan sekadar hafal.
- **Bidang terhad (peraturan eTT sebenar):** eTT hanya menawarkan **Perubatan, Pergigian, Farmasi, dan Pengajian Islam** (Syariah/Usuluddin/Ulum Islamiah/Bahasa Arab/Qiraat) — bukan semua bidang. Ingat had ini semasa mereka bentuk borang & senarai.
- **8 tawaran contoh** dalam data projek merangkumi 6 universiti sebenar: **Al-Azhar, Alexandria, Ain Shams, Tanta** (Mesir) serta **Al Quaraouiyine, Mohammed V** (Maghribi). Lihat jadual penuh dalam [`README.md` utama](../README.md#fakta-domain-ett-disahkan).

---

> 🎤 **Nota penceramah/jurulatih:** [`nota-penceramah.md`](./nota-penceramah.md) — kumpulan nota persembahan (asalnya *speaker notes* dalam slaid) untuk Hari 5.
