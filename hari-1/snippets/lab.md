# Lab Hari 1 — Aliran Kawalan Dart & Widget Asas

Lab ini mengiringi [`README.md`](../README.md) Hari 1. Ikut latihan **secara berurutan** — setiap latihan bina di atas latihan sebelumnya. Rujuk projek akhir sebenar di `projek/ett_mobile/lib/` untuk **banding** jawapan anda selepas cuba sendiri dahulu.

> **Peraturan lab:** Cuba tulis kod **sendiri** dahulu berdasarkan penerangan dalam README sebelum tengok fail rujukan. Belajar Flutter/Dart paling berkesan dengan **taip kod sendiri**, bukan salin-tampal.

---

## Senarai Semak Persediaan (Setup Checklist)

Sebelum mula Latihan 0, pastikan semua berikut sudah **✓** (rujuk [`nota/04-setup-windows.md`](../../nota/04-setup-windows.md) jika belum):

- [ ] `flutter --version` berjaya dijalankan dalam terminal
- [ ] `dart --version` berjaya dijalankan dalam terminal
- [ ] `flutter doctor` — tiada tanda `[✗]` kritikal (Android toolchain & VS Code sekurangnya `[✓]`)
- [ ] VS Code dipasang dengan sambungan **Flutter** (dan **Dart** — dipasang automatik sekali)
- [ ] Emulator Android boleh dimulakan **ATAU** telefon sebenar disambung dengan USB debugging aktif
- [ ] `flutter devices` menyenaraikan sekurang-kurangnya satu peranti
- [ ] Projek `ett_mobile` (dicipta semasa Persediaan) berjaya `flutter run`

Jika ada yang belum ✓, rujuk semula **Bahagian "Persediaan"** dalam `README.md` sebelum teruskan.

---

## Latihan 0 — Orientasi (DartPad & Projek)

**Objektif:** Kenal pasti alatan yang akan digunakan sepanjang hari, sebelum menulis kod sendiri.

1. Buka [dartpad.dev](https://dartpad.dev) dalam pelayar — ini alat yang akan kita guna untuk **separuh pagi** (bahagian Dart tulen, sebelum masuk widget).
2. Dalam DartPad, tampal kod ringkas berikut dan tekan **Run**:

   ```dart
   void main() {
     print('DartPad sedia digunakan!');
   }
   ```

3. Buka folder projek `projek/ett_mobile/` (projek **rujukan penuh**, hasil akhir 5 hari) dalam VS Code — jangan edit fail ini, ia untuk **rujukan/banding** sahaja.
4. Buka `projek/ett_mobile/lib/models/programme.dart` — cari `enum StudyLevel` dan `enum EntryCategory`. Kita akan tulis versi **sama konsep** fail ini sendiri hari ini (bukan salin terus).
5. Buka `projek/ett_mobile/lib/data/sample_programmes.dart` — kira berapa banyak program tersenarai. (Jawapan: 8.)

> **Soalan renungan:** Kenapa kita mula dengan Dart **tanpa** Flutter dahulu pagi ini, sebelum sentuh widget? (Jawapan: Flutter **dibina di atas** Dart — setiap widget cuma `class` Dart. Kalau asas Dart lemah, kod Flutter jadi sukar difahami.)

✅ **Semakan:** DartPad berjaya jalankan kod ringkas, dan anda sudah kenal pasti lokasi `programme.dart` & `sample_programmes.dart` dalam projek rujukan.

---

## Latihan 1 — Operators & Control Flow (`if`/`else`, `switch`)

**Objektif:** Tulis dan jalankan kod Dart tulen menggunakan operator dan aliran kawalan bersyarat.

Boleh guna **DartPad** ATAU cipta fail `.dart` tempatan dan jalankan dengan `dart run`.

1. Tulis pembolehubah `const` untuk kuota dua program Universiti Al-Azhar: `kuotaEtt001 = 40` (Perubatan), `kuotaEtt003 = 80` (Ulum Islamiah). Guna operator `+` untuk jumlahkan kedua-duanya, dan `>` untuk bandingkan mana lebih besar.
2. Tulis pembolehubah `kosFarmasiSetahun = 36000.0` (RM, ETT-004 — Farmasi Universiti Alexandria, ilustrasi) dan `tempohPengajianTahun = 5`. Guna operator `*` untuk kira `anggaranKosKeseluruhan`. Guna operator `<=` untuk semak jika ia dalam bajet `200000`, gabungkan dengan `&&` bersama satu syarat `bool` lain (cth. `sijilLengkap`).
3. Tulis blok `if`/`else if`/`else` yang menyemak pembolehubah `String keperluanProgram` (nilai `'spm'`, `'stam'`, atau `'both'`) berbanding `String sijilPemohon`, dan cetak mesej berbeza untuk setiap kes — **plus** satu `else` untuk kes tidak layak.
4. Tulis function `String countryLabelForUniversity(String universityName)` menggunakan `switch` **statement** (bukan expression) yang memetakan **enam** universiti eTT (rujuk jadual 8 program dalam `projek/ett_mobile/lib/data/sample_programmes.dart`) kepada label negara `'Mesir'` atau `'Maghribi'`, dengan satu `default:` untuk universiti tidak dikenali. Sertakan **sekurang-kurangnya empat** `case` "jatuh melalui" (fall-through) ke `return` yang sama (cth. `'Universiti Al-Azhar'`, `'Universiti Alexandria'`, `'Universiti Ain Shams'`, `'Universiti Tanta'` kesemuanya → `'Mesir'`).
5. Panggil `countryLabelForUniversity(...)` dengan **lima** nama universiti (termasuk satu yang **tiada** dalam senarai anda, untuk uji `default:`) dan `print()` hasilnya.

✅ **Semakan:** Kod anda jalan tanpa ralat, dan `switch` anda betul kembalikan `default:` untuk universiti yang tiada `case` sepadan. Banding pendekatan anda dengan bahagian **"Control Flow"** dalam `README.md`.

---

## Latihan 2 — Looping (`for`, `while`) & Function

**Objektif:** Guna gelung untuk memproses koleksi data sebenar, dan bungkus logik berulang dalam function.

1. Tulis `const List<Map<String, Object>> sampleProgrammes` dengan **kesemua 8 program** eTT (`id`, `universityName`, `quotaSeats` — rujuk jadual dalam `README.md`, bahagian "Looping — `for` & Function").
2. Tulis function `int jumlahkanKuota(List<Map<String, Object>> data)` yang guna `for (final programme in data)` untuk jumlahkan semua `quotaSeats`, dan `return` jumlahnya.
3. Panggil function tersebut, `print()` jumlahnya (sepatutnya **340 tempat**).
4. Tulis gelung `for` **kedua** yang, semasa melintasi `sampleProgrammes`, cetak setiap universiti dengan format `'${nama.padRight(28)}: kuota $bilangan'` (guna `String.padRight()` untuk jajaran kemas).
5. Tulis gelung `while` yang melintasi senarai `['Perubatan (Medicine)', 'Farmasi (Pharmacy)', 'Pergigian (Dentistry)']` dan cetak `'Bidang popular #<nombor>: <bidang>'` — **pastikan** anda tambah pengira (`i++`) supaya gelung tamat (elak *infinite loop*).

✅ **Semakan:** Jumlah kuota anda **mesti** 340 tempat. Jika tidak, semak semula data yang anda taip. Banding dengan fungsi `loopingAndFunctionDemo()` dan `whileDemo()` dalam [`dart_asas.dart`](./dart_asas.dart).

---

## 🧭 Sebelum Latihan 3 — Fail Permulaan Anda

Latihan 1–2 tadi Dart tulen (DartPad). Mulai **Latihan 3**, kita masuk Flutter dan bekerja dalam **satu fail**: `lib/main.dart` projek anda.

**Buka `lib/main.dart`, padam semua isinya, dan tampal kod permulaan ini.** Inilah "kanvas kosong" kita — setiap latihan seterusnya hanya **menambah** pada fail yang sama.

```dart
// lib/main.dart  —  FAIL PERMULAAN LAB HARI 1
import 'package:flutter/material.dart';

void main() {
  runApp(const LabHari1App());
}

class LabHari1App extends StatelessWidget {
  const LabHari1App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lab Hari 1',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Lab Hari 1 — eTT Mobile'),
          backgroundColor: const Color(0xFF1A2B5C),
          foregroundColor: Colors.white,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // ╔════════════════════════════════════════════╗
              // ║  KAWASAN KERJA ANDA                        ║
              // ║  Semua widget Latihan 3 masuk DI SINI      ║
              // ╚════════════════════════════════════════════╝
            ],
          ),
        ),
      ),
    );
  }
}
```

Jalankan `flutter run`. Anda sepatutnya nampak **AppBar navy** dengan skrin kosong di bawahnya. Kalau itu yang keluar — anda sedia.

> **Cara baca kod dalam lab ini:** blok kod menunjukkan **sekeping fail sebenar**, bukan baris terpencil. Baris `// ...` bermaksud "kod sedia ada, jangan ubah". Kotak `╔═╗` atau komen `👈 TAMBAH DI SINI` menunjukkan **tempat tepat** anda menaip kod baharu.

---

## Latihan 3 — Widget Asas: `Text`, `Icon`, `Image`

**Objektif:** Beralih dari Dart tulen ke Flutter — bina paparan pertama anda daripada tiga widget paling asas, satu demi satu.

### 3.1 — Widget pertama: `Text`

Ganti kotak "KAWASAN KERJA ANDA" dengan satu `Text`:

```dart
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // ── 3.1 — Text ────────────────────────────────
              const Text(
                'Universiti Al-Azhar',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),

              // 👈 3.2 — TAMBAH Icon SELEPAS BARIS INI
            ],
          ),
```

Tekan **Hot Reload** (`r` dalam terminal, atau simpan fail dalam VS Code). Teks tebal patut muncul di tengah skrin.

### 3.2 — Tambah `Icon`

Ganti komen `👈 3.2` dengan `SizedBox` (jarak) + `Icon`:

```dart
              // ── 3.1 — Text ────────────────────────────────
              const Text(
                'Universiti Al-Azhar',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),

              // ── 3.2 — Icon ────────────────────────────────
              const SizedBox(height: 12),
              const Icon(
                Icons.school,
                size: 40,
                color: Color(0xFF1A2B5C),
              ),

              // 👈 3.3 — TAMBAH Image / emoji SELEPAS BARIS INI
```

Hot Reload. Ikon topi graduasi navy patut muncul di bawah teks.

> Cuba tukar `Icons.school` kepada `Icons.flag`, `Icons.location_city`, atau `Icons.menu_book` — semuanya terbina dalam Flutter, tiada fail perlu dimuat turun.

### 3.3 — Tambah imej (dua cara)

Ganti komen `👈 3.3`. **Cara A — emoji bendera** (paling selamat, tiada internet perlu):

```dart
              // ── 3.3 — Imej: emoji bendera ─────────────────
              const SizedBox(height: 12),
              const Text('🇪🇬', style: TextStyle(fontSize: 48)),
```

**Cara B — `Image.network`** (perlu internet). Tambah selepas emoji tadi:

```dart
              // ── 3.3b — Imej dari internet ─────────────────
              const SizedBox(height: 12),
              Image.network(
                'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg',
                height: 120,
              ),
```

> Kalau tiada internet semasa kelas, **langkau Cara B** — emoji sudah memadai untuk latihan ini.

### 3.4 — Fail penuh selepas Latihan 3

Banding fail anda dengan ini. Kalau sama (atau lebih baik), Latihan 3 selesai:

```dart
import 'package:flutter/material.dart';

void main() {
  runApp(const LabHari1App());
}

class LabHari1App extends StatelessWidget {
  const LabHari1App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lab Hari 1',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Lab Hari 1 — eTT Mobile'),
          backgroundColor: const Color(0xFF1A2B5C),
          foregroundColor: Colors.white,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Universiti Al-Azhar',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              const Icon(Icons.school, size: 40, color: Color(0xFF1A2B5C)),
              const SizedBox(height: 12),
              const Text('🇪🇬', style: TextStyle(fontSize: 48)),
            ],
          ),
        ),
      ),
    );
  }
}
```

✅ **Semakan:** Ketiga-tiga widget (teks, ikon, emoji/imej) kelihatan bersusun menegak di tengah skrin, tiada skrin merah. Kalau skrin merah keluar — baca **baris pertama** mesej ralat; selalunya koma (`,`) atau kurungan (`)`) tertinggal.

---

## Latihan 4 — `Container`, `Padding`, `Margin`, `SizedBox`: Kad Info Program

**Objektif:** Bina **secara manual** satu kad maklumat program eTT — pendahulu kepada `ProgrammeCard` sebenar yang kita guna mulai Hari 2. Data: **ETT-001, Universiti Al-Azhar, Perubatan**.

Kali ini kita **ganti** isi `Column` Latihan 3 dengan satu `Container`. Kekalkan rangka `MaterialApp`/`Scaffold` yang sama.

### 4.1 — Rangka `Container` kosong

Ganti **semua** `children: [...]` Latihan 3 dengan:

```dart
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // ── 4.1 — Rangka kad ──────────────────────────
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                padding: const EdgeInsets.all(16),
                // 👈 4.2 — TAMBAH decoration SELEPAS BARIS INI
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // ╔══════════════════════════════════════╗
                    // ║  4.3 — Isi kad masuk DI SINI         ║
                    // ╚══════════════════════════════════════╝
                  ],
                ),
              ),
            ],
          ),
        ),
```

Hot Reload — buat masa ini kad masih **tidak kelihatan** kerana belum ada warna/sempadan. Itu normal.

### 4.2 — Beri rupa: `decoration`

Ganti komen `👈 4.2` dengan:

```dart
                padding: const EdgeInsets.all(16),

                // ── 4.2 — Rupa kad ────────────────────────────
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: Colors.grey.shade300),
                ),

                child: Column(
```

Hot Reload — sekarang kotak putih bersudut bulat dengan sempadan kelabu nipis patut kelihatan.

### 4.3 — Isi kad (guna `SizedBox` sebagai jarak)

Ganti kotak `╔ 4.3 ╗` dengan lima baris maklumat. Perhatikan: kita guna **`SizedBox(height: …)`** antara baris, **bukan** `Padding` berasingan setiap kali — lebih ringkas dan itulah amalan biasa dalam `Column`:

```dart
                  children: [
                    // ── 4.3 — Isi kad ─────────────────────────
                    const Text(
                      '🇪🇬  Universiti Al-Azhar',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1A2B5C),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Kaherah (Cairo), Mesir',
                      style: TextStyle(color: Colors.grey.shade600),
                    ),
                    const SizedBox(height: 12),
                    const Text('Bidang: Perubatan (Medicine)'),
                    const SizedBox(height: 4),
                    const Text('Anggaran yuran: RM23,000/tahun'),
                    const SizedBox(height: 4),
                    const Text('Kuota: 40 tempat  ·  Pengambilan: September'),
                  ],
```

### 4.4 — Eksperimen: `margin` lawan `padding`

Ini bahagian paling penting Latihan 4 — **lakukan, jangan hanya baca**:

| Cuba tukar | Perhatikan apa jadi | Kesimpulan |
|---|---|---|
| `margin: EdgeInsets.zero` | Kad melekat ke tepi skrin | `margin` = jarak **LUAR** kad |
| `padding: EdgeInsets.zero` | Teks melekat ke sempadan kad | `padding` = jarak **DALAM** kad |
| `padding: const EdgeInsets.all(40)` | Kad membesar, teks jauh ke tengah | `padding` tolak kandungan ke dalam |

Kembalikan nilai asal (`margin` 16/8, `padding` 16) selepas mencuba ketiga-tiganya.

### 4.5 — Asingkan jadi widget sendiri

Kad ini akan makin panjang. Mari asingkan ia jadi widget berasingan — corak yang sama kita guna sepanjang kursus.

Tambah kelas baharu **di bawah sekali fail** (selepas `class LabHari1App { ... }` tutup):

```dart
// ── 4.5 — Kad sebagai widget sendiri ──────────────────
class ProgrammeInfoCard extends StatelessWidget {
  const ProgrammeInfoCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            '🇪🇬  Universiti Al-Azhar',
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1A2B5C),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Kaherah (Cairo), Mesir',
            style: TextStyle(color: Colors.grey.shade600),
          ),
          const SizedBox(height: 12),
          const Text('Bidang: Perubatan (Medicine)'),
          const SizedBox(height: 4),
          const Text('Anggaran yuran: RM23,000/tahun'),
          const SizedBox(height: 4),
          const Text('Kuota: 40 tempat  ·  Pengambilan: September'),
        ],
      ),
    );
  }
}
```

Kemudian **ringkaskan** `body:` supaya hanya memanggil widget itu:

```dart
        body: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ProgrammeInfoCard(),   // ← seluruh kad, satu baris

              // 👈 Cabaran #3: tambah kad kedua di sini
            ],
          ),
        ),
```

Perhatikan betapa `body:` jadi jauh lebih mudah dibaca. **Itulah sebabnya kita pecahkan widget** — idea yang kita dalami semula pada Hari 5 (*refactoring*).

> Kalau susun atur mula jadi leceh, ini masa yang baik untuk minta bantuan AI:
> ```text
> Saya ada Container kad dalam Flutter dengan Column 5 baris Text.
> Tunjukkan cara susun tajuk universiti dan yuran pada baris yang SAMA,
> tajuk di kiri dan yuran di kanan. Guna widget layout asas sahaja.
> ```
> Semak jawapannya — ia mungkin cadang `Row` + `Expanded` (itu topik Hari 2, jadi bagus kalau anda nampak dulu). Jalankan `flutter analyze` sebelum terima.

✅ **Semakan:** Kad putih kemas dengan lima baris maklumat, jarak sekata, dan `body:` anda kini hanya memanggil `ProgrammeInfoCard()`. Banding dengan `README.md` bahagian "Latihan Bengkel: Kad Info Program (Statik)", dan dengan `projek/ett_mobile/lib/widgets/programme_card.dart` (versi Hari 2 — lebih maju: data dinamik + `Card`).

---

## Latihan 5 — StatelessWidget vs StatefulWidget: Kaunter "Simpan Program"

**Objektif:** Rasa sendiri **kenapa** `StatefulWidget` + `setState()` wujud. `ProgrammeInfoCard` tadi *stateless* — ia tak pernah berubah. Sekarang kita bina sesuatu yang **berubah bila ditekan**.

### 5.1 — Rangka `StatefulWidget`

Tambah **di bawah sekali fail** (selepas `ProgrammeInfoCard`). Rangka ini sentiasa sama — dua kelas berpasangan:

```dart
// ── 5.1 — Rangka StatefulWidget ───────────────────────
class SavedProgrammeCounter extends StatefulWidget {
  const SavedProgrammeCounter({super.key});

  @override
  State<SavedProgrammeCounter> createState() => _SavedProgrammeCounterState();
}

class _SavedProgrammeCounterState extends State<SavedProgrammeCounter> {
  // ╔══════════════════════════════════════════════════╗
  // ║  5.2 — State (data yang berubah) masuk DI SINI   ║
  // ╚══════════════════════════════════════════════════╝

  // ╔══════════════════════════════════════════════════╗
  // ║  5.3 — Kaedah pengubah state masuk DI SINI       ║
  // ╚══════════════════════════════════════════════════╝

  @override
  Widget build(BuildContext context) {
    // 👈 5.4 — Ganti baris di bawah dengan UI sebenar
    return const SizedBox.shrink();
  }
}
```

> Nama kelas `State` bermula dengan `_` (garis bawah) — dalam Dart itu bermakna **peribadi kepada fail ini**. Ia konvensyen standard Flutter.

### 5.2 — Tambah state

Ganti kotak `╔ 5.2 ╗`:

```dart
  // ── 5.2 — State ───────────────────────────────────
  int _savedCount = 0;
```

### 5.3 — Tambah kaedah pengubah

Ganti kotak `╔ 5.3 ╗`. **Inilah baris paling penting hari ini** — `setState()` memberitahu Flutter "data berubah, sila lukis semula":

```dart
  // ── 5.3 — Kaedah pengubah state ───────────────────
  void _addProgramme() {
    setState(() {
      _savedCount++;
    });
  }
```

### 5.4 — Bina UI

Ganti `return const SizedBox.shrink();` dengan:

```dart
  @override
  Widget build(BuildContext context) {
    // ── 5.4 — UI ────────────────────────────────────
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'Program disimpan: $_savedCount',
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        ElevatedButton(
          onPressed: _addProgramme,
          child: const Text('+ Simpan Program'),
        ),
      ],
    );
  }
```

### 5.5 — Pasang ke skrin

Kembali ke `body:` dan tambah kaunter di bawah kad:

```dart
        body: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ProgrammeInfoCard(),

              // ── 5.5 — Pasang kaunter ──────────────────
              SizedBox(height: 24),
              SavedProgrammeCounter(),
            ],
          ),
        ),
```

Jalankan (`flutter run`), **tekan butang 5–6 kali**. Angka patut naik setiap tekan, tanpa *restart*.

### 5.6 — Eksperimen: buang `setState()`

Ini eksperimen yang membuat konsep "melekat". **Sementara**, tukar `_addProgramme()` supaya menambah nilai **tanpa** `setState`:

```dart
  void _addProgramme() {
    // EKSPERIMEN — sengaja SALAH, kita kembalikan selepas ini
    _savedCount++;
  }
```

Hot Reload dan tekan butang beberapa kali. **Perhatikan: angka pada skrin langsung tak berubah** — walaupun `_savedCount` sebenarnya sudah bertambah dalam ingatan. Untuk buktikan, tambah `print('_savedCount = $_savedCount');` selepas `_savedCount++;` dan tengok terminal: nombor naik, skrin tidak.

**Kesimpulan:** menukar data **tidak** cukup. Flutter hanya melukis semula bila anda beritahu ia melalui `setState()`.

Kembalikan `setState(...)` sekarang:

```dart
  void _addProgramme() {
    setState(() {
      _savedCount++;
    });
  }
```

✅ **Semakan akhir:**
- Kaunter naik setiap tekan — **hanya** bila `setState()` digunakan.
- Anda boleh terangkan beza `ProgrammeInfoCard` (`StatelessWidget` — statik) dan `SavedProgrammeCounter` (`StatefulWidget` — berubah ikut interaksi).
- `flutter analyze` bersih (tiada ralat).

> **Nota:** Ini **baru pengenalan**. Kitaran hayat penuh `StatefulWidget` (`createState()` → `initState()` → `build()` → `dispose()`) dan `setState()` dalam borang permohonan sebenar ialah **SESI 5, Hari 3** — jangan risau kalau belum faham setiap bahagian `State`.

---

## Cabaran

Pilih **sekurang-kurangnya satu** untuk cuba selepas Latihan 5 siap:

1. **Function format & tukar kos** — Tulis `String formatCostMyr(double amount)` yang format nombor dengan pemisah ribuan (cth. `23000.0` → `'RM23,000'`), dan `double convertUsdToMyrEstimate(double usd)` menggunakan kadar tukaran **anggaran** `4.6` (diselaras kasar dengan jadual USD rasmi 2021/22 — **bukan** kadar semasa/rasmi). Panggil `formatCostMyr` untuk **semua 8 program** dalam `sampleProgrammes`, dan panggil `convertUsdToMyrEstimate` untuk anggaran Perubatan Al-Azhar (~USD5,000) dan Farmasi (~USD8,000). Banding jawapan anda dengan `costFormattingDemo()` dalam [`dart_asas.dart`](./dart_asas.dart).
2. **Enum dengan getter** — Tulis semula `enum StudyLevel` (3 nilai: `foundation`, `diploma`, `bachelor`) dan `enum EntryCategory` (3 nilai: `spm`, `stam`, `both`), setiap satu dengan getter `label` (guna `switch` expression Dart 3) memulangkan label Bahasa Melayu. Tambah kaedah `bool accepts(EntryCategory applicant)` pada `EntryCategory` yang memulangkan `true` jika `this == both || this == applicant`. Cetak label **semua** nilai `StudyLevel.values` dalam satu gelung `for`, dan uji `accepts()` dengan beberapa kombinasi.
3. **Kad kedua** — Ulang Latihan 4 untuk **satu lagi** program (cth. ETT-007 — Universite Al Quaraouiyine, Fes, Maghribi, bidang Usuluddin, anggaran yuran RM6,000/tahun, kuota **15 tempat** — angka rasmi). Susun **kedua-dua** kad dalam satu `Column` supaya kelihatan berturutan pada skrin.
4. **Kaunter dua arah** — Tambah **dua** butang pada `SavedProgrammeCounter`: satu `+` (tambah) dan satu `-` (tolak), dengan syarat `_savedCount` **tidak boleh** jadi negatif (guna `if (_savedCount > 0)` sebelum tolak dalam `setState()`).
5. **Switch kategori kuota** — Tulis function `String kategoriKuota(int bilangan)` yang guna `switch` **expression** dengan corak julat (*pattern* + `when` guard, Dart 3) atau rantaian `if/else` untuk pulangkan `'Besar'` (≥100), `'Sederhana'` (≥30), atau `'Kecil'` (<30) berdasarkan `quotaSeats` — panggil untuk semua 8 program dalam `sampleProgrammes`.

> Tiada jawapan "betul" tunggal untuk Cabaran — matlamatnya berlatih gabungkan konsep yang sudah dipelajari. Tunjukkan hasil kepada fasilitator/rakan sekelas sebelum tamat kelas.

---

## Rujukan Fail Sebenar

Untuk banding kod anda, fail rujukan lengkap (hasil akhir 5 hari) ada di:

| Fail anda (lab) | Fail rujukan (projek sebenar) |
|------------------|-------------------------------|
| Dart operators/control flow/loops (Latihan 1–2) | [`dart_asas.dart`](./dart_asas.dart) — boleh jalan terus (`dart run snippets/dart_asas.dart`) |
| Widget `Text`/`Icon`/`Image` (Latihan 3) | `projek/ett_mobile/lib/widgets/programme_card.dart` (bahagian atas) |
| `enum StudyLevel`/`EntryCategory` (Cabaran #2) | `projek/ett_mobile/lib/models/programme.dart` |
| Kad info program (Latihan 4) | `projek/ett_mobile/lib/widgets/programme_card.dart` (versi Hari 2 — lebih maju) |
| Kaunter Stateful (Latihan 5) | *(tiada padanan terus — teaser konsep sahaja; `setState()` penuh di SESI 5, Hari 3)* |
| Data 8 program eTT | `projek/ett_mobile/lib/data/sample_programmes.dart` (lihat juga jadual dalam `README.md`) |

> Lihat juga [`dart_asas.dart`](./dart_asas.dart) untuk contoh Dart penuh yang boleh dijalankan terus (`dart run snippets/dart_asas.dart`) — berguna untuk berlatih sintaks Dart di luar konteks widget Flutter.
