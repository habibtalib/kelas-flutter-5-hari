# Hari 1 — Persediaan, Widget & Skrin Senarai

Panduan langkah demi langkah untuk hari pertama kursus **Flutter 5 Hari (gaya KPT/HRD Corp)**. Pada akhir hari ini (lebih kurang 6–7 jam), anda akan mempunyai aplikasi Flutter yang **benar-benar berjalan** pada emulator/telefon anda, memaparkan senarai skrol biasiswa Kementerian Pengajian Tinggi (KPT) — permulaan kepada projek kursus **"MyBiasiswa KPT"** yang akan kita bina berperingkat sepanjang 5 hari.

> **Nota untuk pemula:** Anda tidak perlu tahu Flutter langsung. Setiap langkah diterangkan perlahan-lahan, dengan arahan (command) yang boleh disalin terus. Ikut satu demi satu, dan uji selalu dengan **Hot Reload**.

> **Konvensyen kod:** Penerangan dalam nota ini ditulis dalam **Bahasa Melayu**, tetapi semua kod, nama kelas, nama pembolehubah dan komen dalam fail `.dart` ditulis dalam **Bahasa Inggeris** — ini adalah amalan standard industri Flutter/Dart, dan kita ikut sepanjang kursus ini.

---

## Fokus Hari Ini

| Topik | Rujukan rasmi Flutter |
|-------|------------------------|
| Pasang Flutter SDK | [docs.flutter.dev/get-started/install](https://docs.flutter.dev/get-started/install) |
| Sediakan editor (VS Code) | [docs.flutter.dev/get-started/editor](https://docs.flutter.dev/get-started/editor) |
| Cipta & jalankan projek pertama | [docs.flutter.dev/get-started/test-drive](https://docs.flutter.dev/get-started/test-drive) |
| Struktur aplikasi Flutter (`main()`, widget) | [docs.flutter.dev/get-started/fundamentals/application-structure](https://docs.flutter.dev/get-started/fundamentals/application-structure) |
| Widget & pokok widget (widget tree) | [docs.flutter.dev/get-started/fundamentals/widgets](https://docs.flutter.dev/get-started/fundamentals/widgets) |
| State: Stateless vs Stateful | [docs.flutter.dev/get-started/fundamentals/state-management](https://docs.flutter.dev/get-started/fundamentals/state-management) |
| Widget susun atur (layout) | [docs.flutter.dev/ui/layout](https://docs.flutter.dev/ui/layout) |
| Tema Material 3 | [docs.flutter.dev/ui/design/material](https://docs.flutter.dev/ui/design/material) |
| Senarai panjang (`ListView.builder`) | [docs.flutter.dev/cookbook/lists/long-lists](https://docs.flutter.dev/cookbook/lists/long-lists) |
| Hot Reload | [docs.flutter.dev/tools/hot-reload](https://docs.flutter.dev/tools/hot-reload) |

---

## Apa Akan Dibina Hari Ini

Pada penghujung Hari 1, aplikasi **MyBiasiswa KPT** anda akan:

| # | Ciri | Status |
|---|------|--------|
| 1 | Aplikasi Flutter yang boleh dijalankan pada emulator Android / telefon sebenar | ✅ |
| 2 | `AppBar` berjenama KPT — warna navy `#1A2B5C` dengan tajuk "MyBiasiswa KPT" | ✅ |
| 3 | Skrin senarai (`ScholarshipListScreen`) memaparkan **8 biasiswa contoh** secara boleh skrol | ✅ |
| 4 | Setiap biasiswa dipaparkan dalam `ScholarshipCard` — nama, bidang, kategori, elaun bulanan, tarikh tutup, status "Dibuka"/"Tutup" | ✅ |
| 5 | Carian & tapisan kategori | ⏳ Hari 3 |
| 6 | Ketuk kad → buka skrin butiran | ⏳ Hari 2 |

**Bayangkan skrin akhir hari ini** (tiada tangkapan skrin sebenar — ini gambaran teks):

```
┌─────────────────────────────────┐
│  MyBiasiswa KPT            (navy)│  <- AppBar
├─────────────────────────────────┤
│ ┌─────────────────────────────┐ │
│ │ Biasiswa MyBrainSc   [Dibuka]│ │  <- ScholarshipCard #1
│ │ Sains Tulen…                 │ │
│ │ [Pra Perkhidmatan][Bachelor] │ │
│ │ RM1,500/bulan     30 Sep 2026│ │
│ └─────────────────────────────┘ │
│ ┌─────────────────────────────┐ │
│ │ MyBrain 2.0 (Sarjana)[Dibuka]│ │  <- ScholarshipCard #2
│ │ Semua Bidang…                │ │
│ │ …                             │ │
│ └─────────────────────────────┘ │
│              ⋮ (skrol ke bawah) │
└─────────────────────────────────┘
```

Ini adalah asas — Hari 2 kita tambah navigasi ke skrin butiran, Hari 3 tambah carian & tapisan, Hari 4 sambung ke API sebenar, Hari 5 kita siapkan & bungkus untuk *release*.

---

## Bahagian 1 — Persediaan (Setup)

### 1.1 Pasang Flutter SDK

**Keperluan sistem (Windows):** Windows 10/11 64-bit, minimum **8GB RAM**, **≥2.5GB** ruang cakera kosong untuk Flutter SDK (dan lebih lagi untuk Android Studio + emulator — sediakan sekurang-kurangnya 10GB), sambungan internet, dan **Git for Windows** dipasang terlebih dahulu ([git-scm.com](https://git-scm.com/downloads)).

1. Muat turun **Flutter SDK** untuk Windows daripada halaman rasmi:
   [docs.flutter.dev/get-started/install/windows/mobile](https://docs.flutter.dev/get-started/install/windows/mobile)
2. **Ekstrak** fail zip ke lokasi tanpa ruang/aksara istimewa dalam laluan, contohnya `C:\src\flutter`. **Jangan** ekstrak ke dalam `C:\Program Files\` (perlukan kebenaran *admin* setiap kali).
3. Tambah `C:\src\flutter\bin` ke **PATH** sistem:
   - Cari "Edit environment variables for your account" dalam menu Start.
   - Dalam **User variables**, pilih `Path` → **Edit** → **New** → taip `C:\src\flutter\bin` → **OK** semua tetingkap.
4. Buka **PowerShell baharu** (penting — PATH hanya dimuat semula pada terminal baharu) dan sahkan:

   ```bash
   flutter --version
   ```

> 🍎 **Pengguna macOS:** Cara paling mudah ialah `brew install --cask flutter` (perlukan [Homebrew](https://brew.sh)), atau muat turun SDK terus daripada [docs.flutter.dev/get-started/install/macos/mobile-ios](https://docs.flutter.dev/get-started/install/macos/mobile-ios). Anda juga akan perlukan **Xcode** (dari App Store) jika mahu sasar iOS Simulator — untuk kursus ini kita fokus Android sahaja, jadi Xcode **tidak wajib**.

### 1.2 Pasang Android Studio (untuk Android SDK & Emulator)

Walaupun kita akan **menulis kod dalam VS Code**, kita tetap perlukan **Android Studio** kerana ia membawa **Android SDK**, **Android Virtual Device (AVD) Manager**, dan pemacu (*driver*) yang diperlukan Flutter untuk membina & menjalankan aplikasi Android.

1. Muat turun & pasang [Android Studio](https://developer.android.com/studio).
2. Semasa *first-run wizard*, pilih **Standard setup** — ini akan memasang Android SDK, Android SDK Platform-Tools, dan Android Virtual Device.
3. Buka Android Studio → **More Actions** → **SDK Manager** → pastikan sekurang-kurangnya satu **Android SDK Platform** (cth. Android 14 / API 34) ditanda.

### 1.3 Jalankan `flutter doctor`

`flutter doctor` ialah arahan diagnostik — ia menyemak semua komponen yang Flutter perlukan dan memberitahu apa yang masih tertinggal.

```bash
flutter doctor
```

Contoh output (sebelum semuanya lengkap):

```
[✓] Flutter (Channel stable, 3.35.7, on Microsoft Windows...)
[!] Android toolchain - develop for Android devices
    ✗ Android license status unknown.
[✓] VS Code (version 1.9x)
[!] Connected device
    ! No devices available
```

Selesaikan setiap tanda `[!]` atau `[✗]` mengikut cadangan yang dipaparkan. Perkara paling biasa — terima lesen Android SDK:

```bash
flutter doctor --android-licenses
```

Taip `y` untuk setiap lesen sehingga semua diterima. Jalankan `flutter doctor` sekali lagi sehingga sebanyak mungkin tanda `[✓]` (tanda `[!]` untuk peranti/telefon disambung boleh diabaikan buat sementara — kita sediakan itu di langkah 1.5).

### 1.4 Pasang VS Code & Sambungan Flutter/Dart

1. Muat turun & pasang [VS Code](https://code.visualstudio.com/download).
2. Buka VS Code → tab **Extensions** (ikon kotak di sebelah kiri, atau `Ctrl+Shift+X`) → cari dan pasang:

   | Sambungan | Penerbit | Tujuan |
   |-----------|----------|--------|
   | **Flutter** | Dart Code | Sokongan projek Flutter, debug, jalankan aplikasi, snippet |
   | **Dart** | Dart Code | Dipasang automatik bersama sambungan Flutter — analisis kod, format, IntelliSense |

   > Rujukan rasmi: [docs.flutter.dev/get-started/editor](https://docs.flutter.dev/get-started/editor)
3. Sahkan pemasangan: buka **Command Palette** (`Ctrl+Shift+P`) → taip `Flutter: New Project` — jika ia muncul dalam senarai, sambungan berjaya dipasang.

### 1.5 Sediakan Emulator Android ATAU Telefon Sebenar

Pilih **SALAH SATU**:

**Pilihan A — Android Emulator (disyorkan untuk kelas)**

1. Dalam Android Studio: **More Actions** → **Virtual Device Manager** → **Create Device**.
2. Pilih peranti (cth. **Pixel 7**) → **Next** → pilih *system image* (cth. **API 34**, muat turun jika belum ada) → **Next** → **Finish**.
3. Mulakan emulator dengan klik ▶️ di sebelah peranti dalam senarai.

**Pilihan B — Telefon Android Sebenar (USB debugging)**

1. Pada telefon: **Settings → About phone** → ketuk **Build number** 7 kali untuk membuka **Developer options**.
2. **Settings → Developer options** → hidupkan **USB debugging**.
3. Sambungkan telefon ke komputer melalui kabel USB → terima *prompt* "Allow USB debugging?" pada telefon.

Sahkan peranti dikesan:

```bash
flutter devices
```

Anda sepatutnya nampak sekurang-kurangnya satu peranti disenaraikan (emulator atau telefon sebenar).

### 1.6 Cipta Projek Pertama

Navigasi ke folder tempat anda mahu simpan projek kursus, kemudian jalankan:

```bash
flutter create mybiasiswa_kpt
cd mybiasiswa_kpt
flutter run
```

`flutter run` akan **compile** dan **install** aplikasi lalai Flutter (contoh kaunter +1) pada emulator/telefon anda. Jika ia berjaya berjalan — **tahniah, persekitaran pembangunan anda sudah sedia!**

> Projek sebenar kursus (versi lengkap, hasil akhir 5 hari) sudah disediakan di `projek/mybiasiswa_kpt/` dalam repo ini untuk **rujukan**. Jangan salin terus — kita bina **dari kosong** sepanjang minggu ini supaya faham setiap baris. Boleh buka fail di sana untuk **banding** kod anda selepas setiap latihan.

---

## Bahagian 2 — Anatomi Projek Flutter

Buka folder `mybiasiswa_kpt` dalam VS Code (`File → Open Folder…`). Struktur penting:

```
mybiasiswa_kpt/
├── lib/
│   └── main.dart          ← titik masuk (entry point) aplikasi — kod kita bermula di sini
├── android/                ← projek Android asli (jarang disentuh)
├── ios/                    ← projek iOS asli (jarang disentuh)
├── test/                   ← ujian automatik (Hari 5)
├── pubspec.yaml            ← "package.json" versi Flutter — nama projek, dependencies, versi
└── pubspec.lock            ← versi tepat setiap dependency (jangan edit manual)
```

### `pubspec.yaml`

Fail konfigurasi utama projek — sepadan konsep dengan `package.json` (Node.js) atau `composer.json` (PHP/Laravel).

```yaml
name: mybiasiswa_kpt
description: "MyBiasiswa KPT — aplikasi semakan & permohonan biasiswa Kementerian Pengajian Tinggi."
version: 1.0.0+1

environment:
  sdk: ^3.9.2

dependencies:
  flutter:
    sdk: flutter
  cupertino_icons: ^1.0.8
```

- `dependencies:` — pakej (*package*) yang aplikasi anda **perlukan** untuk berjalan. Sepanjang kursus kita akan tambah `provider` (Hari 3), `http` (Hari 4), `intl` (format tarikh/RM), dan lain-lain.
- Setiap kali `pubspec.yaml` diubah, jalankan `flutter pub get` untuk memuat turun/kemas kini pakej.

### `lib/main.dart` — Titik Masuk Aplikasi

Buka `lib/main.dart` — ganti kandungan lalai dengan versi minimum berikut supaya kita faham setiap baris dari kosong:

```dart
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MyBiasiswa KPT',
      home: Scaffold(
        appBar: AppBar(title: const Text('MyBiasiswa KPT')),
        body: const Center(child: Text('Selamat datang!')),
      ),
    );
  }
}
```

Simpan (`Ctrl+S`) — dengan `flutter run` masih berjalan, perubahan akan **Hot Reload** secara automatik. Mari bedah setiap bahagian:

| Elemen | Penjelasan |
|--------|-----------|
| `import 'package:flutter/material.dart';` | Import pustaka **Material Design** — set widget UI gaya Google yang kita gunakan sepanjang kursus (butang, kad, senarai, dll). |
| `void main()` | Fungsi Dart standard — **titik masuk** aplikasi (sama seperti `main()` dalam Java/C, atau skrip permulaan Node.js). |
| `runApp(const MyApp())` | Fungsi Flutter yang **melekatkan (attach)** widget akar (`MyApp`) ke skrin peranti dan memulakan proses render. |
| `class MyApp extends StatelessWidget` | Widget akar aplikasi kita — jenis `StatelessWidget` (huraian di Bahagian 3). |
| `build(BuildContext context)` | Kaedah **wajib** setiap widget — memulangkan (`return`) pokok widget yang mahu dipaparkan. Dipanggil semula setiap kali Flutter perlu "melukis semula" widget ini. |
| `MaterialApp` | Widget "bungkusan" peringkat tertinggi — menyediakan tema, navigasi, tajuk aplikasi, dan konfigurasi Material Design untuk **seluruh** aplikasi. |
| `Scaffold` | Rangka halaman standard Material — sediakan struktur untuk `appBar`, `body`, `floatingActionButton`, `bottomNavigationBar`, dsb. Hampir setiap skrin dalam aplikasi kita akan guna `Scaffold`. |
| `AppBar` | Bar tajuk di bahagian atas skrin. |
| `Center` / `Text` | Widget UI asas — dibincang penuh di Bahagian 4. |

> **Konsep penting:** Dalam Flutter, **segalanya adalah widget** — bukan sahaja butang atau teks, tetapi juga *padding*, susun atur, malah tema. Kita akan ulang konsep ini sepanjang kursus.

---

## Bahagian 3 — Widget = Segalanya

### Widget Tree (Pokok Widget)

Flutter membina UI dengan **menyusun widget bersarang** (nested) — satu widget mengandungi widget lain sebagai `child` atau `children`. Struktur ini dipanggil **widget tree** (pokok widget):

```
MyApp
 └── MaterialApp
      └── Scaffold
           ├── AppBar
           │    └── Text('MyBiasiswa KPT')
           └── Center
                └── Text('Selamat datang!')
```

Setiap kali data berubah, Flutter tidak "memadam & lukis semula skrin" — ia **bandingkan** pokok widget baharu dengan yang lama, dan hanya kemas kini bahagian yang berubah. Ini sebabnya Flutter sangat pantas.

### StatelessWidget vs StatefulWidget

Dua jenis widget asas yang anda akan tulis **setiap hari**:

| | `StatelessWidget` | `StatefulWidget` |
|---|---|---|
| **Bila guna** | UI **tidak berubah** selepas dibina (atau hanya bergantung pada data luaran yang diterima) | UI **perlu berubah** akibat interaksi pengguna atau data dalaman (cth. tekan butang, taip teks) |
| **Contoh dalam projek kita** | `ScholarshipCard` (papar sahaja) | Borang permohonan biasiswa (Hari 4) — medan input berubah semasa pengguna menaip |
| **Cara ia berfungsi** | Satu kaedah `build()` sahaja | Ada objek `State` berasingan yang menyimpan data (*state*) & kaedah `setState()` untuk beritahu Flutter "lukis semula" |
| **Contoh kod** | `class Foo extends StatelessWidget { @override Widget build(...) { ... } }` | `class Foo extends StatefulWidget { @override State<Foo> createState() => _FooState(); }` diikuti `class _FooState extends State<Foo> { ... }` |

> **Analogi:** `StatelessWidget` seperti gambar bercetak — sekali dicetak, tidak berubah. `StatefulWidget` seperti papan tanda LED — ia boleh dikemas kini bila-bila masa (`setState()` = "tekan butang kemas kini papan").

Sepanjang **Hari 1**, hampir semua widget yang kita tulis adalah `StatelessWidget` — kita baru sentuh `StatefulWidget` mula-mula pada Hari 2/3 apabila perlu simpan *state* seperti teks carian atau navigasi tab.

### Demo Hot Reload

Dengan `flutter run` masih berjalan (jangan tutup terminal):

1. Dalam `main.dart`, tukar `'Selamat datang!'` kepada `'Selamat datang ke MyBiasiswa KPT!'`.
2. Simpan fail (`Ctrl+S`).
3. Lihat emulator/telefon — teks berubah dalam **kurang daripada 1 saat**, tanpa aplikasi *restart* dari awal.

Ini **Hot Reload** — ia menyuntik kod baharu ke dalam aplikasi yang sedang berjalan sambil **mengekalkan state semasa**. Bandingkan dengan **Hot Restart** (`Shift+R` dalam terminal, atau ikon *restart* dalam VS Code) yang memulakan semula seluruh aplikasi (state hilang, tetapi berguna bila Hot Reload tidak mencukupi — cth. selepas ubah `main()` atau tambah *class* baharu).

> Rujukan rasmi: [docs.flutter.dev/tools/hot-reload](https://docs.flutter.dev/tools/hot-reload)

---

## Bahagian 4 — Widget Teras

Berikut widget asas yang akan anda gunakan **setiap hari** sepanjang kursus. Cuba setiap satu — tampal ke dalam `body:` `Scaffold` anda dan lihat hasilnya dengan Hot Reload.

### `Text` — papar teks

```dart
const Text(
  'Biasiswa MyBrainSc',
  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
)
```

### `Container` — kotak serba boleh (warna, saiz, padding, margin, border)

```dart
Container(
  padding: const EdgeInsets.all(16),
  margin: const EdgeInsets.symmetric(horizontal: 12),
  decoration: BoxDecoration(
    color: const Color(0xFF1A2B5C), // navy KPT
    borderRadius: BorderRadius.circular(12),
  ),
  child: const Text('Kotak navy', style: TextStyle(color: Colors.white)),
)
```

### `Column` & `Row` — susun menegak / mendatar

```dart
Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: const [
    Text('Biasiswa MyBrainSc'),
    Text('Sains Tulen'),
  ],
)

Row(
  mainAxisAlignment: MainAxisAlignment.spaceBetween,
  children: const [
    Text('RM1,500/bulan'),
    Text('30 Sep 2026'),
  ],
)
```

> **Konsep penting:** `Column` menyusun *children* dari **atas ke bawah**; `Row` dari **kiri ke kanan**. `mainAxisAlignment` mengawal jarak sepanjang paksi utama; `crossAxisAlignment` mengawal jajaran sepanjang paksi silang.

### `Padding` & `SizedBox` — jarak

```dart
Padding(
  padding: const EdgeInsets.all(16),
  child: const Text('Ada jarak 16px di semua sisi'),
)

Column(
  children: const [
    Text('Baris 1'),
    SizedBox(height: 12), // jarak kosong 12px — TIADA widget lain buat ini seefisien ini
    Text('Baris 2'),
  ],
)
```

### `Icon` — ikon Material

```dart
const Icon(Icons.payments_outlined, size: 16, color: Color(0xFF1A2B5C))
```

### `Card` — kad terapung dengan bayang (shadow) & sudut bulat

```dart
Card(
  margin: const EdgeInsets.all(12),
  child: const Padding(
    padding: EdgeInsets.all(16),
    child: Text('Ini kandungan dalam Card'),
  ),
)
```

### `Center` — tengahkan satu child

```dart
const Center(child: Text('Di tengah skrin'))
```

### `Expanded` — isi ruang berbaki dalam `Row`/`Column`

```dart
Row(
  children: [
    const Icon(Icons.search),
    const SizedBox(width: 8),
    Expanded(
      child: const Text(
        'Teks panjang ini akan isi semua ruang berbaki tanpa overflow',
        overflow: TextOverflow.ellipsis,
      ),
    ),
  ],
)
```

> **Kesilapan biasa pemula:** Letak `Text` panjang terus dalam `Row` **tanpa** `Expanded` sering menyebabkan ralat *"RenderFlex overflowed"* (teks cuba melebihi lebar skrin). Bungkus dengan `Expanded` untuk selesaikan.

Rujukan katalog penuh widget: [docs.flutter.dev/ui/widgets/layout](https://docs.flutter.dev/ui/widgets/layout)

---

## Bahagian 5 — Tema KPT (`theme.dart`)

Setiap aplikasi kerajaan/korporat ada identiti jenama. Untuk MyBiasiswa KPT, kita gunakan:

| Warna | Kod hex | Kegunaan |
|-------|---------|----------|
| **Navy** | `0xFF1A2B5C` | Warna utama (primary) — AppBar, butang, teks penting |
| **Gold** | `0xFFD4A017` | Warna aksen (secondary) — highlight, pill kategori |
| **BG Light** | `0xFFF5F6FA` | Latar belakang skrin |

Cipta fail baharu `lib/theme.dart`:

```dart
import 'package:flutter/material.dart';

/// Tema rasmi aplikasi — warna jenama KPT.
///
/// Navy (biru tua) sebagai warna utama + emas sebagai aksen kecemerlangan.
class KptTheme {
  KptTheme._();

  static const Color navy = Color(0xFF1A2B5C);
  static const Color gold = Color(0xFFD4A017);
  static const Color bgLight = Color(0xFFF5F6FA);

  static ThemeData get light {
    final scheme = ColorScheme.fromSeed(
      seedColor: navy,
      primary: navy,
      secondary: gold,
      brightness: Brightness.light,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      scaffoldBackgroundColor: bgLight,
      appBarTheme: const AppBarTheme(
        backgroundColor: navy,
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
      ),
      cardTheme: CardThemeData(
        elevation: 1,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        clipBehavior: Clip.antiAlias,
      ),
    );
  }
}
```

Bedah kod ini:

- `KptTheme._()` — konstruktor **private** (nama bermula `_`). Ini menghalang sesiapa daripada mencipta *instance* `KptTheme()` — kelas ini hanya digunakan sebagai "bekas" untuk nilai `static`, bukan objek.
- `ColorScheme.fromSeed(seedColor: navy, ...)` — ciri **Material 3**: berikan satu warna "benih" (*seed*), Flutter jana **satu set warna harmoni lengkap** (primary, secondary, error, surface, dll) secara automatik.
- `useMaterial3: true` — aktifkan gaya reka bentuk **Material 3** (Google terkini) — bucu lebih bulat, warna lebih lembut berbanding Material 2.
- `appBarTheme` / `cardTheme` — tetapan **lalai** untuk semua `AppBar`/`Card` dalam aplikasi, supaya kita tak perlu ulang gaya yang sama di setiap skrin.

Kemudian dalam `main.dart`, sambungkan tema ini ke `MaterialApp`:

```dart
MaterialApp(
  title: 'MyBiasiswa KPT',
  debugShowCheckedModeBanner: false,
  theme: KptTheme.light,
  home: const Scaffold(
    appBar: AppBar(title: Text('MyBiasiswa KPT')),
    body: Center(child: Text('Selamat datang!')),
  ),
)
```

Hot Reload — perhatikan AppBar kini berwarna **navy**, bukan biru Material lalai.

> `debugShowCheckedModeBanner: false` — buang lencana (banner) merah "DEBUG" di penjuru kanan atas semasa pembangunan. Kosmetik sahaja, tidak wajib, tetapi kemas untuk demo.

> Rujukan rasmi: [docs.flutter.dev/ui/design/material](https://docs.flutter.dev/ui/design/material)

---

## Bahagian 6 — Model Data: `Scholarship`

Sebelum bina senarai, kita perlukan **struktur data** untuk mewakili satu biasiswa. Dalam Flutter/Dart, kita guna **class biasa** (bukan *interface* seperti TypeScript) sebagai model.

Cipta fail `lib/models/scholarship.dart`:

```dart
/// Model utama: satu tawaran biasiswa KPT.
///
/// Cermin portal sebenar biasiswa.mohe.gov.my.
library;

/// Kategori biasiswa mengikut portal rasmi KPT.
enum ScholarshipCategory {
  praPerkhidmatan,
  dalamPerkhidmatan,
  bantuanKewangan,
  antarabangsa;

  /// Label Bahasa Melayu untuk paparan UI.
  String get label => switch (this) {
        ScholarshipCategory.praPerkhidmatan => 'Pra Perkhidmatan',
        ScholarshipCategory.dalamPerkhidmatan => 'Dalam Perkhidmatan',
        ScholarshipCategory.bantuanKewangan => 'Bantuan Kewangan',
        ScholarshipCategory.antarabangsa => 'Antarabangsa',
      };
}

/// Peringkat pengajian yang ditaja.
enum StudyLevel {
  sijil,
  diploma,
  bachelor,
  master,
  phd,
  postDoctoral;

  String get label => switch (this) {
        StudyLevel.sijil => 'Sijil',
        StudyLevel.diploma => 'Diploma',
        StudyLevel.bachelor => 'Ijazah Sarjana Muda',
        StudyLevel.master => 'Sarjana',
        StudyLevel.phd => 'PhD',
        StudyLevel.postDoctoral => 'Pasca Kedoktoran',
      };
}

class Scholarship {
  final String id;
  final String code;
  final String name;
  final String provider;
  final ScholarshipCategory category;
  final StudyLevel studyLevel;
  final String fieldOfStudy;
  final double monthlyAllowance;
  final bool tuitionCoverage;
  final double minCgpa;
  final int maxAge;
  final DateTime applicationDeadline;
  final bool isOpen;
  final String description;
  final List<String> requirements;
  final String websiteUrl;

  const Scholarship({
    required this.id,
    required this.code,
    required this.name,
    required this.provider,
    required this.category,
    required this.studyLevel,
    required this.fieldOfStudy,
    required this.monthlyAllowance,
    required this.tuitionCoverage,
    required this.minCgpa,
    required this.maxAge,
    required this.applicationDeadline,
    required this.isOpen,
    required this.description,
    required this.requirements,
    required this.websiteUrl,
  });
}
```

Bedah kod ini:

- **`enum ... { ...; String get label => switch(this) {...}; }`** — ciri Dart moden (Dart 3): *enum* boleh ada **getter** dan kaedah, sama seperti *class* biasa. Ini berguna untuk terus memetakan nilai *enum* (`bachelor`) kepada label paparan Bahasa Melayu (`'Ijazah Sarjana Muda'`) tanpa perlu `if/else` berterusan di setiap skrin.
- **`final` field** — semua medan `Scholarship` ditanda `final`: sekali objek dicipta, nilainya **tidak boleh diubah** (*immutable*). Ini amalan baik untuk model data — elak bug akibat data berubah secara tidak sengaja di tempat lain.
- **Konstruktor `const Scholarship({required this.id, ...})`** — guna **named parameters** (parameter bernama) dengan kata kunci `required`. Ini bermakna semasa mencipta objek, anda **wajib** nyatakan nama setiap medan (`Scholarship(id: 'S001', name: '...', ...)`) — bukan mengikut susunan posisi. Lebih mudah dibaca & kurang bug berbanding parameter posisi seperti `Scholarship('S001', '...', ...)`.
- `const` di depan konstruktor — membolehkan Dart cipta objek pada **masa kompil** apabila semua nilai juga `const`, jadi lebih jimat memori untuk data statik seperti senarai contoh kita.

### Data Contoh (`sampleScholarships`)

Cipta fail `lib/data/sample_scholarships.dart` — senarai `Scholarship` yang **dikodkan keras (hardcoded)** untuk Hari 1–3, sebelum kita sambung ke API sebenar pada Hari 4:

```dart
import '../models/scholarship.dart';

final List<Scholarship> sampleScholarships = [
  Scholarship(
    id: 'S001',
    code: 'MYBRAINSC',
    name: 'Biasiswa MyBrainSc',
    provider: 'Kementerian Pengajian Tinggi',
    category: ScholarshipCategory.praPerkhidmatan,
    studyLevel: StudyLevel.bachelor,
    fieldOfStudy: 'Sains Tulen (Fizik, Kimia, Biologi, Matematik)',
    monthlyAllowance: 1500,
    tuitionCoverage: true,
    minCgpa: 3.50,
    maxAge: 24,
    applicationDeadline: DateTime.parse('2026-09-30'),
    isOpen: true,
    description:
        'Penajaan pengajian sains tulen di IPTA/IPTS dan universiti terkemuka luar negara.',
    requirements: [
      'Warganegara Malaysia',
      'CGPA 3.50 ke atas',
      'Bidang sains tulen sepenuh masa',
    ],
    websiteUrl: 'https://biasiswa.mohe.gov.my/MyBrainSc/',
  ),
  // ... lagi 7 biasiswa — lihat senarai penuh (8 entri) di
  // projek/mybiasiswa_kpt/lib/data/sample_scholarships.dart
];
```

> **Latihan:** Salin **kesemua 8 entri** daripada fail sebenar `projek/mybiasiswa_kpt/lib/data/sample_scholarships.dart` ke fail anda — ini data rujukan penuh (MyBrainSc, MyBrain 2.0, Biasiswa Yang di-Pertuan Agong, HLP, SLAI, BKOKU, BKPKK, Malaysia International Scholarship).

> **Kenapa `final List<...>` bukan `const`?** Kerana `DateTime.parse(...)` dikira pada **masa larian (runtime)**, bukan masa kompil, jadi keseluruhan senarai tidak boleh `const`. `final` masih memastikan pembolehubah `sampleScholarships` sendiri tidak boleh ditugaskan semula (*reassign*) selepas dicipta.

---

## Bahagian 7 — Skrin Senarai Biasiswa

Sekarang kita gabungkan semua yang dipelajari: tema, model, data, dan widget teras — untuk bina skrin senarai sebenar.

### `ScholarshipCard` — widget papar satu biasiswa

Cipta `lib/widgets/scholarship_card.dart`:

```dart
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/scholarship.dart';
import '../theme.dart';

/// Kad yang memaparkan ringkasan satu biasiswa dalam senarai (Hari 1).
class ScholarshipCard extends StatelessWidget {
  const ScholarshipCard({
    super.key,
    required this.scholarship,
    this.onTap,
  });

  final Scholarship scholarship;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final rm = NumberFormat.currency(locale: 'ms_MY', symbol: 'RM', decimalDigits: 0);
    final tarikh = DateFormat('d MMM yyyy', 'ms').format(scholarship.applicationDeadline);

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      scholarship.name,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: KptTheme.navy,
                      ),
                    ),
                  ),
                  if (!scholarship.isOpen)
                    const _Pill(text: 'Tutup', color: Colors.red)
                  else
                    const _Pill(text: 'Dibuka', color: Colors.green),
                ],
              ),
              const SizedBox(height: 6),
              Text(
                scholarship.fieldOfStudy,
                style: TextStyle(color: Colors.grey[700], fontSize: 13),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  _Pill(text: scholarship.category.label, color: KptTheme.navy),
                  const SizedBox(width: 8),
                  _Pill(text: scholarship.studyLevel.label, color: KptTheme.gold),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.payments_outlined, size: 16, color: KptTheme.navy),
                      const SizedBox(width: 4),
                      Text(
                        '${rm.format(scholarship.monthlyAllowance)}/bulan',
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.event_outlined, size: 16, color: Colors.grey[600]),
                      const SizedBox(width: 4),
                      Text(tarikh, style: TextStyle(color: Colors.grey[700], fontSize: 12)),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Pill extends StatelessWidget {
  const _Pill({required this.text, required this.color});

  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        text,
        style: TextStyle(color: color, fontSize: 11, fontWeight: FontWeight.w600),
      ),
    );
  }
}
```

Perkara baharu di sini:

- **`InkWell`** — bungkus sekitar `Padding` supaya kad boleh **diketuk** (ripple effect Material apabila ditekan) dan memanggil `onTap`. Hari ini `onTap` belum digunakan sepenuhnya (kita hanya sediakan *parameter*) — Hari 2 kita sambungkan ke navigasi skrin butiran.
- **`VoidCallback? onTap`** — jenis fungsi terbina-dalam Dart untuk fungsi tanpa parameter/pulangan (`void Function()`), ditanda `?` supaya **pilihan (optional)** — kad masih boleh dipapar walaupun `onTap` tidak diberikan.
- **`NumberFormat.currency(...)` & `DateFormat(...)`** daripada pakej `intl` — format nombor jadi mata wang Ringgit (`RM1,500`) dan tarikh jadi format Bahasa Melayu (`30 Sep 2026`). Tambah `intl: ^0.19.0` di bawah `dependencies:` dalam `pubspec.yaml`, kemudian jalankan `flutter pub get`.
- **`_Pill`** — widget kecil **private** (nama bermula `_`, hanya boleh diguna dalam fail ini) untuk cip label berwarna kecil (kategori, peringkat, status). Corak biasa: pecahkan bahagian UI berulang kepada widget kecil supaya kod `build()` utama kekal bersih.
- **`if (!scholarship.isOpen) ... else ...` dalam `children: [...]`** — Dart membenarkan **kawalan aliran (`if`/`for`) terus di dalam senarai literal**. Tiada keperluan `List.of()` atau *ternary* rumit — ciri unik Dart yang sangat berguna untuk UI bersyarat.

### `ScholarshipListScreen` — susun senarai dengan `ListView.builder`

Cipta `lib/screens/scholarship_list_screen.dart` — **versi Hari 1** (ringkas, terus guna `sampleScholarships`):

```dart
import 'package:flutter/material.dart';

import '../data/sample_scholarships.dart';
import '../widgets/scholarship_card.dart';

/// Skrin senarai biasiswa — versi Hari 1 (senarai statik, tiada carian/tapisan).
/// Akan berkembang: Hari 3 = carian & tapisan, Hari 4 = data daripada API.
class ScholarshipListScreen extends StatelessWidget {
  const ScholarshipListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.only(top: 8, bottom: 16),
      itemCount: sampleScholarships.length,
      itemBuilder: (context, index) {
        final scholarship = sampleScholarships[index];
        return ScholarshipCard(scholarship: scholarship);
      },
    );
  }
}
```

Bedah `ListView.builder`:

| Parameter | Penjelasan |
|-----------|-----------|
| `itemCount` | Jumlah item dalam senarai. Flutter perlu tahu ini untuk urus skrol dengan efisien. |
| `itemBuilder` | Fungsi `(context, index) => Widget` yang dipanggil untuk **setiap** item, memberikan `index` semasa (0, 1, 2, …). |

> **Kenapa `ListView.builder` bukan `ListView(children: [...])`?** `ListView` biasa membina **semua** widget serentak walaupun belum kelihatan pada skrin — boros memori untuk senarai panjang. `ListView.builder` bersifat **malas (lazy)** — ia hanya membina item yang **kelihatan** (atau hampir kelihatan) pada skrin, dan musnahkan/bina semula secara automatik semasa pengguna skrol. Untuk senarai biasiswa yang mungkin berpuluh/beratus entri (selepas API Hari 4), ini penting untuk prestasi.

> Rujukan rasmi: [docs.flutter.dev/cookbook/lists/long-lists](https://docs.flutter.dev/cookbook/lists/long-lists)

### Sambungkan Semuanya dalam `main.dart`

```dart
import 'package:flutter/material.dart';

import 'screens/scholarship_list_screen.dart';
import 'theme.dart';

void main() {
  runApp(const MyBiasiswaApp());
}

class MyBiasiswaApp extends StatelessWidget {
  const MyBiasiswaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MyBiasiswa KPT',
      debugShowCheckedModeBanner: false,
      theme: KptTheme.light,
      home: Scaffold(
        appBar: AppBar(title: const Text('MyBiasiswa KPT')),
        body: const ScholarshipListScreen(),
      ),
    );
  }
}
```

Jalankan `flutter run` (atau Hot Reload jika masih berjalan) — anda sepatutnya nampak **senarai skrol 8 biasiswa**, setiap satu dalam kad bertema navy/gold, lengkap dengan pill kategori, elaun bulanan dalam format RM, dan tarikh tutup permohonan.

> **Pratonton Hari 3:** Skrin sebenar dalam `projek/mybiasiswa_kpt/lib/screens/scholarship_list_screen.dart` sudah ada **bar carian** (`TextField`) dan **cip tapisan kategori** (`ChoiceChip`) di atas senarai — kita akan tambah ciri itu Hari 3 apabila belajar `StatefulWidget` dan pengurusan *state* dengan pakej `provider`. Buka fail itu sekarang jika mahu **intai** ke hadapan — tetapi jangan risau kalau belum faham semua bahagiannya lagi.

---

## Penutup — Apa Yang Kita Bina & Langkah Seterusnya

### Ringkasan

Hari ini kita telah:

1. ✅ Pasang **Flutter SDK**, **Android Studio**, **VS Code + sambungan Flutter/Dart**, dan sediakan emulator/telefon.
2. ✅ Fahami **anatomi projek Flutter** — `pubspec.yaml`, `lib/main.dart`, `runApp()`, `MaterialApp`, `Scaffold`.
3. ✅ Fahami **widget tree**, `StatelessWidget` vs `StatefulWidget`, dan `build()`.
4. ✅ Cuba widget teras: `Text`, `Container`, `Column`, `Row`, `Padding`, `SizedBox`, `Icon`, `Card`, `Center`, `Expanded`.
5. ✅ Bina **tema jenama KPT** (`KptTheme`) — navy + gold, Material 3.
6. ✅ Bina **model data** `Scholarship` (dengan `enum` `ScholarshipCategory` & `StudyLevel`) dan data contoh `sampleScholarships`.
7. ✅ Bina **skrin senarai** sebenar dengan `ListView.builder` + `ScholarshipCard`.

### Simpan Kerja Anda (Git)

Jika projek anda belum dalam kawalan versi, mulakan sekarang — tabiat baik dari Hari 1:

```bash
git init
git add .
git commit -m "Hari 1: setup projek, tema KPT, model Scholarship, skrin senarai"
```

> **Nota:** `flutter create` sudah menjana fail `.gitignore` yang sesuai (mengabaikan `build/`, `.dart_tool/`, dll) — tidak perlu konfigurasi tambahan.

### Apa Seterusnya — Hari 2

Hari 2 kita akan:
- Tambah **navigasi** — ketuk `ScholarshipCard` untuk buka **skrin butiran** (`ScholarshipDetailScreen`) menggunakan `Navigator.push()` & `MaterialPageRoute`.
- Perkenalkan `StatefulWidget` buat kali pertama secara mendalam.
- Mula bina rangka navigasi bawah (*bottom navigation*) untuk tab **Biasiswa / Permohonan Saya / Profil**.

Sehingga esok — pastikan `flutter run` anda masih berfungsi tanpa ralat sebelum tamat kelas hari ini!

---

> 🎤 **Nota penceramah/jurulatih:** [`nota-penceramah.md`](./nota-penceramah.md) — kumpulan nota persembahan (asalnya *speaker notes* dalam slaid) untuk Hari 1.

## Nota Tambahan (fakta ringkas dari slaid)

Petua persediaan yang disebut dalam slaid — dikumpulkan di sini supaya nota lengkap:

- **Emulator vs telefon sebenar:** untuk kelas, emulator lebih mudah dikawal; namun telefon sebenar selalunya **lebih pantas** pada komputer berspesifikasi rendah.
- **`flutter run` kali pertama ambil beberapa minit** — Gradle sedang memuat turun dependency. Ini **normal**, bukan hang.
- **`pubspec.yaml` sensitif inden:** guna **2 ruang (space)**, bukan tab.
- Ralat **`flutter is not recognized`** biasanya bermakna PATH belum dimuat semula — buka **terminal baharu** dan cuba lagi.
