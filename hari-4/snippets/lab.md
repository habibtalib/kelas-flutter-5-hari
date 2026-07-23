# Lab Hari 4 — REST API, Async & Error Handling

Lab ini mengiringi [`README.md`](../README.md) Hari 4. Ikut latihan **secara berurutan** — setiap latihan bina di atas latihan sebelumnya, tepat seperti fail sebenar di `projek/ett_mobile/lib/`. Kita bina **tiga lapisan** hari ini, satu demi satu: **model** (`Programme.fromJson`) → **servis** (`ProgrammeService.fetchProgrammes`) → **UI** (skrin dengan loading/error/retry/refresh/submit).

> **Cara baca kod dalam lab ini:** blok kod menunjukkan **sekeping fail sebenar**, bukan baris terpencil. `// ...` bermaksud "kod sedia ada, jangan ubah". Kotak `╔═╗` atau komen `👈 TAMBAH DI SINI` menunjukkan **tempat tepat** kod baharu masuk. Sesetengah langkah pertengahan (contohnya 3.2, 5.3) **sengaja belum lengkap secara logik** — ia masih boleh kompil, tetapi belum berfungsi penuh; jangan risau, langkah seterusnya akan lengkapkannya.

### Dua penanda ujian — apa bezanya

Lab ini ada **dua** jenis arahan menguji. Jangan keliru:

| Penanda | Maksud | Perlu buat? |
|---|---|---|
| ▶ **Jalankan** | Semakan **pantas** di tengah langkah — Hot Reload (`r`) atau Hot Restart (`R`), pandang skrin/terminal sekejap, teruskan. Ambil ~10 saat. | Ya, tetapi ringkas |
| 🧪 **Uji Latihan N** | Ujian **penuh** di hujung setiap latihan. Ada **laluan navigasi** ("macam mana nak sampai ke skrin itu"), jadual langkah demi langkah, dan petua bila gagal. | **Ya — jangan langkau.** Ini bukti latihan anda betul |

Setiap blok 🧪 **Uji** disusun begini:

> **Sampai ke sana:** langkah navigasi dari skrin mula — supaya anda tidak tercari-cari.
>
> Kemudian jadual: **Buat ini** → **Patut nampak**. Buat ikut turutan, dari atas ke bawah.
>
> Akhir sekali **❌ Tak jadi?** — senarai punca paling biasa, supaya anda boleh baiki sendiri tanpa tunggu jurulatih.

> **Khas Hari 4:** hari ini separuh daripada bukti berada di **terminal**, bukan pada skrin — kod status HTTP, JSON mentah, mesej ralat rangkaian. Setiap baris jadual menyatakan dengan jelas sama ada anda patut pandang **skrin** atau **terminal**.

## Persediaan

1. Buka semula projek `ett_mobile` anda (teruskan daripada Hari 3 — JANGAN buat projek baharu).
2. **Salin fail permulaan (foundation).** Lab hari ini bina **di atas** model, tema, data & widget yang sudah siap. Jika anda teruskan projek Hari 3, fail ini kemungkinan besar **sudah ada** — langkau. Salin hanya jika anda mula dari `flutter create` baharu ATAU `flutter analyze` mengadu fail hilang (rujuk [`starter/README.md`](./starter/README.md)):
   ```bash
   # dari dalam folder projek ett_mobile anda
   mkdir -p lib/models lib/data lib/widgets
   cp <laluan-repo>/hari-4/snippets/starter/theme.dart                  lib/theme.dart
   cp <laluan-repo>/hari-4/snippets/starter/models/programme.dart       lib/models/programme.dart
   cp <laluan-repo>/hari-4/snippets/starter/models/application.dart      lib/models/application.dart
   cp <laluan-repo>/hari-4/snippets/starter/data/sample_programmes.dart  lib/data/sample_programmes.dart
   cp <laluan-repo>/hari-4/snippets/starter/data/document_checklist.dart lib/data/document_checklist.dart
   cp <laluan-repo>/hari-4/snippets/starter/widgets/programme_card.dart  lib/widgets/programme_card.dart
   cp <laluan-repo>/hari-4/snippets/starter/widgets/status_badge.dart    lib/widgets/status_badge.dart
   ```
   > **Nota penting:** `starter/models/programme.dart` **sengaja** tanpa `fromString`/`Programme.fromJson` — anda **bina sendiri** di Latihan 3. Itu inti pelajaran hari ini, bukan silap.
3. Jalankan projek:
   ```bash
   cd projek/ett_mobile
   flutter pub get
   flutter run
   ```

▶ **Jalankan** → anda patut nampak: senarai tawaran pengajian memaparkan **8** rekod hardcoded (dari `lib/data/sample_programmes.dart`), sama seperti akhir Hari 3. Jika anda meneruskan projek versi anda sendiri, tidak mengapa — setiap latihan akan beritahu fail yang perlu ditambah/dikemaskini.

> Rujukan kod "siap": `projek/ett_mobile/lib/services/programme_service.dart`, `lib/models/programme.dart`, `lib/screens/programme_list_screen.dart`. Data mock sumber: `projek/mock-api/programmes.json`. Aplikasi rujukan guna pakej `provider` untuk kongsi state merentasi skrin (**pratonton** sahaja) — lab ini guna `setState()` (kaedah rasmi kursus), tetapi strukturnya **sama persis**.

✅ **Semakan Persediaan:** `flutter run` berjaya tanpa skrin merah, senarai memaparkan **8** tawaran (kad pertama 🇪🇬 Universiti Al-Azhar · Perubatan), dan `flutter analyze` melapor **No issues found!**. Kalau salah satu gagal, betulkan **sekarang** — semua latihan hari ini bina di atas asas ini.

---

## Latihan 1 — Pasang pakej `http` & kebenaran internet Android

**Objektif:** Sediakan dua keperluan asas sebelum sebarang panggilan rangkaian boleh berjalan: pakej HTTP, dan kebenaran Android.

1. Jalankan:
   ```bash
   flutter pub add http
   ```
2. Buka `pubspec.yaml`, sahkan baris berikut wujud di bawah `dependencies:`:
   ```yaml
   dependencies:
     http: ^1.2.2
   ```
3. Jalankan `flutter pub get` untuk pastikan semua bergantungan diselesaikan tanpa ralat.
4. Buka `android/app/src/main/AndroidManifest.xml` (fail **utama** — bukan `android/app/src/debug/AndroidManifest.xml` atau `.../profile/AndroidManifest.xml`, yang sudah ada kebenaran ini secara automatik) dan tambah baris berikut di dalam tag `<manifest>`:
   ```xml
   <uses-permission android:name="android.permission.INTERNET"/>
   ```
5. `flutter run` sekali lagi (kebenaran ini tidak menjejaskan `flutter run` debug — ia penting untuk **release build** kelak).

#### Guna iOS Simulator / Mac? Baca ini

iOS **tidak** perlukan kebenaran INTERNET — ia dibenarkan secara lalai. Tetapi iOS ada sekatan lain: **App Transport Security (ATS)** menghalang sambungan **`http://`** biasa (bukan `https://`). Kesannya:

| Kaedah Latihan 2 | Android | iOS |
|---|---|---|
| **2A** GitHub raw (`https://`) | ✅ terus jalan | ✅ terus jalan |
| **2B** `json-server` (`http://localhost:3001`) | ✅ terus jalan | ❌ **disekat ATS** sehingga anda tambah pengecualian |

Kalau anda mahu guna **2B pada iOS**, buka `ios/Runner/Info.plist` dan tambah **sebelum** `</dict>` terakhir:

```xml
	<key>NSAppTransportSecurity</key>
	<dict>
		<!-- Benarkan HTTP ke rangkaian tempatan sahaja (json-server semasa latihan).
		     Ini TIDAK melumpuhkan ATS untuk internet awam. -->
		<key>NSAllowsLocalNetworking</key>
		<true/>
	</dict>
```

Kemudian **hentikan** aplikasi dan `flutter run` semula — tukar `Info.plist` perlukan bina semula penuh, bukan Hot Restart.

> Kalau anda hanya guna **2A (GitHub raw, `https://`)**, langkah iOS ini **tidak perlu** langsung.

▶ **Jalankan** → anda patut nampak: aplikasi terbuka seperti biasa (senarai 8 tawaran), tiada perubahan visual — betul, langkah ini hanya menyiapkan pakej + kebenaran untuk latihan seterusnya.

### 🧪 Uji Latihan 1

> **Sampai ke sana:** tiada skrin baharu untuk latihan ini — semua bukti ada di **terminal** dan dalam fail konfigurasi. Buka terminal di dalam folder projek anda (`cd projek/ett_mobile`).

| # | Buat ini | Patut nampak |
|---|---|---|
| 1 | Buka `pubspec.yaml` | `http: ^1.2.2` berlekuk **dua ruang** di bawah `dependencies:` — **bukan** di bawah `dev_dependencies:` |
| 2 | **Terminal:** `flutter pub deps --style=compact` | Baris menyebut `http` sebagai bergantungan projek anda |
| 3 | Buka `android/app/src/main/AndroidManifest.xml` | `<uses-permission android:name="android.permission.INTERNET"/>` berada **di dalam** `<manifest>` dan **di luar** `<application>` |
| 4 | **Terminal:** `flutter analyze` | `No issues found!` |
| 5 | **Terminal:** `flutter run` | Aplikasi buka seperti biasa — senarai **8** tawaran, tiada perubahan visual. Itu memang betul: latihan ini hanya menyiapkan alat |

❌ **Tak jadi?**
- `flutter pub get` gagal dengan mesej percanggahan versi → jangan taip nombor versi sendiri; jalankan `flutter pub add http` semula dan biar `pub` pilih versi yang serasi.
- `Error on line ..., column ...` daripada `pubspec.yaml` → lekukan YAML salah. `http:` mesti **dua ruang** ke dalam, dan guna ruang (space), bukan tab.
- Anda tersilap menyunting `android/app/src/debug/AndroidManifest.xml` → kebenaran itu memang sudah ada di sana secara automatik. Yang perlu ditambah ialah fail **`main`**; kesan silap ini hanya muncul pada *release build*, jadi mudah terlepas.
- `Undefined name 'http'` bila anda mula guna pakej itu di Latihan 4 → `import 'package:http/http.dart' as http;` tertinggal, atau `flutter pub get` belum dijalankan selepas menyunting `pubspec.yaml`.

---

## Latihan 2 — Hos `programmes.json` anda sendiri

**Objektif:** Sediakan satu URL JSON sebenar yang boleh dicapai melalui rangkaian — tanpa ini, Latihan 4 hanya boleh diuji melalui fallback, bukan panggilan HTTP sebenar.

Data sumber sudah sedia di `projek/mock-api/programmes.json` (salinan juga ada di [`programmes.json`](./programmes.json) dalam folder ini). Pilih **satu** kaedah.

### 2A — GitHub raw URL (paling mudah, kekal)

1. Buat repositori GitHub baharu (boleh guna akaun peribadi anda), atau guna repo kelas sedia ada.
2. Muat naik fail `programmes.json` (salin daripada `projek/mock-api/programmes.json`).
3. Buka fail itu di laman web GitHub → klik butang **Raw** di penjuru kanan atas.
4. Salin URL bar alamat pelayar — formatnya:
   ```
   https://raw.githubusercontent.com/<username-anda>/<nama-repo>/main/programmes.json
   ```
5. Tampal URL itu ke pelayar biasa (bukan emulator) dahulu — pastikan ia terus papar teks JSON mentah, bukan halaman GitHub berformat.

### 2B — `json-server` tempatan (pantas untuk demo langsung)

```bash
npx json-server --watch projek/mock-api/programmes.json --port 3001
```

- Uji dahulu di pelayar komputer: buka `http://localhost:3001/programmes` — patut papar senarai JSON (perhatikan nama laluan `programmes` — jamak, dijana automatik oleh `json-server` daripada nama fail).
- **Emulator Android:** guna `http://10.0.2.2:3001/programmes`, **bukan** `localhost` — `10.0.2.2` ialah alias tetap Google untuk "mesin host" (komputer anda) dari dalam emulator. (Rujuk README SESI 7, Langkah 6.)
- **iOS Simulator:** guna `http://localhost:3001/programmes` terus — simulator berkongsi rangkaian Mac anda, jadi `10.0.2.2` **tidak** berfungsi di sini (itu alias Android sahaja). Anda juga perlu pengecualian ATS dalam `Info.plist` — lihat kotak "Guna iOS Simulator / Mac?" di Latihan 1.
- **Peranti fizikal:** guna alamat IP komputer anda dalam WiFi yang sama, cth. `http://192.168.1.10:3001/programmes`. Cari IP dengan `ipconfig getifaddr en0` (Mac) atau `ipconfig` (Windows). Telefon dan komputer **mesti** berada dalam WiFi yang sama untuk ini berfungsi.

### 🧪 Uji Latihan 2

> **Sampai ke sana:** semua ujian ini dibuat di **terminal komputer** + **pelayar komputer**. Belum ada kod Flutter yang menyentuh URL ini — itu Latihan 4. Ganti `<URL>` di bawah dengan URL pilihan anda dan **simpan** URL itu; anda akan menampalnya ke `_endpoint` nanti.

**Bahagian A — sahkan URL anda (kedua-dua 2A & 2B):**

| # | Buat ini | Patut nampak (di TERMINAL/pelayar) |
|---|---|---|
| 1 | **Terminal:** `curl <URL>` | Teks JSON mentah bermula dengan `[` dan `{` … `"id": "ETT-001"` — **bukan** `<!DOCTYPE html>`, bukan mesej ralat |
| 2 | **Terminal:** `curl -i <URL> \| head -1` | Baris status `HTTP/... 200` |
| 3 | **Terminal:** `curl -s <URL> \| grep -o '"id"' \| wc -l` | `8` — lapan rekod tawaran |
| 4 | Buka URL yang sama dalam **pelayar** | Teks JSON mentah sahaja. Jika 2A: pastikan bar alamat bermula `https://raw.githubusercontent.com/` — bukan `https://github.com/` |

**Bahagian B — hanya jika anda pilih 2B (`json-server`):**

| # | Buat ini | Patut nampak |
|---|---|---|
| 5 | Pandang terminal tempat `json-server` berjalan | Senarai *Resources* termasuk `http://localhost:3001/programmes` |
| 6 | **Terminal (tetingkap lain):** `curl http://localhost:3001/programmes` | JSON 8 rekod yang sama seperti Bahagian A |

❌ **Tak jadi?**
- `json-server` enggan start, mengadu **`Data must be an object`** → `programmes.json` ialah **array** di aras atas (`[ ... ]`), dan `json-server` memerlukan **objek**. Bungkusnya: `{ "programmes": [ …8 rekod… ], "applications": [] }`. Nama laluan diambil daripada **kunci objek** (`/programmes`), bukan daripada nama fail. Tambah `"applications": []` sekarang juga — Latihan 7 memerlukan laluan itu.
- `curl` memulangkan HTML GitHub → anda salin URL **halaman**, bukan URL **Raw**. Tekan butang **Raw** dahulu, baru salin bar alamat.
- `404` pada raw URL → nama cabang salah (`main` vs `master`), laluan folder tertinggal, atau fail belum di-*push*.
- `Connection refused` pada `localhost:3001` → proses `json-server` sudah berhenti. Jalankan semula dan **biarkan** terminal itu terbuka sepanjang lab.
- Ingat: `localhost` hanya sah pada **komputer**. Emulator guna `10.0.2.2`, peranti fizikal guna IP WiFi komputer — itu diuji di Latihan 4, belum sekarang.

---

## Latihan 3 — Tulis `Programme.fromJson` langkah demi langkah

**Objektif:** Model `Programme` yang anda bina Hari 1–2 (medan biasa + enum dengan `label`) belum tahu bagaimana untuk **dilahirkan daripada JSON**. Kita tambah keupayaan itu sekarang, tanpa mengubah medan sedia ada.

Buka `lib/models/programme.dart` anda.

### 3.1 — Tambah `fromString` pada kedua-dua enum

`jsonDecode` tidak faham `enum` — ia hanya faham `String`. Kita perlukan kaedah untuk **memetakan** `String` (cth. `"bachelor"`) balik kepada nilai `enum`. Tambah dalam `enum StudyLevel`, **selepas** getter `label` sedia ada:

```dart
enum StudyLevel {
  foundation,
  diploma,
  bachelor;

  String get label => switch (this) {
        StudyLevel.foundation => 'Asasi',
        StudyLevel.diploma => 'Diploma',
        StudyLevel.bachelor => 'Ijazah Sarjana Muda',
      };

  // ── 3.1 — fromString: String → enum ───────────────────
  static StudyLevel fromString(String value) {
    return StudyLevel.values.firstWhere(
      (s) => s.name == value,
      orElse: () => StudyLevel.bachelor,
    );
  }
}
```

Ulang corak yang **sama** untuk `enum EntryCategory` (letak `fromString` selepas getter/kaedah sedia ada di situ, `orElse: () => EntryCategory.spm`).

> **Kenapa `firstWhere(..., orElse:)` dan bukan `.byName(value)`?** `.byName()` **melontar `ArgumentError` dan meranap** jika pelayan hantar nilai tak dikenali; `firstWhere` + `orElse` sentiasa pulangkan nilai selamat. (Rujuk README SESI 6, Langkah 5.)

### 3.2 — Rangka `factory Programme.fromJson` (sementara, guna placeholder)

Tambah dalam `class Programme`, **selepas** constructor `const Programme({...})` sedia ada:

```dart
  const Programme({
    required this.id,
    // ... (medan sedia ada, jangan ubah)
  });

  // ── 3.2 — Rangka fromJson (placeholder dahulu) ────────
  factory Programme.fromJson(Map<String, dynamic> json) {
    return Programme(
      id: json['id'] as String,
      universityName: json['universityName'] as String,
      country: json['country'] as String,
      // 👈 3.3 — GANTI baris "TBD" di bawah dengan json[...] SEBENAR
      city: 'TBD',
      fieldOfStudy: 'TBD',
      studyLevel: StudyLevel.bachelor,
      category: EntryCategory.spm,
      estimatedAnnualCostMyr: 0,
      intakeMonth: 'TBD',
      recognitionNote: 'TBD',
      quotaSeats: 0,
    );
  }
```

Kod ini **sudah boleh kompil** (semua parameter `required` diisi, walaupun sebahagian dengan nilai sementara) — cuma belum berguna sepenuhnya. `flutter analyze` patut masih bersih di sini.

### 3.3 — Isi baki medan dengan nilai sebenar daripada `json`

Ganti setiap `'TBD'`/`0`/enum hardcoded dengan bacaan sebenar daripada `json`:

```dart
  factory Programme.fromJson(Map<String, dynamic> json) {
    return Programme(
      id: json['id'] as String,
      universityName: json['universityName'] as String,
      country: json['country'] as String,
      // ── 3.3 — Baki medan, daripada json sebenar ─────────
      city: json['city'] as String,
      fieldOfStudy: json['fieldOfStudy'] as String,
      studyLevel: StudyLevel.fromString(json['studyLevel'] as String),
      category: EntryCategory.fromString(json['category'] as String),
      estimatedAnnualCostMyr:
          (json['estimatedAnnualCostMyr'] as num).toDouble(),
      intakeMonth: json['intakeMonth'] as String,
      recognitionNote: json['recognitionNote'] as String,
      quotaSeats: json['quotaSeats'] as int,
    );
  }
```

Perhatikan **`(... as num).toDouble()`** (bukan `as double` terus): JSON kadang hantar `23000` (int) walaupun kita mahu `double`, dan `as double` terus akan **gagal `TypeError`** — `as num` terima int/double dahulu sebelum ditukar selamat. (Rujuk README SESI 6, Langkah 5.)

### 3.4 — Fail penuh selepas Latihan 3

Banding bahagian `factory fromJson` fail anda dengan ini (kelas penuh `Programme` tidak dipaparkan semula di sini — hanya bahagian yang berubah):

```dart
factory Programme.fromJson(Map<String, dynamic> json) {
  return Programme(
    id: json['id'] as String,
    universityName: json['universityName'] as String,
    country: json['country'] as String,
    city: json['city'] as String,
    fieldOfStudy: json['fieldOfStudy'] as String,
    studyLevel: StudyLevel.fromString(json['studyLevel'] as String),
    category: EntryCategory.fromString(json['category'] as String),
    estimatedAnnualCostMyr:
        (json['estimatedAnnualCostMyr'] as num).toDouble(),
    intakeMonth: json['intakeMonth'] as String,
    recognitionNote: json['recognitionNote'] as String,
    quotaSeats: json['quotaSeats'] as int,
  );
}
```

**Uji secara manual (tanpa rangkaian):** tambah kod sementara ini di dalam `main()` (padam selepas diuji) untuk sahkan `fromJson` betul-betul berfungsi:

```dart
void main() {
  final contoh = Programme.fromJson({
    'id': 'ETT-999',
    'universityName': 'Universiti Ujian',
    'country': 'Egypt',
    'city': 'Kaherah (Cairo)',
    'fieldOfStudy': 'Ujian',
    'studyLevel': 'bachelor',
    'category': 'spm',
    'estimatedAnnualCostMyr': 12000,   // sengaja int, bukan double
    'intakeMonth': 'September',
    'recognitionNote': 'Ujian sahaja.',
    'quotaSeats': 10,
  });
  print(contoh.universityName);              // Universiti Ujian
  print(contoh.estimatedAnnualCostMyr);       // 12000.0 — bukan crash
  print(contoh.studyLevel.label);             // Ijazah Sarjana Muda
}
```

▶ **Jalankan** (`flutter run`, lihat **terminal**) → anda patut nampak **tiga baris**: `Universiti Ujian`, `12000.0` (bukan `12000` — bukti `(as num).toDouble()` bekerja walau input `int`), dan `Ijazah Sarjana Muda`.

### 🧪 Uji Latihan 3

> **Sampai ke sana:** tampal `main()` ujian di atas ke dalam `lib/main.dart` (gantikan `main()` asal buat sementara) → `flutter run` → **pandang TERMINAL**, bukan skrin. Skrin akan kekal **kosong/hitam** kerana `main()` ujian ini tidak memanggil `runApp()` — itu dijangka, bukan pepijat.

| # | Buat ini | Patut nampak (di TERMINAL) |
|---|---|---|
| 1 | `flutter run`, baca output terminal — baris pertama | `Universiti Ujian` |
| 2 | Baris kedua | `12000.0` — **ada `.0`**. Kalau `12000` sahaja, medan itu bukan `double`; semak `(… as num).toDouble()` |
| 3 | Baris ketiga | `Ijazah Sarjana Muda` — **bukan** `bachelor`. Ini bukti `StudyLevel.fromString` + getter `label` bekerja |
| 4 | Tukar sementara `'studyLevel': 'bachelor'` → `'studyLevel': 'phd'`, jalankan semula | **Tiada crash**; baris ketiga kekal `Ijazah Sarjana Muda` — itulah kerja `orElse: () => StudyLevel.bachelor` |
| 5 | Kembalikan `'bachelor'`. Tukar pula `'estimatedAnnualCostMyr': 12000` → `12000.5` | Baris kedua jadi `12000.5` — `as num` terima `int` **dan** `double` |
| 6 | **Padam** blok ujian, kembalikan `main()` asal (yang memanggil `runApp(...)`), jalankan semula | Aplikasi kembali normal: senarai **8** tawaran di skrin |
| 7 | **Terminal:** `flutter analyze` | `No issues found!` (selepas blok ujian dipadam) |

❌ **Tak jadi?**
- Skrin hitam/kosong dan anda sangka aplikasi rosak → betul, `main()` ujian tidak memanggil `runApp()`. Ini sementara sahaja; langkah 6 memulihkannya.
- `flutter analyze` mengadu **`avoid_print`** semasa blok ujian masih ada → itu dijangka (lint `flutter_lints`). Ia hilang sebaik blok ujian dipadam (langkah 6); kalau anda mahu senyapkan buat sementara, tambah `// ignore: avoid_print` di atas setiap `print`.
- `type 'int' is not a subtype of type 'double'` → anda tulis `json['estimatedAnnualCostMyr'] as double`. Guna `(json[…] as num).toDouble()` (langkah 3.3).
- `ArgumentError: No enum value with that name` semasa langkah 4 → anda guna `.byName(value)`. Tukar kepada `firstWhere(…, orElse:)` (langkah 3.1).
- `type 'Null' is not a subtype of type 'String'` → satu kunci JSON tersalah eja. Kunci **sensitif huruf besar/kecil**: `universityName`, `fieldOfStudy`, `studyLevel`, `estimatedAnnualCostMyr`, `intakeMonth`, `recognitionNote`, `quotaSeats`.
- Tiada `print` langsung di terminal → anda letak kod ujian dalam fail yang tidak dipanggil, atau anda memandang terminal `flutter run` yang lain.
- Ragu sama ada `fromJson` anda betul → banding dengan `projek/ett_mobile/lib/models/programme.dart`.

---

## Latihan 4 — Bina `ProgrammeService.fetchProgrammes()` langkah demi langkah

**Objektif:** Bina lapisan servis yang benar-benar memanggil rangkaian, **secara berperingkat** — supaya jelas *kenapa* setiap kepingan (`try/catch`, `.timeout`, fallback) wujud, bukan sekadar salin kod siap.

Cipta fail `lib/services/programme_service.dart` jika belum ada.

### 4.1 — Panggilan GET paling bare, cetak sahaja

```dart
import 'dart:async';

import 'package:http/http.dart' as http;

import '../models/programme.dart';

class ProgrammeService {
  ProgrammeService({http.Client? client}) : _client = client ?? http.Client();

  final http.Client _client;

  static const String _endpoint = '<URL anda dari Latihan 2>';

  // ── 4.1 — GET paling bare, cetak sahaja ───────────────
  Future<List<Programme>> fetchProgrammes() async {
    final response = await _client.get(Uri.parse(_endpoint));
    // ignore: avoid_print
    print('Status: ${response.statusCode}');
    // ignore: avoid_print
    print('Body: ${response.body}');
    return []; // 👈 4.2 — GANTI baris ini dengan penghuraian JSON sebenar
  }

  void dispose() => _client.close();
}
```

Panggil `fetchProgrammes()` dari mana-mana skrin ujian sementara (atau `main()`).

▶ **Jalankan** (lihat **terminal**) → anda patut nampak: `Status: 200` diikuti `Body:` + teks JSON penuh 8 tawaran. Jika `Status:` bukan `200`, URL/hos anda (Latihan 2) belum betul — betulkan dahulu sebelum teruskan.

### 4.2 — Tambah `jsonDecode` + map ke `Programme`

```dart
import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/programme.dart';

class ProgrammeService {
  // ...

  // ── 4.2 — jsonDecode + map ke Programme ───────────────
  Future<List<Programme>> fetchProgrammes() async {
    final response = await _client.get(Uri.parse(_endpoint));
    final List<dynamic> data = jsonDecode(response.body) as List<dynamic>;
    return data
        .map((e) => Programme.fromJson(e as Map<String, dynamic>))
        .toList();
  }
```

▶ **Jalankan** → anda patut nampak: senarai `Programme` terhasil betul **jika** rangkaian okay (tiada lagi `Status/Body` dicetak — `print` sudah dibuang). Tetapi kod ini **rapuh** — cuba eksperimen di bawah untuk buktikan kenapa.

> **Eksperimen (sengaja rosakkan):** matikan WiFi komputer/telefon sekejap dan cuba panggil `fetchProgrammes()` semula. Aplikasi patut **crash** dengan skrin merah menyebut `SocketException` — kerana `await _client.get(...)` melontar (`throw`) ralat, dan tiada apa-apa di sini menangkapnya. Ini **bukti langsung** kenapa `try/catch` di 4.3 wajib, bukan hiasan. Hidupkan semula WiFi sebelum teruskan.

### 4.3 — Bungkus dengan `try/catch`, semak `statusCode`, tambah `.timeout`

```dart
  // ── 4.3 — try/catch + semak statusCode + timeout ──────
  Future<List<Programme>> fetchProgrammes() async {
    try {
      final response = await _client
          .get(Uri.parse(_endpoint))
          .timeout(const Duration(seconds: 8));

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body) as List<dynamic>;
        return data
            .map((e) => Programme.fromJson(e as Map<String, dynamic>))
            .toList();
      }
      return []; // 👈 4.4 — status BUKAN 200 sepatutnya fallback, bukan senarai kosong
    } catch (_) {
      return []; // 👈 4.4 — sebarang ralat/timeout sepatutnya fallback juga
    }
  }
```

Dua laluan kini dilayan berasingan: `if (statusCode == 200)` untuk pelayan **jawab tetapi bukan OK** (404/500), dan `catch (_)` untuk rangkaian **gagal sepenuhnya** (tiada internet/timeout/JSON rosak). Tanpa semakan `statusCode`, `jsonDecode` badan ralat 404/500 akan meletup dengan `FormatException` mengelirukan. (Rujuk README SESI 7, Langkah 3.)

### 4.4 — Tambah `_fallback()` tempatan

```dart
import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

import '../data/sample_programmes.dart';
import '../models/programme.dart';

class ProgrammeService {
  ProgrammeService({http.Client? client}) : _client = client ?? http.Client();

  final http.Client _client;

  static const String _endpoint = '<URL anda dari Latihan 2>';

  Future<List<Programme>> fetchProgrammes() async {
    try {
      final response = await _client
          .get(Uri.parse(_endpoint))
          .timeout(const Duration(seconds: 8));

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body) as List<dynamic>;
        return data
            .map((e) => Programme.fromJson(e as Map<String, dynamic>))
            .toList();
      }
      return _fallback();
    } catch (_) {
      return _fallback();
    }
  }

  // ── 4.4 — Fallback tempatan ────────────────────────────
  Future<List<Programme>> _fallback() async {
    await Future.delayed(const Duration(milliseconds: 600));
    return sampleProgrammes;
  }

  void dispose() => _client.close();
}
```

`Future.delayed(...)` di sini **sengaja** — ia mensimulasikan sedikit kelewatan supaya `CircularProgressIndicator` (Latihan 5) sempat kelihatan walaupun fallback sebenarnya pantas, dan supaya pengalaman "loading" konsisten sama ada data datang dari API atau fallback.

### 4.5 — Fail penuh selepas Latihan 4

```dart
import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

import '../data/sample_programmes.dart';
import '../models/programme.dart';

class ProgrammeService {
  ProgrammeService({http.Client? client}) : _client = client ?? http.Client();

  final http.Client _client;

  static const String _endpoint = '<URL anda dari Latihan 2>';

  Future<List<Programme>> fetchProgrammes() async {
    try {
      final response = await _client
          .get(Uri.parse(_endpoint))
          .timeout(const Duration(seconds: 8));

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body) as List<dynamic>;
        return data
            .map((e) => Programme.fromJson(e as Map<String, dynamic>))
            .toList();
      }
      return _fallback();
    } catch (_) {
      return _fallback();
    }
  }

  Future<List<Programme>> _fallback() async {
    await Future.delayed(const Duration(milliseconds: 600));
    return sampleProgrammes;
  }

  void dispose() => _client.close();
}
```

### Eksperimen: `timeout` & fallback

| Cuba tukar | Perhatikan apa jadi | Kesimpulan |
|---|---|---|
| `.timeout(const Duration(milliseconds: 1))` (terlalu singkat) | Hampir **selalu** jatuh ke `_fallback()` walaupun WiFi okay | Timeout terlalu pendek = ralat palsu (*false timeout*), bukan cerminan rangkaian sebenar |
| Tukar `_endpoint` kepada `'https://example.invalid/x.json'` (URL sengaja rosak) | Aplikasi **tidak** crash — terus fallback ke 8 tawaran hardcoded | `try/catch` + fallback lindungi pengguna daripada URL/konfigurasi salah |
| Matikan WiFi terus | Fallback tetap berfungsi (lihat *loading* sekejap, lepas itu data hardcoded muncul) | Fallback adalah **keputusan reka bentuk** — bukan kegagalan tersembunyi |
| Tukar `_endpoint` kepada URL yang **wujud tetapi bukan JSON/404** (cth. tambah `/tiada` di hujung raw URL GitHub anda) | Tetap fallback — tetapi kali ini melalui cabang `if (statusCode == 200)` yang **gagal**, bukan `catch` | Buktikan **dua** cabang 4.3 berbeza: 404 = pelayan jawab bukan-OK, bukan rangkaian mati |
| Tukar kelewatan `_fallback` `600` → `3000` (milisaat) | *Loading* (spinner Latihan 5) berlegar jauh **lebih lama** sebelum data muncul | Kelewatan `_fallback` mengawal berapa lama "loading" dirasai — bukan rangkaian sebenar |

Kembalikan `.timeout(const Duration(seconds: 8))`, kelewatan `600`, dan `_endpoint` sebenar anda selepas eksperimen.

### 🧪 Uji Latihan 4

> **Sampai ke sana:** pastikan `_endpoint` sudah ditukar kepada URL sebenar anda dari Latihan 2, dan `fetchProgrammes()` dipanggil dari `main()`/skrin ujian sementara → `flutter run`. Kerana `_endpoint` ialah `static const`, setiap kali anda mengubahnya tekan **`R`** besar (Hot **Restart**) di terminal — `r` kecil tidak mencukupi. Bukti utama latihan ini ada di **terminal**.

**Bahagian A — laluan berjaya (WiFi hidup, `_endpoint` betul):**

| # | Buat ini | Patut nampak |
|---|---|---|
| 1 | Semasa masih di peringkat **4.1**, jalankan | **Terminal:** `Status: 200`, kemudian `Body: [{"id":"ETT-001",…` — JSON penuh 8 tawaran |
| 2 | Selepas siap **4.2–4.5**, tekan `R` | **Terminal:** tiada lagi `Status:`/`Body:` (kedua-dua `print` sudah dibuang) dan **tiada** ralat — servis memulangkan 8 objek `Programme` |

**Bahagian B — laluan gagal (bukti `try/catch` + fallback):**

| # | Buat ini | Patut nampak |
|---|---|---|
| 3 | Matikan WiFi komputer/telefon, tekan `R` | **Skrin:** tiada skrin merah. Selepas *loading* singkat, **8** tawaran fallback (`sampleProgrammes`) tetap muncul |
| 4 | Hidupkan WiFi semula, tekan `R` | Data daripada API kembali |
| 5 | Tukar `_endpoint` → `'https://example.invalid/x.json'`, tekan `R` | Tiada crash; fallback lagi — kali ini melalui cabang **`catch (_)`** |
| 6 | Tukar `_endpoint` → raw URL anda **+ `/tiada`** (sengaja 404), tekan `R` | Tiada crash; fallback juga — tetapi kali ini melalui cabang **`if (statusCode == 200)` yang gagal**. Untuk buktikan, tambah sementara `// ignore: avoid_print` + `print('status: ${response.statusCode}')` sebelum `if` → **terminal** papar `status: 404` |
| 7 | Buang `print` ujian itu, kembalikan `_endpoint` sebenar, `.timeout(const Duration(seconds: 8))` dan kelewatan `_fallback` `600`, tekan `R` | Data API kembali seperti langkah 2 |
| 8 | **Terminal:** `flutter analyze` | `No issues found!` |

Langkah 5 vs 6 ialah inti latihan ini: **dua** kegagalan berbeza (rangkaian mati vs pelayan jawab bukan-OK) dikendalikan oleh **dua** cabang berlainan, tetapi pengguna tidak pernah nampak skrin merah.

❌ **Tak jadi?**
- Skrin merah `SocketException` masih muncul → anda masih di peringkat 4.2; `try/catch` (4.3) belum ditambah.
- Terminal papar `Status:` bukan `200` (mis. `404`) di langkah 1 → URL Latihan 2 belum betul. Betulkan dahulu sebelum teruskan; jangan teruskan ke 4.2 dengan URL rosak.
- `Status: 200` tetapi `Body:` mengandungi HTML → URL bukan **Raw**. Rujuk 🧪 Uji Latihan 2.
- `Connection refused` di **emulator** dengan `http://localhost:3001/...` → `localhost` di dalam emulator merujuk emulator itu sendiri. Guna `http://10.0.2.2:3001/...`.
- Data **tidak pernah** berubah walaupun API hidup → `_endpoint` ialah `static const`; tekan **`R`** besar, bukan `r` kecil.
- `FormatException: Unexpected character` → anda `jsonDecode` badan ralat 404/500. Semak `statusCode == 200` **sebelum** `jsonDecode` (4.3).
- `type 'List<dynamic>' is not a subtype of type 'Map<String, dynamic>'` (atau sebaliknya) → sumber JSON anda ialah objek `{…}`, bukan array `[…]`. `GET /programmes` pada `json-server` memulangkan **array** — semak laluan anda.
- Fallback berlaku **sentiasa** walaupun WiFi elok → `.timeout` terlalu pendek (kembalikan 8 saat), atau kebenaran INTERNET tiada dalam manifest `main` (Latihan 1).
- Ragu struktur kod anda → banding dengan `projek/ett_mobile/lib/services/programme_service.dart`.

---

## 🧭 Sebelum Latihan 5 — Fail Permulaan Skrin

Model dan servis sudah sedia. Sekarang kita bina **satu skrin** yang menggunakannya, sama seperti Latihan 3 Hari 1 memulakan dari kanvas kosong.

**Cipta fail `lib/screens/lab_hari4_screen.dart`** dengan kandungan ini:

```dart
// lib/screens/lab_hari4_screen.dart  —  FAIL PERMULAAN LATIHAN 5
import 'package:flutter/material.dart';

import '../models/programme.dart';
import '../services/programme_service.dart';
import '../widgets/programme_card.dart';
import 'programme_detail_screen.dart';

class LabHari4Screen extends StatefulWidget {
  const LabHari4Screen({super.key});

  @override
  State<LabHari4Screen> createState() => _LabHari4ScreenState();
}

class _LabHari4ScreenState extends State<LabHari4Screen> {
  final _service = ProgrammeService();

  // ╔══════════════════════════════════════════════════╗
  // ║  5.1 — State (LoadState + senarai) masuk DI SINI ║
  // ╚══════════════════════════════════════════════════╝

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Lab Hari 4 — Tawaran eTT (API)')),
      // 👈 5.3 — GANTI body ini selepas _load() & LoadState sedia
      body: const Center(child: Text('Belum sedia')),
    );
  }
}
```

Untuk **uji** skrin ini semasa lab, tukar sementara `home:` dalam `lib/main.dart` kepada `const LabHari4Screen()` (atau tambah satu butang navigasi sementara daripada `HomeScreen` anda).

▶ **Jalankan** (`flutter run`, atau `R` besar jika app sudah berjalan) → `AppBar` navy bertajuk "Lab Hari 4 — Tawaran eTT (API)" dengan teks "Belum sedia" di tengah skrin. Kalau itu keluar, anda sedia untuk Latihan 5.

---

## Latihan 5 — Loading, error & retry dengan `setState()` + `LoadState`

**Objektif:** Rasa sendiri corak `LoadState` (idle/loading/loaded/error) yang menjadi kaedah rasmi kursus untuk kendalikan hasil rangkaian — satu `enum` yang lebih jelas berbanding beberapa `bool` berasingan.

### 5.1 — Tambah `LoadState` & medan state

Ganti kotak `╔ 5.1 ╗`:

```dart
enum LoadState { idle, loading, loaded, error }

class _LabHari4ScreenState extends State<LabHari4Screen> {
  final _service = ProgrammeService();

  // ── 5.1 — State ────────────────────────────────────
  LoadState _state = LoadState.idle;
  List<Programme> _programmes = [];

  // ╔══════════════════════════════════════════════════╗
  // ║  5.2 — Kaedah _load() masuk DI SINI              ║
  // ╚══════════════════════════════════════════════════╝
```

### 5.2 — Tulis `_load()` dan panggil dalam `initState()`

Ganti kotak `╔ 5.2 ╗`:

```dart
  // ── 5.2 — Kaedah _load() ───────────────────────────
  Future<void> _load() async {
    setState(() => _state = LoadState.loading);
    try {
      final data = await _service.fetchProgrammes();
      setState(() {
        _programmes = data;
        _state = LoadState.loaded;
      });
    } catch (_) {
      setState(() => _state = LoadState.error);
    }
  }

  @override
  void initState() {
    super.initState();
    _load();
  }
```

> **Kenapa `try/catch` di sini JUGA?** `ProgrammeService.fetchProgrammes()` sengaja **tidak pernah** `throw` (sentiasa fallback), jadi `catch` di sini ialah jaring keselamatan **kedua** — amalan baik: setiap lapisan yang panggil `Future` patut kendali ralatnya sendiri. (Rujuk README SESI 7, Langkah 4.)

### 5.3 — Sambungkan ke `build()` dengan `switch`

Ganti **keseluruhan** `build()` sedia ada:

```dart
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Lab Hari 4 — Tawaran eTT (API)')),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    switch (_state) {
      case LoadState.idle:
      case LoadState.loading:
        return const Center(child: CircularProgressIndicator());
      case LoadState.error:
        // 👈 5.4 — GANTI baris di bawah dengan UI ralat + Cuba Lagi
        return const Center(child: Text('Ralat'));
      case LoadState.loaded:
        // 👈 6 — GANTI baris di bawah dengan RefreshIndicator + ListView (Latihan 6)
        return Center(child: Text('${_programmes.length} program dimuat'));
    }
  }
```

Hot **restart** (`R` besar — kod `initState`/struktur `State` berubah, hot reload biasa kadang tidak cukup).

▶ **Jalankan** → anda patut nampak: spinner (`CircularProgressIndicator`) sekejap, kemudian teks `"8 program dimuat"` (atau lebih, jika API anda sudah aktif) — bukti `LoadState` bertukar `loading` → `loaded`.

### 5.4 — Lengkapkan UI ralat

Ganti kes `LoadState.error`:

```dart
      case LoadState.error:
        // ── 5.4 — UI ralat ────────────────────────────
        return Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.wifi_off, size: 48, color: Colors.grey),
              const SizedBox(height: 12),
              const Text('Gagal memuat data program.'),
              const SizedBox(height: 12),
              FilledButton(onPressed: _load, child: const Text('Cuba Lagi')),
            ],
          ),
        );
```

**Eksperimen (paksa keadaan ralat):** sementara sahaja, dalam `_load()`, tukar `catch (_) { setState(() => _state = LoadState.error); }` supaya ia **sentiasa** masuk situ — cara paling mudah, tambah `throw Exception('ujian');` sebaris **selepas** `final data = await _service.fetchProgrammes();` (sebelum `setState` kejayaan). Hot reload, sahkan skrin ralat + butang **Cuba Lagi** muncul dan boleh ditekan. **Padam** baris `throw` itu selepas diuji.

### 5.5 — Eksperimen: buang `setState()` daripada `_load()`

Seperti kaunter Hari 1, ini eksperimen yang buat konsep "melekat" untuk async. Sementara, tukar bahagian kejayaan `_load()`:

```dart
  Future<void> _load() async {
    setState(() => _state = LoadState.loading);
    try {
      final data = await _service.fetchProgrammes();
      // EKSPERIMEN — sengaja SALAH, kita kembalikan selepas ini
      _programmes = data;
      _state = LoadState.loaded;
    } catch (_) {
      setState(() => _state = LoadState.error);
    }
  }
```

Hot reload, buka semula skrin. **Perhatikan: spinner berputar selama-lamanya**, walaupun data sebenarnya sudah sampai (tambah `print('_state = $_state, ${_programmes.length} rekod');` selepas baris `_state = LoadState.loaded;` untuk buktikan — nilai berubah dalam ingatan, tetapi skrin tidak melukis semula). **Kesimpulan:** sama seperti Hari 1 — ini **bukan** isu khusus rangkaian/`Future`; `setState()` tetap wajib **selepas** `await` untuk beritahu Flutter "lukis semula", tidak kira dari mana data itu datang.

Kembalikan `setState({...})` sebenar:

```dart
      setState(() {
        _programmes = data;
        _state = LoadState.loaded;
      });
```

### 5.6 — Fail penuh selepas Latihan 5

```dart
enum LoadState { idle, loading, loaded, error }

class LabHari4Screen extends StatefulWidget {
  const LabHari4Screen({super.key});

  @override
  State<LabHari4Screen> createState() => _LabHari4ScreenState();
}

class _LabHari4ScreenState extends State<LabHari4Screen> {
  final _service = ProgrammeService();

  LoadState _state = LoadState.idle;
  List<Programme> _programmes = [];

  Future<void> _load() async {
    setState(() => _state = LoadState.loading);
    try {
      final data = await _service.fetchProgrammes();
      setState(() {
        _programmes = data;
        _state = LoadState.loaded;
      });
    } catch (_) {
      setState(() => _state = LoadState.error);
    }
  }

  @override
  void initState() {
    super.initState();
    _load();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Lab Hari 4 — Tawaran eTT (API)')),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    switch (_state) {
      case LoadState.idle:
      case LoadState.loading:
        return const Center(child: CircularProgressIndicator());
      case LoadState.error:
        return Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.wifi_off, size: 48, color: Colors.grey),
              const SizedBox(height: 12),
              const Text('Gagal memuat data program.'),
              const SizedBox(height: 12),
              FilledButton(onPressed: _load, child: const Text('Cuba Lagi')),
            ],
          ),
        );
      case LoadState.loaded:
        return Center(child: Text('${_programmes.length} program dimuat'));
    }
  }
}
```

### 🧪 Uji Latihan 5

> **Sampai ke sana:** pastikan `home:` dalam `lib/main.dart` masih `const LabHari4Screen()` → `flutter run` → anda berada pada skrin **"Lab Hari 4 — Tawaran eTT (API)"**. Setiap kali `initState()` atau struktur `State` berubah, tekan **`R`** besar (Hot **Restart**), bukan `r`.

**Bahagian A — `loading` → `loaded`:**

| # | Buat ini | Patut nampak |
|---|---|---|
| 1 | Tekan `R` dan pandang **skrin** dari saat pertama | `CircularProgressIndicator` berpusing di tengah — keadaan `loading` |
| 2 | Tunggu 1–2 saat | Teks **`8 program dimuat`** di tengah — keadaan `loaded` |

**Bahagian B — `error` + Cuba Lagi (guna `throw` eksperimen 5.4):**

| # | Buat ini | Patut nampak |
|---|---|---|
| 3 | Tambah `throw Exception('ujian');` **selepas** `final data = await _service.fetchProgrammes();`, tekan `R` | **Skrin:** ikon `wifi_off` kelabu + teks "Gagal memuat data program." + butang **Cuba Lagi** |
| 4 | Tekan **Cuba Lagi** | Spinner muncul semula sekejap, kemudian kembali ke skrin ralat (kerana `throw` masih ada) — bukti `_load()` benar-benar dipanggil semula |
| 5 | **Padam** baris `throw`, tekan `R` | `8 program dimuat` kembali |

**Bahagian C — eksperimen 5.5 (buang `setState`) — jangan langkau, inilah pengajaran hari ini:**

| # | Buat ini | Patut nampak |
|---|---|---|
| 6 | Buang `setState(…)` pada cabang kejayaan, kekalkan `_programmes = data; _state = LoadState.loaded;` telanjang, tekan `R` | **Skrin:** spinner berpusing **selama-lamanya** |
| 7 | Tambah `// ignore: avoid_print` + `print('_state = $_state, ${_programmes.length} rekod');` selepas baris itu, tekan `R`, pandang **TERMINAL** | `_state = LoadState.loaded, 8 rekod` — data **sudah** sampai; hanya skrin yang tidak dilukis semula |
| 8 | Kembalikan `setState({…})` sebenar, buang `print` + komen `ignore`, tekan `R` | `8 program dimuat` kembali di skrin |
| 9 | **Terminal:** `flutter analyze` | `No issues found!` |

Langkah 6–7 ialah bukti terus: nilai berubah dalam ingatan tetapi UI tidak — `setState()` tetap wajib **selepas** `await`, sama seperti kaunter Hari 1.

❌ **Tak jadi?**
- Skrin kekal "Belum sedia" → `build()` masih versi fail permulaan. Ganti `body:` dengan `_buildBody()` (5.3).
- Spinner kekal berpusing walaupun `setState` ada → `_load()` tidak dipanggil dalam `initState()`, atau anda hanya hot reload; tekan **`R`**.
- Papar `0 program dimuat` → `fetchProgrammes()` memulangkan senarai kosong: anda masih di peringkat 4.1/4.3 yang `return []`. Pasang `_fallback()` (4.4).
- `The instance member '_load' can't be accessed in an initializer` → anda cuba panggil `_load()` semasa deklarasi medan. Ia mesti di dalam `initState()`.
- Skrin ralat langsung tak dapat dicetuskan → ingat `fetchProgrammes()` **tidak pernah** `throw` (ia sentiasa fallback). Satu-satunya cara dalam lab ini ialah `throw` sementara di langkah 3.
- `flutter analyze` mengadu `avoid_print` → `print` eksperimen langkah 7 belum dibuang.

---

## Latihan 6 — Pull-to-refresh dengan `RefreshIndicator`

**Objektif:** Ganti teks placeholder `LoadState.loaded` dengan senarai sebenar, dibalut `RefreshIndicator` supaya pengguna boleh tarik-untuk-muat-semula.

**Langkah 1 — benarkan `_load()` berjalan TANPA spinner penuh.** Ini bahagian yang paling mudah terlepas pandang. `_load()` anda bermula dengan `setState(() => _state = LoadState.loading);`. Kalau `RefreshIndicator` memanggilnya terus, `build()` akan menukar **seluruh** body kepada spinner penuh — `RefreshIndicator` dan senarai **lenyap di tengah gerak isyarat**, dan ia nampak seperti "reload" skrin penuh, bukan pull-to-refresh langsung.

Tambah parameter pada `_load()` supaya refresh boleh melangkau spinner penuh:

```dart
  /// [tunjukSpinnerPenuh] = false semasa pull-to-refresh — biar senarai
  /// kekal di skrin; RefreshIndicator sudah ada spinner sendiri.
  Future<void> _load({bool tunjukSpinnerPenuh = true}) async {   // 👈 UBAH
    if (tunjukSpinnerPenuh) {                                    // 👈 UBAH
      setState(() => _state = LoadState.loading);
    }
    // ... baki _load() kekal sama
```

**Langkah 2 — ganti kes `LoadState.loaded`:**

```dart
      case LoadState.loaded:
        // ── 6 — RefreshIndicator + ListView ───────────
        return RefreshIndicator(
          // Jangan tunjuk spinner penuh — biar senarai kekal semasa refresh.
          onRefresh: () => _load(tunjukSpinnerPenuh: false),
          child: ListView.builder(
            padding: const EdgeInsets.only(bottom: 16),
            itemCount: _programmes.length,
            itemBuilder: (context, index) {
              final p = _programmes[index];
              return ProgrammeCard(
                programme: p,
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => ProgrammeDetailScreen(programme: p),
                  ),
                ),
              );
            },
          ),
        );
```

Hot reload.

▶ **Jalankan** → anda patut nampak: senarai **8** `ProgrammeCard` menggantikan teks `"8 program dimuat"`. Tarik senarai ke bawah dari **atas sekali** → spinner Material muncul di bawah AppBar, kemudian hilang selepas `_load()` selesai.

> **Kenapa `RefreshIndicator` mesti balut widget *scrollable* (`ListView`), bukan `Column`?** Ia mengesan gerak isyarat "tarik lepas hujung atas" yang hanya wujud pada kandungan **boleh skrol**. (Rujuk README SESI 7, Langkah 5.)

### Eksperimen: `RefreshIndicator`

| Cuba tukar | Perhatikan apa jadi | Kesimpulan |
|---|---|---|
| Ganti `ListView.builder` dengan `Column` biasa (kekalkan `RefreshIndicator`) | Tarik-ke-bawah **tidak** mencetuskan apa-apa — spinner tidak muncul langsung | `RefreshIndicator` perlu anak yang **boleh skrol** untuk mengesan gerak isyarat |
| `onRefresh: () => _load(tunjukSpinnerPenuh: false)` → `onRefresh: () async {}` (fungsi kosong) | Spinner muncul lalu hilang, tetapi data **tidak** dimuat semula | `onRefresh` mesti pulangkan `Future` kerja **sebenar**, bukan sekadar animasi |
| Tambah `print('refresh!')` di awal `_load()`, tarik 3 kali | **3** baris `refresh!` di terminal | Setiap tarikan = satu panggilan `_load()` penuh (termasuk fetch semula) |

Kembalikan `ListView.builder`, `onRefresh: () => _load(tunjukSpinnerPenuh: false)`, dan buang `print` selepas eksperimen.

### 🧪 Uji Latihan 6

> **Sampai ke sana:** `flutter run` → skrin **"Lab Hari 4 — Tawaran eTT (API)"** (masih `home: const LabHari4Screen()`) → tunggu spinner hilang, senarai kad muncul.

> ⚠️ **Perhatian sebelum menguji:** kad **1, 2 dan 3 semuanya "Universiti Al-Azhar"** — bezanya pada **bidang** (Perubatan / Syariah dan Undang-undang / Ulum Islamiah). Jangan uji dengan kad 1 vs kad 2; anda akan nampak nama sama dan tersilap sangka ada pepijat. Guna kad **1, 4 dan 7** yang jelas berbeza.

| # | Buat ini | Patut nampak |
|---|---|---|
| 1 | Kira kad, tatal sampai habis | **8** kad. Kad **ke-1**: 🇪🇬 Universiti Al-Azhar · Perubatan (Medicine) · Kaherah (Cairo). Kad **ke-8** (terakhir): 🇲🇦 Universiti Mohammed V · Bahasa Arab (Arabic Language) · Rabat |
| 2 | Tarik senarai ke bawah dari **atas sekali**, kemudian lepas | Spinner bulat Material muncul di bawah `AppBar`, berpusing, lalu hilang bila `_load()` selesai |
| 2b | **Perhati senarai semasa spinner berpusing** | Kad **kekal kelihatan** di belakang spinner. Kalau skrin bertukar kosong/spinner penuh, Langkah 1 tertinggal |
| 3 | Tambah `// ignore: avoid_print` + `print('refresh!')` di **awal** `_load()`, hot reload, tarik-ke-bawah **3** kali | **TERMINAL:** tepat **3** baris `refresh!` — setiap tarikan = satu `_load()` penuh |
| 4 | Buang `print` + komen `ignore` itu | — |
| 5 | Tekan kad **ke-4** (Universiti Alexandria · Farmasi) | `ProgrammeDetailScreen` terbuka memaparkan **Universiti Alexandria** — bukan Al-Azhar |
| 6 | Tekan `←`, tatal, tekan kad **ke-7** (Universite Al Quaraouiyine) | Butiran 🇲🇦 Maghribi, bandar **Fes** |
| 7 | *(pilihan)* Tekan `←`, tekan kad **ke-2** | Nama universiti **sama** dengan kad 1 (Al-Azhar) tetapi **bidang berbeza** (Syariah dan Undang-undang) — ini betul, bukan pepijat |
| 8 | **Terminal:** `flutter analyze` | `No issues found!` |

❌ **Tak jadi?**
- Tarik-ke-bawah tidak mencetuskan apa-apa → `RefreshIndicator` membalut widget yang **tidak boleh skrol** (cth. `Column`). Anaknya mesti `ListView.builder`.
- Spinner muncul lalu hilang tetapi data tidak dimuat semula → `onRefresh:` menunjuk fungsi kosong; ia mesti memanggil `_load(...)` sebenar.
- Seluruh skrin bertukar spinner penuh & senarai **lenyap** semasa menarik → anda guna `onRefresh: _load` terus. Ia mesti `onRefresh: () => _load(tunjukSpinnerPenuh: false)` (Langkah 1).
- Menekan kad tidak membuka apa-apa → `onTap:` pada `ProgrammeCard` tertinggal, atau `import 'programme_detail_screen.dart';` belum ada di atas fail.
- Kad ke-4 & ke-7 pun papar **Al-Azhar** → anda hantar `_programmes.first`/`_programmes[0]`, sepatutnya `p` (item gelung `itemBuilder`).
- Senarai kekal `"8 program dimuat"` sebagai teks → cabang `LoadState.loaded` belum diganti dengan `RefreshIndicator` + `ListView.builder`.
- `flutter analyze` mengadu `avoid_print` → `print('refresh!')` langkah 3 belum dibuang.

---

## Latihan 7 — Hantar permohonan dengan `POST`

**Objektif:** Lengkapkan arah **kedua** komunikasi rangkaian — bukan hanya *ambil* data (GET), tetapi *hantar* data (POST), menggunakan `Application.toJson()` yang sudah wujud sejak Hari 3.

### 7.1 — Rangka `submitApplication` (belum berfungsi)

Dalam `lib/services/programme_service.dart`, tambah import dan rangka method baharu selepas `_fallback()`:

```dart
import '../models/application.dart';
import '../models/programme.dart';

class ProgrammeService {
  // ... (fetchProgrammes, _fallback sedia ada, jangan ubah)

  static const String _baseUrl = '<host json-server/mocki.io anda>';

  // ── 7.1 — Rangka submitApplication (belum berfungsi) ──
  Future<bool> submitApplication(Application application) async {
    // 👈 7.2 — TAMBAH panggilan http.post DI SINI
    return false;
  }

  void dispose() => _client.close();
}
```

> `_baseUrl` **berasingan** daripada `_endpoint` (Latihan 4) kerana `POST` dan `GET` boleh guna laluan berbeza. Untuk `json-server` (Latihan 2B), `_baseUrl` ialah `http://10.0.2.2:3001` (emulator) tanpa `/programmes` di hujung — laluan penuh disambung di 7.2.

### 7.2 — Isi dengan `http.post` sebenar

```dart
  Future<bool> submitApplication(Application application) async {
    // ── 7.2 — http.post sebenar ──────────────────────
    try {
      final response = await _client
          .post(
            Uri.parse('$_baseUrl/applications'),
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode(application.toJson()),
          )
          .timeout(const Duration(seconds: 8));
      return response.statusCode == 200 || response.statusCode == 201;
    } catch (_) {
      return false;
    }
  }
```

Tiga perkara penting: `Content-Type: application/json` beritahu pelayan format `body`; `jsonEncode(application.toJson())` tukar `Map` → `String` JSON; dan kita terima **kedua-dua** `200` & `201` (`json-server` — dan kebanyakan API sebenar — pulangkan `201 Created` bagi rekod **baharu**; sesetengah API pulangkan `200` sahaja, jadi kita terima kedua-duanya). (Rujuk README SESI 7, Langkah 2–3.)

### 7.3 — Sambungkan ke UI: butang hantar contoh + `SnackBar`

Kembali ke `lib/screens/lab_hari4_screen.dart`. Tambah kaedah baharu dan kemas kini `AppBar`:

```dart
  // ── 7.3 — Hantar contoh permohonan ────────────────────
  Future<void> _hantarContohPermohonan() async {
    final contoh = Application(
      id: 'LAB-${DateTime.now().millisecondsSinceEpoch}',
      fullName: 'Pelajar Contoh',
      icNumber: '000000-00-0000',
      email: 'pelajar@example.com',
      phoneNumber: '0123456789',
      academicCategory: EntryCategory.spm,
      academicSummary: 'SPM 2025 — 8A',
      country: 'Egypt',
      fieldOfStudy: 'Perubatan (Medicine)',
      universityChoiceIds: const ['ETT-001'],
    );
    final berjaya = await _service.submitApplication(contoh);
    if (!mounted) return; // 👈 WAJIB — lihat penjelasan di bawah
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          berjaya
              ? 'Permohonan contoh berjaya dihantar'
              : 'Gagal hantar permohonan contoh',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lab Hari 4 — Tawaran eTT (API)'),
        actions: [
          IconButton(
            onPressed: _hantarContohPermohonan,
            icon: const Icon(Icons.send),
          ),
        ],
      ),
      body: _buildBody(),
    );
  }
```

▶ **Jalankan** (hot restart) → anda patut nampak: ikon **✈ (hantar)** kini muncul di kanan `AppBar`. Tekan sekali → `SnackBar` naik dari bawah skrin dengan mesej berjaya/gagal.

> **Kenapa `if (!mounted) return;` wajib?** Pengguna boleh tinggalkan skrin **semasa** `await` berjalan; guna `context` yang sudah "mati" selepas itu melontar ralat runtime. Corak ini wajib **setiap kali** `context` diguna selepas `await` dalam `StatefulWidget`. (Rujuk README SESI 7, Langkah 4.)

### 7.4 — Fail penuh akhir lab

```dart
import 'package:flutter/material.dart';

import '../models/application.dart';
import '../models/programme.dart';
import '../services/programme_service.dart';
import '../widgets/programme_card.dart';
import 'programme_detail_screen.dart';

enum LoadState { idle, loading, loaded, error }

class LabHari4Screen extends StatefulWidget {
  const LabHari4Screen({super.key});

  @override
  State<LabHari4Screen> createState() => _LabHari4ScreenState();
}

class _LabHari4ScreenState extends State<LabHari4Screen> {
  final _service = ProgrammeService();

  LoadState _state = LoadState.idle;
  List<Programme> _programmes = [];

  /// [tunjukSpinnerPenuh] = false semasa pull-to-refresh.
  ///
  /// PENTING: kalau kita set `LoadState.loading` semasa tarik-untuk-muat-semula,
  /// `build()` akan ganti seluruh body dengan spinner penuh — `RefreshIndicator`
  /// dan senarai LENYAP di tengah gerak isyarat, jadi ia nampak seperti skrin
  /// "reload" penuh, bukan pull-to-refresh. Semasa refresh, biarkan senarai
  /// kekal; `RefreshIndicator` sudah pun memaparkan spinnernya sendiri.
  Future<void> _load({bool tunjukSpinnerPenuh = true}) async {
    if (tunjukSpinnerPenuh) setState(() => _state = LoadState.loading);
    try {
      final data = await _service.fetchProgrammes();
      setState(() {
        _programmes = data;
        _state = LoadState.loaded;
      });
    } catch (_) {
      setState(() => _state = LoadState.error);
    }
  }

  Future<void> _hantarContohPermohonan() async {
    final contoh = Application(
      id: 'LAB-${DateTime.now().millisecondsSinceEpoch}',
      fullName: 'Pelajar Contoh',
      icNumber: '000000-00-0000',
      email: 'pelajar@example.com',
      phoneNumber: '0123456789',
      academicCategory: EntryCategory.spm,
      academicSummary: 'SPM 2025 — 8A',
      country: 'Egypt',
      fieldOfStudy: 'Perubatan (Medicine)',
      universityChoiceIds: const ['ETT-001'],
    );
    final berjaya = await _service.submitApplication(contoh);
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          berjaya
              ? 'Permohonan contoh berjaya dihantar'
              : 'Gagal hantar permohonan contoh',
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _load();
  }

  @override
  void dispose() {
    _service.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lab Hari 4 — Tawaran eTT (API)'),
        actions: [
          IconButton(
            onPressed: _hantarContohPermohonan,
            icon: const Icon(Icons.send),
          ),
        ],
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    switch (_state) {
      case LoadState.idle:
      case LoadState.loading:
        return const Center(child: CircularProgressIndicator());
      case LoadState.error:
        return Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.wifi_off, size: 48, color: Colors.grey),
              const SizedBox(height: 12),
              const Text('Gagal memuat data program.'),
              const SizedBox(height: 12),
              FilledButton(onPressed: _load, child: const Text('Cuba Lagi')),
            ],
          ),
        );
      case LoadState.loaded:
        return RefreshIndicator(
          // Jangan tunjuk spinner penuh — biar senarai kekal semasa refresh.
          onRefresh: () => _load(tunjukSpinnerPenuh: false),
          child: ListView.builder(
            padding: const EdgeInsets.only(bottom: 16),
            itemCount: _programmes.length,
            itemBuilder: (context, index) {
              final p = _programmes[index];
              return ProgrammeCard(
                programme: p,
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => ProgrammeDetailScreen(programme: p),
                  ),
                ),
              );
            },
          ),
        );
    }
  }
}
```

### 🧪 Uji Latihan 7

> **Sampai ke sana:** `flutter run` → skrin **"Lab Hari 4 — Tawaran eTT (API)"** → ikon **✈** (`Icons.send`) di **hujung kanan `AppBar`**. Kerana `_baseUrl` ialah `static const`, tekan **`R`** besar setiap kali anda mengubahnya.

> ⚠️ **Ujian ini perlukan pelayan yang menerima `POST`** — iaitu `json-server` (Latihan 2B). Raw URL GitHub (2A) hanya melayan `GET`, jadi dengannya anda hanya boleh sahkan Bahagian B (laluan gagal).

**Bahagian A — hantar berjaya (`json-server` aktif):**

| # | Buat ini | Patut nampak |
|---|---|---|
| 1 | Set `_baseUrl` = `http://10.0.2.2:3001` (emulator) atau `http://<IP-komputer>:3001` (peranti fizikal) — **tanpa** `/applications` di hujung. Tekan `R` | Skrin senarai seperti biasa |
| 2 | Tekan ikon **✈** | **Skrin:** `SnackBar` naik dari bawah — **"Permohonan contoh berjaya dihantar"** |
| 3 | Pandang **terminal `json-server`** | Satu baris log `POST /applications` dengan kod status `201` (Created). Kod anda menerima `200` **dan** `201`, jadi kedua-duanya sah |
| 4 | Buka `http://localhost:3001/applications` dalam **pelayar komputer** | Satu rekod baharu: `"id": "LAB-…"`, `"fullName": "Pelajar Contoh"`, `"country": "Egypt"`, `"fieldOfStudy": "Perubatan (Medicine)"` |
| 5 | Tekan **✈** sekali lagi, muat semula pelayar | **Dua** rekod — setiap tekan = satu `POST` penuh |

**Bahagian B — hantar gagal (bukti `catch` → `false`, bukan crash):**

| # | Buat ini | Patut nampak |
|---|---|---|
| 6 | Tukar `_baseUrl` → `'https://example.invalid'`, tekan `R`, tekan **✈** | `SnackBar`: **"Gagal hantar permohonan contoh"**. **Tiada** skrin merah — `catch (_) { return false; }` yang menyelamatkan |
| 7 | Hentikan `json-server` (Ctrl-C), kembalikan `_baseUrl` sebenar, tekan `R`, tekan **✈** | Sekali lagi "Gagal hantar…" selepas seketika — pelayan mati dikendalikan sama seperti URL rosak |
| 8 | Hidupkan semula `json-server`, tekan `R`, tekan **✈** | Kembali "Permohonan contoh berjaya dihantar" |
| 9 | **Terminal:** `flutter analyze` | `No issues found!` |

❌ **Tak jadi?**
- **Sentiasa** "Gagal hantar" walaupun `json-server` hidup dan `GET` berfungsi → laluan `/applications` tidak wujud dalam fail db anda. `json-server` hanya mencipta laluan daripada **kunci aras atas** dalam fail; tambah `"applications": []` ke dalam objek db, kemudian mula semula `json-server`. (Rujuk ❌ pada 🧪 Uji Latihan 2.)
- Gagal di **emulator** → `_baseUrl` masih `localhost`. Guna `http://10.0.2.2:3001`.
- Gagal pada **peranti fizikal** → telefon & komputer mesti pada WiFi yang sama; guna IP komputer (`ipconfig getifaddr en0` pada Mac, `ipconfig` pada Windows).
- Gagal sepenuhnya dengan raw URL GitHub → memang tidak boleh; GitHub raw hanya melayan `GET`. Guna `json-server` untuk latihan ini.
- Anda tukar `_baseUrl` tetapi hasil tidak berubah → `static const`; tekan **`R`** besar, bukan `r`.
- `SnackBar` langsung tidak muncul → `IconButton` belum ditambah ke `actions:` `AppBar` (7.3), atau `onPressed:` tidak menunjuk `_hantarContohPermohonan`.
- Ralat *"setState() called after dispose()"* atau `context` tidak sah selepas tekan ✈ → `if (!mounted) return;` tertinggal selepas `await`.
- `Undefined name 'jsonEncode'` dalam `programme_service.dart` → `import 'dart:convert';` (ditambah pada 4.2) tertinggal.
- Rekod POST muncul tetapi hilang selepas `json-server` dimulakan semula → normal jika anda menyunting fail db secara manual; `json-server` menulis terus ke fail itu.

Kalau anda minta AI bantu gabungkan kepingan `try/catch` + `statusCode` + `jsonEncode` di atas dengan pantas, ini prompt yang munasabah:

```text
Tulis method submitApplication(Application application) dalam kelas
ProgrammeService (Dart, pakej http). Ia perlu: POST ke '$_baseUrl/applications'
dengan header Content-Type application/json, body jsonEncode(application.toJson()),
timeout 8 saat, pulangkan true jika statusCode 200 ATAU 201, false untuk kod lain
ATAU sebarang exception (jangan throw ke pemanggil).
```

Semak: adakah ia bungkus keseluruhan dalam `try/catch` (bukan hanya bahagian `http.post`), dan adakah ia lupa `.timeout(...)` — draf AI ringkas kadang terlepas ini kerana ia tidak "kelihatan penting" berbanding `try/catch`.

---

## Ringkasan Kod & Troubleshooting

| Simptom | Punca biasa | Betulkan |
|---|---|---|
| Skrin merah `SocketException` semasa `fetchProgrammes()` | Tiada `try/catch` (masih peringkat 4.1/4.2), atau tiada internet | Pastikan kod sepadan 4.3–4.5; semak WiFi/data telefon |
| `Connection refused` pada `http://localhost:3001/...` di **emulator** | `localhost` di dalam emulator merujuk emulator itu sendiri, bukan komputer | Guna `http://10.0.2.2:3001/...` (rujuk Latihan 2B) |
| Data **tidak pernah** bertukar daripada `sampleProgrammes` walaupun API aktif | `_endpoint` masih placeholder/salah, atau lupa **hot restart** (`R`) selepas tukar `static const` | Semak URL, tekan `R` besar (bukan `r` kecil) di terminal |
| `FormatException: Unexpected character` semasa `jsonDecode` | `response.body` bukan JSON sah (cth. halaman HTML ralat 404/500) | Semak `statusCode == 200` **sebelum** `jsonDecode` (rujuk 4.3) |
| `type 'List<dynamic>' is not a subtype of type 'Map<String, dynamic>'` | `jsonDecode(response.body)` pulangkan `List` (senarai rekod) tetapi kod cuba layan seperti `Map` (satu rekod) terus — atau sebaliknya | Semak struktur JSON sumber: array `[...]` → `List<dynamic>`, objek `{...}` → `Map<String, dynamic>`; `.map()` diperlukan untuk senarai |
| Spinner berputar selama-lamanya, tiada ralat/data muncul | `setState()` tertinggal selepas `await` berjaya (rujuk eksperimen 5.5) | Pastikan **kedua-dua** cabang kejayaan & ralat guna `setState()` |
| Ralat *"setState() called after dispose()"* atau `context` tidak sah selepas tekan butang | Guna `context`/`setState` selepas `await`, tanpa semak `mounted`, dan pengguna sudah tinggalkan skrin | Tambah `if (!mounted) return;` sebelum guna `context` selepas `await` (rujuk 7.3) |
| Aplikasi jalan di emulator tetapi APK release gagal akses rangkaian | Kebenaran INTERNET hanya ada di `debug`/`profile` manifest, bukan `main` | Tambah `<uses-permission android:name="android.permission.INTERNET"/>` ke `android/app/src/main/AndroidManifest.xml` (Latihan 1) |

---

## Senarai Semak Akhir

Sebelum tamat lab, pastikan:

- [ ] `flutter pub deps` menyenaraikan `http`, dan kebenaran INTERNET ada dalam manifest utama (Latihan 1).
- [ ] `_endpoint` menghala ke URL JSON sebenar yang boleh dicapai (Latihan 2), disahkan dengan `curl`/pelayar.
- [ ] `Programme.fromJson` betul urai semua medan, termasuk penukaran nombor selamat (`as num).toDouble()`) dan enum (`fromString`) (Latihan 3).
- [ ] `ProgrammeService.fetchProgrammes()` kendali kes 200/bukan-200/timeout/ralat rangkaian — kesemuanya jatuh ke fallback dengan selamat (Latihan 4).
- [ ] `LabHari4Screen` papar ketiga-tiga keadaan (`loading`/`error`/`loaded`) di skrin, dan eksperimen 5.5 (buang `setState`) menghasilkan spinner tersekat — pulih semula selepas `setState` dikembalikan (Latihan 5).
- [ ] Tarik-untuk-muat-semula berfungsi pada senarai (Latihan 6).
- [ ] Menekan ikon hantar memanggil `submitApplication` dan papar `SnackBar` mengikut hasil, dengan semakan `mounted` sebelum guna `context` (Latihan 7).
- [ ] `flutter analyze` tiada ralat merentasi seluruh projek.

---

## Cabaran

Pilih **sekurang-kurangnya satu**:

### Cabaran A — Cap masa "Dikemaskini pada..."

1. Tambah medan `DateTime? _lastUpdated;` pada `_LabHari4ScreenState`.
2. Dalam `_load()`, tetapkan `_lastUpdated = DateTime.now();` selepas `_state = LoadState.loaded;`.
3. Papar teks kecil di atas senarai. Kalau anda mahu guna `intl` (`DateFormat`), tambah pakej itu dahulu — Hari 4 hanya memasang `http`:
   ```bash
   flutter pub add intl
   ```
   kemudian `import 'package:intl/intl.dart';` dan guna `DateFormat('h:mm a').format(_lastUpdated!)`. (Tanpa `intl` pun boleh: `'${_lastUpdated!.hour}:${_lastUpdated!.minute.toString().padLeft(2, '0')}'`.) Contoh hasil: `"Dikemaskini: 4:32 PM"`. (Petunjuk: bungkus `RefreshIndicator` dalam `Column` dengan teks itu di atas, `Expanded` sekeliling `ListView.builder`.)

### Cabaran B — Label sumber data

Bezakan secara visual (cth. cip kecil "Dari Pelayan" vs "Data Tempatan") sama ada senarai yang dipaparkan datang daripada API sebenar atau daripada `_fallback()`. Petunjuk: `fetchProgrammes()` perlu pulangkan maklumat tambahan (cth. rekod `({List<Programme> data, bool fromApi})`) selain senarai sahaja — ini akan mengubah tandatangan method, jadi kemas kini semua tempat yang memanggilnya.

### Cabaran C — Kod status khusus pada borang

Kendalikan kod status `400` secara berasingan daripada `500`/timeout dalam `_hantarContohPermohonan()` — papar mesej berbeza ("Sila semak data anda" vs "Pelayan tidak dapat dihubungi, cuba sebentar lagi"). Anda perlu ubah `submitApplication` supaya pulangkan `int` (kod status) atau rekod, bukan sekadar `bool`.

### Cabaran D — Sambungkan `ApplicationFormScreen` sebenar

Gantikan `_hantarContohPermohonan()` (data hardcoded) dengan panggilan sebenar daripada borang `ApplicationFormScreen` Hari 3 — selepas `_submit()` disahkan (`validator` lulus), panggil `submitApplication(application)` sebelum/selepas `Navigator.pop(application)`.

---

## Rujukan Fail

| Fail lab anda | Fail rujukan (projek sebenar) |
|------|---------|
| Fail permulaan (Persediaan) | [`starter/`](./starter/) — tema, model, data & widget siap salin ([README](./starter/README.md)) |
| `lib/models/programme.dart` (Latihan 3) | `projek/ett_mobile/lib/models/programme.dart` |
| `lib/services/programme_service.dart` (Latihan 4 & 7) | `projek/ett_mobile/lib/services/programme_service.dart` |
| `lib/screens/lab_hari4_screen.dart` (Latihan 5–7) | `projek/ett_mobile/lib/screens/programme_list_screen.dart` (versi `provider` — struktur `switch (state)` **sama persis**) |
| `lib/models/application.dart` (`toJson`, Latihan 7) | `projek/ett_mobile/lib/models/application.dart` |
| Data sumber JSON | `projek/mock-api/programmes.json` |
| Contoh pendekatan alternatif `FutureBuilder` | [`futurebuilder_example.dart`](./futurebuilder_example.dart) |

> Lihat juga bahagian **"Pendekatan alternatif: `FutureBuilder`"** dalam `README.md` (SESI 7, Langkah 4) untuk cara lain memaparkan hasil satu `Future` tanpa `enum LoadState` — sesuai untuk skrin yang hanya fetch **sekali**, tanpa carian/tapisan/refresh di atasnya.
