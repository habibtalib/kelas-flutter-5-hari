# Hari 1 — Aliran Kawalan Dart & Widget Asas

Panduan langkah demi langkah untuk hari pertama kursus **Latihan Secara *Coaching* Aplikasi Mobil Bagi Sistem Pendidikan Tinggi Luar Negara Menggunakan Flutter** (Kementerian Pendidikan Tinggi/KPT, 20–24 Julai 2026). Nota ini mengikut **aturcara rasmi SESI 1** — lihat [`JADUAL.md`](../JADUAL.md) — bukan susunan bebas.

Projek kursus: **eTT Mobile** — companion latihan untuk sistem sebenar **e-Timur Tengah (eTT)**, Bahagian Pengantarabangsaan Pendidikan Tinggi (BPPT), KPT — permohonan pelajar Malaysia ke universiti di **Mesir** & **Maghribi (Morocco)**.

> **Penafian:** Bahan latihan — **BUKAN sistem e-Timur Tengah rasmi**. Permohonan sebenar hanya di **dohe.mohe.gov.my/timurtengah**. KPT **tidak melantik ejen**. Nama universiti & syarat adalah benar; **kos/kuota adalah ilustrasi**.

> **Nota untuk pemula:** Anda tidak perlu tahu Flutter atau Dart langsung. Setiap langkah diterangkan perlahan-lahan.

> **Konvensyen kod:** Penerangan dalam nota ini ditulis dalam **Bahasa Melayu**, tetapi semua kod, nama kelas/pembolehubah dan komen dalam fail `.dart` ditulis dalam **Bahasa Inggeris** — amalan standard industri Flutter/Dart yang kita ikut sepanjang kursus.

---

## Fokus Hari Ini

| Topik | Rujukan rasmi |
|-------|----------------|
| Operators (pengendali) | [dart.dev/language/operators](https://dart.dev/language/operators) |
| Control flow — if/else, switch | [dart.dev/language/branches](https://dart.dev/language/branches) |
| Looping — for, while | [dart.dev/language/loops](https://dart.dev/language/loops) |
| Function | [dart.dev/language/functions](https://dart.dev/language/functions) |
| Widget `Text` | [api.flutter.dev/.../Text-class.html](https://api.flutter.dev/flutter/widgets/Text-class.html) |
| Widget `Icon` | [api.flutter.dev/.../Icon-class.html](https://api.flutter.dev/flutter/widgets/Icon-class.html) |
| Widget `Image` | [docs.flutter.dev/cookbook/images/network-image](https://docs.flutter.dev/cookbook/images/network-image) |
| `Container`, `Padding`, `SizedBox` | [docs.flutter.dev/ui/layout](https://docs.flutter.dev/ui/layout) |
| `EdgeInsets` (padding/margin) | [api.flutter.dev/.../EdgeInsets-class.html](https://api.flutter.dev/flutter/painting/EdgeInsets-class.html) |
| StatelessWidget vs StatefulWidget | [docs.flutter.dev/get-started/fundamentals/state-management](https://docs.flutter.dev/get-started/fundamentals/state-management) |
| DartPad (latih Dart dalam pelayar) | [dartpad.dev](https://dartpad.dev) |

---

## Jadual Hari Ini

| Masa | Agenda |
|------|--------|
| 8.30 – 9.00 pagi | Pendaftaran Peserta & Minum Pagi |
| **9.00 pagi – 1.00 petang** | **SESI 1: Widget Asas & Aliran Kawalan Dart** — Operators, Control flow (if/else, switch), Looping (for, while) & Function, Eksperimen Widget Asas: Text, Icon, Image |
| 1.00 – 2.30 petang | Rehat dan Makan Tengah Hari |
| **2.30 – 5.00 petang** | **Sambungan SESI 1** — Container, Padding, Margin, SizedBox; Perbezaan StatelessWidget vs StatefulWidget |
| 5.00 petang | Bersurai |

Hari ini **tidak** merangkumi `ListView`, `Card`, `Scaffold` penuh, `ThemeData`, navigasi, borang, `provider`, atau API — semua itu SESI 2 ke atas (lihat [`JADUAL.md`](../JADUAL.md)). Fokus hari ini **semata-mata** aliran kawalan Dart + segelintir widget paling asas.

---

## Persediaan (Sebelum 9.00 Pagi / Pra-syarat)

Persediaan **bukan** item agenda rasmi (ia tidak disebut dalam SESI 1), tetapi anda perlukan projek Flutter yang **boleh dijalankan** sebelum kelas bermula. Selesaikan **sebelum** 20 Julai 2026:

1. Pasang **Flutter SDK**, **Android Studio** (untuk Android SDK & emulator) dan **VS Code** (+ sambungan Flutter/Dart) — panduan penuh langkah demi langkah ada di [`nota/04-setup-windows.md`](../nota/04-setup-windows.md).
2. Sahkan persekitaran anda sedia dengan:

   ```bash
   flutter doctor
   flutter devices
   ```

3. Cipta **satu** projek ujian untuk pastikan semuanya berfungsi hujung ke hujung:

   ```bash
   flutter create ett_mobile
   cd ett_mobile
   flutter run
   ```

   Jika aplikasi lalai (kaunter "+1") berjaya berjalan pada emulator/telefon — **persekitaran anda sedia**. Biarkan projek ini terbuka; kita akan edit `lib/main.dart` sepanjang sesi hari ini.

> Projek **rujukan penuh** (hasil akhir 5 hari) sudah disediakan di `projek/ett_mobile/` dalam repo ini. Jangan salin terus — kita bina **dari kosong**, berperingkat, sepanjang minggu supaya faham setiap baris. Boleh buka fail di sana untuk **banding** kod anda selepas setiap latihan.

---

## SESI 1 (Pagi, 9.00 – 1.00) — Aliran Kawalan Dart

Sebelum sentuh sebarang widget, kita perlu selesa dengan **sintaks asas Dart** — bahasa pengaturcaraan di sebalik Flutter. Bahagian ini **tidak perlukan Flutter langsung**; kita akan tulis & jalankan kod Dart tulen dahulu, sama ada dalam [DartPad](https://dartpad.dev) (pelayar, tiada pemasangan) atau terus dalam terminal (`dart run`).

> **Cadangan kelas:** buka [dartpad.dev](https://dartpad.dev) di tab pelayar berasingan — setiap contoh kod di bawah boleh ditampal terus dan diklik **Run** tanpa perlu tunggu `flutter run`/emulator. Ini jimat masa semasa bereksperimen.

### Operators (Pengendali)

Dart menyokong pengendali standard: aritmetik, bandingan, logik, dan tugasan gabungan (*compound assignment*).

```dart
const int kuotaEtt001 = 40;   // arithmetic: pemalar — Al-Azhar, Perubatan
const int kuotaEtt003 = 80;   // Al-Azhar, Ulum Islamiah

print(kuotaEtt001 + kuotaEtt003);              // + (tambah)
print(kuotaEtt003 > kuotaEtt001);              // > (bandingan)

const double kosFarmasiSetahun = 36000;        // RM, ilustrasi — ETT-004
const int tempohPengajianTahun = 5;
final double anggaranKosKeseluruhan = kosFarmasiSetahun * tempohPengajianTahun; // *

final bool dalamBajet = anggaranKosKeseluruhan <= 200000; // <=
const bool sijilLengkap = true;
print(dalamBajet && sijilLengkap);              // && (logik DAN)

int kiraan = 0;
kiraan += 1;   // tugasan gabungan
kiraan *= 3;
```

| Kategori | Contoh | Maksud |
|----------|--------|--------|
| Aritmetik | `+ - * / ~/ %` | tambah, tolak, darab, bahagi, bahagi integer, baki |
| Bandingan | `== != > < >= <=` | pulangkan `bool` |
| Logik | `&& \|\| !` | DAN, ATAU, TIDAK |
| Tugasan gabungan | `+= -= *= /= ??=` | kemas kini nilai pembolehubah terus |

> Rujukan rasmi: [dart.dev/language/operators](https://dart.dev/language/operators)

### Control Flow — `if` / `else`

```dart
const String keperluanProgram = 'stam'; // ETT-002: Syariah dan Undang-undang
const String sijilPemohon = 'spm';

if (keperluanProgram == 'both') {
  print('Program ini terima kedua-dua SPM & STAM.');
} else if (keperluanProgram == sijilPemohon) {
  print('Layak memohon — sijil sepadan keperluan program.');
} else {
  print('Tidak layak — program ini hanya terima '
      '${keperluanProgram.toUpperCase()}.');
}
```

`if`/`else if`/`else` menilai syarat `bool` **dari atas ke bawah** — sebaik sahaja satu syarat `true`, blok itu dijalankan dan yang lain **dilangkau**.

> **Nota realiti eTT:** Setiap permohonan sebenar hanya untuk **SATU negara + SATU bidang** (butiran penuh borang permohonan — Hari 3, SESI 4). Contoh di atas mengelabelkan `keperluanProgram` sebagai `'spm'`, `'stam'` atau `'both'` — corak sebenar model `EntryCategory` yang kita formalkan sebagai `enum` di bawah.

### Control Flow — `switch`

`switch` lebih kemas berbanding rantaian panjang `if/else if` apabila membandingkan **satu nilai** dengan banyak kemungkinan tetap — contohnya, memetakan **nama universiti** kepada **label negara** Bahasa Melayu:

```dart
String countryLabelForUniversity(String universityName) {
  switch (universityName) {
    case 'Universiti Al-Azhar':
    case 'Universiti Alexandria':
    case 'Universiti Ain Shams':
    case 'Universiti Tanta':
      // empat case "jatuh melalui" (fall-through) ke return yang sama
      return 'Mesir';
    case 'Universite Al Quaraouiyine':
    case 'Universiti Mohammed V':
      return 'Maghribi';
    default:
      return 'Negara tidak diketahui';
  }
}
```

> **Nota Dart 3:** Selain `switch` *statement* klasik di atas, Dart 3 juga ada **`switch` *expression*** ringkas (`=>`) — kita akan jumpa corak ini apabila menulis `enum` di bawah. Kedua-dua bentuk sah; `switch` statement lebih biasa untuk **logik bercabang berbilang baris**, `switch` expression untuk **pulangkan satu nilai terus**.

> Rujukan rasmi: [dart.dev/language/branches](https://dart.dev/language/branches)

### Looping — `for` & Function

eTT menawarkan **8 program** (universiti + bidang) merentasi Mesir & Maghribi. Mari kita jumlahkan **kuota tempat** (ilustrasi, kecuali laluan Maghribi — 15 tempat, angka rasmi) menggunakan **loop** dan **function**:

```dart
const List<Map<String, Object>> sampleProgrammes = [
  {'id': 'ETT-001', 'universityName': 'Universiti Al-Azhar', 'quotaSeats': 40},
  {'id': 'ETT-002', 'universityName': 'Universiti Al-Azhar', 'quotaSeats': 120},
  {'id': 'ETT-003', 'universityName': 'Universiti Al-Azhar', 'quotaSeats': 80},
  {'id': 'ETT-004', 'universityName': 'Universiti Alexandria', 'quotaSeats': 30},
  {'id': 'ETT-005', 'universityName': 'Universiti Ain Shams', 'quotaSeats': 25},
  {'id': 'ETT-006', 'universityName': 'Universiti Tanta', 'quotaSeats': 20},
  {'id': 'ETT-007', 'universityName': 'Universite Al Quaraouiyine', 'quotaSeats': 15},
  {'id': 'ETT-008', 'universityName': 'Universiti Mohammed V', 'quotaSeats': 10},
];

// Function — jumlahkan quotaSeats semua program dalam senarai.
int jumlahkanKuota(List<Map<String, Object>> data) {
  int jumlah = 0;
  for (final programme in data) {   // for (... in ...)
    jumlah += programme['quotaSeats'] as int;
  }
  return jumlah;
}

void main() {
  final jumlah = jumlahkanKuota(sampleProgrammes);
  print('Jumlah kuota keseluruhan (8 program): $jumlah tempat'); // 340
}
```

- **`function`** — blok kod dinamakan yang boleh **dipanggil semula** (`jumlahkanKuota(...)`), menerima **parameter** (`List<Map<String, Object>> data`), dan **memulangkan** nilai (`return jumlah;`) berjenis `int`.
- **`for (final programme in data)`** — bentuk `for-in`, lelar (*iterate*) setiap program dalam senarai tanpa perlu urus indeks secara manual.

> Rujukan rasmi: [dart.dev/language/loops](https://dart.dev/language/loops) · [dart.dev/language/functions](https://dart.dev/language/functions)

### Looping — `while`

Guna `while` apabila bilangan lelaran **tidak diketahui terlebih dahulu**, atau anda perlu kawal syarat berhenti sendiri:

```dart
const senaraiBidangPopular = ['Perubatan (Medicine)', 'Farmasi (Pharmacy)', 'Pergigian (Dentistry)'];

int i = 0;
while (i < senaraiBidangPopular.length) {
  print('Bidang popular #${i + 1}: ${senaraiBidangPopular[i]}');
  i++; // PENTING: jangan lupa naikkan i, jika tidak -> infinite loop
}
```

> **Kesilapan biasa pemula:** Lupa `i++` (atau apa-apa yang mengubah syarat `while`) menyebabkan **infinite loop** — program "tersangkut" selama-lamanya. Sentiasa sahkan syarat berhenti akan tercapai.

---

## SESI 1 (Pagi, sambungan) — Eksperimen Widget Asas: Text, Icon, Image

Sekarang kita beralih dari Dart tulen ke **Flutter**. Buka `lib/main.dart` dalam projek `ett_mobile` yang anda cipta semasa Persediaan, dan gantikan kandungannya:

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
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(title: const Text('eTT Mobile')),
        body: const Center(child: Text('Selamat datang!')),
      ),
    );
  }
}
```

Simpan (`Ctrl+S`) — dengan `flutter run` masih berjalan, ini akan **Hot Reload** automatik. Sekarang cuba tiga widget paparan paling asas dalam Flutter, satu demi satu, dalam `body:`:

### `Text` — papar teks

```dart
const Text(
  'Universiti Al-Azhar',
  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
)
```

`style: TextStyle(...)` mengawal saiz fon, berat (*weight*), warna, dsb. — kita akan bedah `TextStyle` penuh di SESI 3 (Hari 2).

### `Icon` — ikon Material terbina-dalam

```dart
const Icon(Icons.school, size: 32, color: Color(0xFF1A2B5C))
const Icon(Icons.flag, size: 32)
```

`Icons.school`, `Icons.flag` ialah sebahagian daripada **beribu-ribu ikon Material** terbina-dalam Flutter — tiada muat turun asset diperlukan. Katalog penuh: [fonts.google.com/icons](https://fonts.google.com/icons).

### `Image` — papar imej

Projek kursus **tiada** aset logo terbenam (*bundled asset*) — jadi kita guna **dua** cara yang tidak perlukan fail imej tempatan:

```dart
// Cara 1: Image.network — muat imej terus dari URL
Image.network(
  'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg',
  height: 120,
)

// Cara 2: emoji bendera sebagai Text — mudah untuk representasi negara
const Text('🇪🇬', style: TextStyle(fontSize: 40)) // Mesir (Egypt)
```

> **Kenapa emoji bendera?** Model sebenar `Programme` dalam projek kursus (`projek/ett_mobile/lib/models/programme.dart`) ada getter `flagEmoji` yang memetakan `country` (`'Egypt'`/`'Morocco'`) kepada emoji bendera (`🇪🇬`/`🇲🇦`) — corak ringan yang elakkan keperluan muat turun/urus fail imej bendera untuk setiap negara. Kita akan guna corak ini semula di Hari 2.

> Rujukan rasmi: [api.flutter.dev/flutter/widgets/Text-class.html](https://api.flutter.dev/flutter/widgets/Text-class.html) · [api.flutter.dev/flutter/widgets/Icon-class.html](https://api.flutter.dev/flutter/widgets/Icon-class.html) · [docs.flutter.dev/cookbook/images/network-image](https://docs.flutter.dev/cookbook/images/network-image)

---

## SESI 1 (Petang, 2.30 – 5.00) — Container, Padding, Margin, SizedBox

### `Container` — kotak serba boleh

`Container` ialah widget "kotak" paling serba boleh dalam Flutter — boleh ada warna latar, saiz, sempadan (*border*), sudut bulat, dan **padding**/**margin** terbina sekali:

```dart
Container(
  padding: const EdgeInsets.all(16),
  decoration: BoxDecoration(
    color: const Color(0xFF1A2B5C), // navy — pilihan reka bentuk latihan, BUKAN warna rasmi KPT
    borderRadius: BorderRadius.circular(12),
  ),
  child: const Text('Kotak navy', style: TextStyle(color: Colors.white)),
)
```

### `Padding` vs `Margin` — apa beza?

Konsep ini sering mengelirukan pemula — kedua-dua "jarak", tetapi **arah** berbeza:

| | `Padding` | `Margin` |
|---|---|---|
| **Maksud** | Jarak **DALAM** — antara sempadan widget dengan kandungannya | Jarak **LUAR** — antara sempadan widget dengan widget/skrin di sekelilingnya |
| **Analogi** | Ruang kosong di dalam bingkai gambar, sekitar gambar itu sendiri | Ruang kosong di luar bingkai, sebelum dinding/bingkai lain |
| **Cara guna dalam `Container`** | `padding: const EdgeInsets.all(16)` | `margin: const EdgeInsets.all(16)` |
| **Widget berasingan?** | Ya — `Padding(padding: ..., child: ...)` boleh berdiri sendiri | Tiada widget `Margin` berasingan — hanya parameter `Container` (atau bungkus dengan `Padding` di luar) |

```dart
Container(
  margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8), // jarak LUAR kotak
  padding: const EdgeInsets.all(16),                                // jarak DALAM kotak
  decoration: BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(12),
  ),
  child: const Text('Ada margin di luar DAN padding di dalam'),
)
```

`EdgeInsets` ada beberapa konstruktor berguna: `EdgeInsets.all(16)` (semua sisi sama), `EdgeInsets.symmetric(horizontal: 12, vertical: 8)` (kiri=kanan, atas=bawah berbeza), `EdgeInsets.only(top: 8, left: 16)` (sisi tertentu sahaja).

### `SizedBox` — jarak/saiz tepat

```dart
Column(
  children: const [
    Text('Universiti Al-Azhar'),
    SizedBox(height: 12), // jarak kosong 12px — TIADA widget lain buat ini seefisien ini
    Text('Kaherah (Cairo), Mesir'),
  ],
)
```

`SizedBox` boleh juga guna untuk **paksa saiz tepat** widget lain (`SizedBox(width: 200, height: 50, child: ...)`), tetapi kegunaan paling lazim ialah sebagai **jarak kosong** (*spacer*) ringkas antara widget dalam `Column`/`Row`.

### Latihan Bengkel: Kad Info Program (Statik)

Mari gabungkan `Container`, `Padding`, `SizedBox`, `Text`, dan `Icon` untuk bina **secara manual** satu kad maklumat program — pendahulu (*precursor*) kepada widget `ProgrammeCard` sebenar yang kita bina Hari 2. Data diambil daripada `sample_programmes.dart` (**ETT-001**: Universiti Al-Azhar, Perubatan):

```dart
Container(
  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
  padding: const EdgeInsets.all(16),
  decoration: BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(14),
    border: Border.all(color: Colors.grey.shade300),
  ),
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: const [
      Text(
        '🇪🇬  Universiti Al-Azhar',
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF1A2B5C)),
      ),
      SizedBox(height: 4),
      Text('Kaherah (Cairo), Mesir', style: TextStyle(color: Colors.grey)),
      SizedBox(height: 12),
      Text('Bidang: Perubatan (Medicine)'),
      SizedBox(height: 4),
      Text('Anggaran yuran: RM23,000/tahun (ilustrasi)'),
      SizedBox(height: 4),
      Text('Kuota (ilustrasi): 40 tempat · Pengambilan: September'),
    ],
  ),
)
```

Tampal kod ini sebagai `body:` `Scaffold` anda (atau dalam `Center(child: ...)`) dan Hot Reload. Anda sepatutnya nampak satu **kad putih bersudut bulat** dengan maklumat Universiti Al-Azhar (Perubatan) tersusun kemas.

> **Intip Hari 2:** Kad statik ini akan jadi widget `ProgrammeCard` yang **boleh guna semula** (*reusable*) untuk **8 program**, dipaparkan dalam senarai skrol — kita belum sentuh `ListView`/`Card` hari ini, jadi buat masa ini kita hanya bina **satu** kad secara manual untuk faham struktur `Container`/`Padding`/`SizedBox` dahulu.

---

## SESI 1 (Petang) — StatelessWidget vs StatefulWidget

Dua jenis widget asas yang anda akan tulis **setiap hari** sepanjang kursus:

| | `StatelessWidget` | `StatefulWidget` |
|---|---|---|
| **Bila guna** | UI **tidak berubah** selepas dibina (atau hanya bergantung pada data luaran yang diterima) | UI **perlu berubah** akibat interaksi pengguna atau data dalaman (cth. tekan butang, taip teks) |
| **Contoh dalam projek kita** | `ProgrammeCard` (papar sahaja — Hari 2) | Kaunter interaksi, borang permohonan (Hari 3) |
| **Cara ia berfungsi** | Satu kaedah `build()` sahaja | Ada objek `State` berasingan yang menyimpan data (*state*) & kaedah `setState()` untuk beritahu Flutter "lukis semula" |
| **Struktur kod** | `class Foo extends StatelessWidget { @override Widget build(...) { ... } }` | `class Foo extends StatefulWidget { @override State<Foo> createState() => _FooState(); }` diikuti `class _FooState extends State<Foo> { ... }` |

> **Analogi:** `StatelessWidget` seperti gambar bercetak — sekali dicetak, tidak berubah. `StatefulWidget` seperti papan tanda LED — ia boleh dikemas kini bila-bila masa (`setState()` = "tekan butang kemas kini papan").

### Teaser: Kaunter "Simpan Program"

Kita **belum** masuk mendalam kitaran hayat (*lifecycle*) penuh `setState()` — itu **SESI 5 (Hari 3)**. Tetapi mari lihat sepintas lalu **kenapa** `StatefulWidget` wujud, dengan satu kaunter ringkas — "berapa program telah anda simpan (bookmark)":

```dart
class SavedProgrammeCounter extends StatefulWidget {
  const SavedProgrammeCounter({super.key});

  @override
  State<SavedProgrammeCounter> createState() => _SavedProgrammeCounterState();
}

class _SavedProgrammeCounterState extends State<SavedProgrammeCounter> {
  int _savedCount = 0; // data yang boleh BERUBAH sepanjang widget ini hidup

  void _addProgramme() {
    setState(() {
      _savedCount++; // beritahu Flutter: "data berubah, lukis semula build()"
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text('Program disimpan: $_savedCount'),
        const SizedBox(height: 8),
        ElevatedButton(
          onPressed: _addProgramme,
          child: const Text('+ Simpan Program'),
        ),
      ],
    );
  }
}
```

Tampal `SavedProgrammeCounter()` sebagai `body:` dan cuba tekan butang berulang kali — anda akan nampak angka bertambah **tanpa** perlu `flutter run` semula (Hot Reload kekalkan state semasa anda sedang menaip kod, tetapi tekanan butang berlaku semasa aplikasi berjalan, direkodkan oleh `setState()`).

- **`class ... extends StatefulWidget`** — widget "cangkang" (*shell*) yang tidak menyimpan data sendiri; ia hanya cipta objek `State`.
- **`class _SavedProgrammeCounterState extends State<SavedProgrammeCounter>`** — di sinilah **data sebenar** (`_savedCount`) hidup, dan `build()` dipanggil semula setiap kali `setState()` dipanggil.
- **`setState(() { ... })`** — **satu-satunya** cara sah untuk beritahu Flutter "data telah berubah, sila lukis semula". Jika anda tukar `_savedCount++` **tanpa** bungkus dalam `setState()`, UI **TIDAK** akan kemas kini walaupun nilai berubah di belakang tabir.

> **Pratonton SESI 5 (Hari 3):** Kita akan bedah **kitaran hayat penuh** `StatefulWidget` (`initState()`, `dispose()`, dsb.), sambungkan `setState()` kepada borang permohonan sebenar (`ApplicationFormScreen`), dan bincang bila `provider` (pengurusan *state* lanjutan — **bonus/di luar aturcara rasmi**) berguna berbanding `setState()` semata-mata.

---

## Penutup — Ringkasan & Langkah Seterusnya

### Ringkasan

Hari ini kita telah:

1. ✅ Kuasai **operators** Dart (aritmetik, bandingan, logik, tugasan gabungan).
2. ✅ Kuasai **control flow** — `if`/`else if`/`else` dan `switch`.
3. ✅ Kuasai **looping** — `for` (termasuk `for-in`) dan `while` — serta cara tulis **function** dengan parameter & pulangan nilai.
4. ✅ Cuba widget paparan asas: `Text`, `Icon`, `Image` (`Image.network` & emoji).
5. ✅ Fahami `Container`, beza **`Padding`** (dalam) vs **`Margin`** (luar), dan `SizedBox` (jarak/saiz) — digunakan untuk bina satu kad info program statik.
6. ✅ Fahami beza konsep **`StatelessWidget`** vs **`StatefulWidget`**, dengan pratonton `setState()` melalui kaunter ringkas.

### Simpan Kerja Anda (Git)

Jika projek anda belum dalam kawalan versi, mulakan sekarang — tabiat baik dari Hari 1:

```bash
git init
git add .
git commit -m "Hari 1: aliran kawalan Dart, widget asas, kad program eTT statik"
```

> **Nota:** `flutter create` sudah menjana fail `.gitignore` yang sesuai (mengabaikan `build/`, `.dart_tool/`, dll) — tidak perlu konfigurasi tambahan.

### Apa Seterusnya — Hari 2 (SESI 2 & 3)

Esok kita mula bina **seni bina layout** sebenar (`Row`, `Column`, `Expanded`, `Stack`, `Scaffold`, `AppBar`) — termasuk **Slot AI** rasmi pertama (jana mockup UI dengan bantuan prompt AI) — kemudian sambung ke **`BottomNavigationBar`** (Program / Permohonan Saya / Profil), **`Drawer`** (pilih negara: Mesir/Maghribi), **`ListView.builder`**, `Card`, dan `ThemeData` untuk papar **8 program** dalam senarai boleh skrol bertema navy/gold.

Sehingga esok — pastikan `flutter run` anda masih berfungsi tanpa ralat sebelum tamat kelas hari ini!

---

> 🎤 **Nota penceramah/jurulatih:** [`nota-penceramah.md`](./nota-penceramah.md) — kumpulan nota persembahan (asalnya *speaker notes* dalam slaid) untuk Hari 1.

## Nota Tambahan (fakta ringkas dari slaid)

- **Operator tugasan gabungan:** `kiraan += 1;` **sama dengan** `kiraan = kiraan + 1;` — ia hanya cara ringkas menulis semula nilai ke pembolehubah yang sama. Begitu juga `-=`, `*=`, `/=`.
- **Operator `??` (if-null):** pulangkan nilai di sebelah kiri jika ia **bukan** null; jika null, guna nilai lalai di sebelah kanan.
  ```dart
  // jika kadar tukaran tiada dalam peta, guna 1.0 sebagai lalai
  final kadar = kadarTukaranAnggaran[currency] ?? 1.0;
  ```
