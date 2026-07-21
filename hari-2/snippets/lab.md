# Lab Hari 2 — Layout, Senarai Dinamik & Styling

Lab ini menyambung terus daripada projek `ett_mobile` yang anda bina Hari 1. Ikut latihan **secara berurutan** — setiap latihan bina di atas latihan sebelumnya, sama seperti semalam. Rujuk projek akhir sebenar di `projek/ett_mobile/lib/` untuk **banding** jawapan anda selepas cuba sendiri dahulu.

> **Peraturan lab:** Cuba tulis kod **sendiri** dahulu berdasarkan penerangan dalam [`README.md`](../README.md) sebelum tengok fail rujukan. Belajar Flutter/Dart paling berkesan dengan **taip kod sendiri**, bukan salin-tampal.

> **Cara baca kod dalam lab ini (sama seperti Hari 1):** blok kod menunjukkan **sekeping fail sebenar**, bukan baris terpencil. `// ...` bermaksud "kod sedia ada, jangan ubah". Kotak `╔═╗` atau komen `👈 TAMBAH DI SINI` menunjukkan **tempat tepat** anda menaip kod baharu.

---

## Persediaan

1. Buka semula projek `ett_mobile` daripada Hari 1 (JANGAN buat projek baharu).
2. **Salin fail permulaan (foundation).** Lab hari ini membina UI **di atas** data & model yang sudah siap. Salin folder [`starter/`](./starter/) ke `lib/` projek anda (rujuk [`starter/README.md`](./starter/README.md)) — jangan taip dari kosong:
   ```bash
   # dari dalam folder projek ett_mobile anda
   mkdir -p lib/models lib/data lib/widgets
   cp <laluan-repo>/hari-2/snippets/starter/theme.dart                 lib/theme.dart
   cp <laluan-repo>/hari-2/snippets/starter/models/programme.dart      lib/models/programme.dart
   cp <laluan-repo>/hari-2/snippets/starter/data/sample_programmes.dart lib/data/sample_programmes.dart
   cp <laluan-repo>/hari-2/snippets/starter/widgets/programme_card.dart lib/widgets/programme_card.dart
   ```
3. Pastikan `flutter pub get` dijalankan.
4. Jalankan aplikasi sedia ada untuk pastikan ia masih berfungsi:
   ```bash
   flutter run
   ```
5. Buka fail-fail berikut dalam editor — ini rujukan sepanjang lab:
   - `lib/main.dart` (sedia ada, Hari 1)
   - `lib/theme.dart` (fail starter — `KptTheme.navy` + `KptTheme.gold`)
   - `lib/models/programme.dart` (fail starter — kelas `Programme` + enum)
   - `lib/data/sample_programmes.dart` (fail starter — `sampleProgrammes`, 8 tawaran)
   - `lib/widgets/programme_card.dart` (fail starter — mengandungi `CategoryPill` yang akan kita guna semula)

✅ **Semakan:** `flutter analyze` bersih dan `flutter run` berjaya. `sampleProgrammes` dan `KptTheme.navy` sudah boleh digunakan.

---

## 🧭 Sebelum Latihan 1 — Fail Permulaan Anda

Fail `lib/main.dart` anda sepatutnya berakhir Hari 1 seperti ini (kalau tidak sama persis, itu tidak mengapa — asalkan `flutter run` berjaya dan anda ada `ProgrammeInfoCard` + `SavedProgrammeCounter`):

```dart
// lib/main.dart — STATUS AKHIR HARI 1 (titik permulaan Hari 2)
import 'package:flutter/material.dart';

void main() {
  runApp(const LabHari1App());
}

class LabHari1App extends StatelessWidget {
  const LabHari1App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lab Hari 1-2',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Lab eTT Mobile'),
          backgroundColor: const Color(0xFF1A2B5C),
          foregroundColor: Colors.white,
        ),
        body: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ProgrammeInfoCard(),
              SizedBox(height: 24),
              SavedProgrammeCounter(),
            ],
          ),
        ),
      ),
    );
  }
}

// ── ProgrammeInfoCard & SavedProgrammeCounter (Hari 1) ──────────
// ... (kekalkan kedua-dua class ini di bawah sekali fail, tidak
//      diubah hari ini — kita akan TUKAR body: di atas beberapa
//      kali sepanjang lab ini, tetapi class-class ini kekal wujud
//      sebagai rujukan/ujian).
```

**Hari ini kita akan tukar `body:` `Scaffold` di atas beberapa kali** — sekali bagi setiap latihan besar — dan pada penghujung lab, kita gantikan **keseluruhan** `home:` dengan skrin sebenar aplikasi (`HomeScreen`, lengkap dengan tab + drawer). `ProgrammeInfoCard`/`SavedProgrammeCounter` kekal di bawah fail sebagai rujukan Hari 1, kita cuma tidak paparkan lagi selepas Latihan 1.

### ⚠️ Langkah wajib — daftarkan tema pada `MaterialApp`

Fail starter `lib/theme.dart` memberi anda `KptTheme.light`, tetapi ia **tidak aktif** sehingga didaftarkan pada `MaterialApp`. Tanpa langkah ini, `AppBar` anda **tidak** akan bertukar navy secara automatik (Latihan 3) dan tajuk `Theme.of(context).textTheme.titleLarge` **tidak** akan jadi navy+bold (Latihan 7).

Tambah `import` dan satu baris `theme:` dalam `main.dart`:

```dart
import 'package:flutter/material.dart';
import 'theme.dart';                    // 👈 TAMBAH baris ini

// ...

    return MaterialApp(
      title: 'Lab Hari 1-2',
      debugShowCheckedModeBanner: false,
      theme: KptTheme.light,             // 👈 TAMBAH baris ini
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Lab eTT Mobile'),
          // 👈 BUANG dua baris warna di bawah — tema sudah uruskan warna
          //    backgroundColor: const Color(0xFF1A2B5C),
          //    foregroundColor: Colors.white,
        ),
```

▶ **Jalankan** (`flutter run`) → `AppBar` kekal **navy dengan teks putih**, walaupun anda sudah **membuang** `backgroundColor`/`foregroundColor`. Itu bukti tema global berfungsi — warna kini datang daripada `appBarTheme` dalam `KptTheme.light`, bukan ditulis semula pada setiap `AppBar`.

---

## Latihan 1 — `Row`, `Column` & `Expanded` (Elak Overflow)

**Objektif:** Bina baris ringkasan program yang **sengaja** overflow, lihat jalur kuning-hitam dengan mata sendiri, kemudian betulkan dengan `Expanded`.

### 1.1 — Widget yang (sengaja) rosak

Tambah kelas baharu **di bawah sekali fail** `lib/main.dart` (selepas `SavedProgrammeCounter`):

```dart
// ── 1.1 — Ringkasan program TANPA Expanded (akan overflow) ──────
class ProgrammeSummaryRow extends StatelessWidget {
  const ProgrammeSummaryRow({super.key, required this.programme});

  final Programme programme;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Text(
            programme.universityName,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),

          // 👈 1.2 — GANTI baris di bawah dengan versi Expanded selepas anda LIHAT overflow
          Text(' — ${programme.city}, ${programme.countryLabel}'),
        ],
      ),
    );
  }
}
```

Anda perlukan `import '../models/programme.dart';` — tetapi kerana kita masih dalam **satu fail** `main.dart`, tambah baris import ini di **paling atas** fail (bawah `import 'package:flutter/material.dart';`):

```dart
import 'package:flutter/material.dart';
import 'models/programme.dart';
import 'data/sample_programmes.dart';

// ...
```

### 1.2 — Uji dan LIHAT overflow

Tukar sementara `body:` `Scaffold` untuk uji widget ini dengan program bernama panjang (`sampleProgrammes[6]` = Universite Al Quaraouiyine, Fes):

```dart
        body: Center(
          child: ProgrammeSummaryRow(programme: sampleProgrammes[6]),
        ),
```

`flutter run`. **Perhatikan dengan teliti:** jalur **kuning-hitam bergaris** melekat di tepi kanan baris tersebut, dan dalam **terminal** satu mesej merah panjang bermula `A RenderFlex overflowed by NN pixels on the right.` muncul. Ini bukan ralat yang menyebabkan aplikasi *crash* — ia terus berjalan, cuma bahagian itu rosak secara visual. **Ambil masa lihat jalur ini** — ia ralat paling kerap anda akan jumpa sepanjang kursus Flutter.

### 1.3 — Betulkan dengan `Expanded`

Kembali ke `ProgrammeSummaryRow`, ganti komen `👈 1.2`:

```dart
      child: Row(
        children: [
          Expanded(
            child: Text(
              programme.universityName,
              style: const TextStyle(fontWeight: FontWeight.bold),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Text(' — ${programme.city}, ${programme.countryLabel}'),
        ],
      ),
```

Hot Reload. Jalur kuning-hitam **hilang**. Nama universiti panjang kini dipotong dengan `…` jika perlu, dan bahagian bandar/negara di kanan kekal **penuh** kelihatan.

### 1.4 — Eksperimen: `MainAxisAlignment`

Ini eksperimen yang membuat konsep "paksi" melekat. Dalam `body:`, uji `ProgrammeSummaryRow` dengan program **pendek** (`sampleProgrammes[3]`, Universiti Alexandria) supaya ada ruang kosong untuk dilihat kesannya, kemudian ubah `mainAxisAlignment` pada `Row` dalam `ProgrammeSummaryRow` satu demi satu:

| `mainAxisAlignment` dicuba | Apa yang berlaku pada skrin | Kesimpulan |
|---|---|---|
| (tiada — lalai `start`) | Kedua-dua teks melekat rapat di kiri | Lalai `Row` mengumpul semua anak di **permulaan** paksi utama |
| `MainAxisAlignment.spaceBetween` | Teks pertama kekal kiri, teks kedua tertolak ke **hujung kanan** skrin | `spaceBetween` letak jarak sama besar **antara** anak, bukan di tepi luar |
| `MainAxisAlignment.center` | Kedua-dua teks bersama-sama bergerak ke **tengah** skrin | `center` mengumpul semua anak di tengah paksi utama, sebagai satu kumpulan |

Kembalikan `mainAxisAlignment` (buang parameter itu, guna lalai) selepas mencuba ketiga-tiganya, dan pulangkan `body:` semula kepada `Center(child: Column(...))` Latihan 0 (kad + kaunter Hari 1) buat sementara — kita akan uji Latihan 2 secara berasingan.

✅ **Semakan Latihan 1:** Anda dapat terangkan **sebab** jalur kuning-hitam muncul (jumlah lebar anak `Row` > lebar skrin), dan **cara** `Expanded` + `overflow: TextOverflow.ellipsis` membetulkannya. Banding dengan README Bahagian 2.

---

## Latihan 2 — `Stack` & `Positioned`: Banner Program

**Objektif:** Bina `ProgrammeBanner` — banner navy dengan universiti & bidang di bawah kiri, dan pill kategori kemasukan (SPM/STAM) ditindan di sudut kanan atas.

### 2.1 — Cipta fail baharu, rangka `Stack`

Cipta `lib/widgets/programme_banner.dart`:

```dart
// lib/widgets/programme_banner.dart
import 'package:flutter/material.dart';

import '../models/programme.dart';
import '../theme.dart';
import 'programme_card.dart'; // guna semula CategoryPill

class ProgrammeBanner extends StatelessWidget {
  const ProgrammeBanner({super.key, required this.programme});

  final Programme programme;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // ── 2.1 — Lapisan bawah: kotak navy + bendera di tengah ──
        Container(
          height: 160,
          width: double.infinity,
          decoration: BoxDecoration(
            color: KptTheme.navy,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Center(
            child: Text(
              programme.flagEmoji,
              style: const TextStyle(fontSize: 56),
            ),
          ),
        ),

        // ╔═══════════════════════════════════════════════════╗
        // ║  2.2 — Positioned nama universiti masuk DI SINI   ║
        // ╚═══════════════════════════════════════════════════╝

        // ╔═══════════════════════════════════════════════════╗
        // ║  2.3 — Positioned pill kategori masuk DI SINI     ║
        // ╚═══════════════════════════════════════════════════╝
      ],
    );
  }
}
```

Uji sementara di `main.dart` (lihat cara ujian di bawah). **Buat masa ini** anda sepatutnya nampak **satu** kotak navy bersudut bulat dengan bendera besar di tengah — tiada apa lagi.

> **Cara uji widget baharu tanpa `Navigator` (kita belum belajar itu — Hari 3):** tukar sementara `home:` dalam `main.dart` kepada widget yang mahu diuji, contohnya:
> ```dart
> home: Scaffold(
>   appBar: AppBar(title: const Text('Ujian Widget')),
>   body: Padding(
>     padding: const EdgeInsets.all(16),
>     child: ProgrammeBanner(programme: sampleProgrammes.first),
>   ),
> ),
> ```
> Jangan lupa **pulangkan** struktur asal selepas selesai menguji setiap latihan — kita akan gantikan `home:` secara **kekal** dengan `HomeScreen` di Latihan 5.

### 2.2 — Tambah nama universiti (Positioned bawah-kiri)

Ganti kotak `╔ 2.2 ╗`:

```dart
        // ── 2.2 — Universiti & bidang, dilabuhkan bawah-kiri ──
        Positioned(
          left: 16,
          bottom: 14,
          child: Text(
            '${programme.universityName}\n${programme.fieldOfStudy}',
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
```

Hot Reload. Nama universiti & bidang (dua baris, kesan `\n`) kini muncul **ditindan** di atas kotak navy, di sudut kiri bawah.

### 2.3 — Tambah pill kategori (Positioned kanan-atas)

Ganti kotak `╔ 2.3 ╗`:

```dart
        // ── 2.3 — Pill kategori, ditindan di sudut kanan atas ──
        Positioned(
          top: 12,
          right: 12,
          child: CategoryPill(category: programme.category),
        ),
```

Hot Reload. Sekarang **tiga** lapisan kelihatan bertindan: kotak navy (bawah), teks universiti (kiri bawah), dan pill kategori emas kecil (kanan atas) — semuanya berkongsi ruang skrin yang **sama**, bukan tersusun berasingan seperti `Column`.

### 2.4 — Eksperimen: nilai `Positioned`

| Cuba tukar | Perhatikan apa jadi | Kesimpulan |
|---|---|---|
| `top: 12, right: 12` → `top: 0, right: 0` | Pill melekat **tepat** di sudut kotak, tiada jarak nafas | `Positioned` = jarak **mutlak** dari sempadan `Stack`, bukan dari kandungan lain |
| `right: 12` → `left: 12` (pill kategori) | Pill berpindah ke sudut **kiri** atas, mungkin bertindih nama universiti kalau kad kecil | Anda kawal **sudut mana** widget itu berlabuh — gabungan `top`/`bottom` + `left`/`right` |
| Uji `sampleProgrammes[1]` (STAM) vs `sampleProgrammes[0]` (SPM) | Teks dalam pill bertukar `STAM` ↔ `SPM` | `CategoryPill` **membaca** `programme.category` — ia bukan teks tetap |

### 2.5 — Fail penuh selepas Latihan 2

```dart
// lib/widgets/programme_banner.dart
import 'package:flutter/material.dart';

import '../models/programme.dart';
import '../theme.dart';
import 'programme_card.dart';

class ProgrammeBanner extends StatelessWidget {
  const ProgrammeBanner({super.key, required this.programme});

  final Programme programme;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 160,
          width: double.infinity,
          decoration: BoxDecoration(
            color: KptTheme.navy,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Center(
            child: Text(
              programme.flagEmoji,
              style: const TextStyle(fontSize: 56),
            ),
          ),
        ),
        Positioned(
          left: 16,
          bottom: 14,
          child: Text(
            '${programme.universityName}\n${programme.fieldOfStudy}',
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
        Positioned(
          top: 12,
          right: 12,
          child: CategoryPill(category: programme.category),
        ),
      ],
    );
  }
}
```

✅ **Semakan Latihan 2:** Pill kategori kekal **di dalam** sempadan banner (tidak terpotong tepi), label pill bertukar ikut `category`, dan anda boleh terangkan beza `Positioned` (mutlak dari sempadan `Stack`) berbanding kalau ia sekadar `Column` anak biasa.

---

## Latihan 3 — Rangka `Scaffold` + `AppBar`

**Objektif:** Bina skrin ujian sebenar (bukan sekadar tukar `home:` sementara) menggunakan `Scaffold` + `AppBar`, memaparkan **semua 8** `ProgrammeBanner` boleh diskrol.

### 3.1 — Cipta skrin

Cipta `lib/screens/layout_playground_screen.dart`:

```dart
// lib/screens/layout_playground_screen.dart
import 'package:flutter/material.dart';

import '../data/sample_programmes.dart';
import '../widgets/programme_banner.dart';

class LayoutPlaygroundScreen extends StatelessWidget {
  const LayoutPlaygroundScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Playground Layout')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // ╔═══════════════════════════════════════════════╗
          // ║  3.2 — Senarai banner masuk DI SINI           ║
          // ╚═══════════════════════════════════════════════╝
        ],
      ),
    );
  }
}
```

### 3.2 — Jana satu banner bagi setiap program

Ganti kotak `╔ 3.2 ╗`:

```dart
          // ── 3.2 — Satu ProgrammeBanner bagi setiap program ──
          for (final p in sampleProgrammes)
            Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: ProgrammeBanner(programme: p),
            ),
```

Tukar `home:` dalam `main.dart` kepada `const LayoutPlaygroundScreen()` dan `flutter run`. Anda patut nampak **8 banner** boleh diskrol, satu bagi setiap tawaran pengajian — dan `AppBar` "Playground Layout" automatik berwarna **navy** dengan teks **putih**, walaupun anda **tidak** tetapkan warna secara eksplisit pada `AppBar()` itu.

✅ **Semakan Latihan 3:** 8 banner kelihatan, boleh diskrol tanpa ralat overflow. Buka `lib/theme.dart`, cari baris yang menyebabkan `AppBar` automatik navy (petunjuk: `appBarTheme`) — tulis di komen ringkas kenapa anda tidak perlu set warna itu sendiri.

---

## Latihan 4 — Jana Widget Baharu dengan Bantuan AI

**Objektif:** Guna Claude Code (atau AI lain) untuk jana **satu** widget baharu — Card+ListTile untuk satu tawaran pengajian — kemudian semak & betulkan secara manual, bukan terima terus.

### 4.1 — Prompt

```text
Konteks: Projek Flutter "eTT Mobile". Tema: KptTheme.navy (0xFF1A2B5C) +
KptTheme.gold (0xFFD4A017). Model: Programme (universityName,
fieldOfStudy, city, countryLabel, intakeMonth, quotaSeats).

Tugas: Jana StatelessWidget bernama `ProgrammeIntakeTile` yang memaparkan
satu Programme sebagai Card + ListTile: leading ikon Icons.school_outlined
berwarna KptTheme.navy, title universityName, subtitle "fieldOfStudy ·
intakeMonth", trailing memaparkan quotaSeats sebagai teks kecil
(contoh "40 tempat").

Kekangan: guna widget Flutter standard sahaja. Kekalkan gaya kod konsisten
dengan projek sedia ada.
```

### 4.2 — Semak & betulkan

Salin kod yang dijana AI ke dalam fail baharu `lib/widgets/programme_intake_tile.dart`. **Senarai semak minimum sebelum guna:**

- [ ] `const` digunakan di mana boleh (constructor widget, `Icon`, `EdgeInsets`)?
- [ ] Warna dirujuk melalui `KptTheme.navy`/`KptTheme.gold`, **bukan** `Color(0xFF...)` baharu ditulis semula?
- [ ] Nama universiti panjang (`title`) berisiko *overflow*? Tambah `overflow: TextOverflow.ellipsis`.
- [ ] Tiada import pakej luar yang tidak perlu?

Versi selepas dibetulkan (rujukan — AI anda mungkin hasilkan sesuatu yang sedikit berbeza, itu normal):

```dart
// lib/widgets/programme_intake_tile.dart
import 'package:flutter/material.dart';

import '../models/programme.dart';
import '../theme.dart';

class ProgrammeIntakeTile extends StatelessWidget {
  const ProgrammeIntakeTile({super.key, required this.programme});

  final Programme programme;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: ListTile(
        leading: const Icon(Icons.school_outlined, color: KptTheme.navy),
        title: Text(
          programme.universityName,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Text('${programme.fieldOfStudy} · ${programme.intakeMonth}'),
        trailing: Text(
          '${programme.quotaSeats} tempat',
          style: const TextStyle(fontSize: 12),
        ),
      ),
    );
  }
}
```

Jalankan `flutter analyze` — mesti **"No issues found!"**. Uji dengan `for (final p in sampleProgrammes) ProgrammeIntakeTile(programme: p)` dalam `ListView`, sama corak seperti Latihan 3.

✅ **Semakan Latihan 4:** `flutter analyze` bersih, dan anda boleh tulis (di komen atas fail) **sekurang-kurangnya satu** perkara yang anda ubah daripada output asal AI.

---

## Latihan 5 — `BottomNavigationBar` + `Drawer`: `HomeScreen` Sebenar

**Objektif:** Bina rangka `HomeScreen` — skrin **kekal** aplikasi mulai sekarang — dengan 3 tab dan `Drawer` senarai negara. Ini menggantikan `home:` `main.dart` secara **kekal** buat baki kursus.

### 5.1 — Skrin placeholder dahulu

Sebelum `HomeScreen`, kita perlukan 3 skrin untuk tab (walaupun kosong buat masa ini — akan dibina penuh Hari 3–4). Cipta `lib/screens/my_applications_screen.dart`:

```dart
// lib/screens/my_applications_screen.dart
import 'package:flutter/material.dart';

class MyApplicationsScreen extends StatelessWidget {
  const MyApplicationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Permohonan Saya — dibina Hari 3'));
  }
}
```

Dan `lib/screens/profile_screen.dart`:

```dart
// lib/screens/profile_screen.dart
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Profil — dibina Hari 3'));
  }
}
```

Dan `lib/screens/programme_list_screen.dart` (versi **ringkas** hari ini — tanpa carian/tapisan, itu Hari 3–4):

```dart
// lib/screens/programme_list_screen.dart
import 'package:flutter/material.dart';

import '../data/sample_programmes.dart';
import '../widgets/programme_card.dart';

class ProgrammeListScreen extends StatelessWidget {
  const ProgrammeListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.only(top: 8, bottom: 16),
      itemCount: sampleProgrammes.length,
      itemBuilder: (context, index) {
        final p = sampleProgrammes[index];
        return ProgrammeCard(programme: p);
      },
    );
  }
}
```

### 5.2 — Rangka `HomeScreen` (tab dahulu, drawer kemudian)

Cipta `lib/screens/home_screen.dart`:

```dart
// lib/screens/home_screen.dart
import 'package:flutter/material.dart';

import '../theme.dart';
import 'my_applications_screen.dart';
import 'profile_screen.dart';
import 'programme_list_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _index = 0;

  static const _titles = ['Program', 'Permohonan Saya', 'Profil'];
  static const _screens = [
    ProgrammeListScreen(),
    MyApplicationsScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('eTT Mobile · ${_titles[_index]}')),
      body: _screens[_index],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _index,
        onTap: (i) => setState(() => _index = i),
        type: BottomNavigationBarType.fixed,
        selectedItemColor: KptTheme.navy,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.school_outlined), label: 'Program'),
          BottomNavigationBarItem(icon: Icon(Icons.assignment_outlined), label: 'Permohonan Saya'),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: 'Profil'),
        ],
      ),

      // 👈 5.3 — TAMBAH drawer: SELEPAS bottomNavigationBar
    );
  }
}
```

Tukar `home:` `main.dart` kepada `const HomeScreen()` (import `screens/home_screen.dart`). Mulai sekarang `main.dart` menjadi ringkas — `HomeScreen` yang uruskan skrin:

```dart
// lib/main.dart — STATUS AKHIR HARI 2
import 'package:flutter/material.dart';

import 'screens/home_screen.dart';
import 'theme.dart';

void main() {
  runApp(const EttMobileApp());
}

class EttMobileApp extends StatelessWidget {
  const EttMobileApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'eTT Mobile',
      debugShowCheckedModeBanner: false,
      theme: KptTheme.light,      // tema navy + emas
      home: const HomeScreen(),   // skrin kekal aplikasi
    );
  }
}
```

> `ProgrammeInfoCard`, `SavedProgrammeCounter` dan `ProgrammeSummaryRow` (Hari 1 + Latihan 1) sudah tidak dipaparkan lagi. Anda boleh **biarkan** class-class itu di bawah fail sebagai rujukan, atau **buang** supaya `main.dart` bersih — kedua-duanya OK.

▶ **Jalankan** (`flutter run`, atau tekan **`R`** besar untuk Hot **Restart** kerana nama kelas root bertukar) → tekan setiap tab bawah: `AppBar` title dan `body` bertukar mengikut tab aktif, ikon tab aktif bertukar warna navy.

### 5.3 — Tambah `Drawer` negara

Ganti komen `👈 5.3` dalam `Scaffold` (tambah parameter `drawer:` — **sejajar** dengan `appBar:`/`body:`/`bottomNavigationBar:`, bukan bersarang di dalamnya):

```dart
      appBar: AppBar(title: Text('eTT Mobile · ${_titles[_index]}')),
      drawer: _CountryDrawer(onSelect: _selectCountry),
      body: _screens[_index],
```

Tambah kaedah `_selectCountry` di dalam `_HomeScreenState` (atas `build()`):

```dart
  void _selectCountry(String? country) {
    // Hari 3 ke atas: hubung dengan ProgrammeProvider untuk tapis sebenar.
    Navigator.of(context).pop(); // tutup Drawer
  }
```

Dan tambah `_CountryOption` + `_CountryDrawer` **di bawah sekali fail** (selepas `_HomeScreenState` tutup):

```dart
class _CountryOption {
  const _CountryOption(this.value, this.label, this.flag);
  final String? value;
  final String label;
  final String flag;
}

class _CountryDrawer extends StatelessWidget {
  const _CountryDrawer({required this.onSelect});
  final void Function(String?) onSelect;

  static const _options = [
    _CountryOption(null, 'Semua Negara', '🌍'),
    _CountryOption('Egypt', 'Mesir', '🇪🇬'),
    _CountryOption('Morocco', 'Maghribi', '🇲🇦'),
  ];

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(color: KptTheme.navy),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'eTT Mobile',
                  style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 4),
                Text(
                  'Program pengajian Timur Tengah',
                  style: TextStyle(color: Colors.white70, fontSize: 13),
                ),
              ],
            ),
          ),
          for (final option in _options)
            ListTile(
              leading: Text(option.flag, style: const TextStyle(fontSize: 22)),
              title: Text(option.label),
              onTap: () => onSelect(option.value),
            ),
        ],
      ),
    );
  }
}
```

Hot Reload. Tekan ikon hamburger (☰) atau leret dari tepi kiri skrin — `Drawer` meluncur keluar memaparkan header navy "eTT Mobile" + 3 pilihan negara. Tekan mana-mana negara — `Drawer` tertutup semula.

✅ **Semakan Latihan 5:** Tukar antara ketiga-tiga tab beberapa kali — `_titles[_index]` di `AppBar` **sentiasa sepadan** dengan tab aktif. Buka `Drawer`, kira baris negara — mesti tepat **3**.

---

## Latihan 6 — `ListView` vs `ListView.builder` & `GridView`

**Objektif:** Rasa sendiri **kenapa** `.builder` penting untuk senarai besar, dan bina paparan grid alternatif untuk data yang sama.

### 6.1 — Eksperimen: `ListView.builder` sebenarnya "malas" (*lazy*)

Dalam `programme_list_screen.dart`, **sementara**, tambah `print()` di dalam `itemBuilder` supaya anda boleh lihat **bila** setiap kad dibina:

```dart
      itemBuilder: (context, index) {
        final p = sampleProgrammes[index];
        print('Kad dibina untuk: ${p.universityName}'); // EKSPERIMEN sementara
        return ProgrammeCard(programme: p);
      },
```

`flutter run`, lihat **terminal** — hanya **8** baris `print` muncul (sama seperti bilangan program), kerana kesemua 8 kelihatan serentak pada skrin kecil ini. Ini belum nampak beza berbanding `ListView(children:...)` biasa kerana datanya kecil. Untuk **benar-benar nampak** kesan "malas", uji dengan senarai jauh lebih panjang:

```dart
      // EKSPERIMEN sementara — GANTI itemCount & indeks data untuk uji 1000 item
      itemCount: 1000,
      itemBuilder: (context, index) {
        final p = sampleProgrammes[index % sampleProgrammes.length];
        print('Kad dibina untuk indeks: $index');
        return ProgrammeCard(programme: p);
      },
```

`flutter run` semula. Perhatikan terminal: **hanya ~10–15 baris** `print` muncul pada mulanya (bukan 1000!) — kad yang **kelihatan** di skrin sahaja. Skrol ke bawah perlahan-lahan dan baris `print` baharu muncul **beransur-ansur** mengikut skrol anda. Ini bukti `ListView.builder` membina widget **hanya bila hampir kelihatan**, bukan semua sekali gus.

**Kembalikan** `itemCount`/`itemBuilder`/`print` kepada versi asal (Latihan 5.1, `sampleProgrammes.length`, tiada `print`) selepas eksperimen ini.

### 6.2 — Bina `GridView` alternatif

Cipta `lib/screens/programme_grid_screen.dart` — memaparkan data **sama** (`sampleProgrammes`) tetapi sebagai grid 2 lajur:

```dart
// lib/screens/programme_grid_screen.dart
import 'package:flutter/material.dart';

import '../data/sample_programmes.dart';
import '../theme.dart';

class ProgrammeGridScreen extends StatelessWidget {
  const ProgrammeGridScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tawaran Pengajian eTT')),
      body: GridView.builder(
        padding: const EdgeInsets.all(12),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          childAspectRatio: 0.95,
        ),
        itemCount: sampleProgrammes.length,
        itemBuilder: (context, index) {
          final p = sampleProgrammes[index];
          return Card(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(p.flagEmoji, style: const TextStyle(fontSize: 22)),
                  const SizedBox(height: 4),
                  Text(
                    p.universityName,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    p.fieldOfStudy,
                    style: const TextStyle(fontSize: 12),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const Spacer(),
                  Text(
                    '${p.quotaSeats} tempat',
                    style: const TextStyle(color: KptTheme.navy, fontSize: 12),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
```

Uji sementara melalui `main.dart` (`home: const ProgrammeGridScreen()`). Semua **8** kad patut kelihatan tersusun 2 lajur, boleh diskrol. **Pulangkan** `home:` kepada `const HomeScreen()` selepas selesai menguji.

### 6.3 — Eksperimen: `crossAxisCount`

| Cuba tukar `crossAxisCount` | Perhatikan apa jadi | Kesimpulan |
|---|---|---|
| `2` → `1` | Grid jadi macam senarai satu lajur, kad jauh lebih lebar | `crossAxisCount: 1` = grid dengan **satu** lajur sahaja, secara visual hampir sama `ListView` |
| `2` → `4` | Kad jadi sangat kecil, teks mungkin terpotong lebih agresif | Lebih lajur = kad lebih sempit; `childAspectRatio` mungkin perlu dilaraskan semula |
| `childAspectRatio: 0.95` → `1.5` | Kad jadi **lebih pendek dan lebar** (bukan tinggi macam sebelum ini) | `childAspectRatio` < 1 = petak lebih tinggi; > 1 = petak lebih lebar |

Kembalikan `crossAxisCount: 2` dan `childAspectRatio: 0.95` selepas mencuba.

✅ **Semakan Latihan 6:** Anda dapat terangkan (dalam ayat sendiri) **bila** anda akan pilih `ListView.builder` berbanding `GridView.builder` untuk data sebenar eTT, dan buktikan (melalui eksperimen 1000-item) yang `.builder` tidak membina semua widget serentak.

---

## Latihan 7 — Styling dengan `ThemeData`

**Objektif:** Tambah gaya teks global baharu pada `KptTheme`, dan sahkan kesannya **automatik** merentasi lebih daripada satu skrin.

### 7.1 — Tambah `textTheme` pada `lib/theme.dart`

Buka `lib/theme.dart`. Cari penutup `inputDecorationTheme: InputDecorationTheme(...)` di dalam `ThemeData(...)` dan tambah `textTheme` **selepasnya**:

```dart
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),

      // ── 7.1 — Gaya teks tajuk global ──────────────────────
      textTheme: const TextTheme(
        titleLarge: TextStyle(fontWeight: FontWeight.bold, color: KptTheme.navy),
        titleMedium: TextStyle(fontWeight: FontWeight.w600, color: KptTheme.navy),
      ),
    );
  }
}
```

### 7.2 — Guna di lebih daripada satu tempat

Dalam `lib/screens/layout_playground_screen.dart` (Latihan 3), tambah satu tajuk **di atas** senarai banner menggunakan `Theme.of(context)`:

```dart
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // ── 7.2 — Tajuk guna tema global, BUKAN TextStyle sebaris ──
          Text(
            'Semua Tawaran Pengajian',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 12),
          for (final p in sampleProgrammes)
            Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: ProgrammeBanner(programme: p),
            ),
        ],
      ),
```

Buat perkara **sama** dalam `lib/screens/programme_grid_screen.dart` (Latihan 6.2) — tambah tajuk sebelum `GridView`.

⚠️ **Hati-hati di sini** — `GridView` (dan `ListView`) mahu mengisi **semua** ruang menegak. Jika anda hanya masukkan kedua-duanya ke dalam `Column` begitu sahaja, `GridView` menerima tinggi **tidak terhad** dan aplikasi meletup dengan ralat `RenderFlex overflowed by 99xxx pixels on the bottom`. Penyelesaiannya: balut `GridView` dengan **`Expanded`**.

```dart
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── 7.2 — Tajuk guna tema global ──
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 12, 12, 0),
            child: Text(
              'Tawaran Pengajian eTT (Grid)',
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          Expanded(              // 👈 WAJIB — beri GridView tinggi terhad
            child: GridView.builder(
              // ... kekalkan GridView.builder sedia ada Latihan 6.2 ...
            ),
          ),
        ],
      ),
```

| Cuba tukar | Perhatikan pada skrin | Kesimpulan |
|---|---|---|
| Buang `Expanded(` (biar `GridView` terus dalam `Column`) | Skrin merah / jalur overflow besar, terminal: `overflowed by 99xxx pixels on the bottom` | `Column` beri tinggi **tak terhad**; `GridView` cuba jadi infinit |
| Kembalikan `Expanded` | Grid muncul semula, boleh diskrol | `Expanded` mengehadkan tinggi kepada ruang **baki** sebenar |

`flutter run` kedua-dua skrin (tukar `home:` sementara untuk uji) — **kedua-dua** tajuk kelihatan **navy + bold**, konsisten, walaupun ditulis di **dua fail berlainan**, tanpa `color: KptTheme.navy` diulang secara eksplisit pada `Text` masing-masing.

### 7.3 — Eksperimen: kesan global sebenar

Tukar **sementara** `navy` dalam `KptTheme` (baris `static const Color navy = Color(0xFF1A2B5C);`) kepada `Color(0xFF6A1B9A)` (ungu). `flutter run` semula (perlu **Hot Restart**, bukan sekadar Hot Reload, kerana ini nilai `const` tahap kelas). Perhatikan: `AppBar`, semua `Card`, kedua-dua tajuk `titleLarge` yang baru anda tambah — **semuanya** bertukar ungu **serentak**, walaupun anda hanya ubah **satu baris** dalam **satu** fail.

**Pulangkan** semula kepada `0xFF1A2B5C` selepas eksperimen.

✅ **Semakan Latihan 7:** Sekurang-kurangnya **dua** skrin berbeza (`LayoutPlaygroundScreen`, `ProgrammeGridScreen`) menggunakan `Theme.of(context).textTheme.titleLarge` dan kelihatan konsisten (navy + bold) tanpa gaya sebaris diulang.

---

## Troubleshooting Lab Hari 2

| Simptom | Kemungkinan Sebab | Pembetulan |
|---|---|---|
| Jalur kuning-hitam di tepi `Row` | Anak `Row` melebihi lebar skrin | Bungkus `Text`/widget fleksibel dengan `Expanded` + `overflow: TextOverflow.ellipsis` (Latihan 1) |
| `Incorrect use of ParentDataWidget` | `Expanded`/`Positioned` diletak bukan sebagai anak langsung `Row`/`Column`/`Stack` | Pastikan ia **terus** dalam senarai `children:` widget induk yang betul |
| `Vertical viewport was given unbounded height` | `ListView`/`GridView` diletak terus dalam `Column` tanpa had tinggi | Bungkus dengan `Expanded(child: ...)`, atau `shrinkWrap: true` untuk senarai pendek |
| Tab bawah tak bertukar bila ditekan | Lupa `setState()` dalam `onTap`, atau `HomeScreen` tertulis `StatelessWidget` | `HomeScreen extends StatefulWidget`; `onTap: (i) => setState(() => _index = i)` |
| `Drawer` tidak muncul / ikon ☰ tiada | `drawer:` tidak ditetapkan pada `Scaffold` paling luar | Tambah `drawer: _CountryDrawer(...)` sejajar `appBar:`/`body:` dalam `HomeScreen` |
| Tema tidak bertukar selepas edit `theme.dart` | Hot Reload tidak cukup untuk perubahan `const` tahap kelas | Guna **Hot Restart** (`R` besar dalam terminal) |
| `flutter analyze` — `prefer_const_constructors` | Widget statik ditulis tanpa `const` | Tambah `const`; VS Code selalunya cadangkan pembetulan automatik |

---

## Cabaran

Pilih **sekurang-kurangnya satu** untuk diselesaikan sebelum kelas Hari 3:

1. **Banner lanjutan** — tambah `Positioned` ketiga pada `ProgrammeBanner` (Latihan 2): pill kecil di sudut **kiri bawah** memaparkan `programme.countryLabel` (Mesir/Maghribi), dengan warna latar berbeza daripada `CategoryPill`.
2. **Grid responsif** — ubah `ProgrammeGridScreen` (Latihan 6.2) supaya `crossAxisCount` bertukar mengikut lebar skrin: guna `MediaQuery.of(context).size.width` — 2 lajur jika lebar < 600, 3 lajur jika ≥ 600. (Petunjuk: `crossAxisCount: MediaQuery.of(context).size.width < 600 ? 2 : 3`.)
3. **Widget kosong dengan bantuan AI** — minta AI jana satu widget `EmptyStateView` (ikon besar kelabu + mesej + butang "Cuba Lagi") yang boleh diguna semula untuk sebarang senarai kosong dalam aplikasi (contoh: hasil carian program yang tiada padanan). Semak: adakah ia `const`-friendly? Adakah teks boleh dilalukan sebagai parameter (bukan *hardcoded*)?
4. **Tema alternatif** — tambah `static ThemeData get dark` dalam `KptTheme` (skema gelap ringkas menggunakan `brightness: Brightness.dark`), dan bandingkan `AppBar`/`Card` antara kedua-dua tema pada emulator.
5. **Wire `ProgrammeGridScreen` ke tab Profil** — sementara `ProfileScreen` masih placeholder, cuba paparkan `ProgrammeGridScreen()` terus sebagai tab ketiga (`_screens[2]`) supaya anda ada **dua** cara nampak data yang sama semasa lab (senarai di tab Program, grid di tab Profil) — pulangkan semula ke `ProfileScreen()` biasa selepas puas mencuba.

> Tiada jawapan "betul" tunggal untuk Cabaran — matlamatnya berlatih gabungkan konsep yang sudah dipelajari. Tunjukkan hasil kepada fasilitator/rakan sekelas sebelum tamat kelas.

---

## Rujukan Fail Sebenar

Untuk banding kod anda, fail rujukan lengkap (hasil akhir 5 hari, guna `provider` untuk carian/tapisan sebenar — topik Hari 3 ke atas) ada di:

| Fail anda (lab) | Fail rujukan (projek sebenar) |
|------------------|-------------------------------|
| `ProgrammeSummaryRow` overflow demo (Latihan 1) | `projek/ett_mobile/lib/widgets/programme_card.dart` (Row header, corak sama) |
| `programme_banner.dart` (Latihan 2) | *(tiada padanan terus — latihan konsep `Stack`/`Positioned`, bukan ciri kekal aplikasi)* |
| `layout_playground_screen.dart` (Latihan 3) | *(fail lab sahaja, tidak wujud dalam projek akhir)* |
| `programme_intake_tile.dart` (Latihan 4) | Alternatif ringkas kepada `ProgrammeCard` penuh |
| `home_screen.dart` (Latihan 5) | `projek/ett_mobile/lib/screens/home_screen.dart` (versi sebenar tambah `provider` untuk tapis negara) |
| `programme_list_screen.dart` (Latihan 5–6) | `projek/ett_mobile/lib/screens/programme_list_screen.dart` (versi sebenar tambah carian & cip tapisan) |
| `programme_grid_screen.dart` (Latihan 6) | *(fail lab sahaja — grid bukan ciri kekal skrin utama aplikasi)* |
| `textTheme` dalam `theme.dart` (Latihan 7) | `projek/ett_mobile/lib/theme.dart` |

> Lihat juga [`README.md`](../README.md) Hari 2 untuk penjelasan konsep penuh setiap latihan, termasuk deskripsi visual, jadual "salah biasa", dan bahagian *troubleshooting*.
</content>
