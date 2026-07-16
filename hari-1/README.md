# Hari 1 — Aliran Kawalan Dart & Widget Asas

Panduan langkah demi langkah untuk hari pertama kursus **Latihan Secara *Coaching* Aplikasi Mobil Bagi Sistem Pendidikan Tinggi Luar Negara Menggunakan Flutter** (Kementerian Pendidikan Tinggi/KPT, 20–24 Julai 2026). Nota ini mengikut **aturcara rasmi SESI 1** — lihat [`JADUAL.md`](../JADUAL.md) — bukan susunan bebas.

Projek kursus: **MyPelajar LN** (*MyPelajar Luar Negara*) — aplikasi mudah alih rujukan destinasi pengajian luar negara & pendaftaran pelajar, konsep cermin sistem sebenar **MyData@EducationMalaysia4U**.

> **Penafian:** Bahan latihan ini **BUKAN sistem rasmi KPT**. Data yuran adalah ilustrasi; semakan pengiktirafan kelayakan sebenar dibuat melalui **eSisraf (MQA)**.

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
   flutter create mypelajar_ln
   cd mypelajar_ln
   flutter run
   ```

   Jika aplikasi lalai (kaunter "+1") berjaya berjalan pada emulator/telefon — **persekitaran anda sedia**. Biarkan projek ini terbuka; kita akan edit `lib/main.dart` sepanjang sesi hari ini.

> Projek **rujukan penuh** (hasil akhir 5 hari) sudah disediakan di `projek/mypelajar_ln/` dalam repo ini. Jangan salin terus — kita bina **dari kosong**, berperingkat, sepanjang minggu supaya faham setiap baris. Boleh buka fail di sana untuk **banding** kod anda selepas setiap latihan.

---

## SESI 1 (Pagi, 9.00 – 1.00) — Aliran Kawalan Dart

Sebelum sentuh sebarang widget, kita perlu selesa dengan **sintaks asas Dart** — bahasa pengaturcaraan di sebalik Flutter. Bahagian ini **tidak perlukan Flutter langsung**; kita akan tulis & jalankan kod Dart tulen dahulu, sama ada dalam [DartPad](https://dartpad.dev) (pelayar, tiada pemasangan) atau terus dalam terminal (`dart run`).

> **Cadangan kelas:** buka [dartpad.dev](https://dartpad.dev) di tab pelayar berasingan — setiap contoh kod di bawah boleh ditampal terus dan diklik **Run** tanpa perlu tunggu `flutter run`/emulator. Ini jimat masa semasa bereksperimen.

### Operators (Pengendali)

Dart menyokong pengendali standard: aritmetik, bandingan, logik, dan tugasan gabungan (*compound assignment*).

```dart
const int totalPelajarLN = 54903;      // arithmetic: pemalar
const int pelajarTajaan = 14697;
const int pelajarSendiri = 40206;

print(pelajarTajaan + pelajarSendiri);              // + (tambah)
print(pelajarTajaan + pelajarSendiri == totalPelajarLN); // == (bandingan)

const double yuranMelbourneAud = 52000;
const double kadarTukaranAudMyr = 3.0;              // anggaran, bukan rasmi
final double yuranMelbourneMyr = yuranMelbourneAud * kadarTukaranAudMyr; // *

final bool dalamBajet = yuranMelbourneMyr <= 200000; // <=
final bool statusDiiktiraf = true;
print(dalamBajet && statusDiiktiraf);                // && (logik DAN)

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
const String recognitionStatusAuckland = 'checkWithMqa';

if (recognitionStatusAuckland == 'recognised') {
  print('University of Auckland: diiktiraf terus.');
} else if (recognitionStatusAuckland == 'checkWithMqa') {
  print('University of Auckland: perlu semak eSisraf (MQA) dahulu.');
} else {
  print('Status tidak dikenali.');
}
```

`if`/`else if`/`else` menilai syarat `bool` **dari atas ke bawah** — sebaik sahaja satu syarat `true`, blok itu dijalankan dan yang lain **dilangkau**.

### Control Flow — `switch`

`switch` lebih kemas berbanding rantaian panjang `if/else if` apabila membandingkan **satu nilai** dengan banyak kemungkinan tetap — contohnya, memetakan **negara** kepada **pejabat Education Malaysia (EM)** yang menyelianya:

```dart
String emOfficeForCountry(String country) {
  switch (country) {
    case 'Australia':
      return 'Education Malaysia Australia';
    case 'United Kingdom':
    case 'Ireland':
      // dua case "jatuh melalui" (fall-through) ke return yang sama
      return 'Education Malaysia London';
    case 'China':
    case 'Japan':
      return 'Education Malaysia Beijing';
    default:
      return 'Tiada pejabat EM khusus direkodkan';
  }
}
```

> **Nota Dart 3:** Selain `switch` *statement* klasik di atas, Dart 3 juga ada **`switch` *expression*** ringkas (`=>`) — kita akan jumpa corak ini apabila menulis `enum` di bawah. Kedua-dua bentuk sah; `switch` statement lebih biasa untuk **logik bercabang berbilang baris**, `switch` expression untuk **pulangkan satu nilai terus**.

> Rujukan rasmi: [dart.dev/language/branches](https://dart.dev/language/branches)

### Looping — `for` & Function

Data sebenar (Statistik Pendidikan Tinggi 2024, Bab 6): **54,903** pelajar Malaysia belajar di luar negara (14,697 tajaan + 40,206 sendiri), merentasi destinasi seperti Australia, UK, Mesir, dan lain-lain. Mari kita jumlahkan bilangan mengikut 12 negara utama menggunakan **loop** dan **function**:

```dart
const Map<String, int> pelajarMengikutNegara = {
  'Australia': 18348,
  'United Kingdom': 13005,
  'Egypt': 5445,
  'United States': 4980,
  'China': 4357,
  'Jordan': 2003,
  'Indonesia': 1110,
  'Japan': 1039,
  'Ireland': 856,
  'South Korea': 695,
  'Russia': 622,
  'New Zealand': 575,
};

// Function — jumlahkan semua nilai dalam peta statistik negara.
int jumlahkanPelajar(Map<String, int> data) {
  int jumlah = 0;
  for (final entry in data.entries) {   // for (... in ...)
    jumlah += entry.value;
  }
  return jumlah;
}

void main() {
  final jumlah = jumlahkanPelajar(pelajarMengikutNegara);
  print('Jumlah 12 negara utama: $jumlah');       // 53,035
  print('Jumlah rasmi keseluruhan: 54903');
  // baki (1,868) tersebar di destinasi lain yang tidak disenaraikan di sini
}
```

- **`function`** — blok kod dinamakan yang boleh **dipanggil semula** (`jumlahkanPelajar(...)`), menerima **parameter** (`Map<String, int> data`), dan **memulangkan** nilai (`return jumlah;`) berjenis `int`.
- **`for (final entry in data.entries)`** — bentuk `for-in`, lelar (*iterate*) setiap pasangan kunci-nilai dalam `Map` tanpa perlu urus indeks secara manual.

> Rujukan rasmi: [dart.dev/language/loops](https://dart.dev/language/loops) · [dart.dev/language/functions](https://dart.dev/language/functions)

### Looping — `while`

Guna `while` apabila bilangan lelaran **tidak diketahui terlebih dahulu**, atau anda perlu kawal syarat berhenti sendiri:

```dart
const senaraiDestinasiPopular = ['Australia', 'United Kingdom', 'Egypt'];

int i = 0;
while (i < senaraiDestinasiPopular.length) {
  print('Destinasi popular #${i + 1}: ${senaraiDestinasiPopular[i]}');
  i++; // PENTING: jangan lupa naikkan i, jika tidak -> infinite loop
}
```

> **Kesilapan biasa pemula:** Lupa `i++` (atau apa-apa yang mengubah syarat `while`) menyebabkan **infinite loop** — program "tersangkut" selama-lamanya. Sentiasa sahkan syarat berhenti akan tercapai.

---

## SESI 1 (Pagi, sambungan) — Eksperimen Widget Asas: Text, Icon, Image

Sekarang kita beralih dari Dart tulen ke **Flutter**. Buka `lib/main.dart` dalam projek `mypelajar_ln` yang anda cipta semasa Persediaan, dan gantikan kandungannya:

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
        appBar: AppBar(title: const Text('MyPelajar LN')),
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
  'University of Melbourne',
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
const Text('🇦🇺', style: TextStyle(fontSize: 40)) // Australia
```

> **Kenapa emoji bendera?** Model sebenar `OverseasUniversity` dalam projek kursus (`projek/mypelajar_ln/lib/models/overseas_university.dart`) ada getter `flagEmoji` yang memetakan negara kepada emoji bendera — corak ringan yang elakkan keperluan muat turun/urus fail imej bendera untuk setiap negara. Kita akan guna corak ini semula di Hari 2.

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
    Text('University of Melbourne'),
    SizedBox(height: 12), // jarak kosong 12px — TIADA widget lain buat ini seefisien ini
    Text('Melbourne, Australia'),
  ],
)
```

`SizedBox` boleh juga guna untuk **paksa saiz tepat** widget lain (`SizedBox(width: 200, height: 50, child: ...)`), tetapi kegunaan paling lazim ialah sebagai **jarak kosong** (*spacer*) ringkas antara widget dalam `Column`/`Row`.

### Latihan Bengkel: Kad Info Universiti (Statik)

Mari gabungkan `Container`, `Padding`, `SizedBox`, `Text`, dan `Icon` untuk bina **secara manual** satu kad maklumat universiti — pendahulu (*precursor*) kepada widget `UniversityCard` sebenar yang kita bina Hari 2. Data diambil daripada `sample_universities.dart`:

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
        '🇦🇺  University of Melbourne',
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF1A2B5C)),
      ),
      SizedBox(height: 4),
      Text('Melbourne, Australia', style: TextStyle(color: Colors.grey)),
      SizedBox(height: 12),
      Text('Bidang popular: Medicine, Engineering, Commerce'),
      SizedBox(height: 4),
      Text('Anggaran yuran: RM156,000/tahun'),
      SizedBox(height: 4),
      Text('Pelajar Malaysia (Australia, 2024): 18,348'),
    ],
  ),
)
```

Tampal kod ini sebagai `body:` `Scaffold` anda (atau dalam `Center(child: ...)`) dan Hot Reload. Anda sepatutnya nampak satu **kad putih bersudut bulat** dengan maklumat University of Melbourne tersusun kemas.

> **Intip Hari 2:** Kad statik ini akan jadi widget `UniversityCard` yang **boleh guna semula** (*reusable*) untuk **8 universiti**, dipaparkan dalam senarai skrol — kita belum sentuh `ListView`/`Card` hari ini, jadi buat masa ini kita hanya bina **satu** kad secara manual untuk faham struktur `Container`/`Padding`/`SizedBox` dahulu.

---

## SESI 1 (Petang) — StatelessWidget vs StatefulWidget

Dua jenis widget asas yang anda akan tulis **setiap hari** sepanjang kursus:

| | `StatelessWidget` | `StatefulWidget` |
|---|---|---|
| **Bila guna** | UI **tidak berubah** selepas dibina (atau hanya bergantung pada data luaran yang diterima) | UI **perlu berubah** akibat interaksi pengguna atau data dalaman (cth. tekan butang, taip teks) |
| **Contoh dalam projek kita** | `UniversityCard` (papar sahaja — Hari 2) | Kaunter interaksi, borang pendaftaran (Hari 3) |
| **Cara ia berfungsi** | Satu kaedah `build()` sahaja | Ada objek `State` berasingan yang menyimpan data (*state*) & kaedah `setState()` untuk beritahu Flutter "lukis semula" |
| **Struktur kod** | `class Foo extends StatelessWidget { @override Widget build(...) { ... } }` | `class Foo extends StatefulWidget { @override State<Foo> createState() => _FooState(); }` diikuti `class _FooState extends State<Foo> { ... }` |

> **Analogi:** `StatelessWidget` seperti gambar bercetak — sekali dicetak, tidak berubah. `StatefulWidget` seperti papan tanda LED — ia boleh dikemas kini bila-bila masa (`setState()` = "tekan butang kemas kini papan").

### Teaser: Kaunter "Simpan Destinasi"

Kita **belum** masuk mendalam kitaran hayat (*lifecycle*) penuh `setState()` — itu **SESI 5 (Hari 3)**. Tetapi mari lihat sepintas lalu **kenapa** `StatefulWidget` wujud, dengan satu kaunter ringkas — "berapa destinasi telah anda simpan":

```dart
class SavedDestinationCounter extends StatefulWidget {
  const SavedDestinationCounter({super.key});

  @override
  State<SavedDestinationCounter> createState() => _SavedDestinationCounterState();
}

class _SavedDestinationCounterState extends State<SavedDestinationCounter> {
  int _savedCount = 0; // data yang boleh BERUBAH sepanjang widget ini hidup

  void _addDestination() {
    setState(() {
      _savedCount++; // beritahu Flutter: "data berubah, lukis semula build()"
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text('Destinasi disimpan: $_savedCount'),
        const SizedBox(height: 8),
        ElevatedButton(
          onPressed: _addDestination,
          child: const Text('+ Simpan Destinasi'),
        ),
      ],
    );
  }
}
```

Tampal `SavedDestinationCounter()` sebagai `body:` dan cuba tekan butang berulang kali — anda akan nampak angka bertambah **tanpa** perlu `flutter run` semula (Hot Reload kekalkan state semasa anda sedang menaip kod, tetapi tekanan butang berlaku semasa aplikasi berjalan, direkodkan oleh `setState()`).

- **`class ... extends StatefulWidget`** — widget "cangkang" (*shell*) yang tidak menyimpan data sendiri; ia hanya cipta objek `State`.
- **`class _SavedDestinationCounterState extends State<SavedDestinationCounter>`** — di sinilah **data sebenar** (`_savedCount`) hidup, dan `build()` dipanggil semula setiap kali `setState()` dipanggil.
- **`setState(() { ... })`** — **satu-satunya** cara sah untuk beritahu Flutter "data telah berubah, sila lukis semula". Jika anda tukar `_savedCount++` **tanpa** bungkus dalam `setState()`, UI **TIDAK** akan kemas kini walaupun nilai berubah di belakang tabir.

> **Pratonton SESI 5 (Hari 3):** Kita akan bedah **kitaran hayat penuh** `StatefulWidget` (`initState()`, `dispose()`, dsb.), sambungkan `setState()` kepada borang pendaftaran sebenar, dan bincang bila `provider` (pengurusan *state* lanjutan — **bonus/di luar aturcara rasmi**) berguna berbanding `setState()` semata-mata.

---

## Penutup — Ringkasan & Langkah Seterusnya

### Ringkasan

Hari ini kita telah:

1. ✅ Kuasai **operators** Dart (aritmetik, bandingan, logik, tugasan gabungan).
2. ✅ Kuasai **control flow** — `if`/`else if`/`else` dan `switch`.
3. ✅ Kuasai **looping** — `for` (termasuk `for-in`) dan `while` — serta cara tulis **function** dengan parameter & pulangan nilai.
4. ✅ Cuba widget paparan asas: `Text`, `Icon`, `Image` (`Image.network` & emoji).
5. ✅ Fahami `Container`, beza **`Padding`** (dalam) vs **`Margin`** (luar), dan `SizedBox` (jarak/saiz) — digunakan untuk bina satu kad info universiti statik.
6. ✅ Fahami beza konsep **`StatelessWidget`** vs **`StatefulWidget`**, dengan pratonton `setState()` melalui kaunter ringkas.

### Simpan Kerja Anda (Git)

Jika projek anda belum dalam kawalan versi, mulakan sekarang — tabiat baik dari Hari 1:

```bash
git init
git add .
git commit -m "Hari 1: aliran kawalan Dart, widget asas, kad universiti statik"
```

> **Nota:** `flutter create` sudah menjana fail `.gitignore` yang sesuai (mengabaikan `build/`, `.dart_tool/`, dll) — tidak perlu konfigurasi tambahan.

### Apa Seterusnya — Hari 2 (SESI 2 & 3)

Esok kita mula bina **seni bina layout** sebenar (`Row`, `Column`, `Expanded`, `Stack`, `Scaffold`, `AppBar`) — termasuk **Slot AI** rasmi pertama (jana mockup UI dengan bantuan prompt AI) — kemudian sambung ke **`ListView.builder`**, `Card`, dan `ThemeData` untuk papar **8 universiti** dalam senarai boleh skrol bertema navy/gold.

Sehingga esok — pastikan `flutter run` anda masih berfungsi tanpa ralat sebelum tamat kelas hari ini!

---

> 🎤 **Nota penceramah/jurulatih:** [`nota-penceramah.md`](./nota-penceramah.md) — kumpulan nota persembahan (asalnya *speaker notes* dalam slaid) untuk Hari 1.

## Nota Tambahan (fakta ringkas dari slaid)

- **Operator tugasan gabungan:** `kiraan += 1;` **sama dengan** `kiraan = kiraan + 1;` — ia hanya cara ringkas menulis semula nilai ke pembolehubah yang sama. Begitu juga `-=`, `*=`, `/=`.
- **Operator `??` (if-null):** pulangkan nilai di sebelah kiri jika ia **bukan** null; jika null, guna nilai lalai di sebelah kanan.
  ```dart
  // jika mata wang tiada dalam peta, guna 1.0 sebagai lalai
  final kadar = kadarTukaran[currency] ?? 1.0;
  ```
