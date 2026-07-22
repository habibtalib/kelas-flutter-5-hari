# Lab Hari 3 — Navigasi, Borang & setState()

Lab ini menyambung terus projek **eTT Mobile** (`projek/ett_mobile`) dari Hari 1–2. Anda akan menyambungkan senarai tawaran pengajian kepada skrin butiran, mendaftar **named routes**, menghantar & memulangkan data antara skrin, membina **borang permohonan penuh** langkah demi langkah, dan menguasai `setState()` + kitaran hayat `StatefulWidget`. Rujuk [`README.md`](../README.md) Hari 3 untuk penjelasan "kenapa" setiap konsep — lab ini fokus kepada "macam mana", sub-langkah demi sub-langkah.

> **Peraturan lab:** Cuba tulis kod **sendiri** dahulu berdasarkan penerangan dalam README sebelum tengok fail rujukan penuh. Penyelesaian sebenar (versi projek, yang menggunakan `provider`) boleh dibanding di `projek/ett_mobile/lib/`. Lab ini memandu anda membina versi **`setState()`-sahaja** dahulu — itulah yang diajar rasmi SESI 5 — dan Bahagian 9 README membandingkannya dengan corak `provider`.

---

## Cara Baca Kod Dalam Lab Ini

Blok kod dalam lab ini menunjukkan **sekeping fail sebenar**, bukan baris terpencil. Dua penanda digunakan sepanjang lab:

```dart
// ╔══════════════════════════════════════════╗
// ║  LANGKAH X.Y — kod anda masuk DI SINI    ║
// ╚══════════════════════════════════════════╝
```

Kotak ini menandakan **kawasan kosong** yang anda isi pada langkah `X.Y` — biasanya rangka yang belum ada apa-apa lagi.

```dart
  const Text('sesuatu yang sudah ada'),

  // 👈 X.Y — TAMBAH <benda> SELEPAS BARIS INI
```

Komen `👈` menandakan **titik tepat** untuk menyisip kod baharu **selepas** baris yang ditunjuk. Baris `// ...` (tiga titik) bermaksud "kod sedia ada, jangan ubah — dipendekkan supaya fokus kepada bahagian relevan". Selepas setiap langkah, lab tunjukkan **hasil** (kawasan yang sama, sudah diisi) supaya anda boleh semak sendiri sebelum teruskan.

### Dua penanda ujian — apa bezanya

Lab ini ada **dua** jenis arahan menguji. Jangan keliru:

| Penanda | Maksud | Perlu buat? |
|---|---|---|
| ▶ **Jalankan** | Semakan **pantas** di tengah langkah — Hot Reload, pandang skrin sekejap, teruskan. Ambil ~10 saat. | Ya, tetapi ringkas |
| 🧪 **Uji Latihan N** | Ujian **penuh** di hujung setiap latihan. Ada **laluan navigasi** ("macam mana nak sampai ke skrin itu"), jadual langkah demi langkah, dan petua bila gagal. | **Ya — jangan langkau.** Ini bukti latihan anda betul |

Setiap blok 🧪 **Uji** disusun begini:

> **Sampai ke sana:** langkah navigasi dari skrin mula — supaya anda tidak tercari-cari.
>
> Kemudian jadual: **Buat ini** → **Patut nampak**. Buat ikut turutan, dari atas ke bawah.
>
> Akhir sekali **❌ Tak jadi?** — senarai punca paling biasa, supaya anda boleh baiki sendiri tanpa tunggu jurulatih.

---

## Persediaan

1. Pastikan projek Hari 1–2 anda boleh dijalankan tanpa ralat:

   ```bash
   cd projek/ett_mobile
   flutter pub get
   flutter run
   ```

2. **Salin fail permulaan (foundation) Hari 3.** Borang hari ini perlukan model `Application`, senarai dokumen, dan `StatusBadge`. Salin folder [`starter/`](./starter/) ke `lib/` (rujuk [`starter/README.md`](./starter/README.md)). Folder ini **kumulatif** — kalau anda sudah salin fail Hari 2, cuma **tiga fail baharu** yang diperlukan:

   ```bash
   # dari dalam folder projek ett_mobile anda
   mkdir -p lib/models lib/widgets
   cp <laluan-repo>/hari-3/snippets/starter/models/application.dart      lib/models/application.dart
   cp <laluan-repo>/hari-3/snippets/starter/data/document_checklist.dart lib/data/document_checklist.dart
   cp <laluan-repo>/hari-3/snippets/starter/widgets/status_badge.dart    lib/widgets/status_badge.dart
   ```

   > Jika anda mula terus dari Hari 3 (terlepas Hari 2), salin **keseluruhan** folder `starter/` — ia mengandungi juga `theme.dart`, `programme.dart`, `sample_programmes.dart`, `programme_card.dart`.

3. Sahkan struktur anda kini mempunyai sekurang-kurangnya:

   ```
   lib/models/programme.dart
   lib/models/application.dart          ← starter Hari 3
   lib/data/sample_programmes.dart
   lib/data/document_checklist.dart     ← starter Hari 3
   lib/widgets/programme_card.dart
   lib/widgets/status_badge.dart        ← starter Hari 3
   lib/screens/home_screen.dart
   lib/screens/programme_list_screen.dart
   ```

4. **Cipta `lib/utils/validators.dart`** — empat fungsi validator yang kita gunakan pada Latihan 4. Perhatikan ia **Dart tulen** (tiada `import 'package:flutter/...'`), jadi setiap fungsi boleh diuji sendiri, dan tandatangannya (`String? Function(String?)`) sepadan **terus** dengan parameter `validator:` pada `TextFormField` — cukup hantar nama fungsi, cth. `validator: validateIcNumber`.

   ```bash
   mkdir -p lib/utils
   ```

   ```dart
   // lib/utils/validators.dart
   // Dart tulen — tiada import Flutter, jadi mudah diuji sendiri.

   /// Validator generik untuk medan wajib diisi.
   /// Cth: validateRequired(value, 'Nama Penuh') -> "Nama Penuh diperlukan"
   String? validateRequired(String? value, String fieldLabel) {
     if (value == null || value.trim().isEmpty) {
       return '$fieldLabel diperlukan';
     }
     return null;
   }

   /// No. Kad Pengenalan Malaysia.
   /// Peraturan latihan (bukan semakan digit semak rasmi JPN):
   /// wajib diisi · hanya digit & sengkang · TEPAT 12 digit selepas buang '-'.
   /// Menerima '051231145678' dan '051231-14-5678'.
   String? validateIcNumber(String? value) {
     if (value == null || value.trim().isEmpty) {
       return 'No. Kad Pengenalan diperlukan';
     }
     final trimmed = value.trim();
     if (!RegExp(r'^[0-9-]+$').hasMatch(trimmed)) {
       return 'No. Kad Pengenalan hanya boleh mengandungi digit dan sengkang (-)';
     }
     final digits = trimmed.replaceAll('-', '');
     if (digits.length != 12) {
       return 'No. Kad Pengenalan mesti 12 digit (cth: 051231-14-5678)';
     }
     return null;
   }

   /// Format emel ringkas (bukan RFC 5322 penuh — cukup untuk borang latihan).
   String? validateEmail(String? value) {
     if (value == null || value.trim().isEmpty) {
       return 'Emel diperlukan';
     }
     final trimmed = value.trim();
     final regex = RegExp(r'^[\w.+-]+@[\w-]+\.[\w.-]+$');
     if (!regex.hasMatch(trimmed)) {
       return 'Format emel tidak sah';
     }
     return null;
   }

   /// No. telefon (Malaysia/antarabangsa): buang ruang & sengkang, kemudian
   /// terima 9–15 digit dengan awalan '+' pilihan.
   /// Cth sah: '0123456789', '012-345 6789', '+60123456789'.
   String? validatePhoneNumber(String? value) {
     if (value == null || value.trim().isEmpty) {
       return 'No. Telefon diperlukan';
     }
     final digits = value.trim().replaceAll(RegExp(r'[\s-]'), '');
     if (!RegExp(r'^\+?\d{9,15}$').hasMatch(digits)) {
       return 'No. Telefon tidak sah (cth: 0123456789)';
     }
     return null;
   }
   ```

   > Malas menaip? Salinan penuh fail ini ada di [`validators.dart`](./validators.dart) — tetapi cuba **taip sendiri** dahulu; corak `if (kosong) return mesej; ... return null;` inilah yang anda ulang untuk setiap validator baharu di Latihan 5.

5. Jalankan `flutter analyze` — pastikan tiada ralat sebelum bermula.

✅ **Semakan Persediaan:** `flutter run` berjaya, `lib/models/application.dart` wujud, dan `lib/utils/validators.dart` wujud dengan empat fungsi (`validateRequired`, `validateIcNumber`, `validateEmail`, `validatePhoneNumber`).

---

## Latihan 1 — `Navigator.push` & `pop` ke Skrin Butiran

**Matlamat:** Tekan kad tawaran dalam senarai membuka skrin butiran; butang kembali menutupnya semula.

### 1.1 — Cipta `ProgrammeDetailScreen` (versi ringkas dahulu)

Jika `lib/screens/programme_detail_screen.dart` belum wujud, cipta fail baharu dengan rangka ini — `StatelessWidget` yang menerima `Programme` melalui constructor:

```dart
// lib/screens/programme_detail_screen.dart
import 'package:flutter/material.dart';

import '../models/programme.dart';

class ProgrammeDetailScreen extends StatelessWidget {
  const ProgrammeDetailScreen({super.key, required this.programme});

  final Programme programme;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(programme.universityName)),
      body: Center(
        child: Text('${programme.city}, ${programme.countryLabel}'),
      ),
    );
  }
}
```

### 1.2 — Sambungkan dari senarai

Buka `lib/screens/programme_list_screen.dart`. Cari `onTap` pada `ProgrammeCard` di dalam `ListView.builder` — ia mungkin masih kosong atau tiada langsung:

```dart
              return ProgrammeCard(
                programme: p,
                // 👈 1.2 — TAMBAH onTap SELEPAS BARIS INI
              );
```

Ganti dengan:

```dart
              return ProgrammeCard(
                programme: p,
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => ProgrammeDetailScreen(programme: p),
                  ),
                ),
              );
```

Import `programme_detail_screen.dart` di atas fail jika belum ada. Jalankan app, tekan mana-mana kad tawaran.

▶ **Jalankan** (Hot Reload) → menekan kad membuka skrin baharu dengan `AppBar` memaparkan nama universiti, dan `Text` di tengah memaparkan bandar + negara.

### 🧪 Uji Latihan 1

> **Sampai ke sana:** `flutter run` → aplikasi buka pada tab **Program** (senarai 8 tawaran).

> ⚠️ **Perhatian sebelum menguji:** kad **1, 2 dan 3 semuanya "Universiti Al-Azhar"** — bezanya pada **bidang** (Perubatan / Syariah / Ulum Islamiah). Jadi jangan uji dengan kad 1 vs kad 2 sahaja; anda akan nampak nama sama dan tersilap sangka ada pepijat. Guna kad **1, 4 dan 7** yang jelas berbeza.

| # | Buat ini | Patut nampak |
|---|---|---|
| 1 | Tekan kad **ke-1** (Al-Azhar · Perubatan) | Skrin baharu. `AppBar` = "Universiti Al-Azhar", bidang = **Perubatan** |
| 2 | Tekan butang kembali `←` | Kembali ke senarai |
| 3 | Tekan kad **ke-4** (Universiti Alexandria · Farmasi) | `AppBar` = "Universiti Alexandria" — **bukan** Al-Azhar |
| 4 | Kembali, tekan kad **ke-7** (Universite Al Quaraouiyine) | `AppBar` = nama itu, lokasi = "Fes, Maghribi" 🇲🇦 |
| 5 | *(pilihan)* Kembali, tekan kad **ke-2** (Al-Azhar · Syariah) | Nama universiti **sama** dengan kad 1, tetapi **bidang berbeza** — ini betul, bukan pepijat |

❌ **Tak jadi?**
- Tiada apa berlaku bila kad ditekan → `onTap:` belum ditambah pada `ProgrammeCard` (langkah 1.2).
- Kad ke-4 & ke-7 pun tunjuk **Al-Azhar** → anda hantar `sampleProgrammes[0]`/`.first`, sepatutnya `p` (item gelung itu).
- `Undefined name 'ProgrammeDetailScreen'` → import `programme_detail_screen.dart` belum ditambah di atas fail.

---

## Latihan 2 — Named Routes

**Matlamat:** Daftar laluan `/detail` di `MaterialApp` dan navigasi menggunakan nama + `arguments`, sebagai alternatif kepada `push` terus.

### 2.1 — Daftar `onGenerateRoute`

Buka `lib/main.dart`. Cari `MaterialApp(...)` di dalam `build()` kelas `EttMobileApp`:

```dart
      child: MaterialApp(
        title: 'eTT Mobile — Latihan',
        debugShowCheckedModeBanner: false,
        theme: KptTheme.light,
        home: const HomeScreen(),
        // 👈 2.1 — TAMBAH onGenerateRoute SELEPAS BARIS INI
      ),
```

Tambah `onGenerateRoute` (perlukan import `models/programme.dart` dan `screens/programme_detail_screen.dart` di atas fail):

```dart
      child: MaterialApp(
        title: 'eTT Mobile — Latihan',
        debugShowCheckedModeBanner: false,
        theme: KptTheme.light,
        home: const HomeScreen(),
        onGenerateRoute: (settings) {
          if (settings.name == '/detail') {
            final programme = settings.arguments as Programme;
            return MaterialPageRoute(
              builder: (_) => ProgrammeDetailScreen(programme: programme),
            );
          }
          return null; // laluan tidak dikenali
        },
      ),
```

### 2.2 — Navigasi dengan `pushNamed`

Kembali ke `lib/screens/programme_list_screen.dart`. Buat **satu** salinan uji sahaja — tukar `onTap` kad **pertama** dalam senarai kepada named route, untuk banding dengan `push` terus pada kad-kad lain:

```dart
              return ProgrammeCard(
                programme: p,
                onTap: index == 0
                    ? () => Navigator.of(context).pushNamed('/detail', arguments: p)
                    : () => Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => ProgrammeDetailScreen(programme: p),
                          ),
                        ),
              );
```

Jalankan app — kad pertama sepatutnya masih membuka skrin butiran yang sama, walaupun melalui laluan berbeza.

▶ **Jalankan** (Hot Reload) → kad pertama & kad lain kedua-duanya buka `ProgrammeDetailScreen`, tiada beza kelihatan pada UI — bezanya cuma **cara** navigasi berlaku "di belakang tabir".

**Eksperimen — kenapa named routes kurang selamat jenis:**

| Cuba tukar | Perhatikan apa jadi | Kesimpulan |
|---|---|---|
| `arguments: p` (asal) | Skrin butiran buka normal | `settings.arguments as Programme` berjaya |
| `arguments: 'salah jenis'` | App **crash** dengan `type 'String' is not a subtype of type 'Programme'` semasa `as Programme` dijalankan | Named routes **kurang selamat jenis (type-safe)** — ralat hanya muncul masa jalan (*runtime*), bukan masa `flutter analyze` |

Kembalikan `arguments: p` selepas mencuba.

### 🧪 Uji Latihan 2

> **Sampai ke sana:** `flutter run` → tab **Program**.

| # | Buat ini | Patut nampak |
|---|---|---|
| 1 | Tekan kad **ke-1** — ini sahaja yang guna `pushNamed('/detail')` | Skrin butiran terbuka seperti biasa (Al-Azhar · Perubatan) |
| 2 | Kembali `←`, tekan kad **ke-4** (Alexandria) — guna `push` terus | Skrin butiran juga terbuka, kali ini Alexandria |
| 3 | Banding kedua-duanya | Hasil **sama**; yang berbeza hanya **cara** navigasi di belakang tabir |

Itulah intinya: named route dan `push` terus memberi hasil sama, tetapi named route **kurang selamat jenis** (lihat jadual eksperimen di atas).

❌ **Tak jadi?**
- Kad pertama tak buat apa-apa / skrin putih → `onGenerateRoute` belum didaftar dalam `MaterialApp`, atau nama laluan tersalah eja (mesti tepat `/detail`).
- Ranap `type 'Null' is not a subtype of type 'Programme'` → anda lupa hantar `arguments: p` pada `pushNamed`.

---

## Latihan 3 — Uji Corak Hantar/Pulang Data (Skeleton Borang)

**Matlamat:** Sebelum membina borang **penuh** (Latihan 4), bina rangka minimum `ApplicationFormScreen` dan pastikan corak "hantar data keluar" (`pop(value)` + `await push<T>()` daripada README Bahagian 4.2) benar-benar berfungsi.

### 3.1 — Model `Application`

Anda sepatutnya sudah menyalin `lib/models/application.dart` daripada folder [`starter/`](./starter/) pada langkah Persediaan — jadi ia sudah wujud dan lengkap (termasuk `toJson`/`fromJson`). Berikut ringkasan strukturnya sebagai rujukan (versi penuh: `projek/ett_mobile/lib/models/application.dart`):

```dart
// lib/models/application.dart
import 'programme.dart';

enum ApplicationStatus {
  submitted, underReview, eligible, notEligible, offered, accepted, rejected;

  String get label => switch (this) {
        ApplicationStatus.submitted => 'Dihantar',
        ApplicationStatus.underReview => 'Dalam Semakan',
        ApplicationStatus.eligible => 'Layak',
        ApplicationStatus.notEligible => 'Tidak Layak',
        ApplicationStatus.offered => 'Tawaran',
        ApplicationStatus.accepted => 'Diterima',
        ApplicationStatus.rejected => 'Ditolak',
      };
}

class Application {
  final String id;
  final String fullName;
  final String icNumber;
  final String email;
  final String phoneNumber;
  final EntryCategory academicCategory;
  final String academicSummary;
  final String country;       // 1 negara (peraturan eTT)
  final String fieldOfStudy;  // 1 bidang (peraturan eTT)
  final List<String> universityChoiceIds; // 1-3 pilihan
  final List<String> uploadedDocuments;
  final ApplicationStatus status;
  final DateTime? submittedAt;

  const Application({
    required this.id,
    required this.fullName,
    required this.icNumber,
    required this.email,
    required this.phoneNumber,
    required this.academicCategory,
    required this.academicSummary,
    required this.country,
    required this.fieldOfStudy,
    required this.universityChoiceIds,
    this.uploadedDocuments = const [],
    this.status = ApplicationStatus.submitted,
    this.submittedAt,
  });
}
```

### 3.2 — Rangka `ApplicationFormScreen` (dummy submit)

Cipta `lib/screens/application_form_screen.dart` — **rangka minimum** sahaja, borang penuh di Latihan 4:

```dart
// lib/screens/application_form_screen.dart
import 'package:flutter/material.dart';

import '../models/application.dart';
import '../models/programme.dart';

class ApplicationFormScreen extends StatefulWidget {
  const ApplicationFormScreen({super.key, required this.programme});

  final Programme programme;

  @override
  State<ApplicationFormScreen> createState() => _ApplicationFormScreenState();
}

class _ApplicationFormScreenState extends State<ApplicationFormScreen> {
  void _submitDummy() {
    final application = Application(
      id: 'ETT-UJIAN-${DateTime.now().millisecondsSinceEpoch}',
      fullName: 'Ujian Sahaja',
      icNumber: '000000000000',
      email: 'ujian@contoh.my',
      phoneNumber: '0123456789',
      academicCategory: EntryCategory.spm,
      academicSummary: 'Ujian',
      country: widget.programme.country,
      fieldOfStudy: widget.programme.fieldOfStudy,
      universityChoiceIds: [widget.programme.id],
      status: ApplicationStatus.submitted,
      submittedAt: DateTime.now(),
    );
    Navigator.of(context).pop(application); // pulangkan objek ke skrin sebelumnya
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Borang Permohonan')),
      body: Center(
        child: FilledButton(
          onPressed: _submitDummy,
          child: const Text('Hantar (Ujian)'),
        ),
      ),
    );
  }
}
```

### 3.3 — Sambungkan daripada skrin butiran (`await push<T>()`)

Buka `lib/screens/programme_detail_screen.dart`. Tukar kelas kepada `StatefulWidget` (ia perlu `setState()` untuk kemas kini butang selepas permohonan berjaya):

```dart
class ProgrammeDetailScreen extends StatefulWidget {
  const ProgrammeDetailScreen({super.key, required this.programme});

  final Programme programme;

  @override
  State<ProgrammeDetailScreen> createState() => _ProgrammeDetailScreenState();
}

class _ProgrammeDetailScreenState extends State<ProgrammeDetailScreen> {
  bool _sudahMohon = false;

  // 👈 3.3 — TAMBAH _mohon() SELEPAS BARIS INI
```

Tambah kaedah `_mohon()` dan sambungkan ke butang dalam `build()`:

```dart
  Future<void> _mohon() async {
    final hasil = await Navigator.of(context).push<Application>(
      MaterialPageRoute(
        builder: (_) => ApplicationFormScreen(programme: widget.programme),
      ),
    );
    if (!mounted) return; // skrin mungkin sudah ditutup semasa menunggu
    if (hasil != null) {
      setState(() => _sudahMohon = true);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Permohonan ${hasil.id} berjaya dihantar!')),
      );
    }
  }
```

> `if (!mounted) return;` **selepas** `await` ialah pemeriksaan yang README Bahagian 8.4 & 10 ajar — ia mengelak `ScaffoldMessenger.of(context)` daripada cuba guna `context` sekiranya pengguna entah bagaimana sudah tinggalkan skrin ini semasa borang masih terbuka.

Dalam `build()`, ganti butang "Mohon" (atau tambah baharu jika belum ada):

```dart
                FilledButton.icon(
                  onPressed: _sudahMohon ? null : _mohon,
                  icon: Icon(_sudahMohon ? Icons.check : Icons.app_registration),
                  label: Text(_sudahMohon ? 'Anda Telah Memohon' : 'Mohon'),
                ),
```

Import `application_form_screen.dart` dan `models/application.dart` di atas fail.

### 🧪 Uji Latihan 3

> **Sampai ke sana:** `flutter run` → tab **Program** → tekan mana-mana kad → anda berada di **skrin butiran**.

**Bahagian A — hantar data balik (laluan berjaya):**

| # | Buat ini | Patut nampak |
|---|---|---|
| 1 | Tekan butang **"Mohon"** | Borang skeleton terbuka |
| 2 | Tekan **"Hantar (Ujian)"** | Borang **tertutup** sendiri, kembali ke skrin butiran |
| 3 | Pandang bawah skrin butiran | `SnackBar`: "Permohonan ETT-UJIAN-… berjaya dihantar!" |
| 4 | Pandang butang "Mohon" | Sudah bertukar → **"Anda Telah Memohon"**, kelabu & tidak boleh ditekan |

**Bahagian B — batal (laluan `null`) — jangan langkau, ini yang membuktikan `if (hasil != null)`:**

| # | Buat ini | Patut nampak |
|---|---|---|
| 5 | Kembali ke senarai, buka kad **lain**, tekan "Mohon" | Borang terbuka |
| 6 | Tekan butang kembali `←` **tanpa** menekan "Hantar" | Borang tertutup |
| 7 | Perhati skrin butiran | **TIADA** `SnackBar`, butang **kekal** "Mohon" |

Langkah 7 membuktikan `hasil` benar-benar `null` bila borang ditutup tanpa hantar.

❌ **Tak jadi?**
- `SnackBar` muncul walaupun anda tekan `←` → anda terlupa `if (hasil != null)` dalam `_mohon()`.
- Butang tak bertukar selepas hantar → `setState(() => _sudahMohon = true)` tidak dipanggil, atau skrin masih `StatelessWidget`.
- Amaran `use_build_context_synchronously` → `if (!mounted) return;` belum ditambah selepas `await`.

---

## Latihan 4 — Bina Borang Permohonan Sepenuhnya

**Matlamat:** Gantikan `_submitDummy()` skeleton Latihan 3 dengan borang **sebenar**: `Form` + `GlobalKey<FormState>`, `TextEditingController` untuk setiap medan, validator daripada `lib/utils/validators.dart`, dropdown negara/bidang **saling bergantung** (peraturan eTT: 1 negara + 1 bidang), 1–3 pilihan universiti, senarai semak dokumen, dan `_submit()` sebenar. Kita bina **tanpa `provider`** — versi `setState()`-sahaja yang diajar rasmi SESI 5 (README Bahagian 6.7 membandingkannya dengan versi projek sebenar yang guna `provider`).

### 🧭 Fail Permulaan Latihan 4

Pastikan `lib/screens/application_form_screen.dart` anda kini kelihatan seperti ini (kekalkan `_submitDummy()` buat sementara — kita gantikan pada 4.12):

```dart
import 'package:flutter/material.dart';

import '../models/application.dart';
import '../models/programme.dart';

class ApplicationFormScreen extends StatefulWidget {
  const ApplicationFormScreen({super.key, required this.programme});

  final Programme programme;

  @override
  State<ApplicationFormScreen> createState() => _ApplicationFormScreenState();
}

class _ApplicationFormScreenState extends State<ApplicationFormScreen> {
  // ╔══════════════════════════════════════════════════╗
  // ║  4.1 — _formKey masuk DI SINI                    ║
  // ╚══════════════════════════════════════════════════╝

  // ╔══════════════════════════════════════════════════╗
  // ║  4.2 — Controller masuk DI SINI                  ║
  // ╚══════════════════════════════════════════════════╝

  void _submitDummy() { /* ... kod Latihan 3, buang pada 4.12 ... */ }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Borang Permohonan')),
      body: Center(
        child: FilledButton(
          onPressed: _submitDummy,
          child: const Text('Hantar (Ujian)'),
        ),
      ),
    );
  }
}
```

### 4.1 — `GlobalKey<FormState>` & rangka `Form`

Ganti kotak `╔ 4.1 ╗` dengan kunci borang:

```dart
  // ── 4.1 — Kunci borang ────────────────────────────
  final _formKey = GlobalKey<FormState>();
```

Kemudian bina rangka `Form` dalam `build()` — ganti **seluruh** `body:` sedia ada:

```dart
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Borang Permohonan eTT')),
      body: Form(
        key: _formKey,
        // PENTING: SingleChildScrollView + Column, BUKAN ListView.
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Maklumat Pemohon',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),

              // ╔══════════════════════════════════════╗
              // ║  4.4 — TextFormField masuk DI SINI   ║
              // ╚══════════════════════════════════════╝
            ],
          ),
        ),
      ),
    );
  }
```

> ⚠️ **Kenapa BUKAN `ListView` di dalam `Form`?** `ListView` bersifat **malas** (*lazy*) — medan yang ditatal keluar skrin akan **dilupuskan**, dan `FormField` yang dilupuskan **terkeluar daftar** `Form`. Akibatnya `_formKey.currentState!.validate()` hanya menyemak medan yang **sedang kelihatan**: pada telefon skrin kecil, menatal ke bawah untuk tekan "Hantar" boleh membuat borang **kosong "lulus"** validation, lalu ranap pada baris `!` seperti `_academicCategory!`. `SingleChildScrollView` + `Column` membina **semua** medan sekali gus, jadi validation menyemak kesemuanya.

▶ **Jalankan** (Hot Reload) → skrin sepatutnya masih kelihatan hampir sama (tajuk "Maklumat Pemohon"), tetapi `FilledButton` "Hantar (Ujian)" kini **hilang** — itu normal, kita belum tambah semula. `Form` sendiri **tidak** kelihatan (ia widget tak-visual yang menguruskan pengesahan — sama seperti `Column` dari segi susun atur).

### 4.2 — `TextEditingController` untuk setiap medan (Input Controller)

Ganti kotak `╔ 4.2 ╗` dengan lima controller — satu bagi setiap medan teks:

```dart
  // ── 4.2 — Input Controller ─────────────────────────
  final _nameCtrl = TextEditingController();
  final _icCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _phoneCtrl = TextEditingController();
  final _academicCtrl = TextEditingController();

  // 👈 4.3 — TAMBAH dispose() SELEPAS BARIS INI
```

> Permohonan eTT **tidak** memerlukan No. Pasport dalam borang — hanya No. Kad Pengenalan (rujuk README Bahagian 6.3).

### 4.3 — `dispose()` — kitaran hayat, bahagian "bersihkan"

Ganti komen `👈 4.3` dengan kaedah `dispose()`. **Ini langkah paling mudah dilupakan** — setiap `Controller` yang dicipta **mesti** di-`dispose()`:

```dart
  @override
  void dispose() {
    // ── 4.3 — Bersihkan setiap Controller ─────────────
    _nameCtrl.dispose();
    _icCtrl.dispose();
    _emailCtrl.dispose();
    _phoneCtrl.dispose();
    _academicCtrl.dispose();
    super.dispose(); // WAJIB baris TERAKHIR
  }
```

> **Kenapa penting?** `TextEditingController` memegang sumber sistem (*listener*, buffer teks). Lupa `.dispose()` = bocor memori (*memory leak*) — controller kekal dalam ingatan walaupun skrin sudah ditutup. Rujuk README Bahagian 8.4 untuk jadual kesilapan biasa berkaitan kitaran hayat.

▶ **Jalankan** (Hot Reload) → tiada perubahan visual pada skrin — `dispose()` hanya kelihatan kesannya bila skrin **ditutup**, bukan semasa ia aktif. `flutter analyze` patut masih bersih.

### 4.4 — Medan pertama: `TextFormField` "Nama Penuh" + `validator` inline

Ganti kotak `╔ 4.4 ╗` dengan satu `TextFormField` sahaja dahulu — lihat bagaimana `validator` dipasang:

```dart
            const SizedBox(height: 16),

            // ── 4.4 — Nama Penuh ──────────────────────
            TextFormField(
              controller: _nameCtrl,
              textCapitalization: TextCapitalization.words,
              decoration: const InputDecoration(labelText: 'Nama Penuh'),
              validator: (v) =>
                  (v == null || v.trim().isEmpty) ? 'Nama diperlukan' : null,
            ),

            // 👈 4.5 — TAMBAH medan IC SELEPAS BARIS INI
```

Hot Reload. `TextFormField` sepatutnya kelihatan seperti `TextField` biasa — bezanya baru ketara bila `validate()` dipanggil (Langkah 4.12).

> **`validator` ialah fungsi**, bukan nilai tetap: ia terima `String?` (nilai semasa medan) dan pulangkan `String?` — `null` bermakna **sah**, mana-mana `String` lain dipaparkan sebagai mesej ralat merah di bawah medan.

### 4.5 — Medan IC dengan validator daripada `lib/utils/validators.dart`

Ganti komen `👈 4.5`. Kali ini `validator:` merujuk fungsi **bernama** (bukan closure inline) daripada fail yang anda salin semasa Persediaan — perlu import di atas fail (`import '../utils/validators.dart';` dan `import 'package:flutter/services.dart';` untuk `inputFormatters`):

```dart
            const SizedBox(height: 14),

            // ── 4.5 — No. Kad Pengenalan ──────────────
            TextFormField(
              controller: _icCtrl,
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'[0-9-]')),
              ],
              decoration: const InputDecoration(
                labelText: 'No. Kad Pengenalan',
                hintText: '051231-14-5678',
              ),
              validator: validateIcNumber,
            ),

            // 👈 4.6 — TAMBAH Emel, Telefon, Ringkasan SELEPAS BARIS INI
```

▶ **Jalankan** (Hot Reload) → medan "No. Kad Pengenalan" muncul. Cuba taip di dalamnya:

| Cuba taip | Perhatikan pada skrin | Kesimpulan |
|---|---|---|
| huruf `abc` | Tiada apa masuk — huruf terus disekat | `inputFormatters` menapis aksara **semasa** ditaip |
| `051231-14-5678` | Digit & sengkang diterima biasa | `RegExp(r'[0-9-]')` benarkan `0-9` + `-` sahaja |

> `inputFormatters` menyekat aksara semasa ditaip; `validator` menyemak nilai akhir. (Rujuk README Bahagian 6.5 untuk kes tepi format bersengkang yang draf pertama AI selalu terlepas.)

### 4.6 — Tiga medan lagi: Emel, Telefon, Ringkasan Keputusan

Ganti komen `👈 4.6` dengan tiga `TextFormField` sekali gus — corak sama, validator berbeza:

```dart
            const SizedBox(height: 14),

            // ── 4.6 — Emel, Telefon, Ringkasan Keputusan ──
            TextFormField(
              controller: _emailCtrl,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(labelText: 'Emel'),
              validator: validateEmail,
            ),
            const SizedBox(height: 14),
            TextFormField(
              controller: _phoneCtrl,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                labelText: 'No. Telefon',
                hintText: '0123456789',
              ),
              validator: validatePhoneNumber,
            ),
            const SizedBox(height: 14),
            TextFormField(
              controller: _academicCtrl,
              decoration: const InputDecoration(
                labelText: 'Ringkasan Keputusan',
                hintText: 'Cth: SPM 2025 — 9A',
              ),
              validator: (v) => (v == null || v.trim().isEmpty)
                  ? 'Ringkasan keputusan diperlukan'
                  : null,
            ),

            // 👈 4.8 — TAMBAH Kategori Sijil SELEPAS BARIS INI
```

▶ **Jalankan** (Hot Reload) → `flutter analyze` masih bersih, dan lima medan (Nama, IC, Emel, Telefon, Ringkasan) kelihatan tersusun menegak dalam borang. Cuba tekan "Hantar (Ujian)" — ia masih memanggil `_submitDummy()` lama, jadi belum ada pengesahan lagi; itu langkah 4.12.

### 4.7 — `initState()`: nilai awal daripada `widget.programme`

Sebelum sambung ke dropdown, tambah `initState()` — kaedah ini isi **nilai permulaan** medan pilihan (negara, bidang, pilihan-1) daripada `widget.programme` yang dihantar skrin sebelumnya. Tambah field pilihan dahulu, terus di bawah controller (Langkah 4.2):

```dart
  final Map<String, bool> _documents = {};

  EntryCategory? _academicCategory;
  late String _country;       // 1 negara — peraturan eTT
  late String _fieldOfStudy;  // 1 bidang — peraturan eTT
  String? _choice1;
  String? _choice2;
  String? _choice3;

  @override
  void initState() {
    super.initState(); // WAJIB baris PERTAMA
    // ── 4.7 — Nilai awal daripada tawaran yang dipilih ─
    _country = widget.programme.country;
    _fieldOfStudy = widget.programme.fieldOfStudy;
    _choice1 = widget.programme.id;
    for (final doc in ettDocumentChecklist) {
      _documents[doc] = false;
    }
  }
```

Import `../data/document_checklist.dart` untuk `ettDocumentChecklist`.

> `late String _country` bermakna "saya janji beri nilai sebelum digunakan, walaupun bukan semasa deklarasi" — sesuai kerana nilai sebenar hanya diketahui dalam `initState()` (bergantung kepada `widget.programme`, yang belum wujud semasa fail dimuat).

### 4.8 — Dropdown Kategori Sijil (SPM/STAM)

Ganti komen `👈 4.8`:

```dart
            const SizedBox(height: 24),
            const Text(
              'Kelayakan & Pilihan Pengajian',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            // ── 4.8 — Kategori Sijil ───────────────────
            DropdownButtonFormField<EntryCategory>(
              initialValue: _academicCategory,
              decoration: const InputDecoration(labelText: 'Kategori Sijil'),
              items: const [
                DropdownMenuItem(value: EntryCategory.spm, child: Text('SPM')),
                DropdownMenuItem(value: EntryCategory.stam, child: Text('STAM')),
              ],
              onChanged: (v) => setState(() => _academicCategory = v),
              validator: (v) => v == null ? 'Sila pilih kategori sijil' : null,
            ),

            // 👈 4.10 — TAMBAH dropdown Negara & Bidang SELEPAS BARIS INI
```

▶ **Jalankan** (Hot Reload) → dropdown kosong ("Kategori Sijil") kelihatan; pilih SPM/STAM dan perhatikan nilai terpapar kekal terpilih — itu kerja `setState(() => _academicCategory = v)`.

### 4.9 — Helper & pengendali cascading (negara → bidang → pilihan)

Sebelum bina dropdown negara/bidang, tambah kaedah bantuan di bawah `dispose()` — ini **teras** peraturan eTT (1 negara + 1 bidang + sehingga 3 pilihan universiti, README Bahagian 6.6):

```dart
  List<String> get _countries =>
      {for (final p in sampleProgrammes) p.country}.toList();

  String _countryLabel(String country) => switch (country) {
        'Egypt' => '🇪🇬 Mesir',
        'Morocco' => '🇲🇦 Maghribi',
        _ => country,
      };

  List<String> get _fields => {
        for (final p in sampleProgrammes)
          if (p.country == _country) p.fieldOfStudy,
      }.toList();

  List<Programme> get _choiceProgrammes => sampleProgrammes
      .where((p) => p.country == _country && p.fieldOfStudy == _fieldOfStudy)
      .toList();

  void _onCountryChanged(String? value) {
    if (value == null) return;
    setState(() {
      _country = value;
      final fields = _fields;
      _fieldOfStudy = fields.isNotEmpty ? fields.first : '';
      _resetChoices(); // pilihan universiti lama tidak lagi sah
    });
  }

  void _onFieldChanged(String? value) {
    if (value == null) return;
    setState(() {
      _fieldOfStudy = value;
      _resetChoices();
    });
  }

  void _resetChoices() {
    final programmes = _choiceProgrammes;
    _choice1 = programmes.isNotEmpty ? programmes.first.id : null;
    _choice2 = null;
    _choice3 = null;
  }
```

Import `../data/sample_programmes.dart` untuk `sampleProgrammes`.

> Perhatikan `_onCountryChanged` memanggil `_resetChoices()` **di dalam** `setState()` — kedua-dua perubahan (negara baharu + pilihan universiti di-reset) mesti berlaku dalam **satu** `setState()` supaya Flutter hanya `build()` semula **sekali**, bukan dua kali berasingan.

### 4.10 — Dropdown Negara & Bidang dalam `build()`

Ganti komen `👈 4.10`:

```dart
            const SizedBox(height: 14),
            Text(
              'Peraturan eTT: 1 negara + 1 bidang setiap permohonan. Anda '
              'boleh menyusun sehingga 3 pilihan universiti dalam bidang itu.',
              style: TextStyle(fontSize: 12, color: Colors.grey[700]),
            ),
            const SizedBox(height: 8),

            // ── 4.10 — Negara & Bidang (saling bergantung) ─
            DropdownButtonFormField<String>(
              initialValue: _country,
              isExpanded: true,
              decoration: const InputDecoration(labelText: 'Negara (satu sahaja)'),
              items: [
                for (final c in _countries)
                  DropdownMenuItem(value: c, child: Text(_countryLabel(c))),
              ],
              onChanged: _onCountryChanged,
              validator: (v) => v == null ? 'Sila pilih negara' : null,
            ),
            const SizedBox(height: 14),
            DropdownButtonFormField<String>(
              initialValue: _fields.contains(_fieldOfStudy) ? _fieldOfStudy : null,
              isExpanded: true,
              decoration: const InputDecoration(labelText: 'Bidang (satu sahaja)'),
              items: [
                for (final f in _fields)
                  DropdownMenuItem(value: f, child: Text(f, overflow: TextOverflow.ellipsis)),
              ],
              onChanged: _onFieldChanged,
              validator: (v) => v == null ? 'Sila pilih bidang' : null,
            ),

            // 👈 4.13 — TAMBAH dropdown Pilihan Universiti SELEPAS BARIS INI
```

▶ **Jalankan** (Hot Reload) → dua dropdown "Negara (satu sahaja)" & "Bidang (satu sahaja)" muncul, sudah pra-isi dengan negara + bidang tawaran yang anda buka.

**Eksperimen — cascading dropdown, buat betul-betul, jangan hanya baca:**

| Buat | Perhatikan apa jadi | Kesimpulan |
|---|---|---|
| Buka borang untuk tawaran Mesir, tukar Negara → Maghribi | Senarai **Bidang** terus bertukar kepada bidang Maghribi (Usuluddin, Bahasa Arab) | Menukar negara **mencetuskan** `_onCountryChanged` → `setState()` → `build()` semula dengan `_fields` baharu |
| Selepas itu tukar Negara semula → Mesir | Bidang kembali senarai Mesir; **pilihan universiti tadi (langkah 4.13) turut hilang**, bukan kekal terpapar salah | `_resetChoices()` di dalam kedua-dua `setState()` membuang pilihan lama yang tidak lagi sah |

### 4.11 — Widget boleh guna semula: `_ChoiceDropdown`

Tiga dropdown pilihan universiti (Pilihan 1–3) berkongsi struktur sama — mari asingkan jadi satu widget, corak yang sama seperti `ProgrammeInfoCard` Hari 1. Tambah **di bawah sekali fail**, selepas kurungan penutup `_ApplicationFormScreenState`:

```dart
// ── 4.11 — Dropdown pilihan universiti (boleh guna semula) ─
class _ChoiceDropdown extends StatelessWidget {
  const _ChoiceDropdown({
    required this.label,
    required this.value,
    required this.programmes,
    required this.onChanged,
    this.validator,
    this.includeNone = false,
  });

  final String label;
  final String? value;
  final List<Programme> programmes;
  final ValueChanged<String?> onChanged;
  final String? Function(String?)? validator;

  /// Jika benar, tambah item "Tiada" bernilai null (untuk pilihan opsional).
  final bool includeNone;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      initialValue: value,
      isExpanded: true,
      decoration: InputDecoration(labelText: label),
      items: [
        if (includeNone)
          const DropdownMenuItem<String>(value: null, child: Text('Tiada')),
        for (final p in programmes)
          DropdownMenuItem(
            value: p.id,
            child: Text(
              '${p.universityName} (${p.city})',
              overflow: TextOverflow.ellipsis,
            ),
          ),
      ],
      onChanged: onChanged,
      validator: validator,
    );
  }
}
```

### 4.12 — Pasang tiga `_ChoiceDropdown` — Pilihan 1 wajib, 2 & 3 pilihan

Ganti komen `👈 4.13`:

```dart
            const SizedBox(height: 14),

            // ── 4.12 — Pilihan Universiti 1–3 ──────────
            _ChoiceDropdown(
              label: 'Pilihan 1 (wajib)',
              value: _choice1,
              programmes: choiceProgrammes,
              onChanged: (v) => setState(() => _choice1 = v),
              validator: (v) => v == null ? 'Pilihan 1 diperlukan' : null,
            ),
            const SizedBox(height: 14),
            _ChoiceDropdown(
              label: 'Pilihan 2 (pilihan)',
              value: _choice2,
              programmes: choiceProgrammes,
              includeNone: true,
              onChanged: (v) => setState(() => _choice2 = v),
            ),
            const SizedBox(height: 14),
            _ChoiceDropdown(
              label: 'Pilihan 3 (pilihan)',
              value: _choice3,
              programmes: choiceProgrammes,
              includeNone: true,
              onChanged: (v) => setState(() => _choice3 = v),
            ),

            // 👈 4.14 — TAMBAH senarai semak dokumen SELEPAS BARIS INI
```

`choiceProgrammes` mesti dikira **sekali** di awal `build()` (sebelum `return Scaffold(`) supaya ketiga-tiga dropdown guna senarai yang sama:

```dart
  @override
  Widget build(BuildContext context) {
    final choiceProgrammes = _choiceProgrammes; // 👈 tambah baris ini SEBELUM return Scaffold(
    return Scaffold(
```

▶ **Jalankan** (Hot Reload) → ketiga-tiga dropdown pilihan universiti kelihatan; Pilihan 1 sudah pra-isi dengan tawaran asal (daripada `initState()`), Pilihan 2 & 3 memaparkan "Tiada".

### 4.13 — Senarai semak dokumen (`CheckboxListTile`)

Ganti komen `👈 4.14`:

```dart
            const SizedBox(height: 24),
            const Text(
              'Senarai Semak Dokumen',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text(
              'Dalam sistem sebenar, dokumen dimuat naik selepas status LAYAK.',
              style: TextStyle(fontSize: 12, color: Colors.grey[700]),
            ),
            const SizedBox(height: 8),

            // ── 4.13 — Senarai semak dokumen ───────────
            for (final doc in ettDocumentChecklist)
              CheckboxListTile(
                dense: true,
                contentPadding: EdgeInsets.zero,
                controlAffinity: ListTileControlAffinity.leading,
                title: Text(doc),
                value: _documents[doc],
                onChanged: (v) => setState(() => _documents[doc] = v ?? false),
              ),

            // 👈 4.15 — TAMBAH butang Hantar SELEPAS BARIS INI
```

▶ **Jalankan** (Hot Reload) → senarai 6 dokumen eTT muncul dengan kotak semak. Tanda & nyahtanda beberapa kotak — setiap tekan kekal bertukar kerana `setState(() => _documents[doc] = ...)` menyimpan pilihan itu.

### 4.14 — `_submit()` sebenar: validate → bina `Application` → `pop`

Sekarang gantikan `_submitDummy()` (dari fail permulaan) dengan `_submit()` sebenar. Padam `_submitDummy()` dan tambah dua kaedah ini di tempat yang sama:

```dart
  void _submit() {
    // ── 4.14a — Jalankan SEMUA validator dalam Form ───
    if (!_formKey.currentState!.validate()) return;

    if (_choice1 == null) {
      _snack('Sila pilih sekurang-kurangnya satu universiti (Pilihan 1).');
      return;
    }

    // Buang nilai kosong & pendua daripada senarai pilihan.
    final choices = <String>[];
    for (final id in [_choice1, _choice2, _choice3]) {
      if (id != null && !choices.contains(id)) choices.add(id);
    }

    final application = Application(
      id: 'ETT-${DateTime.now().year}-${DateTime.now().millisecondsSinceEpoch}',
      fullName: _nameCtrl.text.trim(),
      icNumber: _icCtrl.text.trim(),
      email: _emailCtrl.text.trim(),
      phoneNumber: _phoneCtrl.text.trim(),
      academicCategory: _academicCategory!,
      academicSummary: _academicCtrl.text.trim(),
      country: _country,
      fieldOfStudy: _fieldOfStudy,
      universityChoiceIds: choices,
      uploadedDocuments: _documents.entries
          .where((e) => e.value)
          .map((e) => e.key)
          .toList(),
      status: ApplicationStatus.submitted,
      submittedAt: DateTime.now(),
    );

    _snack('Permohonan ${application.id} berjaya dihantar!');
    Navigator.of(context).pop(application); // pulangkan objek ke skrin sebelumnya
  }

  void _snack(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }
```

> `_formKey.currentState!.validate()` menjalankan **setiap** `validator` dalam `Form` serentak — jika mana-mana satu pulangkan mesej (bukan `null`), `validate()` pulangkan `false` dan Flutter memaparkan semua mesej ralat sekali gus. Hanya bila **semua** medan sah, kod terus ke bawah dan `Navigator.pop(application)` dipanggil.

### 4.15 — Butang "Hantar Permohonan"

Ganti komen `👈 4.15`:

```dart
            const SizedBox(height: 24),

            // ── 4.15 — Butang hantar ───────────────────
            FilledButton.icon(
              onPressed: _submit,
              icon: const Icon(Icons.send),
              label: const Text('Hantar Permohonan'),
            ),
```

▶ **Jalankan** (Hot Reload) → butang "Hantar Permohonan" (ikon pesawat kertas) kini muncul di hujung borang. Jangan tekan lagi — kita uji pengesahan penuh di ✅ Semakan akhir di bawah.

### 4.16 — Fail penuh selepas Latihan 4

Banding fail anda dengan checkpoint ini (import disusun di atas):

```dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../data/document_checklist.dart';
import '../data/sample_programmes.dart';
import '../models/application.dart';
import '../models/programme.dart';
import '../utils/validators.dart';

class ApplicationFormScreen extends StatefulWidget {
  const ApplicationFormScreen({super.key, required this.programme});

  final Programme programme;

  @override
  State<ApplicationFormScreen> createState() => _ApplicationFormScreenState();
}

class _ApplicationFormScreenState extends State<ApplicationFormScreen> {
  final _formKey = GlobalKey<FormState>();

  final _nameCtrl = TextEditingController();
  final _icCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _phoneCtrl = TextEditingController();
  final _academicCtrl = TextEditingController();

  final Map<String, bool> _documents = {};

  EntryCategory? _academicCategory;
  late String _country;
  late String _fieldOfStudy;
  String? _choice1;
  String? _choice2;
  String? _choice3;

  @override
  void initState() {
    super.initState();
    _country = widget.programme.country;
    _fieldOfStudy = widget.programme.fieldOfStudy;
    _choice1 = widget.programme.id;
    for (final doc in ettDocumentChecklist) {
      _documents[doc] = false;
    }
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _icCtrl.dispose();
    _emailCtrl.dispose();
    _phoneCtrl.dispose();
    _academicCtrl.dispose();
    super.dispose();
  }

  List<String> get _countries =>
      {for (final p in sampleProgrammes) p.country}.toList();

  String _countryLabel(String country) => switch (country) {
    'Egypt' => '🇪🇬 Mesir',
    'Morocco' => '🇲🇦 Maghribi',
    _ => country,
  };

  List<String> get _fields => {
    for (final p in sampleProgrammes)
      if (p.country == _country) p.fieldOfStudy,
  }.toList();

  List<Programme> get _choiceProgrammes => sampleProgrammes
      .where((p) => p.country == _country && p.fieldOfStudy == _fieldOfStudy)
      .toList();

  void _onCountryChanged(String? value) {
    if (value == null) return;
    setState(() {
      _country = value;
      final fields = _fields;
      _fieldOfStudy = fields.isNotEmpty ? fields.first : '';
      _resetChoices();
    });
  }

  void _onFieldChanged(String? value) {
    if (value == null) return;
    setState(() {
      _fieldOfStudy = value;
      _resetChoices();
    });
  }

  void _resetChoices() {
    final programmes = _choiceProgrammes;
    _choice1 = programmes.isNotEmpty ? programmes.first.id : null;
    _choice2 = null;
    _choice3 = null;
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    if (_academicCategory == null) {
      _snack('Sila pilih kategori sijil (SPM atau STAM).');
      return;
    }
    if (_choice1 == null) {
      _snack('Sila pilih sekurang-kurangnya satu universiti (Pilihan 1).');
      return;
    }

    final choices = <String>[];
    for (final id in [_choice1, _choice2, _choice3]) {
      if (id != null && !choices.contains(id)) choices.add(id);
    }

    final application = Application(
      id: 'ETT-${DateTime.now().year}-${DateTime.now().millisecondsSinceEpoch}',
      fullName: _nameCtrl.text.trim(),
      icNumber: _icCtrl.text.trim(),
      email: _emailCtrl.text.trim(),
      phoneNumber: _phoneCtrl.text.trim(),
      academicCategory: _academicCategory!,
      academicSummary: _academicCtrl.text.trim(),
      country: _country,
      fieldOfStudy: _fieldOfStudy,
      universityChoiceIds: choices,
      uploadedDocuments: _documents.entries
          .where((e) => e.value)
          .map((e) => e.key)
          .toList(),
      status: ApplicationStatus.submitted,
      submittedAt: DateTime.now(),
    );

    _snack('Permohonan ${application.id} berjaya dihantar!');
    Navigator.of(context).pop(application);
  }

  void _snack(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    final choiceProgrammes = _choiceProgrammes;

    return Scaffold(
      appBar: AppBar(title: const Text('Borang Permohonan eTT')),
      body: Form(
        key: _formKey,
        // PENTING: guna SingleChildScrollView + Column, BUKAN ListView.
        // ListView bersifat "malas" — medan yang ditatal keluar skrin akan
        // dilupuskan dan TERKELUAR daftar Form, menyebabkan validate()
        // melangkau medan itu (borang kosong boleh "lulus" validation).
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Maklumat Pemohon',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _nameCtrl,
                textCapitalization: TextCapitalization.words,
                decoration: const InputDecoration(labelText: 'Nama Penuh'),
                validator: (v) =>
                    (v == null || v.trim().isEmpty) ? 'Nama diperlukan' : null,
              ),
              const SizedBox(height: 14),
              TextFormField(
                controller: _icCtrl,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9-]')),
                ],
                decoration: const InputDecoration(
                  labelText: 'No. Kad Pengenalan',
                  hintText: '051231-14-5678',
                ),
                validator: validateIcNumber,
              ),
              const SizedBox(height: 14),
              TextFormField(
                controller: _emailCtrl,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(labelText: 'Emel'),
                validator: validateEmail,
              ),
              const SizedBox(height: 14),
              TextFormField(
                controller: _phoneCtrl,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  labelText: 'No. Telefon',
                  hintText: '0123456789',
                ),
                validator: validatePhoneNumber,
              ),
              const SizedBox(height: 14),
              TextFormField(
                controller: _academicCtrl,
                decoration: const InputDecoration(
                  labelText: 'Ringkasan Keputusan',
                  hintText: 'Cth: SPM 2025 — 9A',
                ),
                validator: (v) => (v == null || v.trim().isEmpty)
                    ? 'Ringkasan keputusan diperlukan'
                    : null,
              ),
              const SizedBox(height: 24),
              const Text(
                'Kelayakan & Pilihan Pengajian',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<EntryCategory>(
                initialValue: _academicCategory,
                decoration: const InputDecoration(labelText: 'Kategori Sijil'),
                items: const [
                  DropdownMenuItem(
                    value: EntryCategory.spm,
                    child: Text('SPM'),
                  ),
                  DropdownMenuItem(
                    value: EntryCategory.stam,
                    child: Text('STAM'),
                  ),
                ],
                onChanged: (v) => setState(() => _academicCategory = v),
                validator: (v) =>
                    v == null ? 'Sila pilih kategori sijil' : null,
              ),
              const SizedBox(height: 14),
              Text(
                'Peraturan eTT: 1 negara + 1 bidang setiap permohonan. Anda '
                'boleh menyusun sehingga 3 pilihan universiti dalam bidang itu.',
                style: TextStyle(fontSize: 12, color: Colors.grey[700]),
              ),
              const SizedBox(height: 8),
              DropdownButtonFormField<String>(
                initialValue: _country,
                isExpanded: true,
                decoration: const InputDecoration(
                  labelText: 'Negara (satu sahaja)',
                ),
                items: [
                  for (final c in _countries)
                    DropdownMenuItem(value: c, child: Text(_countryLabel(c))),
                ],
                onChanged: _onCountryChanged,
                validator: (v) => v == null ? 'Sila pilih negara' : null,
              ),
              const SizedBox(height: 14),
              DropdownButtonFormField<String>(
                initialValue: _fields.contains(_fieldOfStudy)
                    ? _fieldOfStudy
                    : null,
                isExpanded: true,
                decoration: const InputDecoration(
                  labelText: 'Bidang (satu sahaja)',
                ),
                items: [
                  for (final f in _fields)
                    DropdownMenuItem(
                      value: f,
                      child: Text(f, overflow: TextOverflow.ellipsis),
                    ),
                ],
                onChanged: _onFieldChanged,
                validator: (v) => v == null ? 'Sila pilih bidang' : null,
              ),
              const SizedBox(height: 14),
              _ChoiceDropdown(
                label: 'Pilihan 1 (wajib)',
                value: _choice1,
                programmes: choiceProgrammes,
                onChanged: (v) => setState(() => _choice1 = v),
                validator: (v) => v == null ? 'Pilihan 1 diperlukan' : null,
              ),
              const SizedBox(height: 14),
              _ChoiceDropdown(
                label: 'Pilihan 2 (pilihan)',
                value: _choice2,
                programmes: choiceProgrammes,
                includeNone: true,
                onChanged: (v) => setState(() => _choice2 = v),
              ),
              const SizedBox(height: 14),
              _ChoiceDropdown(
                label: 'Pilihan 3 (pilihan)',
                value: _choice3,
                programmes: choiceProgrammes,
                includeNone: true,
                onChanged: (v) => setState(() => _choice3 = v),
              ),
              const SizedBox(height: 24),
              const Text(
                'Senarai Semak Dokumen',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              Text(
                'Dalam sistem sebenar, dokumen dimuat naik selepas status LAYAK.',
                style: TextStyle(fontSize: 12, color: Colors.grey[700]),
              ),
              const SizedBox(height: 8),
              for (final doc in ettDocumentChecklist)
                CheckboxListTile(
                  dense: true,
                  contentPadding: EdgeInsets.zero,
                  controlAffinity: ListTileControlAffinity.leading,
                  title: Text(doc),
                  value: _documents[doc],
                  onChanged: (v) =>
                      setState(() => _documents[doc] = v ?? false),
                ),
              const SizedBox(height: 24),
              FilledButton.icon(
                onPressed: _submit,
                icon: const Icon(Icons.send),
                label: const Text('Hantar Permohonan'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ChoiceDropdown extends StatelessWidget {
  const _ChoiceDropdown({
    required this.label,
    required this.value,
    required this.programmes,
    required this.onChanged,
    this.validator,
    this.includeNone = false,
  });

  final String label;
  final String? value;
  final List<Programme> programmes;
  final ValueChanged<String?> onChanged;
  final String? Function(String?)? validator;
  final bool includeNone;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      initialValue: value,
      isExpanded: true,
      decoration: InputDecoration(labelText: label),
      items: [
        if (includeNone)
          const DropdownMenuItem<String>(value: null, child: Text('Tiada')),
        for (final p in programmes)
          DropdownMenuItem(
            value: p.id,
            child: Text(
              '${p.universityName} (${p.city})',
              overflow: TextOverflow.ellipsis,
            ),
          ),
      ],
      onChanged: onChanged,
      validator: validator,
    );
  }
}
```

### 🧪 Uji Latihan 4 — ujian penuh borang

> **Sampai ke sana:** `flutter run` → tab **Program** → tekan kad **Universiti Al-Azhar** → tekan **"Mohon"**. Anda kini di borang penuh.

**Bahagian A — pengesahan (validation) mesti MENGHALANG:**

| # | Buat ini | Patut nampak |
|---|---|---|
| 1 | Terus tekan **"Hantar Permohonan"** tanpa isi apa-apa | Mesej ralat **merah** di bawah **setiap** medan wajib. Borang **TIDAK** tertutup |
| 2 | Isi No. KP dengan `123` sahaja, tekan Hantar | "No. Kad Pengenalan mesti 12 digit (cth: 051231-14-5678)" |
| 3 | Isi Emel dengan `abc` (tiada `@`), tekan Hantar | "Format emel tidak sah" |
| 4 | Biar **Kategori Sijil** kosong, isi yang lain betul, tekan Hantar | Ralat pada dropdown kategori — borang masih tidak tertutup |

**Bahagian B — dropdown saling bergantung:**

| # | Buat ini | Patut nampak |
|---|---|---|
| 5 | Tukar **Negara** dari Mesir → Maghribi | Senarai **Bidang** berubah serta-merta kepada bidang Maghribi |
| 6 | Perhati **Pilihan 1/2/3** | Ikut berubah — pilihan universiti Mesir yang lama **hilang** |

**Bahagian C — laluan berjaya:**

| # | Buat ini | Patut nampak |
|---|---|---|
| 7 | Isi **semua** medan betul: nama, KP `051231-14-5678`, emel sah, telefon `0123456789`, ringkasan, kategori SPM, negara+bidang, Pilihan 1 | Tiada lagi ralat merah |
| 8 | Tanda 2–3 kotak dokumen, tekan **"Hantar Permohonan"** | Borang **tertutup** |
| 9 | Pandang skrin butiran | `SnackBar` dengan ID **sebenar** (`ETT-2026-…`) — bukan lagi `ETT-UJIAN-…` |
| 10 | Terminal | `flutter analyze` → **No issues found!** |

❌ **Tak jadi?**
- Borang **tertutup** walaupun kosong (langkah 1) → `Form` anda membalut `ListView`. Tukar kepada `SingleChildScrollView` + `Column` (lihat amaran di 4.1) — `ListView` melupuskan medan yang ditatal keluar skrin, jadi `validate()` melangkaunya.
- Ranap `Null check operator used on a null value` → sama punca seperti di atas, atau pengawal `if (_academicCategory == null)` belum ditambah.
- Bidang tak berubah bila tukar negara → `_onCountryChanged` tidak memanggil `_resetChoices()` **di dalam** `setState()`.
- Ralat merah tak hilang walaupun sudah betul → tekan Hantar sekali lagi; `validator` hanya dinilai semula semasa `validate()` dipanggil.

---

## Latihan 5 — Tambah Satu Validator Baharu Dengan Bantuan AI

**Matlamat:** Amalkan corak "prompt → semak kritikal → sahkan" daripada README Bahagian 6.5, kali ini untuk medan **Ringkasan Keputusan** (`academicSummary`) — dalam kod Latihan 4 ia hanya disahkan dengan `.isEmpty` mudah; kita naik taraf kepada fungsi validator bernama yang lebih menyeluruh.

1. Tulis prompt anda sendiri kepada AI (Claude Code atau lain) — contoh titik permulaan:

   ```text
   Tulis fungsi Dart standalone `String? validateAcademicSummary(String? value)`
   (tiada import package:flutter), tandatangan String? Function(String?), untuk
   medan "Ringkasan Keputusan" borang permohonan pelajar. Wajib diisi, dan
   TIDAK boleh hanya ruang kosong. Mesej ralat dalam Bahasa Melayu.
   ```

2. Sebelum menerima kod yang dijana, isi jadual ujian kes tepi sendiri:

   | Input `value` | Sepatutnya |
   |---|---|
   | `null` | ❌ "Ringkasan keputusan diperlukan" |
   | `""` | ❌ "Ringkasan keputusan diperlukan" |
   | `"   "` (ruang sahaja) | ❌ (mesti `.trim()` dahulu — ramai draf AI pertama terlepas kes ini) |
   | `"SPM 2025 — 9A"` | ✅ sah |

3. Jalankan kod yang dijana AI melalui **kesemua** baris jadual di atas secara manual. Versi yang telah disemak (contoh):

   ```dart
   String? validateAcademicSummary(String? value) {
     if (value == null || value.trim().isEmpty) {
       return 'Ringkasan keputusan diperlukan';
     }
     return null;
   }
   ```

4. Tambah fungsi yang telah disahkan ke `lib/utils/validators.dart`, dan sambungkan ke `TextFormField` Ringkasan Keputusan (Langkah 4.6) menggantikan validator inline:

   ```dart
   TextFormField(
     controller: _academicCtrl,
     decoration: const InputDecoration(
       labelText: 'Ringkasan Keputusan',
       hintText: 'Cth: SPM 2025 — 9A',
     ),
     validator: validateAcademicSummary,   // 👈 ganti closure inline
   ),
   ```

5. Jalankan `dart analyze lib/utils/validators.dart` (atau `flutter analyze` untuk keseluruhan projek).

### 🧪 Uji Latihan 5

> **Sampai ke sana:** `flutter run` → tab **Program** → kad mana-mana → **"Mohon"** → tatal ke medan **Ringkasan Keputusan**.

| # | Taip ini dalam Ringkasan Keputusan | Patut nampak (selepas tekan Hantar) |
|---|---|---|
| 1 | (biar kosong) | Mesej ralat — medan wajib |
| 2 | Tiga space sahaja: `"   "` | Mesej ralat **juga** — inilah kes tepi yang AI selalu terlepas |
| 3 | `SPM 2025 — 9A` | ✅ Tiada ralat pada medan ini |
| 4 | Terminal | `flutter analyze` → **No issues found!** |

Langkah 2 ialah ujian sebenar: validator naif (`value.isEmpty`) akan **lulus** ruang kosong. Versi betul guna `value.trim().isEmpty`.

❌ **Tak jadi?**
- `"   "` diterima → validator anda tidak `trim()` dahulu.
- Ralat tak muncul langsung → medan itu belum disambungkan kepada `validator:` anda.

---

## Latihan 6 — Kitaran Hayat `StatefulWidget` Secara Eksplisit

**Matlamat:** Bina widget demo kecil yang **khusus** menunjukkan susunan kitaran hayat `StatefulWidget` — berasingan daripada borang permohonan, supaya konsepnya jelas tanpa kekacauan medan borang.

Cipta fail baharu `lib/widgets/lifecycle_demo.dart`:

```dart
import 'package:flutter/material.dart';

/// Widget demo — bukan sebahagian aliran permohonan sebenar.
/// Tujuannya SEMATA-MATA menunjukkan susunan initState -> build -> dispose.
class LifecycleDemo extends StatefulWidget {
  const LifecycleDemo({super.key});

  @override
  State<LifecycleDemo> createState() => _LifecycleDemoState();
}

class _LifecycleDemoState extends State<LifecycleDemo> {
  int _count = 0;

  @override
  void initState() {
    super.initState();
    debugPrint('[LifecycleDemo] initState() — dipanggil SEKALI sahaja');
  }

  void _increment() => setState(() => _count++);
  void _reset() => setState(() => _count = 0);

  @override
  Widget build(BuildContext context) {
    debugPrint('[LifecycleDemo] build() — _count = $_count');
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text('Kiraan: $_count', style: const TextStyle(fontSize: 24)),
        const SizedBox(height: 12),
        GestureDetector(
          onTap: _increment,
          onLongPress: _reset,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            color: Colors.blue.shade100,
            child: const Text('Tekan (+1) · Tekan Lama (reset)'),
          ),
        ),
        const SizedBox(height: 12),
        FilledButton(onPressed: _increment, child: const Text('Tambah (Button)')),
      ],
    );
  }

  @override
  void dispose() {
    debugPrint('[LifecycleDemo] dispose() — dipanggil SEKALI sahaja, skrin ditutup');
    super.dispose();
  }
}
```

Sekarang kita perlukan **cara membukanya**. Daripada menampal demo ini ke dalam skrin sebenar (dan terpaksa ingat untuk membuangnya semula), kita daftarkan **laluan ujian sendiri** — sekali gus mengulang semula `pushNamed` daripada Latihan 2.

**Langkah 1 — daftar laluan `/lifecycle`** dalam `lib/main.dart`, di dalam `onGenerateRoute` yang anda bina di Latihan 2.1:

```dart
import 'widgets/lifecycle_demo.dart';   // 👈 TAMBAH di atas fail

// ...

        if (settings.name == '/detail') {
          // ... (Latihan 2.1, jangan ubah)
        }

        // 👇 Latihan 6 — laluan ujian untuk demo kitaran hayat
        if (settings.name == '/lifecycle') {
          return MaterialPageRoute(
            builder: (_) => Scaffold(
              appBar: AppBar(title: const Text('Demo Kitaran Hayat')),
              body: const Center(child: LifecycleDemo()),
            ),
          );
        }
        return null;
```

**Langkah 2 — beri pintu masuk** dalam `Drawer` yang anda bina Hari 2. Buka `lib/screens/home_screen.dart`, dan tambah **selepas** gelung `for (final option in _options) ListTile(...)`:

```dart
          // ── Hari 3, Latihan 6 — pintu masuk demo kitaran hayat ──
          const Divider(),
          ListTile(
            leading: const Icon(Icons.science_outlined, color: KptTheme.navy),
            title: const Text('Demo Kitaran Hayat'),
            subtitle: const Text('Lihat log initState / build / dispose'),
            onTap: () {
              Navigator.of(context).pop(); // tutup Drawer dahulu
              Navigator.of(context).pushNamed('/lifecycle');
            },
          ),
```

> **Kenapa laluan berasingan, bukan tampal dalam `ProgrammeDetailScreen`?** Kerana `dispose()` hanya dipanggil apabila skrin **ditutup**. Dengan laluan sendiri, anda boleh masuk & keluar berulang kali dan lihat `initState → build… → dispose` penuh setiap kali — itulah separuh daripada pelajaran ini.

Perhatikan **konsol/terminal** (`flutter run`) semasa: skrin dibuka pertama kali; tekan kawasan `GestureDetector` beberapa kali (`onTap`); tekan **lama** (*long-press*) kawasan sama; tekan butang `FilledButton`; tutup skrin (navigasi kembali).

**Eksperimen — buang `setState()`, lihat apa hilang:**

Sementara, tukar `_increment()` supaya menambah nilai **tanpa** `setState`:

```dart
void _increment() {
  // EKSPERIMEN — sengaja SALAH, kembalikan selepas ini
  _count++;
  debugPrint('_count = $_count'); // nombor naik di konsol...
}
```

| Buat | Perhatikan | Kesimpulan |
|---|---|---|
| Tekan "Tambah (Button)" berkali-kali | Konsol tunjuk `_count` naik, tetapi **`Text('Kiraan: ...')` pada skrin langsung tidak berubah** | Data berubah **tidak** cukup — Flutter hanya lukis semula bila `setState()` dipanggil |

Kembalikan `setState(() => _count++);` sebelum teruskan.

### 🧪 Uji Latihan 6

> **Sampai ke sana:** `flutter run` (tekan **`R`** besar — Hot **Restart**, kerana `main.dart` berubah) → buka **Drawer** (☰ atau leret dari tepi kiri) → tatal ke bawah → tekan **"Demo Kitaran Hayat"**.
>
> ⚠️ **Pandang TERMINAL, bukan skrin sahaja.** Pelajaran ini tentang log, bukan UI.

| # | Buat ini | Patut nampak di **terminal** |
|---|---|---|
| 1 | Skrin demo baru terbuka | `initState() — dipanggil SEKALI sahaja`, diikuti `build() — _count = 0` |
| 2 | Tekan **"Tambah (Button)"** 3 kali | **3** baris `build()` baharu (`_count = 1`, `2`, `3`). Skrin: "Kiraan: 3" |
| 3 | Tekan kotak biru (`GestureDetector`) 2 kali | 2 baris `build()` lagi — `onTap` juga guna `setState` |
| 4 | Tekan **lama** kotak biru | `build() — _count = 0`. Skrin kembali "Kiraan: 0" |
| 5 | Tekan `←` untuk keluar | `dispose() — dipanggil SEKALI sahaja, skrin ditutup` |
| 6 | Masuk semula melalui Drawer | `initState()` muncul **sekali lagi** — kitaran bermula semula |

Urutan penuh yang anda patut lihat:
```
initState()  →  build()  →  build()  →  build()  →  …  →  dispose()
   sekali        setiap kali setState dipanggil            sekali
```

❌ **Tak jadi?**
- Tiada entri "Demo Kitaran Hayat" dalam Drawer → anda buat Hot **Reload** (`r`), bukan Hot **Restart** (`R`). Laluan & `main.dart` perlu restart.
- `dispose()` tak muncul → anda belum keluar dari skrin; ia hanya dipanggil bila skrin benar-benar ditutup.
- Nombor naik di terminal tetapi **skrin tidak berubah** → anda masih dalam mod eksperimen "buang `setState()`". Kembalikan `setState(() => _count++);`.

---

## Latihan 7 — Siapkan `Drawer` Negara: Tapisan Sebenar dengan `setState()`

**Matlamat:** Hari 2 anda bina `Drawer` negara, tetapi `_selectCountry` hanya **menutup** Drawer — senarai tidak berubah. Sekarang setelah `setState()` dikuasai (Latihan 6), kita siapkannya. Ini latihan **gabungan** dua konsep SESI 4–5: `setState()` **dan** menghantar data ke widget anak.

▶ **Cuba dahulu:** jalankan aplikasi, buka `Drawer`, tekan **Mesir**. Drawer tertutup… senarai **langsung tidak berubah**. Itu yang kita betulkan.

### 7.1 — `ProgrammeListScreen` terima negara pilihan

Widget anak tidak boleh "tahu" sendiri negara mana dipilih — ia mesti **diberitahu** melalui parameter. Buka `lib/screens/programme_list_screen.dart`:

```dart
class ProgrammeListScreen extends StatelessWidget {
  const ProgrammeListScreen({super.key, this.countryFilter}); // 👈 UBAH

  /// null = semua negara; 'Egypt' / 'Morocco' = tapis negara itu sahaja.
  final String? countryFilter;                                 // 👈 TAMBAH

  @override
  Widget build(BuildContext context) {
    // 👇 TAMBAH — tapis senarai mengikut negara yang dipilih
    final items = countryFilter == null
        ? sampleProgrammes
        : sampleProgrammes.where((p) => p.country == countryFilter).toList();

    if (items.isEmpty) {
      return const Center(child: Text('Tiada tawaran untuk negara ini.'));
    }

    return ListView.builder(
      padding: const EdgeInsets.only(top: 8, bottom: 16),
      itemCount: items.length,        // 👈 UBAH: items, bukan sampleProgrammes
      itemBuilder: (context, index) {
        final p = items[index];       // 👈 UBAH
        return ProgrammeCard(
          programme: p,
          onTap: index == 0
              ? () => Navigator.of(context).pushNamed('/detail', arguments: p)
              : () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => ProgrammeDetailScreen(programme: p),
                    ),
                  ),
        );
      },
    );
  }
}
```

### 7.2 — `HomeScreen` simpan negara pilihan dalam state

Dalam `_HomeScreenState` (`lib/screens/home_screen.dart`):

```dart
  int _index = 0;

  /// Negara dipilih dalam Drawer. null = semua negara.
  String? _countryFilter;                       // 👈 TAMBAH

  static const _titles = ['Program', 'Permohonan Saya', 'Profil'];

  void _selectCountry(String? country) {
    setState(() => _countryFilter = country);   // 👈 UBAH — inilah kuncinya
    Navigator.of(context).pop();
  }
```

### 7.3 — Buang `static const _screens` (bahagian paling penting)

> ⚠️ `static const _screens = [...]` **tidak boleh** membawa state yang berubah. `const` bermaksud "nilai tetap, dibina sekali pada waktu kompil" — jadi `ProgrammeListScreen` di dalamnya **tidak akan pernah** menerima `_countryFilter` baharu, walaupun `setState()` dipanggil. Inilah sebab sebenar Drawer nampak "tidak berfungsi".

**Padam** baris `static const _screens = [...]`, dan bina senarai itu **di dalam `build()`**:

```dart
  @override
  Widget build(BuildContext context) {
    // 👇 TAMBAH — dibina dalam build() supaya _countryFilter terkini sampai
    final screens = [
      ProgrammeListScreen(countryFilter: _countryFilter),
      const MyApplicationsScreen(),
      const ProfileScreen(),
    ];

    return Scaffold(
      appBar: AppBar(title: Text('eTT Mobile · ${_titles[_index]}')),
      drawer: _CountryDrawer(onSelect: _selectCountry),
      body: screens[_index],          // 👈 UBAH: screens, bukan _screens
```

▶ **Hot Reload** → buka `Drawer`, tekan **Mesir**: senarai kini **hanya** universiti Mesir (Al-Azhar, Alexandria, Ain Shams, Tanta). Tekan **Maghribi**: hanya Al Quaraouiyine & Mohammed V. Tekan **Semua Negara**: kesemua 8 kembali.

| Cuba tukar | Perhatikan pada skrin | Kesimpulan |
|---|---|---|
| Kekalkan `static const _screens` (jangan pindah ke `build()`) | Tekan negara — senarai **tidak** berubah langsung | `const` dibina sekali sahaja; state baharu tidak sampai kepada widget anak |
| Buang `setState(...)`, tinggalkan `_countryFilter = country;` | Drawer tutup, senarai **tidak** berubah walaupun nilai sudah bertukar | Menukar nilai **tidak cukup** — `setState()` yang mencetuskan `build()` semula (sama seperti Latihan 6) |
| Tekan **Maghribi**, tukar ke tab **Profil**, balik ke tab **Program** | Tapisan Maghribi **masih kekal** | State hidup dalam `_HomeScreenState` selagi skrin itu hidup — bandingkan `initState()` Latihan 6 |

### 7.4 — Maklum balas visual

Tambah getter label dalam `_HomeScreenState`:

```dart
  /// Label BM untuk negara yang sedang ditapis (null jika semua).
  String? get _filterLabel => switch (_countryFilter) {
        'Egypt' => 'Mesir',
        'Morocco' => 'Maghribi',
        _ => null,
      };
```

Guna dalam `build()` untuk tajuk, dan hantar `selected` ke Drawer:

```dart
    // Tunjuk negara yang ditapis pada tajuk, contoh: "Program · Mesir".
    final title = _index == 0 && _filterLabel != null
        ? '${_titles[_index]} · $_filterLabel'
        : _titles[_index];

    return Scaffold(
      appBar: AppBar(title: Text('eTT Mobile · $title')),   // 👈 UBAH
      drawer: _CountryDrawer(
        selected: _countryFilter,                           // 👈 TAMBAH
        onSelect: _selectCountry,
      ),
```

Dan `_CountryDrawer` terima `selected`:

```dart
class _CountryDrawer extends StatelessWidget {
  const _CountryDrawer({required this.selected, required this.onSelect}); // 👈 UBAH

  final String? selected;                                    // 👈 TAMBAH
  final void Function(String?) onSelect;
```

```dart
            ListTile(
              leading: Text(option.flag, style: const TextStyle(fontSize: 22)),
              title: Text(option.label),
              selected: option.value == selected,   // 👈 TAMBAH — tanda pilihan
              selectedColor: KptTheme.navy,         // 👈 TAMBAH
              onTap: () => onSelect(option.value),
            ),
```

### 🧪 Uji Latihan 7

> **Sampai ke sana:** `flutter run` → tab **Program** → buka **Drawer** (☰).

| # | Buat ini | Patut nampak |
|---|---|---|
| 1 | Tekan **🇪🇬 Mesir** | Drawer tutup. Senarai tinggal **universiti Mesir sahaja** (Al-Azhar, Alexandria, Ain Shams, Tanta) |
| 2 | Pandang `AppBar` | Bertukar → `eTT Mobile · Program · Mesir` |
| 3 | Buka semula Drawer | Baris **Mesir** kini berwarna **navy** (tanda pilihan semasa) |
| 4 | Tekan **🇲🇦 Maghribi** | Senarai tinggal 2: Al Quaraouiyine & Mohammed V |
| 5 | Tukar ke tab **Profil**, kemudian balik ke tab **Program** | Tapisan Maghribi **masih kekal** — state hidup dalam `_HomeScreenState` |
| 6 | Buka Drawer → **🌍 Semua Negara** | Kesemua **8** tawaran kembali, tajuk kembali `eTT Mobile · Program` |
| 7 | Terminal | `flutter analyze` → **No issues found!** |

❌ **Tak jadi?**
- Senarai **langsung tidak berubah** → anda masih ada `static const _screens`. Ia mesti dipindah ke dalam `build()` (langkah 7.3) — `const` tidak boleh bawa state berubah.
- Drawer tutup tetapi tiada apa berlaku → `setState()` tertinggal dalam `_selectCountry`.
- Tajuk tak berubah → `_filterLabel` belum digunakan pada `AppBar` (langkah 7.4).

---

## Senarai Semak Akhir

Sebelum tamat lab, pastikan:

- [ ] `flutter analyze` tiada ralat merentasi seluruh projek.
- [ ] Navigasi senarai → butiran berfungsi (Latihan 1) dan named route `/detail` turut berfungsi (Latihan 2).
- [ ] Borang skeleton memulangkan data melalui `Navigator.pop(application)` dan skrin butiran menerimanya melalui `await push<Application>()` (Latihan 3).
- [ ] Semua medan borang penuh mempunyai `validator`, dan mesej ralat Bahasa Melayu dipaparkan dengan betul untuk input tidak sah (Latihan 4).
- [ ] Setiap `TextEditingController` di-`dispose()` (Latihan 4.3).
- [ ] Dropdown negara & bidang saling bergantung — menukar negara menyusun semula bidang & pilihan universiti (Latihan 4.9–4.10).
- [ ] Sekurang-kurangnya satu validator baharu ditulis dengan bantuan AI **dan** disahkan melalui ujian kes tepi manual (Latihan 5).
- [ ] Log konsol `LifecycleDemo` menunjukkan susunan `initState → build (berulang) → dispose` yang betul (Latihan 6), dan ia boleh dibuka melalui `Drawer` → "Demo Kitaran Hayat".
- [ ] `Drawer` negara benar-benar **menapis** senarai tawaran, dan tajuk `AppBar` menunjukkan negara yang ditapis (Latihan 7).

---

## Troubleshooting

| Simptom | Punca biasa | Pembetulan |
|---|---|---|
| `Bad state: No element` bila buka borang | `_choiceProgrammes` kosong (tiada tawaran sepadan negara+bidang) semasa `.first` dipanggil | Semak `_resetChoices()` guna `programmes.isNotEmpty ? programmes.first.id : null` — jangan panggil `.first` terus |
| Borang tertutup **terus** tanpa mesej ralat walaupun medan kosong | `_formKey.currentState!.validate()` tidak dipanggil sebelum logik lain dalam `_submit()` | Baris **pertama** dalam `_submit()` mesti `if (!_formKey.currentState!.validate()) return;` |
| `LateInitializationError: Field '_country' has not been initialized` | `_country`/`_fieldOfStudy` digunakan dalam `build()` sebelum `initState()` sempat tetapkannya | Pastikan `initState()` wujud dan `super.initState()` dipanggil dahulu — `late` **bukan** izin untuk lupa isi nilai |
| Dropdown pilihan universiti tidak berubah bila negara ditukar | Lupa panggil `_resetChoices()` di dalam `_onCountryChanged`, atau letak di luar `setState()` | `_resetChoices()` mesti dipanggil **di dalam** closure `setState(() { ... })` |
| `setState() called after dispose()` | Callback `Future`/timer selesai **selepas** skrin sudah ditutup (jarang berlaku dalam lab ini kerana tiada `async` panjang, tapi biasa bila sambung API Hari 4) | Semak `if (!mounted) return;` sebelum `setState()` dalam callback tak segerak |
| `RenderFlex overflowed` pada dropdown pilihan universiti | Nama universiti panjang tanpa `isExpanded: true`/`overflow: TextOverflow.ellipsis` | Pastikan `DropdownButtonFormField` guna `isExpanded: true` dan `Text(..., overflow: TextOverflow.ellipsis)` |
| Kad kembali ke skrin senarai memaparkan `SnackBar` **dua kali** | `_mohon()` dipanggil semula tanpa `_sudahMohon` melumpuhkan butang (`onPressed: null` bila `true`) | Semak semula `onPressed: _sudahMohon ? null : _mohon` (Latihan 3.3) |

---

## Cabaran

Pilih **sekurang-kurangnya satu**:

1. **Dialog pengesahan sebelum hantar** — sebelum `Navigator.pop(application)` dalam `_submit()`, papar `AlertDialog` ("Adakah anda pasti mahu menghantar permohonan ini?") dengan butang "Batal" dan "Hantar" — hanya teruskan `pop()` jika pengguna tekan "Hantar".

2. **Elak permohonan berganda tanpa provider** — di `HomeScreen` (atau skrin induk lain), simpan `Set<String> _programmeIdSudahMohon = {}` sebagai state tempatan (`setState()`), kemas kini apabila `await push<Application>()` memulangkan hasil bukan `null`, dan lalukan status ini sebagai parameter tambahan (`bool sudahMohon`) ke `ProgrammeDetailScreen` supaya butang "Mohon" boleh dilumpuhkan **walaupun** pengguna kembali ke senarai dan buka semula tawaran yang sama.

3. **Named route dengan senarai penuh** — tukar **kesemua** `onTap` kad tawaran (bukan hanya kad pertama seperti Latihan 2) kepada `pushNamed('/detail', arguments: p)`, dan alih keluar `push` terus sepenuhnya. Uji semula kesemua kad masih berfungsi.

4. **(Lanjutan)** Tambah validator/logik tersuai yang menolak **Pilihan 2** atau **Pilihan 3** jika nilainya **sama** dengan Pilihan 1 atau satu sama lain (memohon universiti yang sama dua/tiga kali tidak masuk akal) — paparkan mesej ralat pada dropdown berkenaan.

Rujuk fail rujukan penuh (versi `provider` projek sebenar) di `projek/ett_mobile/lib/screens/application_form_screen.dart` jika anda tersekat — tetapi cuba dahulu versi `setState()` anda sendiri sebelum membukanya.

---

## Rujukan Fail Sebenar

| Fail anda (lab) | Fail rujukan (projek sebenar) |
|---|---|
| `ProgrammeDetailScreen` (Latihan 1, 3.3, 6) | `projek/ett_mobile/lib/screens/programme_detail_screen.dart` (`StatelessWidget` — versi sebenar tidak perlu `setState()` kerana guna `provider`) |
| `application.dart` (Latihan 3.1) | `projek/ett_mobile/lib/models/application.dart` (versi penuh + `toJson`/`fromJson` untuk `shared_preferences`) |
| `ApplicationFormScreen` penuh (Latihan 4) | `projek/ett_mobile/lib/screens/application_form_screen.dart` (versi `provider` — bandingkan `_submit()` anda dengan versi sana, README Bahagian 6.7) |
| `validators.dart` (Latihan 4–5) | [`validators.dart`](./validators.dart) — boleh disahkan terus (`dart analyze snippets/validators.dart`) |
| `document_checklist.dart` | `projek/ett_mobile/lib/data/document_checklist.dart` |
| `LifecycleDemo` (Latihan 6) | *(tiada padanan terus — demo konsep sahaja, bukan sebahagian aliran permohonan sebenar)* |

Selamat mencuba — jumpa di Hari 4 untuk sambungkan senarai tawaran kepada REST API sebenar!
