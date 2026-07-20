# Hari 2 — Seni Bina Layout, Struktur UI & Senarai Dinamik

Panduan langkah demi langkah untuk **Hari 2** kursus *eTT Mobile*. Hari ini kita tidak menambah skrin baharu melalui navigasi (itu topik Hari 3) — sebaliknya kita memperkukuhkan **cara menyusun widget di dalam satu skrin**: bagaimana meletakkan widget bersebelahan (Row/Column), bagaimana menindankan widget di atas satu sama lain (Stack), bagaimana membina rangka skrin standard (Scaffold/AppBar), bagaimana memaparkan senarai/grid data secara dinamik, dan bagaimana menggayakan (*styling*) keseluruhan aplikasi secara konsisten melalui `ThemeData`.

**Imbas kembali Hari 1:** Anda telah belajar asas Dart (operator, `if`/`else`, `switch`, gelung `for`/`while`, fungsi), mencuba widget paparan asas (`Text`, `Icon`, `Image`), memahami `Container`/`Padding`/`Margin`/`SizedBox` untuk jarak dan sempadan, serta perbezaan `StatelessWidget` (tetap) berbanding `StatefulWidget` (boleh berubah). Hari ini kita **bina di atas** projek Flutter yang sama — jangan mulakan projek baharu.

> **Nota untuk pemula:** Teruskan menggunakan folder projek `ett_mobile` daripada Hari 1. Jika `flutter pub get` belum dijalankan hari ini, jalankan dahulu sebelum meneruskan.

**Kenapa "layout" perlu satu hari penuh sendiri?** Hari 1 anda sudah bina satu kad statik (`ProgrammeInfoCard`) menggunakan `Container` + `Column` — tetapi itu baru **satu** widget berdiri sendiri, disusun menegak secara mudah. Aplikasi sebenar perlu memaparkan **berpuluh** kad seumpama itu (8 tawaran pengajian eTT, berkembang ke ratusan selepas sambungan API Hari 4), disusun dalam pelbagai bentuk — senarai menegak, grid berlajur, banner bertindan, tab navigasi, panel sisi. Tanpa memahami betul bagaimana Flutter mengagihkan **ruang** (siapa dapat berapa lebar/tinggi) antara widget bersebelahan, anda akan sentiasa terserempak dengan ralat susun atur paling biasa dalam Flutter — `RenderFlex overflowed`. Hari ini fokus kepada **mengawal ruang**: paksi (axis), pengagihan ruang baki, dan bila widget patut "memaksa" ambil ruang berbanding "bertolak ansur".

---

## Fokus Hari Ini

| Topik | Rujukan Rasmi Flutter |
|-------|------------------------|
| Asas layout (`Row`/`Column`) | https://docs.flutter.dev/ui/layout |
| `Row` | https://api.flutter.dev/flutter/widgets/Row-class.html |
| `Column` | https://api.flutter.dev/flutter/widgets/Column-class.html |
| `Expanded` | https://api.flutter.dev/flutter/widgets/Expanded-class.html |
| `Flexible` | https://api.flutter.dev/flutter/widgets/Flexible-class.html |
| `Stack` | https://api.flutter.dev/flutter/widgets/Stack-class.html |
| `Positioned` | https://api.flutter.dev/flutter/widgets/Positioned-class.html |
| `Align` | https://api.flutter.dev/flutter/widgets/Align-class.html |
| `Center` | https://api.flutter.dev/flutter/widgets/Center-class.html |
| `Scaffold` | https://api.flutter.dev/flutter/material/Scaffold-class.html |
| `AppBar` | https://api.flutter.dev/flutter/material/AppBar-class.html |
| `BottomNavigationBar` | https://api.flutter.dev/flutter/material/BottomNavigationBar-class.html |
| `Drawer` | https://api.flutter.dev/flutter/material/Drawer-class.html |
| `ListView` | https://api.flutter.dev/flutter/widgets/ListView-class.html |
| `ListView.builder` (senarai panjang) | https://docs.flutter.dev/cookbook/lists/long-lists |
| `GridView` | https://api.flutter.dev/flutter/widgets/GridView-class.html |
| `Card` | https://api.flutter.dev/flutter/material/Card-class.html |
| `ListTile` | https://api.flutter.dev/flutter/material/ListTile-class.html |
| `TextStyle` | https://api.flutter.dev/flutter/painting/TextStyle-class.html |
| `ThemeData` & tema aplikasi | https://docs.flutter.dev/cookbook/design/themes |
| Prompt AI untuk Flutter (rujukan dalaman) | [`nota/08-prompt-claude-code.md`](../nota/08-prompt-claude-code.md) |

---

## Jadual Sesi Hari Ini

Selaras dengan aturcara rasmi (lihat [`JADUAL.md`](../JADUAL.md)):

| Masa | Sesi | Tajuk |
|------|------|-------|
| 8.30 – 9.00 pagi | — | Pendaftaran & Minum Pagi |
| **9.00 pagi – 1.00 petang** | **SESI 2** | **Seni Bina Layout & Struktur UI** — Row, Column, Expanded, Flexible · Stack, Positioned, Align, Center · Scaffold, AppBar |
| 1.00 – 2.30 petang | — | Rehat & Makan Tengah Hari |
| **2.00 – 5.00 petang** | **SESI 3** | **Senarai Dinamik & Kemasan (Styling)** — BottomNavigationBar & Drawer · ListView, ListView.builder, GridView · Card & ListTile · TextStyle, Warna, Font & ThemeData |
| 5.00 petang | — | Bersurai |

> **Apa yang TIDAK kita sentuh hari ini:** `Navigator`/laluan (*routes*) antara skrin, borang (`Form`/`TextFormField`) — semua itu ialah **Hari 3**. Sambungan API — **Hari 4**. Pakej `provider` untuk perkongsian *state* merentasi skrin — diperkenalkan penuh **Hari 3 ke atas**; hari ini jika kod sebenar aplikasi menggunakannya, kita akan tandakan jelas sebagai "pratonton, bukan fokus hari ini".

---

## 1. Row & Column — Susun Atur Asas

### 1.0 Kenapa perlu widget susun atur langsung?

Dalam HTML/CSS, susun atur (*layout*) sebahagian besarnya diuruskan oleh pelayar melalui peraturan `display`/`float`/`flexbox` di luar struktur kandungan. Flutter berbeza: **setiap** susunan — mendatar, menegak, jarak, sejajaran — ialah widget yang anda letak **secara eksplisit** dalam pokok widget. Ini nampak lebih banyak kod pada mulanya, tetapi kelebihannya: tiada "peraturan tersembunyi" — apa yang anda tulis dalam kod **itulah** susunan sebenar pada skrin, tanpa kejutan daripada helaian gaya luar.

Setiap skrin Flutter dibina dengan **menyusun widget kecil menjadi widget lebih besar**. Dua widget paling asas untuk susun atur ialah:

- **`Column`** — susun anak widget **menegak** (atas ke bawah).
- **`Row`** — susun anak widget **mendatar** (kiri ke kanan).

```dart
Row(
  mainAxisAlignment: MainAxisAlignment.spaceBetween,
  crossAxisAlignment: CrossAxisAlignment.center,
  children: [
    Text('Universiti Al-Azhar'),
    Text('🇪🇬'),
  ],
);
```

**Apa yang anda patut nampak:** dua keping teks pada baris **yang sama** — `'Universiti Al-Azhar'` di paling kiri dan `'🇪🇬'` di paling kanan, dengan jarak kosong di antaranya yang mengembang mengikut lebar skrin (kesan `spaceBetween`). Kedua-duanya sejajar di **tengah** menegak (kesan `center` pada `crossAxisAlignment`) — kalau salah satu teks lebih tinggi daripada yang lain (contoh kerana `fontSize` berbeza), ini nampak sebagai kedua-dua teks berada di paras "tengah" baris, bukan salah satu terapung di atas/bawah.

### 1.1 `MainAxisAlignment` vs `CrossAxisAlignment`

Setiap `Row`/`Column` mempunyai **dua paksi (axis)**:

| Widget | Paksi Utama (*main axis*) | Paksi Silang (*cross axis*) |
|--------|---------------------------|------------------------------|
| `Row` | mendatar (kiri↔kanan) | menegak (atas↔bawah) |
| `Column` | menegak (atas↔bawah) | mendatar (kiri↔kanan) |

- **`mainAxisAlignment`** — mengawal jarak/sejajaran **sepanjang paksi utama**: `start`, `end`, `center`, `spaceBetween`, `spaceAround`, `spaceEvenly`.
- **`crossAxisAlignment`** — mengawal sejajaran **merentasi paksi silang**: `start`, `end`, `center`, `stretch`.

**Bayangkan skrin telefon anda sebagai satu petak.** Untuk `Row`, "paksi utama" ialah garis mendatar merentasi skrin — `mainAxisAlignment.spaceBetween` menolak anak pertama ke tepi kiri dan anak terakhir ke tepi kanan, dengan jarak sama rata di antara mana-mana anak lain. Untuk `Column`, "paksi utama" pula garis menegak — `MainAxisAlignment.center` (seperti digunakan dalam `main.dart` Hari 1) menolak **semua** anak ke **tengah** menegak skrin, meninggalkan ruang kosong sama banyak di atas dan di bawah kumpulan widget itu.

Contoh sebenar daripada `widgets/programme_card.dart` — header kad menggunakan `Row` dengan `crossAxisAlignment: CrossAxisAlignment.start` supaya bendera, nama universiti & bidang, dan kos RM semuanya bermula sejajar di bahagian atas walaupun tingginya berbeza:

```dart
Row(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    Text(programme.flagEmoji, style: const TextStyle(fontSize: 30)),
    const SizedBox(width: 12),
    Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(programme.universityName, style: const TextStyle(fontWeight: FontWeight.bold)),
          Text(programme.fieldOfStudy, style: TextStyle(color: Colors.grey[800])),
          Text('${programme.city}, ${programme.countryLabel}', style: TextStyle(color: Colors.grey[600])),
        ],
      ),
    ),
    // ... kos anggaran tahunan RM
  ],
);
```

**Apa yang anda patut nampak:** satu baris dengan bendera besar (🇪🇬) di kiri, lajur tengah yang mengandungi **tiga** baris teks bertindih menegak (nama universiti tebal, bidang pengajian kelabu gelap, bandar+negara kelabu terang) — kesemuanya bermula pada **paras atas** yang sama dengan bendera, walaupun bendera hanya **satu** baris tinggi dan lajur tengah **tiga** baris. Jika `crossAxisAlignment` ditukar kepada `center` (nilai lalai), bendera akan "melayang" ke tengah menegak lajur tiga baris itu, bukan sejajar di atas — kelihatan longgar dan kurang kemas berbanding versi `start`.

Perhatikan `Column` **bersarang di dalam** `Row` — ini corak biasa: `Row` untuk susun mendatar bahagian besar (bendera | maklumat program | kos), `Column` di dalamnya untuk susun menegak universiti, bidang & lokasi. Susun atur kompleks hampir selalu dibina dengan **menyarangkan** (*nesting*) `Row` dan `Column` berulang kali.

### Salah biasa: `Row`/`Column`

| ❌ Yang selalu ditulis pemula | ✅ Pembetulan | Kenapa |
|---|---|---|
| `Row(child: Text('A'), child: Text('B'))` — cuba letak dua `child:` | `Row(children: [Text('A'), Text('B')])` | `Row`/`Column` terima **satu** senarai `children:` (jamak), bukan berbilang parameter `child:` (tunggal). `child:` untuk widget yang **hanya** ada satu anak (`Container`, `Padding`, `Center`). |
| Lupa `crossAxisAlignment: CrossAxisAlignment.start` untuk teks berbilang baris dalam `Column` yang bersarang dalam `Row` | Tambah `crossAxisAlignment: CrossAxisAlignment.start` pada `Column` dalaman | Lalai `Column` ialah `CrossAxisAlignment.center` — teks jadi tersadur di **tengah** mendatar, bukan sejajar kiri seperti kad biasa. |
| `Column(mainAxisSize: MainAxisSize.max)` (lalai) untuk `Column` **kecil** yang dibenamkan dalam `Row`/`Container` yang tidak infinite tinggi | Tetapkan `mainAxisSize: MainAxisSize.min` bila `Column` itu sepatutnya "sekecil kandungannya" | `MainAxisSize.max` (lalai) memaksa `Column` cuba **mengisi semua** ruang menegak yang ada — dalam `Container` yang membungkus rapat kandungan, ini boleh menyebabkan ralat "unbounded height" atau ruang kosong luar jangka. |
| Meletakkan koma tertinggal / kurungan tak sepadan selepas senarai `children:` panjang | Guna auto-format editor (`Shift+Alt+F` VS Code) selepas setiap perubahan | `Row`/`Column` bersarang cepat jadi dalam — satu kurungan hilang menyebabkan ralat sintaks yang mengelirukan (baris ralat ditunjuk selalunya **bukan** baris sebenar masalah). |

> **Ringkasan setakat ini:** `Row` = mendatar, `Column` = menegak. Setiap satu ada paksi utama (`mainAxisAlignment`) dan paksi silang (`crossAxisAlignment`). Susun atur kompleks = `Row`/`Column` bersarang. Cuba sendiri dalam **Latihan 1** (`snippets/lab.md`) sebelum teruskan ke bahagian seterusnya.

---

## 2. `Expanded` vs `Flexible` — Elak Ralat Overflow

### 2.0 Kenapa ini bahagian paling penting hari ini

`Row` dan `Column`, secara lalai, **tidak** tahu apa nak buat bila jumlah lebar (atau tinggi) semua anaknya melebihi ruang yang ada. Ia tidak "mengecilkan" kandungan secara automatik seperti pelayar web — ia hanya **melukis melepasi sempadan**, dan Flutter menandakan ini sebagai ralat visual yang mencolok. Ini ialah ralat susun atur **paling kerap** dilihat oleh pemula Flutter, jadi memahami sebab dan tiga cara membetulkannya adalah kemahiran paling bernilai hari ini.

### 2.1 Demonstrasi ralat overflow klasik

Cuba bayangkan kod ini — memaparkan nama universiti yang panjang bersebelahan dengan tag negara, di dalam `Row` biasa:

```dart
Row(
  children: [
    Text('Universite Al Quaraouiyine'),
    Text(' — Fes, Maghribi'),
  ],
);
```

Pada skrin telefon yang sempit, jumlah lebar kedua-dua `Text` **melebihi** lebar skrin. Flutter tidak akan membesarkan skrin — sebaliknya ia memaparkan **jalur kuning-hitam bergaris (`RenderFlex overflowed`)** di tepi kanan, disertai amaran merah di konsol. Ini ialah salah satu ralat paling biasa dilihat oleh pemula Flutter.

**Apa sebenarnya yang anda nampak di skrin:** jalur diagonal berwarna **kuning dan hitam berselang-seli** (seperti reben amaran pembinaan) melekat di **tepi kanan** kawasan `Row` itu, biasanya setinggi baris teks tersebut sahaja (bukan seluruh skrin). Di sebelah jalur itu, sebahagian teks `' — Fes, Maghribi'` mungkin terpotong atau tidak kelihatan langsung. Dalam **terminal** (bukan skrin telefon), anda akan nampak mesej merah panjang bermula dengan `A RenderFlex overflowed by NN pixels on the right.` — nombor `NN` memberitahu **tepat berapa piksel** susun atur itu melebihi ruang. Aplikasi **tidak crash**; ia terus berjalan, cuma bahagian itu kelihatan rosak secara visual.

### 2.2 Penyelesaian: `Expanded`

`Expanded` memberitahu Flutter: *"widget ini boleh mengisi baki ruang yang ada, tetapi tidak boleh melebihinya."*

```dart
Row(
  children: [
    Expanded(
      child: Text(
        'Universite Al Quaraouiyine',
        overflow: TextOverflow.ellipsis,
      ),
    ),
    const Text(' — Fes, Maghribi'),
  ],
);
```

Dengan `Expanded`, `Text` nama universiti **dipaksa** memenuhi ruang yang tinggal (selepas ditolak ruang teks kedua), dan `overflow: TextOverflow.ellipsis` memotong teks dengan `…` jika masih terlalu panjang — bukan lagi ralat, tetapi paparan yang terkawal.

**Apa yang anda patut nampak selepas pembetulan:** jalur kuning-hitam **hilang**. Teks `'Universite Al Quaraouiyine'` kini dipotong dengan tiga titik (`Universite Al Quarao…`) jika ruang tidak cukup, dan `' — Fes, Maghribi'` kekal **penuh** kelihatan di sebelah kanan kerana ia **tidak** dibalut `Expanded` — ia hanya mengambil lebar sekadar kandungannya, dan `Expanded` pada teks pertama "menolak diri" supaya sentuh kekal dalam ruang yang tinggal.

Ini corak yang sama digunakan `ProgrammeCard` sebenar:

```dart
Expanded(
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(programme.universityName, /* ... */),
      Text(programme.fieldOfStudy, /* ... */),
      Text('${programme.city}, ${programme.countryLabel}', /* ... */),
    ],
  ),
),
```

Tanpa `Expanded` di sini, `Column` universiti+bidang cuba mengambil lebar **sepenuhnya yang ia mahu**, menolak lajur kos RM di sebelah kanan keluar dari skrin.

> Susun atur macam ni memang leceh nak dapat elok kali pertama. Kalau anda buntu bina keseluruhan `Row` header kad ini, cuba minta AI:
> ```text
> Bina Row untuk ProgrammeCard: bendera negara, Column (universityName, fieldOfStudy),
> Expanded, dan kos RM di hujung kanan. Guna KptTheme.navy untuk tajuk.
> ```
> Semak hasilnya sebelum terima — pastikan `const` di tempat yang patut, dan jalankan `flutter analyze` untuk tangkap apa-apa yang tertinggal.

### 2.3 `Flexible` — sepupu `Expanded` yang lebih longgar

`Flexible` serupa dengan `Expanded`, tetapi **tidak memaksa** widget mengisi semua ruang baki — ia hanya membenarkan widget itu **mengecil jika perlu**, dan besarnya bergantung kandungan.

```dart
Row(
  children: [
    Flexible(child: Text('Universiti Al-Azhar', overflow: TextOverflow.ellipsis)),
    const Icon(Icons.chevron_right),
  ],
);
```

**Apa yang anda patut nampak:** jika `'Universiti Al-Azhar'` muat dalam ruang yang ada, ia dipaparkan **penuh**, dengan ikon anak panah `›` terus di sebelahnya — teks **tidak** ditolak untuk mengisi semua ruang baki (berbeza daripada `Expanded`, yang akan menolak ikon ke hujung paling kanan skrin walaupun teks pendek).

| | `Expanded` | `Flexible` |
|---|---|---|
| Definisi ringkas | `Expanded` = `Flexible(fit: FlexFit.tight)` | `fit: FlexFit.loose` (lalai) |
| Kelakuan | **Memaksa** isi semua ruang baki | **Boleh** isi ruang baki, tapi tak wajib |
| Bila guna | Widget yang MESTI mengambil ruang (contoh: `Column` maklumat dalam kad) | Widget yang boleh lebih kecil daripada ruang baki (contoh: ikon/label pendek) |

> **Peraturan mudah untuk pemula:** Jika anda tidak pasti, mula dengan `Expanded`. Jika hasilnya nampak "terlalu meregang" (contohnya butang kecil jadi terlalu lebar), tukar kepada `Flexible`.

### Salah biasa: `Expanded`/`Flexible`

| ❌ Yang selalu ditulis pemula | ✅ Pembetulan | Kenapa |
|---|---|---|
| `Expanded(child: Text('...'))` diletak **terus** dalam `Container`/`Padding` (bukan dalam `Row`/`Column`) | Hanya guna `Expanded`/`Flexible` sebagai **anak langsung** `Row`, `Column`, atau `Flex` | Flutter akan lempar ralat masa jalan: *"Incorrect use of ParentDataWidget"* — `Expanded` perlu tahu "ruang baki **daripada apa**", dan hanya `Row`/`Column`/`Flex` menyediakan konsep itu. |
| Bungkus **semua** anak `Row` dengan `Expanded`, walaupun sebahagian patut kekal saiz asal (contoh ikon) | Hanya bungkus widget yang **patut** regang mengisi ruang baki; biarkan ikon/label pendek tanpa `Expanded` | Semua anak `Expanded` akan berkongsi ruang **sama rata** (melainkan `flex:` berbeza ditetapkan) — ikon kecil jadi meregang aneh, bukan kekal saiz semula jadinya. |
| Lupa `overflow: TextOverflow.ellipsis` pada `Text` di dalam `Expanded` | Tambah `overflow: TextOverflow.ellipsis` (atau `maxLines`) pada teks panjang | Tanpa ini, `Expanded` memang elak *overflow melebihi Row* — tetapi teks yang masih terlalu panjang untuk ruang barunya akan **overflow secara menegak** (baris tambahan tak kelihatan/berpotongan), bukan dipotong kemas dengan `…`. |

> **Ringkasan setakat ini:** `RenderFlex overflowed` = jumlah lebar/tinggi anak `Row`/`Column` melebihi ruang ibu. `Expanded` memaksa isi ruang baki; `Flexible` membenarkan tapi tak paksa. Kedua-duanya **hanya** sah sebagai anak langsung `Row`/`Column`. Cuba sendiri eksperimen overflow → pembetulan dalam **Latihan 1** (`snippets/lab.md`).

---

## 3. `Stack`, `Positioned`, `Align` & `Center` — Susun Atur Bertindan

### 3.0 Kenapa perlukan susun atur bertindan?

`Row` dan `Column` menganggap **setiap** widget mengambil "petaknya sendiri" — tiada dua widget berkongsi ruang yang sama. Tetapi rekaan UI moden sering perlukan lapisan **di atas** lapisan lain — lencana kecil di sudut gambar, label di atas banner berwarna, ikon "loading" di tengah kandungan yang sedang dimuat. Untuk keperluan ini, `Row`/`Column` **tidak mencukupi**; kita perlukan widget yang membenarkan tindanan secara eksplisit — itulah `Stack`.

`Row` dan `Column` menyusun widget **bersebelahan** (tiada widget bertindih). Kadangkala kita mahu widget **bertindan di atas satu sama lain** — contohnya lencana/pill kategori di atas sudut banner. Untuk ini kita guna `Stack`.

### 3.1 Konsep `Stack` + `Positioned`

```dart
Stack(
  children: [
    // Widget pertama = lapisan paling bawah
    Container(height: 160, color: KptTheme.navy),
    // Widget seterusnya ditindan di ATAS lapisan sebelumnya
    Positioned(
      top: 12,
      right: 12,
      child: Container(/* pill */),
    ),
  ],
);
```

- Anak pertama dalam `children` menjadi **lapisan paling bawah**; anak seterusnya ditindan **di atasnya**, mengikut urutan senarai.
- `Positioned` **hanya sah di dalam `Stack`** — ia menetapkan jarak dari mana-mana gabungan `top`/`bottom`/`left`/`right` daripada sempadan `Stack`.
- Anak `Stack` yang **bukan** `Positioned` (seperti `Container` navy di atas) akan memenuhi keseluruhan `Stack` secara lalai.

**Apa yang anda patut nampak:** satu kotak navy setinggi 160 piksel, selebar penuh skrin — dan di **atas** sudut kanan-atasnya, sebuah "pill" kecil (kotak bulat sudut) kelihatan **melekat** di permukaan navy itu, 12 piksel dari tepi atas dan 12 piksel dari tepi kanan. Kotak navy dan pill itu **berkongsi ruang skrin yang sama** — bukan dua bahagian berasingan seperti dalam `Column`.

### 3.2 Contoh domain: banner program dengan pill kategori kemasukan

Mari bina `ProgrammeBanner` — banner ringkas untuk satu `Programme` (tawaran pengajian eTT), dengan pill kategori kemasukan (`SPM` / `STAM` / `SPM atau STAM`) ditindan di sudut kanan atas:

```dart
class ProgrammeBanner extends StatelessWidget {
  const ProgrammeBanner({super.key, required this.programme});

  final Programme programme;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Lapisan bawah: "gambar" destinasi (guna warna sebagai placeholder)
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
        // Lapisan atas: universiti & bidang, dilabuhkan ke bawah kiri
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
        // Pill kategori kemasukan, ditindan di sudut kanan atas
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

**Apa yang anda patut nampak:** satu kotak besar navy bersudut bulat (tinggi 160px, lebar penuh), dengan bendera negara **besar** (56px) terapung di **tengah** kotak. Di sudut **kiri bawah** kotak, nama universiti (tebal, putih) dan bidang pengajian tersusun **dua baris** (kesan `\n` dalam teks). Di sudut **kanan atas** kotak, satu pill emas kecil bertulis `SPM`, `STAM`, atau `SPM atau STAM` bergantung kategori kemasukan program tersebut — kelihatan seperti "lencana" melekat pada banner, bukan sebahagian aliran teks biasa.

Perhatikan `CategoryPill` di sini ialah widget **sedia ada** daripada `widgets/programme_card.dart` — kita guna semula terus, bukan tulis pill baharu. Ini pengukuhan prinsip Hari 1: ekstrak widget kecil, guna semula di mana perlu.

Bila anda dah selesa dengan `Stack`+`Positioned` asas macam ni, cuba lanjutkan idea ini dengan bantuan AI — contohnya minta ia jana satu kad "hero" lebih lengkap:

```text
Konteks: Projek Flutter "eTT Mobile". Tema: KptTheme.navy (0xFF1A2B5C) + KptTheme.gold
(0xFFD4A017). Model data: Programme (universityName, country, city, fieldOfStudy,
category, estimatedAnnualCostMyr, quotaSeats).

Tugas: Jana satu StatelessWidget bernama `ProgrammeHeroCard` yang memaparkan satu
Programme sebagai kad "hero" besar — banner warna navy di atas (guna Stack),
universiti & bidang di bahagian bawah banner (teks putih), dan pill kategori
kemasukan ditindan di sudut kanan atas banner. Di bawah banner, papar kos
anggaran tahunan dalam RM dan senarai dokumen diperlukan (ettDocumentChecklist)
sebagai baris cip kecil.

Kekangan: guna widget Flutter standard sahaja (jangan import pakej luar).
Kekalkan gaya kod konsisten dengan widgets/programme_card.dart sedia ada.
```

AI biasanya akan pulangkan sesuatu yang **berfungsi**, tetapi jarang sempurna pada percubaan pertama. Perkara biasa yang perlu anda perbetulkan sendiri:

- **`const` yang hilang** pada widget statik (contoh `Container(height: 140, color: KptTheme.navy)`) — `flutter analyze` akan tunjuk `prefer_const_constructors`.
- **`Row` untuk cip dokumen boleh overflow** — `ettDocumentChecklist` ada **6** item, lebih daripada muat dalam satu baris skrin telefon (ingat Bahagian 2 di atas). AI selalunya tidak fikirkan kes ini secara automatik; gantikan `Row` dengan `Wrap(spacing: 6, children: ...)` yang secara automatik "lipat" ke baris baharu.
- **Warna hardcoded baharu** — jika AI menjana `Color(0xFF...)` baharu dan bukan rujuk `KptTheme.navy`/`KptTheme.gold`, gantikan supaya kekal konsisten jika tema bertukar kelak.

Lepas betulkan, jalankan `flutter analyze` sebelum sambung — ini tabiat yang patut jadi automatik setiap kali terima kod daripada AI, bukan langkah pilihan. Lihat [`nota/08-prompt-claude-code.md`](../nota/08-prompt-claude-code.md) untuk lebih banyak contoh prompt yang baik (konteks → model data → tugas khusus → kekangan).

### 3.3 `Align` & `Center` — meletak satu anak di dalam ruang lebih besar

`Center` ialah **kes khas** `Align` — ia sentiasa `Alignment.center`. `Align` lebih fleksibel: anda boleh letak anak di mana-mana titik dalam ruang ibu (`Alignment.topLeft`, `Alignment.bottomRight`, atau koordinat tersuai `-1.0` hingga `1.0`).

```dart
Align(
  alignment: Alignment.centerRight,
  child: Icon(Icons.chevron_right, color: KptTheme.navy),
);
```

**Apa yang anda patut nampak:** jika `Align` ini dibenamkan dalam `Container` yang lebih lebar daripada ikon itu sendiri (contoh `SizedBox(width: double.infinity, height: 40, child: Align(...))`), ikon anak panah akan kelihatan melekat di **tepi kanan** kotak itu, dengan ruang kosong di sebelah kirinya — berbeza daripada `Center` yang akan letak ikon **tepat di tengah**.

> **Bila guna `Stack`+`Positioned` berbanding `Align`?** `Positioned` menetapkan jarak **mutlak** dari sempadan `Stack` (contoh: "12px dari kanan atas"). `Align` menetapkan kedudukan **relatif** (contoh: "tengah-kanan") tanpa perlu `Stack` — cukup di dalam mana-mana widget induk yang mempunyai ruang lebih besar daripada anaknya (contoh: `Container` dengan tinggi tetap membalut satu `Icon`).

> **Ringkasan setakat ini:** `Stack` membenarkan widget bertindan (lapisan pertama = paling bawah). `Positioned` menetapkan jarak mutlak dari sempadan `Stack`. `Align`/`Center` meletak **satu** anak pada satu titik relatif dalam ruang induknya, tanpa perlu `Stack`. Cuba sendiri dalam **Latihan 2** (`snippets/lab.md`) — bina `ProgrammeBanner` penuh.

---

## 4. `Scaffold` & `AppBar` — Rangka Skrin

### 4.0 Kenapa perlu `Scaffold`?

Setakat ini kita hanya susun widget di dalam `body:` `MaterialApp` secara terus. Tetapi aplikasi sebenar hampir selalu perlukan **struktur baku**: bar tajuk di atas, ruang kandungan utama, mungkin bar navigasi di bawah dan panel sisi. Menulis semua ini secara manual setiap skrin (kedudukan bar atas, jarak selamat dari notch telefon, animasi buka/tutup drawer) amat membazir. `Scaffold` menyediakan **rangka Material Design siap pakai** untuk semua keperluan biasa ini, supaya anda cuma isikan bahagian yang relevan.

Hampir setiap skrin dalam Flutter (Material Design) bermula dengan `Scaffold` — ia menyediakan **struktur asas** halaman: bar atas, badan, navigasi bawah, drawer sisi, dan lebih.

```dart
Scaffold(
  appBar: AppBar(
    title: const Text('Program'),
  ),
  body: const Center(child: Text('Kandungan skrin di sini')),
);
```

**Apa yang anda patut nampak:** satu bar berwarna (mengikut tema — navy dalam projek kita) melekat di **paling atas** skrin dengan teks `'Program'` di dalamnya, dan di bawahnya kawasan putih/kelabu terang dengan teks `'Kandungan skrin di sini'` di **tengah**. `Scaffold` secara automatik mengelakkan kandungan bertindih dengan bar status telefon (jam, bateri) di paling atas — anda tidak perlu uruskan jarak selamat (*safe area*) secara manual.

Bahagian utama `Scaffold` yang kita guna hari ini:

| Parameter `Scaffold` | Fungsi |
|-----------------------|--------|
| `appBar` | Bar tajuk di atas — biasanya `AppBar` |
| `body` | Kandungan utama skrin |
| `drawer` | Panel sisi yang meluncur keluar dari kiri (Bahagian 5) |
| `bottomNavigationBar` | Bar tab di bawah skrin (Bahagian 5) |

`AppBar` sendiri menyokong `title`, `actions` (ikon di kanan), dan banyak lagi. Dalam projek kita, warna `AppBar` **tidak** ditetapkan setiap kali — ia datang secara automatik daripada `KptTheme` (lihat Bahagian 9):

```dart
appBarTheme: const AppBarTheme(
  backgroundColor: KptTheme.navy,
  foregroundColor: Colors.white,
  elevation: 0,
  centerTitle: false,
),
```

Ini bermakna **setiap** `AppBar()` polos dalam aplikasi — tanpa perlu nyatakan warna berulang kali — automatik navy dengan teks putih. Ini contoh pertama kenapa `ThemeData` global penting: konsistensi jenama tanpa mengulang kod warna di setiap skrin.

> **Ringkasan setakat ini:** `Scaffold` = rangka skrin standard (bar atas, kandungan, navigasi bawah, drawer). `AppBar` ialah bar atas paling biasa. Warna `AppBar` kita datang daripada `KptTheme.light`, bukan ditulis sebaris setiap skrin. Cuba sendiri dalam **Latihan 3** (`snippets/lab.md`).

---

## SESI 3 — Senarai Dinamik & Kemasan (Styling)

---

## 5. `BottomNavigationBar` & `Drawer` — Navigasi Peringkat Aplikasi

### 5.0 Kenapa perlukan dua lapisan navigasi berbeza?

Aplikasi eTT Mobile ada **tiga** bahagian besar yang pengguna perlu tukar-ganti dengan cepat (Program, Permohonan Saya, Profil) — untuk ini, tab tetap di bawah skrin (`BottomNavigationBar`) paling sesuai kerana ia **sentiasa kelihatan**, satu ketukan sahaja untuk bertukar. Tetapi penapisan negara (Mesir/Maghribi) ialah tindakan yang **kurang kerap** dilakukan — tidak wajar mengambil ruang skrin tetap untuk sesuatu yang jarang disentuh. Untuk keperluan sedemikian, `Drawer` (panel tersembunyi yang meluncur keluar bila diperlukan) lebih sesuai. Peraturan umum: **navigasi utama, kerap ditekan → `BottomNavigationBar`; pilihan sekunder, jarang ditekan → `Drawer`.**

Aplikasi sebenar sering mempunyai lebih daripada satu "bahagian utama". `eTT Mobile` mempunyai **tiga** bahagian: Program, Permohonan Saya, Profil — ditukar melalui tab di bawah skrin (`BottomNavigationBar`). Tambahan pula, panel sisi (`Drawer`) menyenaraikan **negara** eTT (Mesir & Maghribi) untuk tapisan pantas.

### 5.1 Struktur asas — tukar `body` mengikut tab dipilih

```dart
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
      appBar: AppBar(title: Text(_titles[_index])),
      body: _screens[_index],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _index,
        onTap: (i) => setState(() => _index = i),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.school_outlined), label: 'Program'),
          BottomNavigationBarItem(icon: Icon(Icons.assignment_outlined), label: 'Permohonan Saya'),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: 'Profil'),
        ],
      ),
    );
  }
}
```

**Apa yang anda patut nampak:** satu bar di **bawah sekali** skrin dengan tiga ikon + label (Program, Permohonan Saya, Profil). Tab yang **sedang aktif** ditonjolkan (warna berbeza — biasanya navy — berbanding tab lain yang kelabu). Menekan mana-mana tab menukar **kedua-dua** tajuk di `AppBar` **dan** seluruh kandungan `body` **serentak-merta**, tanpa animasi "muat semula" penuh skrin — kerana `body: _screens[_index]` cuma menukar rujukan widget, `Scaffold` yang sama kekal.

Perkara penting:

- `HomeScreen` **mesti** `StatefulWidget` — indeks tab yang dipilih (`_index`) **berubah** setiap kali pengguna menekan tab.
- `onTap: (i) => setState(() => _index = i)` — apabila pengguna menekan tab ke-`i`, kita panggil `setState()` supaya Flutter membina semula (*rebuild*) `Scaffold` dengan `_screens[_index]` yang baharu.
  > **Nota:** `setState()` diterangkan **penuh** di Hari 3 (SESI 5). Buat masa ini, anggap ia sekadar arahan "beritahu Flutter: nilai `_index` sudah berubah, sila lukis semula skrin".
- `_screens[_index]` menukar **keseluruhan** widget `body` kepada skrin yang sepadan dengan tab semasa.

### 5.2 Kod sebenar `screens/home_screen.dart` — dengan `Drawer`

Kod sebenar aplikasi menambah `drawer` yang menyenaraikan pilihan **negara** (Semua Negara / Mesir / Maghribi) untuk tapisan pantas:

```dart
Scaffold(
  appBar: AppBar(title: Text('eTT Mobile · ${_titles[_index]}')),
  drawer: _CountryDrawer(onSelect: _selectCountry),
  body: _screens[_index],
  bottomNavigationBar: BottomNavigationBar(/* ... seperti di atas ... */),
);
```

`Scaffold` **secara automatik** menambah ikon "hamburger" (☰) pada `AppBar` apabila `drawer` disediakan — anda tidak perlu tulis butang itu sendiri. Menekan ikon itu, atau leret (*swipe*) dari tepi kiri skrin, membuka `Drawer`.

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
                Text('eTT Mobile', style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
                SizedBox(height: 4),
                Text('Program pengajian Timur Tengah', style: TextStyle(color: Colors.white70, fontSize: 13)),
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

**Apa yang anda patut nampak:** menekan ☰ di `AppBar` (atau leret dari tepi kiri skrin) membuat panel putih **meluncur masuk** dari kiri, menutupi ~75% lebar skrin, dengan **overlay gelap separuh telus** di baki 25% kanan (kesan Material lalai — menekan overlay itu menutup semula `Drawer`). Di bahagian **atas** panel, satu kotak navy (`DrawerHeader`) memaparkan `'eTT Mobile'` (putih, besar, tebal) dengan sari kata kecil di bawahnya, teks tersebut **dilabuhkan ke bawah** kotak header (kesan `mainAxisAlignment: MainAxisAlignment.end`). Di bawah header, **tiga** baris (`ListTile`) tersenarai menegak: 🌍 Semua Negara, 🇪🇬 Mesir, 🇲🇦 Maghribi.

Perkara baharu di sini:

- **`DrawerHeader`** — bahagian atas `Drawer`, tempat lazim untuk logo/tajuk aplikasi. `mainAxisAlignment: MainAxisAlignment.end` melabuhkan teks ke bahagian bawah header (biasa untuk header berlatar warna).
- **`ListTile`** dalam senarai `Drawer` — lihat Bahagian 8 untuk `ListTile` secara terperinci.
- **`for (final option in _options) ListTile(...)`** — corak *collection-for* Dart: menjana satu `ListTile` bagi **setiap** rekod dalam senarai `_options` (Semua Negara, Mesir, Maghribi), terus di dalam senarai `children`. Ini setara `_options.map((o) => ListTile(...)).toList()` tetapi lebih ringkas dibaca.
- **`_CountryOption`** — kelas ringkas tiga medan (`value`, `label`, `flag`) sekadar pembungkus data untuk setiap baris drawer; `value` bernilai `null` bermaksud "tiada tapisan" (papar semua negara).

> **Pratonton (bukan fokus hari ini):** Kod sebenar `_CountryDrawer` turut memanggil `context.watch<ProgrammeProvider>().countryFilter` untuk menandakan negara yang **sedang dipilih** (`selected: selected == option.value`), dan `_selectCountry` memanggil `context.read<ProgrammeProvider>().filterByCountry(country)` untuk benar-benar menapis senarai. `context.watch`/`context.read` ialah cara skrin membaca & mengubah data daripada pakej **`provider`** — topik lanjutan yang diperkenalkan bermula Hari 3. Hari ini, fokus semata-mata pada **struktur** `BottomNavigationBar` + `Drawer`; anggap `onSelect(option.value)` sekadar `print('negara dipilih: ${option.label}')` buat masa ini jika anda membina dari kosong.

### Salah biasa: `Scaffold`/`BottomNavigationBar`/`Drawer`

| ❌ Yang selalu ditulis pemula | ✅ Pembetulan | Kenapa |
|---|---|---|
| `HomeScreen extends StatelessWidget` kemudian cuba tukar `_index` dalam `build()` | `HomeScreen extends StatefulWidget` dengan `_index` sebagai medan `State` | Tab yang aktif ialah **data yang berubah** akibat interaksi pengguna — hanya `StatefulWidget` + `setState()` boleh memicu Flutter melukis semula dengan nilai baharu (konsep Hari 1, Latihan 5). |
| `onTap: (i) { _index = i; }` (terlupa `setState`) | `onTap: (i) => setState(() => _index = i)` | Sama seperti kaunter Hari 1 — menukar pembolehubah **tanpa** `setState()` tidak melukis semula skrin; tab akan kelihatan "tersekat" walaupun nilai sebenarnya berubah. |
| Letak `bottomNavigationBar` **di dalam** `body:` (cuba letak `Column` merangkumi kandungan + bar tab) | Letak `bottomNavigationBar:` sebagai **parameter berasingan** `Scaffold`, sejajar dengan `body:` | `Scaffold` menguruskan kedudukan bar bawah secara automatik (termasuk *safe area*) — meletaknya manual dalam `body` boleh menyebabkan ia tertindih kandungan atau tidak melekat di bawah skrin semasa skrol. |
| Lupa `type: BottomNavigationBarType.fixed` bila ada **4 atau lebih** item | Tetapkan `type: BottomNavigationBarType.fixed` untuk kekalkan semua label kelihatan | Lalai Flutter (`shifting`) untuk 4+ item menganimasikan label supaya hanya tab aktif ada label — mengelirukan pemula pada mulanya. (Projek kita ada 3 item, jadi ini tidak berlaku, tetapi baik diketahui.) |

> **Ringkasan setakat ini:** `BottomNavigationBar` = navigasi utama, kerap ditekan, sentiasa kelihatan. `Drawer` = pilihan sekunder, tersembunyi sehingga dibuka. Kedua-duanya perlukan `HomeScreen` sebagai `StatefulWidget` supaya tab aktif (`_index`) boleh berubah melalui `setState()`. Cuba sendiri dalam **Latihan 5** (`snippets/lab.md`).

---

## 6. `ListView` vs `ListView.builder`

### 6.0 Kenapa ada dua cara berbeza untuk paparkan senarai?

Bayangkan anda perlu memaparkan senarai borang yang **tetap** (contoh: 4 medan input) berbanding senarai data yang **berpotensi besar dan berubah-ubah** (contoh: hasil carian universiti, yang mungkin 0, 8, atau kelak 500 rekod selepas API). Kedua-dua situasi ini ada trade-off yang berbeza — satu mengutamakan **kesederhanaan kod**, satu lagi mengutamakan **prestasi** apabila jumlah data besar. `ListView` (senarai tetap) dan `ListView.builder` (senarai dinamik "malas") wujud untuk dua situasi berbeza ini; memilih yang salah tidak akan "salah" pada 8 rekod kecil hari ini, tetapi jadi masalah prestasi sebenar apabila data berkembang.

### 6.1 `ListView` — senarai tetap, dibina serentak

`ListView(children: [...])` membina **semua** widget anak sekali gus, sama seperti `Column`, tetapi dengan keupayaan tambahan: ia **automatik membenarkan skrol** jika kandungan lebih panjang daripada skrin.

```dart
ListView(
  children: const [
    Text('Universiti Al-Azhar'),
    Text('Universiti Alexandria'),
    Text('Universite Al Quaraouiyine'),
  ],
);
```

**Apa yang anda patut nampak:** tiga baris teks tersusun menegak, **boleh diskrol** jika senarai itu lebih panjang daripada tinggi skrin (cuba tambah 20 lagi `Text` — anda akan boleh leret ke bawah untuk nampak selebihnya, sesuatu yang **tidak** berlaku secara automatik dengan `Column` biasa).

Sesuai untuk senarai **pendek dan tetap** (contohnya, senarai medan borang, atau kandungan skrin butiran seperti dalam Hari 3).

### 6.2 `ListView.builder` — senarai dinamik, dibina "malas" (*lazy*)

Untuk senarai data (lapan tawaran pengajian, berpotensi ratusan kelak selepas sambungan API di Hari 4), `ListView(children: [...])` **membazir** — ia membina *semua* widget serta-merta walaupun pengguna belum skrol sampai ke situ. `ListView.builder` menyelesaikan ini dengan membina widget **hanya apabila hampir kelihatan di skrin**.

```dart
ListView.builder(
  itemCount: sampleProgrammes.length,
  itemBuilder: (context, index) {
    final p = sampleProgrammes[index];
    return ProgrammeCard(programme: p);
  },
);
```

| Parameter | Fungsi |
|-----------|--------|
| `itemCount` | Berapa banyak item dalam senarai — Flutter guna ini untuk tahu bila skrol tamat |
| `itemBuilder` | Fungsi `(context, index) => Widget` — dipanggil **sekali bagi setiap item yang hampir kelihatan**, bukan semua sekali gus |

**Apa yang anda patut nampak:** secara visual, hasilnya **kelihatan sama** seperti `ListView(children: ...)` — lapan `ProgrammeCard` tersusun menegak, boleh diskrol. Bezanya **tidak nampak pada mata**, tetapi boleh dibuktikan: tambah `print('Kad dibina untuk: ${p.universityName}');` di dalam `itemBuilder`, jalankan dengan senarai **1000 item palsu**, dan lihat terminal — hanya ~10-15 baris `print` muncul pada mulanya (kad yang kelihatan di skrin), **bukan** 1000 baris serentak. Skrol ke bawah dan baris `print` baharu muncul secara beransur — bukti `ListView.builder` membina widget **hanya bila diperlukan**.

> **Kenapa "malas" (*lazy*) penting?** Bayangkan senarai 10,000 item. `ListView(children: [...])` akan cuba bina 10,000 widget serentak — lambat dan memakan memori. `ListView.builder` hanya bina ~10-15 widget yang kelihatan pada skrin pada satu masa, dan membina/memusnahkan widget lain secara dinamik semasa pengguna skrol. Untuk 8 tawaran pengajian hari ini perbezaannya tidak ketara — tetapi **tabiat** guna `.builder` untuk sebarang senarai data patut bermula dari sekarang.

### 6.3 Kod sebenar `screens/programme_list_screen.dart`

```dart
ListView.builder(
  padding: const EdgeInsets.only(bottom: 16),
  itemCount: items.length,
  itemBuilder: (context, index) {
    final p = items[index];
    return ProgrammeCard(
      programme: p,
      onTap: () { /* Hari 3: Navigator.push ke ProgrammeDetailScreen */ },
    );
  },
);
```

> **Pratonton (bukan fokus hari ini):** `items` dalam kod sebenar datang daripada `context.watch<ProgrammeProvider>().programmes` (senarai yang sudah ditapis carian/negara/kategori), dan `onTap` sudah menavigasi ke `ProgrammeDetailScreen` — kedua-duanya topik Hari 3. Hari ini cukup guna terus `sampleProgrammes` (senarai tetap daripada `data/sample_programmes.dart`) dan `onTap` kosong atau `print(...)`.

### Salah biasa: `ListView` di dalam `Column`

| ❌ Yang selalu ditulis pemula | ✅ Pembetulan | Kenapa |
|---|---|---|
| `Column(children: [Text('Tajuk'), ListView.builder(...)])` — letak `ListView` terus dalam `Column` | Bungkus `ListView.builder` dengan `Expanded(child: ListView.builder(...))` di dalam `Column` | `Column` cuba beri `ListView` **tinggi tidak terhad** (*unbounded height*) supaya ia boleh "sekecil kandungannya" — tetapi `ListView` pula mahu **mengisi semua ruang menegak** yang ada. Percanggahan ini melempar ralat masa jalan: *"Vertical viewport was given unbounded height"*. `Expanded` menyelesaikannya dengan memberi `ListView` had tinggi yang jelas (baki ruang `Column`). |
| Cuba selesaikan ralat di atas dengan `shrinkWrap: true` pada **senarai panjang/dinamik** | Guna `shrinkWrap: true` **hanya** untuk senarai pendek yang dibenamkan dalam `ListView`/`Column` lain (jarang perlu untuk senarai utama skrin) | `shrinkWrap: true` memaksa `ListView` mengukur **semua** anaknya dahulu untuk tahu tingginya — ini membatalkan faedah "malas" `.builder` sepenuhnya, dan **perlahan** untuk senarai panjang. |
| `ListView.builder(itemCount: sampleProgrammes.length + 1, itemBuilder: (c, i) => ProgrammeCard(programme: sampleProgrammes[i]))` — `itemCount` tidak sepadan panjang data sebenar | Pastikan `itemCount` **tepat** sepadan panjang senarai sumber (atau uruskan indeks tambahan secara eksplisit, cth. header) | `itemBuilder` akan cuba akses `sampleProgrammes[8]` yang tidak wujud (senarai hanya 8 item, indeks 0–7) — ralat masa jalan `RangeError: Index out of range`. |

> **Ringkasan setakat ini:** `ListView(children:...)` = senarai pendek/tetap, dibina serentak. `ListView.builder` = senarai dinamik, dibina "malas" mengikut `itemCount`+`itemBuilder`. `ListView` **tidak boleh** diletak terus dalam `Column` tanpa `Expanded`/`shrinkWrap`. Cuba sendiri eksperimen 1000-item dalam **Latihan 6** (`snippets/lab.md`).

---

## 7. `GridView` — Papar Grid Tawaran Pengajian

### 7.0 Kenapa grid, bukan senarai?

`ListView` sesuai bila pengguna perlu **baca** setiap rekod secara terperinci satu demi satu (nama panjang, subteks, kos — semua dalam satu baris lebar). Tetapi bila tujuan pengguna ialah **bandingkan sepintas lalu** berpuluh pilihan (macam melihat katalog produk), petak-petak kecil bersebelahan lebih cekap menggunakan ruang skrin dan lebih pantas diimbas mata berbanding senarai panjang menegak. `GridView` menyelesaikan keperluan "papar ringkas, banyak sekaligus" ini.

Untuk data yang lebih sesuai dipaparkan sebagai **petak** (bukan baris panjang) — contohnya membandingkan 8 tawaran pengajian sepintas lalu — `GridView` ialah pilihan lebih semula jadi daripada `ListView`.

```dart
GridView.builder(
  padding: const EdgeInsets.all(12),
  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: 2,       // 2 lajur
    mainAxisSpacing: 10,
    crossAxisSpacing: 10,
    childAspectRatio: 0.95,  // nisbah lebar:tinggi setiap petak
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
            Text(p.universityName, style: const TextStyle(fontWeight: FontWeight.bold), maxLines: 2, overflow: TextOverflow.ellipsis),
            Text(p.fieldOfStudy, style: const TextStyle(fontSize: 12), maxLines: 2, overflow: TextOverflow.ellipsis),
            const Spacer(),
            Text('${p.quotaSeats} tempat', style: const TextStyle(color: KptTheme.navy, fontSize: 12)),
          ],
        ),
      ),
    );
  },
);
```

**Apa yang anda patut nampak:** **8** kad kecil tersusun dalam **2 lajur** (4 baris), setiap kad memaparkan bendera negara di atas, nama universiti (maksimum 2 baris, dipotong `…` jika lebih panjang), bidang pengajian (juga maksimum 2 baris), ruang kosong yang mengembang (kesan `Spacer`) menolak baris terakhir — bilangan tempat — ke **bahagian bawah** setiap kad supaya semua kad kelihatan sekata tingginya walaupun panjang teks berbeza.

Bahagian penting `SliverGridDelegateWithFixedCrossAxisCount`:

| Parameter | Fungsi |
|-----------|--------|
| `crossAxisCount` | Bilangan **lajur** tetap (di sini: 2) |
| `mainAxisSpacing` / `crossAxisSpacing` | Jarak menegak / mendatar antara petak |
| `childAspectRatio` | Nisbah lebar berbanding tinggi setiap petak — `0.95` bermaksud setiap petak sedikit lebih tinggi daripada lebar |

`GridView.builder` sama seperti `ListView.builder` — ia **malas** (*lazy*), hanya membina petak yang hampir kelihatan. `sampleProgrammes` (8 rekod) daripada `data/sample_programmes.dart` ialah senarai `const` tetap, tiada `provider` terlibat — sesuai sebagai latihan `GridView` yang bersih tanpa kerumitan tambahan; kelak selepas API Hari 4, jumlah tawaran boleh berkembang jauh melebihi 8 tanpa mengubah struktur `GridView` ini.

> **`GridView.count` — alternatif ringkas.** Untuk grid kecil yang tidak perlu skrol berasingan (contohnya di dalam `ListView` lain, seperti kad ringkasan status dalam `ProfileScreen`), `GridView.count(crossAxisCount: 2, shrinkWrap: true, physics: const NeverScrollableScrollPhysics(), children: [...])` lebih ringkas — tiada `itemBuilder`, terus senaraikan `children`. Guna `GridView.builder` untuk grid **besar/dinamik** (seperti senarai tawaran pengajian di atas), dan `GridView.count` untuk grid **kecil/tetap** yang dibenamkan dalam skrin lain.

> **Ringkasan setakat ini:** `GridView` untuk paparan "banding sepintas lalu"; `ListView` untuk paparan "baca terperinci satu-satu". `childAspectRatio` mengawal nisbah lebar:tinggi setiap petak — nilai < 1 bermaksud petak lebih tinggi daripada lebar. Cuba sendiri dalam **Latihan 6** (`snippets/lab.md`).

---

## 8. `Card` & `ListTile`

### 8.0 Kenapa guna widget siap pakai, bukan bina sendiri setiap kali?

Corak "satu unit maklumat dalam bekas berbayang" dan "baris ikon+tajuk+subtajuk+trailing" begitu kerap muncul dalam aplikasi Material Design sehingga Flutter menyediakannya sebagai widget **siap pakai** — `Card` dan `ListTile`. Membina semula corak ini secara manual setiap kali (kotak + bayang + sudut bulat; atau `Row` dengan ikon+dua lajur teks+ikon lagi) bukan sahaja lebih banyak kod, ia juga lebih mudah tersasar daripada garis panduan Material rasmi (jarak, saiz ikon, potongan teks). `Card`/`ListTile` menjimatkan kod **dan** memastikan konsistensi visual automatik.

### 8.1 `Card` — bekas dengan bayang & sudut bulat

`Card` ialah bekas Material Design dengan **bayang (elevation)** dan **sudut bulat** secara lalai — pembalut biasa untuk satu "unit maklumat" (satu tawaran pengajian, satu permohonan).

```dart
Card(
  child: Padding(
    padding: const EdgeInsets.all(16),
    child: Text('Kandungan kad'),
  ),
);
```

**Apa yang anda patut nampak:** kotak putih bersudut bulat dengan **bayang lembut** (kesan `elevation`) di bawahnya — kelihatan seperti "terapung" sedikit di atas latar belakang skrin, berbeza daripada `Container` biasa yang rata tanpa bayang.

Dalam projek kita, gaya `Card` **tidak** ditetapkan berulang — ia datang daripada `KptTheme` (Bahagian 9):

```dart
cardTheme: CardThemeData(
  elevation: 1,
  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
  clipBehavior: Clip.antiAlias,
),
```

### 8.2 `ListTile` — baris standard "ikon + tajuk + subtajuk + trailing"

`ListTile` ialah widget **siap pakai** untuk corak baris yang amat biasa: ikon di kiri, tajuk, subtajuk kecil di bawah tajuk, dan widget di kanan (ikon anak panah, suis, dsb).

```dart
ListTile(
  leading: const Icon(Icons.school_outlined),
  title: const Text('Universiti Al-Azhar'),
  subtitle: const Text('Kaherah (Cairo), Mesir'),
  trailing: const Icon(Icons.chevron_right),
  onTap: () {},
);
```

**Apa yang anda patut nampak:** satu baris dengan ikon topi graduasi di **paling kiri**, di tengahnya dua baris teks bertindih menegak (`'Universiti Al-Azhar'` lebih besar di atas, `'Kaherah (Cairo), Mesir'` lebih kecil/pudar di bawah), dan ikon anak panah `›` di **paling kanan** — semuanya sejajar menegak dengan jarak dan saiz fon yang **konsisten** mengikut garis panduan Material, tanpa anda perlu tetapkan `SizedBox`/`Padding` secara manual seperti membina `Row` sendiri.

| Parameter | Kedudukan |
|-----------|-----------|
| `leading` | Kiri (biasanya `Icon` atau `CircleAvatar`) |
| `title` | Baris utama |
| `subtitle` | Baris kecil di bawah `title` |
| `trailing` | Kanan (biasanya `Icon` panah atau `Text` ringkas) |
| `onTap` | Callback bila baris ditekan (navigasi sebenar — Hari 3) |

`ListTile` sudah digunakan dalam `_CountryDrawer` sebenar (Bahagian 5.2) untuk setiap baris negara. Bandingkan dengan membina `Row(children: [Icon(...), Column(...), ...])` secara manual setiap kali — `ListTile` menjimatkan banyak kod berulang untuk corak baris standard ini.

> **`Card` + `ListTile` bersama** — corak amat biasa: bungkus `ListTile` di dalam `Card` untuk dapatkan bayang & sudut bulat serentak dengan struktur baris standard:
> ```dart
> Card(
>   margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
>   child: ListTile(
>     leading: const Icon(Icons.school_outlined, color: KptTheme.navy),
>     title: Text(programme.universityName),
>     subtitle: Text('${programme.fieldOfStudy} · ${programme.intakeMonth}'),
>     trailing: Text('${programme.quotaSeats} tempat'),
>   ),
> );
> ```
> Ini alternatif **lebih ringkas** berbanding `ProgrammeCard` tersuai penuh (Bahagian 1) — sesuai bila anda tidak perlukan susun atur istimewa (RM di kanan, pill kategori, dsb.), cuma perlu senarai baris seragam dengan cepat.

Kalau anda perlu banyak variasi kad/baris macam ni untuk skrin lain (contoh: senarai dokumen, senarai pilihan universiti dalam borang Hari 3), pantas untuk minta AI jana satu terus — *"Jana StatelessWidget `ProgrammeIntakeTile` — Card + ListTile, leading ikon sekolah warna KptTheme.navy, title universityName, subtitle 'fieldOfStudy · intakeMonth', trailing quotaSeats sebagai teks kecil"*. Semak macam biasa: `const` di tempat patut, warna rujuk `KptTheme` (bukan hex baharu), teks panjang dilindungi `overflow`/`Expanded`, dan `flutter analyze` bersih sebelum diguna pakai.

> **Ringkasan setakat ini:** `Card` = bekas bayang+sudut bulat untuk satu unit maklumat. `ListTile` = baris standard ikon+tajuk+subtajuk+trailing. Gabungan keduanya = senarai seragam yang cepat dibina, alternatif ringkas kepada kad tersuai penuh. Cuba sendiri dalam **Latihan 6** (`snippets/lab.md`).

---

## 9. Styling — `TextStyle`, Warna, Font & `ThemeData`

### 9.0 Kenapa `ThemeData`, bukan `TextStyle` sebaris di mana-mana?

Bayangkan aplikasi eTT Mobile mempunyai 15 skrin, dan setiap tajuk kad ditulis sebagai `TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF1A2B5C))` secara berasingan di setiap fail. Esok jenama KPT bertukar warna — anda terpaksa cari dan ganti puluhan salinan yang serupa, berisiko terlepas satu-dua tempat sehingga aplikasi kelihatan tidak konsisten. `ThemeData` wujud untuk mengelakkan senario ini: tetapkan gaya **sekali**, di **satu** tempat (`lib/theme.dart`), dan setiap widget standard (AppBar, Card, FilledButton, dsb.) di seluruh aplikasi automatik mewarisi gaya itu.

### 9.1 `TextStyle` — gaya untuk satu `Text`

```dart
Text(
  'Universiti Al-Azhar',
  style: TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: KptTheme.navy,
    fontStyle: FontStyle.normal,
    letterSpacing: 0.2,
  ),
);
```

`TextStyle` boleh ditulis terus **sebaris** (*inline*) seperti di atas — sesuai untuk gaya **sekali guna**. Tetapi bila gaya yang sama (contoh: navy + bold untuk semua tajuk kad) diulang di **banyak fail**, menulisnya berulang kali menyukarkan penyelenggaraan — jika jenama bertukar warna esok, anda perlu cari-ganti di puluhan tempat.

### 9.2 `ThemeData` — gaya global, satu tempat sahaja

`ThemeData` menyelesaikan masalah di atas: satu objek konfigurasi gaya untuk **keseluruhan aplikasi**, ditetapkan sekali di `MaterialApp(theme: ...)`. Fail sebenar `lib/theme.dart`:

```dart
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
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: navy,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 14),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}
```

Perkara penting:

- **`Color(0xFF1A2B5C)`** — format warna Flutter: `0xFF` (opaqueness penuh) + 6 digit heksadesimal RGB. `1A2B5C` = navy gelap; `D4A017` = emas.
- **`ColorScheme.fromSeed(seedColor: navy, ...)`** — Material 3 menjana **satu skema warna lengkap** (puluhan warna: `primary`, `onPrimary`, `surface`, `error`, dll) secara automatik daripada **satu** warna benih (*seed*). Kita override `primary`/`secondary` terus supaya sepadan jenama KPT (navy/gold), bukan warna terbitan automatik.
- **`appBarTheme`, `cardTheme`, `filledButtonTheme`, `inputDecorationTheme`** — setiap satu menetapkan gaya **lalai** untuk semua widget jenis itu merentasi aplikasi. Selepas ini, `AppBar()` polos di **mana-mana** skrin automatik navy+putih tanpa perlu tulis warna setiap kali (lihat Bahagian 4).
- **`KptTheme._()`** — constructor peribadi (*private*) tanpa nama; ini corak Dart untuk mengelakkan sesiapa mencipta `KptTheme()` — kelas ini hanya bekas untuk pemalar & getter statik, bukan untuk diinstankan.

Didaftarkan di `main.dart`:

```dart
MaterialApp(
  title: 'eTT Mobile — Latihan',
  theme: KptTheme.light,
  home: const HomeScreen(),
);
```

Kalau `ColorScheme.fromSeed` atau struktur `ThemeData` ini rasa padat pada mula, minta AI huraikan — *"Terangkan apa `ColorScheme.fromSeed` buat, dan kenapa saya override `primary`/`secondary` terus dalam KptTheme"* — atau, kalau nak cuba idea tema gelap, minta ia jana draf `static ThemeData get dark` berdasarkan struktur `light` di atas. Macam biasa: baca hasilnya baris demi baris, dan jalankan `flutter analyze` sebelum letak dalam projek sebenar.

### 9.3 Mengakses tema dalam widget — `Theme.of(context)`

Selain rujuk terus `KptTheme.navy`, Flutter juga membenarkan mengakses tema semasa melalui `Theme.of(context)` — berguna untuk gaya teks standard Material:

```dart
Text(
  'Program Popular',
  style: Theme.of(context).textTheme.titleMedium,
);
```

`textTheme` menyediakan set gaya teks piawai (`displayLarge`, `headlineSmall`, `titleMedium`, `bodyLarge`, `labelSmall`, dll) yang sudah konsisten dengan `ColorScheme` aplikasi. Untuk projek Hari 2 ini, kita kekal guna rujukan terus `KptTheme.navy`/`TextStyle` eksplisit demi kejelasan pemula — tetapi baik untuk tahu `Theme.of(context)` wujud sebagai alternatif lebih "Material-native".

### 9.4 Font

Secara lalai, Flutter guna fon sistem (`Roboto` di Android, `San Francisco` di iOS). Untuk fon tersuai, tetapkan `fontFamily` dalam `ThemeData`, atau guna pakej [`google_fonts`](https://pub.dev/packages/google_fonts) untuk akses ratusan fon Google Fonts tanpa muat turun fail fon secara manual. Projek `eTT Mobile` **tidak** menggunakan fon tersuai buat masa ini — fon sistem lalai memadai untuk bahan latihan ini.

Navy (`0xFF1A2B5C`) dan emas (`0xFFD4A017`) dalam `KptTheme` ialah pilihan reka bentuk untuk bahan kursus ini — eTT/KPT sendiri tidak menerbitkan palet warna korporat rasmi.

> **Eksperimen mudah untuk rasa kesan global `ThemeData`:** tukar sementara `navy` dalam `KptTheme` kepada `Color(0xFF6A1B9A)` (ungu) dan `flutter run` semula. Perhatikan `AppBar`, semua `Card`, dan mana-mana `FilledButton` di **seluruh** aplikasi turut bertukar ungu **serentak**, walaupun anda hanya ubah **satu baris** dalam **satu** fail. Ini bukti nyata kenapa `ThemeData` global menjimatkan kerja penyelenggaraan berbanding menulis `TextStyle`/`Color` sebaris berselerak di puluhan fail. Pulangkan semula kepada `0xFF1A2B5C` selepas mencuba.

> **Ringkasan setakat ini:** `TextStyle` sebaris = gaya sekali guna. `ThemeData` (`KptTheme.light`) = gaya global, satu tempat, kesan automatik merentasi seluruh aplikasi. `Theme.of(context).textTheme` = cara "Material-native" mengakses gaya teks tema semasa. Cuba sendiri dalam **Latihan 7** (`snippets/lab.md`).

---

## Troubleshooting Hari 2

Ralat paling kerap ditemui semasa belajar layout, navigasi, senarai & styling — dan cara membetulkannya:

| Simptom | Sebab | Pembetulan |
|---------|-------|------------|
| Jalur **kuning-hitam bergaris** di tepi `Row`/`Column`, mesej terminal `A RenderFlex overflowed by NN pixels` | Jumlah lebar/tinggi anak `Row`/`Column` melebihi ruang ibu | Bungkus widget yang **boleh** mengecil/dipotong dengan `Expanded` atau `Flexible`; untuk `Text`, tambah `overflow: TextOverflow.ellipsis`. Rujuk Bahagian 2. |
| Ralat masa jalan merah: `Incorrect use of ParentDataWidget. Expanded widgets must be placed inside Flex widgets` | `Expanded`/`Flexible` diletak **bukan** sebagai anak langsung `Row`/`Column`/`Flex` (cth. terus dalam `Container`) | Pastikan `Expanded`/`Flexible` **terus** menjadi salah satu `children:` sesebuah `Row`/`Column`, bukan dibalut lapisan lain terlebih dahulu. |
| Ralat masa jalan: `Vertical viewport was given unbounded height` (biasanya bila `ListView`/`GridView` dibenamkan dalam `Column`) | `Column` memberi ruang menegak **tidak terhad** kepada anaknya, tetapi `ListView`/`GridView` pula mahu mengisi **semua** ruang menegak yang ada | Bungkus `ListView`/`GridView` dengan `Expanded(child: ...)` di dalam `Column`, ATAU tetapkan `shrinkWrap: true` (hanya untuk senarai **pendek**). Rujuk Bahagian 6. |
| `Positioned` melempar ralat: *"Positioned widgets must directly inside a Stack widget"* | `Positioned` diletak bukan sebagai anak langsung `Stack` | Pastikan `Positioned` **terus** berada dalam senarai `children:` sesebuah `Stack`. |
| `RangeError: Index out of range` dalam `itemBuilder` `ListView.builder`/`GridView.builder` | `itemCount` tidak sepadan dengan panjang sebenar senarai sumber | Pastikan `itemCount: sampleProgrammes.length` (atau senarai sebenar yang digunakan), bukan nombor tetap yang mungkin tersasar bila data bertambah/berkurang. |
| Ikon hamburger (☰) tidak muncul di `AppBar`, `Drawer` tidak boleh dibuka | `drawer:` tidak ditetapkan pada `Scaffold`, atau `Scaffold` yang salah (cth. `Scaffold` bersarang) menerima `drawer` | Pastikan `drawer: _CountryDrawer(...)` ditetapkan pada `Scaffold` **paling luar** skrin (biasanya `HomeScreen`), bukan pada `Scaffold` lain yang bersarang. |
| Menekan tab `BottomNavigationBar` — ikon bertukar tetapi `body`/tajuk **tidak** berubah | Lupa `setState()` dalam `onTap`, atau `HomeScreen` tertulis sebagai `StatelessWidget` | Pastikan `HomeScreen extends StatefulWidget`, dan `onTap: (i) => setState(() => _index = i)`. Rujuk Bahagian 5 & Hari 1 Latihan 5. |
| `AppBar`/`Card` kelihatan **putih polos** tanpa warna navy, walaupun `KptTheme.light` sudah ditulis | `theme: KptTheme.light` tidak didaftarkan pada `MaterialApp` dalam `main.dart` | Semak `main.dart` — pastikan baris `theme: KptTheme.light,` wujud di dalam `MaterialApp(...)`. |
| `flutter analyze` melaporkan `prefer_const_constructors` berulang kali selepas tampal kod AI/lab | Widget statik (tiada nilai berubah) ditulis tanpa `const` di hadapan | Tambah `const` pada constructor widget yang semua parameternya juga `const`/pemalar — editor VS Code selalunya cadangkan pembetulan automatik (klik mentol kuning). |
| Skrin merah (*red screen of death*) selepas Hot Reload | Ralat sintaks/logik yang Flutter tidak dapat pulih tanpa *restart* penuh | Baca **baris pertama** mesej ralat pada skrin merah — biasanya nama fail + nombor baris tepat. Jika Hot Reload tidak menyelesaikan selepas pembetulan, cuba **Hot Restart** (`R` besar dalam terminal, atau ikon *restart* VS Code) — Hot Reload hanya menampal perubahan, Hot Restart memulakan semula keseluruhan aplikasi dari `main()`. |

---

## Rumusan & Tip Git

### Apa yang telah dipelajari

- **Susun atur asas:** `Row`/`Column`, `MainAxisAlignment`/`CrossAxisAlignment`, dan menyarang (*nest*) kedua-duanya untuk struktur kompleks.
- **`Expanded` vs `Flexible`** — menyelesaikan ralat *overflow* klasik dengan memberi ruang baki kepada widget yang perlu.
- **Susun atur bertindan** dengan `Stack`, `Positioned`, `Align`, `Center` — dibina sebagai `ProgrammeBanner` dengan pill kategori kemasukan ditindan.
- **`Scaffold`/`AppBar`** sebagai rangka standard setiap skrin, dan bagaimana `ThemeData` memberikannya gaya konsisten tanpa perlu tetapkan warna berulang.
- **Bantuan AI di sepanjang layout** — prompt yang khusus (Row kad, kad hero Stack, ListTile, ThemeData), semakan manual (`Wrap` vs `Row`, `const`, rujukan `KptTheme`), dan `flutter analyze` selepas setiap penjanaan.
- **`BottomNavigationBar` + `Drawer`** — rangka navigasi peringkat aplikasi untuk 3 tab dan penapisan negara eTT (Mesir/Maghribi).
- **`ListView` vs `ListView.builder`** — bila guna senarai tetap berbanding senarai dinamik "malas" (*lazy*).
- **`GridView`/`GridView.builder`** — memaparkan 8 tawaran pengajian sebagai grid 2 lajur.
- **`Card` & `ListTile`** — corak baris standard, dan gabungan kedua-duanya untuk senarai ringkas.
- **`ThemeData`/`TextStyle`** — gaya global vs gaya sebaris, dan struktur penuh `KptTheme` (warna, `AppBarTheme`, `CardThemeData`, `FilledButtonThemeData`, `InputDecorationTheme`).

### Tip Git

Setelah widget/skrin latihan hari ini boleh dijalankan tanpa ralat, simpan kemajuan anda secara berperingkat:

```bash
git add lib/widgets/programme_banner.dart \
        lib/screens/home_screen.dart
git commit -m "Hari 2: layout, navigasi bawah/drawer, senarai & grid, styling"
```

> **Amalan baik:** Commit berasingan mengikut ciri (contoh: satu commit untuk banner Stack, satu lagi untuk BottomNav+Drawer) memudahkan anda patah balik jika sesuatu tersasar kelak.

---

## Pratonton Hari 3

Esok kita mula sambungkan skrin: `Navigator.push`/`pop` untuk pergi ke skrin butiran program, `TextField`/`TextFormField` untuk borang permohonan pelajar, dan `setState()` diterangkan penuh sebagai asas pengurusan *state* kursus ini.

---

## Cabaran

Untuk pelajar yang mahu meneroka lebih jauh sebelum kelas esok:

1. Ubah `ProgrammeBanner` (Bahagian 3.2) supaya menambah **satu lagi** `Positioned` — pill kecil di sudut **kiri bawah** memaparkan `programme.countryLabel` (Mesir/Maghribi).
2. Cuba tukar `crossAxisCount` grid tawaran pengajian (Bahagian 7) daripada `2` kepada `3`, dan laraskan `childAspectRatio` supaya kad kekal kemas tanpa teks terpotong.
3. Tulis satu lagi contoh ralat *overflow* (Bahagian 2.1) dengan data anda sendiri, ambil tangkapan skrin jalur kuning-hitam, kemudian betulkan dengan `Expanded` — bandingkan sebelum & selepas.
4. Tambah satu warna baharu (`info`) dalam `KptTheme` (contoh: biru terang untuk mesej makluman), dan gunakan pada satu pill baharu yang memaparkan `'Pengambilan seterusnya: ...'` daripada `programme.intakeMonth`.

---

> 🎤 **Nota penceramah/jurulatih:** Nota persembahan untuk Hari 2 (SESI 2–3) sedang dikemas kini untuk agenda baharu ini dan akan disediakan berasingan.

---

> 🎤 **Nota penceramah/jurulatih:** [`nota-penceramah.md`](./nota-penceramah.md) — kumpulan nota persembahan (asalnya *speaker notes* dalam slaid) untuk Hari 2.

## Nota Tambahan (fakta ringkas dari slaid)

- **Kos & kuota dalam data contoh:** medan `estimatedAnnualCostMyr` dan `quotaSeats` dalam `Programme` adalah ilustrasi (diselaras dengan jadual USD rasmi 2021/22), kecuali kuota laluan Maghribi (**15 tempat**) yang merupakan angka rasmi.
- **Anatomi prompt AI yang baik** (kenapa contoh prompt sepanjang bab ini disusun begitu): **konteks** → **model data** → **tugas khusus** → **kekangan**. Empat bahagian ini menjadikan output AI jauh lebih tepat. Lihat [`../nota/08-prompt-claude-code.md`](../nota/08-prompt-claude-code.md).
</content>
