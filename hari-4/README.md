# Hari 4 — REST API, Async & Pengendalian Ralat

> **SESI 6 & 7** (JADUAL rasmi, 23 Julai 2026): *Konsep REST API & Sambungan Backend* (9.00 pagi–1.00 petang), diikuti *Model Data & Pengendalian Ralat (Error Handling)* (2.30–5.00 petang).

Panduan langkah demi langkah untuk menyambungkan **eTT Mobile** kepada data **sebenar** menerusi rangkaian. Pada akhir hari ini (~6.5 jam kelas), senarai tawaran pengajian yang selama ini **hardcoded** (`sampleProgrammes`) akan digantikan dengan data yang **diambil (fetch) daripada REST API** dalam format JSON — lengkap dengan penunjuk memuat (loading), pengendalian ralat (error handling), butang cuba lagi (retry), dan **tarik-untuk-muat-semula** (pull-to-refresh).

**Imbas kembali Hari 1–3:**

- **Hari 1 (SESI 1):** asas Dart — operators, control flow, looping, function; widget asas `Text`/`Icon`/`Image`; `Container`/`Padding`/`Margin`/`SizedBox`; perbezaan `StatelessWidget` vs `StatefulWidget`.
- **Hari 2 (SESI 2–3):** seni bina layout — `Row`/`Column`/`Expanded`/`Flexible`, `Stack`/`Positioned`/`Align`, `Scaffold`/`AppBar`; menjana mockup layout dengan bantuan AI; navigasi `BottomNavigationBar`/`Drawer`; senarai dinamik `ListView.builder`/`GridView`; `Card`/`ListTile`; kemasan `TextStyle`/`ThemeData`.
- **Hari 3 (SESI 4–5):** `Navigator.push`/`pop`, named routes & navigation stack, hantar data antara skrin; `TextField`/`TextFormField`; Input Controller; `Button`/`GestureDetector`; logik **form validation** (borang permohonan eTT) ditulis dengan bantuan AI; pengurusan state asas dengan **`setState()`** & kitaran hayat `StatefulWidget`.

Setakat Hari 3, `ProgrammeListScreen` memaparkan `sampleProgrammes` — satu senarai `const` yang ditulis tangan dalam `lib/data/sample_programmes.dart`. Dalam sistem sebenar **e-Timur Tengah (eTT)**, senarai tawaran pengajian ini perlu datang daripada **pelayan pusat KPT** — supaya Bahagian Pengantarabangsaan Pendidikan Tinggi (BPPT) boleh kemas kini senarai universiti Mesir/Maghribi, syarat kelayakan, dan tarikh pengambilan tanpa perlu keluarkan versi aplikasi baharu. Hari ini kita selesaikan bahagian itu.

**Apa yang akan dibina:**

- Kefahaman **REST API**: beza *backend* & *frontend*, kaedah HTTP, dan format JSON
- Pemasangan pakej **`http`** & kebenaran (permission) internet Android
- Konsep **async/await** & `Future` di Dart — kenapa UI tidak boleh disekat (blocked)
- Permintaan **HTTP GET** untuk **fetch** senarai `Programme` (tawaran universiti Mesir/Maghribi)
- Menukar respons JSON kepada Dart model class dengan bantuan AI — dan cara mengesahkannya
- Permintaan **HTTP POST** untuk **submit** permohonan pelajar (`Application`)
- Pengendalian **kod status HTTP** (200/201/400/401/404/500)
- **Pengendalian ralat**: `try-catch`, `CircularProgressIndicator`, skrin ralat + retry
- **Pull-to-refresh** dengan `RefreshIndicator`
- Menghos fail JSON mock anda sendiri supaya kelas boleh "sambung ke API sebenar"

> **Nota:** Sesi rasmi hari ini fokus pada REST API, async/await, dan pengendalian ralat — `flutter build apk` bukan sebahagian sesi ini (Hari 5 ialah projek mini + refactoring + demo). Pengurusan state kekal `setState()` (SESI 5); bila kod projek sebenar (`ett_mobile`) menggunakan `provider`/`shared_preferences` untuk berkongsi state merentasi skrin, ia ditandakan sebagai rujukan lanjutan.

---

> 📱 **Demo interaktif dalam aplikasi.** Konsep hari ini ada demo yang boleh anda **jalankan & main-main** pada telefon/emulator — ubah kawalan, lihat kesannya serta-merta:
>
> async/await · Fetch JSON dari API · LoadState · Pengendalian Ralat (try/catch)
>
> Jalankan galeri demo: `cd projek/ett_mobile && flutter run -t lib/demos_main.dart` → pilih **Hari 4**. Kod: [`projek/ett_mobile/lib/demos/hari4/`](../projek/ett_mobile/lib/demos/hari4/).

## Fokus Hari Ini

| Topik | Rujukan Rasmi |
|-------|---------------|
| Pakej `http` | https://pub.dev/packages/http |
| Async & await di Dart | https://dart.dev/language/async |
| Kelas `Future` | https://api.dart.dev/stable/dart-async/Future-class.html |
| Fetch data (cookbook) | https://docs.flutter.dev/cookbook/networking/fetch-data |
| Serialisasi JSON | https://docs.flutter.dev/data-and-backend/serialization/json |
| Send data / Networking (cookbook) | https://docs.flutter.dev/cookbook/networking/send-data |
| Widget `CircularProgressIndicator` | https://api.flutter.dev/flutter/material/CircularProgressIndicator-class.html |
| Widget `RefreshIndicator` | https://api.flutter.dev/flutter/material/RefreshIndicator-class.html |

> **Nota:** Sentiasa rujuk dokumentasi rasmi di atas dahulu sebelum cuba menyelesaikan ralat dengan cuba-jaya (trial-and-error) — 90% jawapan sudah ada di situ.

### Susunan Sesi Hari Ini

| Masa | Sesi | Fokus |
|------|------|-------|
| 8.30 – 9.00 pagi | — | Pendaftaran & minum pagi |
| **9.00 pagi – 1.00 petang** | **SESI 6 — Konsep REST API & Sambungan Backend** | Backend vs Frontend · HTTP methods & JSON · pasang `http` · Async/Future/await · praktikal fetch data |
| 1.00 – 2.30 petang | — | Rehat & makan tengah hari |
| **2.30 – 5.00 petang** | **SESI 7 — Model Data & Pengendalian Ralat** | JSON→Dart model (dibantu AI) · submit data (POST) · HTTP response & status code · try-catch, `CircularProgressIndicator` & mesej ralat |
| 5.00 petang | — | Bersurai |

---

## Apa Akan Dibina

| Sebelum (Hari 1–3) | Selepas (Hari 4) |
|---------------------|-------------------|
| Senarai `sampleProgrammes` yang `const`, sentiasa sama | Senarai diambil (fetch) daripada API JSON secara langsung |
| Skrin terus papar data — tiada "loading" | `CircularProgressIndicator` semasa data sedang diambil |
| Tiada pengendalian ralat rangkaian | Skrin ralat dengan ikon + butang **Cuba Lagi** |
| Borang permohonan hanya simpan dalam memori | Borang boleh **hantar (POST)** ke pelayan mock |
| Data hanya berubah bila kod ditukar & di-*rebuild* | **Tarik ke bawah** (pull-to-refresh) untuk muat semula bila-bila masa |
| Tiada keperluan internet | Jika offline / pelayan gagal, aplikasi **fallback** secara senyap ke data tempatan supaya kelas tidak terhenti |

---

## Persediaan

Pastikan projek `ett_mobile` dari Hari 1–3 anda masih berjalan:

```bash
cd projek/ett_mobile
flutter pub get
flutter run
```

Sahkan dahulu aplikasi masih memaparkan 8 tawaran pengajian hardcoded (Universiti Al-Azhar, Universiti Alexandria, dan lain-lain) sebelum kita mula ubah sumber datanya.

> **Nota:** Kod penuh versi "siap" Hari 4 sudah ada di `projek/ett_mobile/lib/` — anda boleh rujuk fail sebenar bila-bila masa: `services/programme_service.dart`, `models/programme.dart`, `models/application.dart`, dan `screens/programme_list_screen.dart`. Panduan ini menerangkan **kenapa** kod itu ditulis sedemikian, langkah demi langkah.

---

# SESI 6 — Konsep REST API & Sambungan Backend

## Langkah 1: Backend vs Frontend — Kenapa Data Tidak Boleh Hardcode

### Dua bahagian sistem

| | **Frontend** (apa yang kita bina) | **Backend** (di luar skop kursus ini) |
|---|---|---|
| Contoh | Aplikasi Flutter `ett_mobile` di telefon pelajar | Pelayan KPT yang menyimpan senarai tawaran eTT & permohonan |
| Peranan | Papar UI, terima input pengguna, **minta** & **hantar** data | Simpan data secara pusat, proses logik perniagaan, **balas** permintaan |
| Siapa kawal | Setiap peranti pengguna (banyak salinan aplikasi terpasang) | Satu (atau sekumpulan kecil) pelayan yang dikawal KPT |

Bayangkan sistem **e-Timur Tengah** sebenar: apabila BPPT menambah tawaran baharu (contohnya bidang baharu di Universiti Tanta) atau menukar kuota tempat sesuatu program, mereka **tidak** boleh memaksa berjuta-juta pengguna memuat turun kemas kini aplikasi serta-merta. Sebaliknya:

```
Backend (pelayan KPT)                    Frontend (app di telefon pelajar)
   │  simpan & urus data tawaran eTT         │
   │  sedia ENDPOINT (alamat URL)             │
   │                                          │
   │  ◄──────── permintaan (request) ──────── │   "Bagi saya senarai tawaran pengajian"
   │                                          │
   │  ──────── respons (response) ──────────► │   balas dengan data JSON
   │                                          │  papar dalam UI
```

Ini **corak REST API** (*Representational State Transfer*) — frontend menghantar **permintaan HTTP** ke satu **endpoint** (URL), backend membalas dengan data (biasanya format **JSON**). Frontend **tidak pernah** perlu tahu bagaimana data itu disimpan (pangkalan data, fail, dll.) — ia hanya tahu cara **minta** dan cara **hurai** jawapan.

> Dalam kursus ini, kita **tidak** akan membina backend sebenar (itu di luar skop 5 hari). Sebaliknya kita guna satu fail JSON mock (`projek/mock-api/programmes.json`) yang dihos secara ringkas — cukup untuk simulasikan tingkah laku sebenar REST API (Langkah 7).

> **📎 Ringkasan setakat ini:** Frontend (app Flutter) **minta**, backend **balas** — frontend tidak pernah perlu tahu bagaimana data disimpan di sisi pelayan. Ini corak **REST API**. Seterusnya kita lihat *bahasa* yang digunakan untuk minta/balas: kaedah HTTP dan format JSON.

## Langkah 2: HTTP Methods & JSON

### Empat kaedah HTTP utama

| Kaedah | Makna | Dalam eTT Mobile |
|--------|-------|---------------------|
| **GET** | Ambil (baca) data, tiada kesan sampingan | `GET /programmes` — dapatkan senarai tawaran pengajian Mesir/Maghribi |
| **POST** | Cipta rekod **baharu** | `POST /applications` — hantar permohonan pelajar baharu |
| **PUT** | Kemas kini rekod **sedia ada** (ganti sepenuhnya) | `PUT /applications/{id}` — tukar status permohonan (cth. `submitted` → `eligible`) |
| **DELETE** | Padam rekod | `DELETE /applications/{id}` — batalkan draf permohonan |

> Kelas ini fokus pada **GET** (Langkah 5, SESI 6) dan **POST** (Langkah 5, SESI 7) — `PUT`/`DELETE` diperkenalkan konsepnya di sini supaya anda kenal keempat-empat kaedah, tetapi tidak semestinya dilaksanakan penuh dalam projek mini Hari 5.

### JSON — format pertukaran data

Setiap permintaan/respons membawa data dalam format **JSON** (*JavaScript Object Notation*) — teks berstruktur yang mudah dibaca manusia **dan** mesin:

```json
{
  "id": "ETT-001",
  "universityName": "Universiti Al-Azhar",
  "country": "Egypt",
  "city": "Kaherah (Cairo)",
  "fieldOfStudy": "Perubatan (Medicine)",
  "studyLevel": "bachelor",
  "category": "spm",
  "estimatedAnnualCostMyr": 23000.0,
  "intakeMonth": "September",
  "recognitionNote": "Semak pengiktirafan di www2.mqa.gov.my/esisraf (eSisraf, MQA); perubatan tertakluk syarat Majlis Perubatan Malaysia (MMC). Kos anggaran ilustrasi.",
  "quotaSeats": 40
}
```

Perkara penting: JSON hanya mempunyai jenis **teks** (`"..."`), **nombor**, **boolean** (`true`/`false`), **senarai** (`[...]`), **objek** (`{...}`), dan `null`. Ia **tiada** konsep `enum` atau `DateTime` — kedua-duanya dihantar sebagai `String` biasa (lihat Langkah 4).

### Bentuk respons: satu objek lawan senarai objek

Perhatikan **kurungan luar** rekod JSON di atas — ia `{...}`, satu **objek**. Tetapi bila API pulangkan **senarai** tawaran (yang kita perlukan untuk `fetchProgrammes()`), bentuknya berbeza — kurungan luar `[...]`, **senarai objek**:

```json
[
  { "id": "ETT-001", "universityName": "Universiti Al-Azhar", "...": "..." },
  { "id": "ETT-002", "universityName": "Universiti Al-Azhar", "...": "..." }
]
```

Beza ini **penting** kerana ia menentukan jenis Dart yang terhasil daripada `jsonDecode`: `{...}` → `Map<String, dynamic>` (satu rekod), `[...]` → `List<dynamic>` (banyak rekod, masing-masing biasanya `Map`). Kod yang menganggap salah satu bentuk padahal API pulangkan bentuk lain akan gagal dengan ralat jenis (`TypeError`) semasa `jsonDecode` cuba dihantar ke kod pemprosesan — lihat jadual kesilapan biasa di Langkah 5.

### ❌ Kesilapan biasa — HTTP & JSON

| ❌ Yang selalu ditulis | Kenapa ia masalah | ✅ Betulkan |
|---|---|---|
| Anggap semua respons API sentiasa `Map<String, dynamic>` | Senarai (`GET /programmes`) pulangkan `List<dynamic>`, bukan `Map` — kod cuba `response['id']` terus akan gagal | Semak kurungan luar JSON (`[` = senarai, `{` = objek) sebelum tulis kod penghuraian |
| Guna `PUT`/`DELETE` untuk "kemas kini sikit" tanpa fikir kaedah yang betul | `PUT` konvensyennya **ganti sepenuhnya** rekod, bukan kemas kini sebahagian (itu peranan `PATCH`, di luar skop hari ini) | Untuk kelas ini, cukup kenal konsep `PUT`/`DELETE` — fokus praktikal kekal `GET`/`POST` |
| Hardcode URL API terus dalam pelbagai fail/widget | Sukar tukar bila URL berubah (cth. tukar daripada mock ke pelayan sebenar) | Simpan dalam **satu** pemalar (`_endpoint`) di lapisan servis (Langkah 5) |

## Langkah 3: Pakej `http`

### Pasang pakej

```bash
flutter pub add http
```

Ini menambah baris berikut secara automatik ke `pubspec.yaml` (sahkan ia sudah ada di projek kelas):

```yaml
dependencies:
  # REST API / HTTP (SESI 6 & 7)
  http: ^1.2.2
```

### Permintaan GET paling asas

```dart
import 'package:http/http.dart' as http;

Future<void> contohGet() async {
  final response = await http.get(Uri.parse('https://example.com/data.json'));

  if (response.statusCode == 200) {
    print('Berjaya! Badan respons: ${response.body}');
  } else {
    print('Gagal dengan kod status: ${response.statusCode}');
  }
}
```

Perkara penting tentang `http.Response`:

| Ciri | Penerangan |
|------|------------|
| `response.statusCode` | Kod status HTTP — `200` bermaksud OK/berjaya, `404` tidak dijumpai, `500` ralat pelayan |
| `response.body` | Badan respons sebagai `String` (biasanya JSON dalam bentuk teks) |
| `response.headers` | Map header HTTP (cth. `content-type`) |
| `Uri.parse(...)` | Menukar `String` URL kepada objek `Uri` yang diperlukan oleh `http.get` |

### Kebenaran (permission) internet Android

Untuk **debug** (`flutter run` biasa), kebenaran internet Android sudah disediakan automatik oleh Flutter tool menerusi `android/app/src/debug/AndroidManifest.xml` dan `.../profile/AndroidManifest.xml` — anda tidak perlu buat apa-apa untuk terus membangun di kelas ini.

Tetapi untuk **release build**, kebenaran ini **tiada** secara lalai dalam `android/app/src/main/AndroidManifest.xml` — fail **utama** (main), bukan `debug`/`profile`. Sebelum keluarkan APK yang perlu capai internet, tambah baris ini di dalam tag `<manifest>` fail **`android/app/src/main/AndroidManifest.xml`**:

```xml
<uses-permission android:name="android.permission.INTERNET"/>
```

> **Nota:** Sesi hari ini tidak merangkumi `flutter build apk` — tetapi **simpan nota ini**, ia keperluan biasa bila mana-mana projek Flutter yang guna rangkaian akhirnya perlu dikeluarkan sebagai APK release. Lupa langkah ini bermakna APK release gagal buat sebarang panggilan rangkaian walaupun berfungsi sempurna semasa `flutter run`.

### ❌ Kesilapan biasa — pemasangan `http`

| ❌ Yang selalu ditulis | Kenapa ia masalah | ✅ Betulkan |
|---|---|---|
| Tambah `<uses-permission .../>` hanya dalam `android/app/src/debug/AndroidManifest.xml` | Fail `debug` **tidak** disertakan dalam APK **release** — aplikasi *debug* nampak berfungsi, tetapi APK yang diedarkan gagal senyap semasa `flutter build apk --release` | Tambah baris kebenaran dalam fail **`android/app/src/main/AndroidManifest.xml`** (bukan `debug`/`profile`) |
| Lupa `flutter pub get` selepas `flutter pub add http` | `pubspec.yaml` sudah betul, tetapi `pubspec.lock` & cache pakej belum disegerakkan — import `package:http/http.dart` gagal dikesan editor | `flutter pub add http` sepatutnya jalankan `pub get` automatik — kalau masih gagal, jalankan `flutter pub get` manual |
| Anggap kebenaran INTERNET diperlukan untuk `flutter run` biasa | Menyebabkan kekeliruan bila `flutter run` **berjaya** tanpa kebenaran itu ditambah (ia memang automatik untuk debug build) | Faham: kebenaran ini hanya **kritikal untuk release build**, bukan sepanjang pembangunan di kelas |

> 🧪 Cuba sendiri: [`snippets/lab.md`](./snippets/lab.md) Latihan 1 (pasang `http` + kebenaran) dan Latihan 2 (hos `programmes.json` anda sendiri, termasuk nota `10.0.2.2` untuk emulator).

## Langkah 4: Asas Tak Segerak (Async) — Kenapa Ia Penting

### Masalah: UI yang tersekat (blocked)

Bayangkan kod berikut cuba ambil data dari internet **secara segerak (synchronous)**:

```dart
// ❌ Ini TIDAK berfungsi macam ini di Flutter — hanya ilustrasi konsep
List<Programme> data = getProgrammesFromInternet(); // ambil masa 2 saat
print('Selesai!');
```

Jika `getProgrammesFromInternet()` mengambil masa 2 saat untuk siap, **seluruh aplikasi beku** — animasi tak jalan, butang tak boleh ditekan, skrin macam "hang". Ini kerana Flutter (macam kebanyakan UI framework) berjalan atas **satu thread utama**: thread yang sama yang melukis skrin ialah thread yang menjalankan kod anda.

### Penyelesaian: `Future`, `async`, `await`

Dart menyelesaikan ini dengan jenis `Future<T>` — **nilai yang akan sedia pada masa hadapan**, bukan sekarang. Kita imbas kembali dari nota Dart asas ([`nota/02-dart-asas.md`](../nota/02-dart-asas.md), bahagian 8):

```dart
Future<String> ambilData() async {
  await Future.delayed(Duration(seconds: 2));   // simulasi kelewatan rangkaian
  return 'Data siap';
}

void main() async {
  print('Mula...');
  String hasil = await ambilData();   // tunggu tanpa sekat UI
  print(hasil);
}
```

Perkara penting:

- `Future<T>` — "resit" untuk nilai jenis `T` yang akan sampai kemudian.
- `async` pada tandatangan fungsi — menandakan fungsi ini **mungkin** akan `await` sesuatu di dalamnya, dan ia sentiasa memulangkan `Future`.
- `await` — "tunggu di sini sehingga `Future` ini selesai, **tetapi jangan sekat thread utama**" — Flutter bebas terus melukis frame, mengendali sentuhan, dan lain-lain semasa menunggu.
- `Future.delayed(Duration(...))` — cara mudah untuk **mensimulasikan** kelewatan rangkaian tanpa perlu internet sebenar. Kita guna ini nanti dalam `ProgrammeService` sebagai fallback.

### Demo pantas di DartPad

Cuba jalankan ini di [dartpad.dev](https://dartpad.dev) untuk lihat susunan `print` yang berlaku:

```dart
void main() async {
  print('1. Mula memuat...');
  final data = await ambilTawaranEtt();
  print('3. Data diterima: $data');
}

Future<String> ambilTawaranEtt() async {
  print('2. Sedang hubungi pelayan...'); // dilaksana serta-merta
  await Future.delayed(const Duration(seconds: 2));
  return '8 tawaran pengajian dijumpai';
}
```

Perhatikan `print` bernombor **1, 2, 3** — bukan tersusun mengikut kod semata-mata, tetapi mengikut bila setiap operasi *benar-benar* selesai. Ini konsep teras async yang akan kita guna sepanjang hari ini.

### Garis masa dalam perkataan — apa **sebenarnya** berlaku setiap saat

Untuk faham kenapa `await` tidak membekukan UI, mari susun apa yang berlaku **saat demi saat** apabila `main()` di atas dijalankan, dan bandingkan dengan andaian biasa "kod berjalan baris demi baris":

1. **Saat 0.0** — `main()` mula jalan. `print('1. Mula memuat...')` dilaksanakan **serta-merta** — baris ini biasa (segerak), tiada kaitan dengan `Future`.
2. **Saat 0.0 (sambungan)** — Dart sampai ke `await ambilTawaranEtt()`. Ia **memanggil** function itu — `print('2. Sedang hubungi pelayan...')` di dalamnya turut jalan **serta-merta** (bahagian *sebelum* `await` dalam sesebuah function `async` sentiasa jalan segerak). Kemudian ia sampai ke `await Future.delayed(...)`.
3. **Di sinilah titik genting** — bukannya "berhenti dan buat apa-apa" (macam `while (true) {}` yang sekat segalanya), Dart **memulangkan kawalan** kepada *event loop* Flutter. Ertinya: enjin Flutter **bebas** terus melukis animasi, layan sentuhan pengguna, proses gelung lain — semuanya berjalan **selari** semasa `Future.delayed` "menunggu" di latar.
4. **Saat 0.0 hingga 2.0** — tiada apa berlaku pada `main()` kita (ia sedang "dijeda" pada titik `await`), tetapi **seluruh aplikasi Flutter yang lain terus responsif**. Kalau ada butang lain pada skrin, ia masih boleh ditekan.
5. **Saat 2.0** — `Future.delayed` selesai. Dart **menyambung semula** `main()` tepat di titik ia berhenti — `await` "pulangkan" nilai `'8 tawaran pengajian dijumpai'`, ditugaskan kepada `data`.
6. **Saat 2.0 (sambungan)** — `print('3. Data diterima: $data')` jalan.

**Bandingkan** dengan andaian salah biasa: "`await` bermaksud aplikasi berhenti selama 2 saat". Itu **salah** — yang berhenti hanyalah *baris kod dalam function itu sahaja*; keseluruhan aplikasi (UI, animasi, gelung rangka/*frame*) terus berjalan. Ini beza asasi antara `await` dan gelung segerak (`while (true) { ... }`) yang **benar-benar** menyekat semuanya kerana ia tidak pernah memulangkan kawalan kepada *event loop*.

### ❌ Kesilapan biasa — async/await

| ❌ Yang selalu ditulis | Kenapa ia masalah | ✅ Betulkan |
|---|---|---|
| `final data = fetchProgrammes();` (lupa `await`) | `data` menjadi jenis `Future<List<Programme>>`, **bukan** `List<Programme>` — cuba `data.length` akan gagal kompil dengan mesej mengelirukan tentang jenis | Sentiasa `await` sebarang panggilan `Future` yang anda perlukan **hasilnya** serta-merta: `final data = await fetchProgrammes();` |
| Function guna `await` di dalam tetapi lupa kata kunci `async` pada tandatangannya | Ralat kompil terus: `await` **hanya sah** dalam function bertanda `async` | Tambah `async` selepas parameter function: `Future<void> _load() async { ... }` |
| Panggil function `async` dalam `initState()` **dengan** `await` terus di hadapannya | `initState()` **tidak boleh** jadi `async` (ia `void`, dipanggil sekali oleh *framework*) — cuba tambah `async` di situ ralat kompil | Panggil **tanpa** `await`: `_load();` sahaja di dalam `initState()` (function `_load()` sendiri yang `async`, ia jalan di latar) |
| Fikir `await` = "tunggu, apl freeze" | Membuat pembangun ragu-ragu guna async, walhal ia **penyelesaian** kepada masalah freeze, bukan puncanya | Ingat garis masa di atas: `await` memulangkan kawalan kepada *event loop*, bukan sekat semuanya |

## Langkah 5: Praktikal — Fetch Data & Model `Programme`

### JSON → objek Dart dengan `jsonDecode`

API mengembalikan **teks** (`response.body`), bukan objek Dart terus. Kita perlu **hurai (parse)** teks JSON itu dengan `dart:convert`:

```dart
import 'dart:convert';

const contohJson = '[{"id":"ETT-001","universityName":"Universiti Al-Azhar"}]';

void contoh() {
  final List<dynamic> data = jsonDecode(contohJson) as List<dynamic>;
  print(data[0]['universityName']); // Universiti Al-Azhar
}
```

`jsonDecode` menukar `String` JSON kepada struktur Dart generik: objek `{}` menjadi `Map<String, dynamic>`, senarai `[]` menjadi `List<dynamic>`. Masalahnya — `dynamic` tidak selamat jenis (type-safe) dan menyusahkan bila digunakan merata-rata dalam UI.

### `Programme.fromJson` — daripada `Map<String, dynamic>` kepada objek

Model sebenar `lib/models/programme.dart` sudah menyediakan `factory fromJson`:

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

Perkara yang perlu diperhatikan:

- **`enum` daripada `String`** — JSON tidak ada konsep `enum`, jadi peringkat pengajian & kategori kemasukan dihantar sebagai teks biasa (`"bachelor"`, `"spm"`). Kaedah statik seperti `StudyLevel.fromString(...)` dan `EntryCategory.fromString(...)` memetakan teks itu balik kepada nilai `enum`, dengan nilai lalai (`orElse`) jika teks tidak dikenali — ini mengelakkan aplikasi *crash* jika pelayan hantar nilai luar jangka.
- **`(json['estimatedAnnualCostMyr'] as num).toDouble()`** — nombor dalam JSON kadangkala tiba sebagai `int` walaupun kita mahu `double`; `as num` menerima kedua-duanya dahulu sebelum ditukar dengan selamat.
- **`Programme` tiada medan `DateTime`** — berbeza daripada model universiti luar negara Hari 1–3 versi lama, `Programme` sengaja disimpan mudah: `intakeMonth` cuma `String` biasa (cth. `"September"`), bukan tarikh sebenar. Ini keputusan reka bentuk domain eTT — cukup untuk paparan tanpa memerlukan `DateTime.parse`.
- **`quotaSeats`** — nombor **ilustrasi**, kecuali laluan Maghribi (`ETT-007`) yang memang **15 tempat sebenar**. Jangan anggap semua kuota rasmi.
- **`toJson()`** — arah bertentangan (objek Dart → JSON), digunakan bila kita perlu **hantar** data (POST permohonan — Langkah 5 SESI 7).

### Menukar senarai JSON penuh

```dart
final List<dynamic> data = jsonDecode(response.body) as List<dynamic>;
final List<Programme> senarai = data
    .map((e) => Programme.fromJson(e as Map<String, dynamic>))
    .toList();
```

`.map()` menjalankan `Programme.fromJson` untuk **setiap** elemen dalam senarai JSON, menghasilkan `Iterable<Programme>`, kemudian `.toList()` menukarnya kepada `List<Programme>` sebenar.

### ❌ Kesilapan biasa — parsing JSON & model

| ❌ Yang selalu ditulis | Kenapa ia masalah | ✅ Betulkan |
|---|---|---|
| `jsonDecode(response.body) as Map<String, dynamic>` untuk respons **senarai** | `GET /programmes` pulangkan `[...]` (senarai), bukan `{...}` (objek) — `as Map` melontar `TypeError` serta-merta | Semak bentuk JSON dahulu (Langkah 2): senarai → `as List<dynamic>`, kemudian `.map(...)` setiap elemen |
| Terus `jsonDecode(response.body)` tanpa semak `response.statusCode` dahulu | Respons `404`/`500` selalunya **bukan** JSON tawaran pengajian (mungkin HTML halaman ralat, atau `{"error": "..."}`) — `Programme.fromJson` akan cuba baca medan yang tiada dan gagal dengan ralat mengelirukan | **Sentiasa** semak `if (response.statusCode == 200)` **sebelum** `jsonDecode` untuk data sebenar |
| `as double` terus untuk medan seperti `estimatedAnnualCostMyr` | JSON boleh hantar nombor bulat (`23000`) walaupun kita mahu `double` — `as double` gagal untuk nilai `int` | `(json['estimatedAnnualCostMyr'] as num).toDouble()` — terima kedua-dua jenis dahulu |
| `EntryCategory.values.byName(json['category'])` | Melontar `ArgumentError` dan **meranapkan** aplikasi jika pelayan hantar nilai `enum` yang tidak dikenali versi aplikasi semasa | `EntryCategory.fromString(...)` guna `firstWhere(..., orElse: ...)` — sentiasa pulangkan nilai selamat |

> 🧪 Cuba sendiri: [`snippets/lab.md`](./snippets/lab.md) Latihan 3 — tulis `Programme.fromJson` langkah demi langkah, termasuk ujian manual `Programme.fromJson({...})` untuk sahkan setiap medan terurai betul sebelum sambung ke rangkaian sebenar.

### Lapisan servis — `ProgrammeService`

Kita tidak letak kod `http.get` terus dalam widget — sebaliknya kita asingkan ke **lapisan servis** (`lib/services/programme_service.dart`). Ini corak seni bina yang baik: widget tidak perlu tahu **dari mana** data datang, ia cuma panggil satu method.

Fail sebenar (`projek/ett_mobile/lib/services/programme_service.dart`):

```dart
import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

import '../data/sample_programmes.dart';
import '../models/programme.dart';

class ProgrammeService {
  ProgrammeService({http.Client? client}) : _client = client ?? http.Client();

  final http.Client _client;

  /// Ganti dengan endpoint sebenar/mock anda.
  static const String _endpoint =
      'https://raw.githubusercontent.com/kpt-kursus/mock/main/programmes.json';

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
      // Kod status bukan 200 → guna data tempatan.
      return _fallback();
    } catch (_) {
      // Ralat rangkaian / masa tamat / JSON rosak → guna data tempatan.
      return _fallback();
    }
  }

  /// Simulasi kelewatan rangkaian supaya penunjuk memuat (loading) kelihatan.
  Future<List<Programme>> _fallback() async {
    await Future.delayed(const Duration(milliseconds: 600));
    return sampleProgrammes;
  }

  void dispose() => _client.close();
}
```

Mari huraikan bahagian penting:

- **`_endpoint`** — pemalar konfigurasi, satu tempat untuk tukar URL API/mock (Langkah 7).
- **`http.Client` boleh suntik (injectable)** — `ProgrammeService({http.Client? client})` membenarkan `client` palsu (mock) dihantar semasa ujian unit tanpa perlu sambungan internet sebenar.
- **`try/catch` + `.timeout(...)`** — `.timeout(Duration(seconds: 8))` memaksa `Future` melontar `TimeoutException` jika pelayan tidak balas dalam 8 saat. Digabung dengan `try/catch`, **sebarang** kegagalan (tiada internet, DNS gagal, JSON rosak, timeout) ditangkap dan dikendalikan dengan cara yang sama: jatuh balik (fallback).
- **Kenapa fallback ke data tempatan?** Ini **keputusan reka bentuk yang sengaja** untuk konteks kelas: jika rangkaian WiFi kelas tidak stabil, atau URL mock belum disediakan lagi oleh pelajar, aplikasi **tetap berfungsi** — ia terus guna `sampleProgrammes` secara senyap. Dalam aplikasi produksi sebenar, anda mungkin mahu tunjuk mesej ralat yang lebih jelas kepada pengguna — tetapi untuk tujuan pembelajaran, fallback memastikan **tiada seorang pelajar pun terhenti** semata-mata kerana isu rangkaian semasa demo.

Menggabungkan `.timeout()`, `try/catch`, dan fallback dengan betul (supaya **semua** jenis kegagalan — bukan cuma satu — jatuh balik ke `sampleProgrammes`) mudah tersilap kalau ditulis tergesa-gesa. Kalau anda buntu menyusunnya, cuba minta AI:

```text
Tulis method fetchProgrammes() dalam kelas ProgrammeService (Dart, pakej http).
Ia perlu: GET ke _endpoint dengan timeout 8 saat, jika statusCode 200 hurai
JSON kepada List<Programme> guna Programme.fromJson, jika status lain ATAU
timeout ATAU sebarang exception (termasuk JSON rosak) — kembalikan senarai
sampleProgrammes sebagai fallback tanpa lontar (throw) ralat ke pemanggil.
```

Semak hasilnya: cuba matikan WiFi dan pastikan ia benar-benar jatuh ke fallback (bukan crash), dan pastikan `catch` menangkap **jenis** ralat yang betul — sesetengah draf AI hanya tangkap `Exception` dan terlepas `TimeoutException` atau ralat parsing JSON yang bukan turunan `Exception`.

> 🧪 Cuba sendiri: [`snippets/lab.md`](./snippets/lab.md) Latihan 4 — bina `ProgrammeService.fetchProgrammes()` **langkah demi langkah** (GET bare → `jsonDecode` → `try/catch` + semak `statusCode` → `.timeout` → fallback), dengan eksperimen memaksa ralat rangkaian sengaja pada setiap peringkat untuk lihat kesannya.

> **📎 Ringkasan setakat ini (SESI 6):** kita sudah lalui **empat** kepingan asas REST API di Flutter — (1) beza backend/frontend & corak permintaan-respons, (2) kaedah HTTP (`GET`/`POST`/`PUT`/`DELETE`) & format JSON, (3) pakej `http` + kebenaran Android, dan (4) `async`/`await`/`Future` supaya panggilan rangkaian tidak membekukan UI. Kepingan terakhir, `ProgrammeService.fetchProgrammes()`, **menggabungkan** kesemuanya: `http.get` (2+3) dibungkus `try/catch` + `.timeout` (4) yang menghurai JSON (2) kepada `List<Programme>` menerusi `Programme.fromJson`. SESI 7 seterusnya menyambung **arah bertentangan** — menghantar data (`POST`) — dan memperdalam pengendalian ralat di peringkat UI.

---

# SESI 7 — Model Data & Pengendalian Ralat (Error Handling)

## Langkah 1: JSON → Dart Model Class Dengan Bantuan AI

Menulis `fromJson`/`toJson` untuk model secara manual **memakan masa dan mudah tersilap** (huruf besar/kecil kunci JSON, jenis nombor, dsb.) — lebih-lebih lagi bila terdapat beberapa `enum` yang perlu dipetakan. Ini titik yang sesuai untuk minta bantuan pembantu AI (Claude Code, ChatGPT, Copilot) menjana rangka model, **kemudian sahkan ia dengan teliti**.

### Contoh prompt

Tampal **satu rekod contoh** JSON (bukan keseluruhan fail — cukup untuk AI kenal struktur) dan minta kelas Dart:

```text
Berikut satu rekod JSON daripada API tawaran pengajian e-Timur Tengah (eTT):

{
  "id": "ETT-001",
  "universityName": "Universiti Al-Azhar",
  "country": "Egypt",
  "city": "Kaherah (Cairo)",
  "fieldOfStudy": "Perubatan (Medicine)",
  "studyLevel": "bachelor",
  "category": "spm",
  "estimatedAnnualCostMyr": 23000.0,
  "intakeMonth": "September",
  "recognitionNote": "Semak pengiktirafan di www2.mqa.gov.my/esisraf (eSisraf, MQA); perubatan tertakluk syarat Majlis Perubatan Malaysia (MMC). Kos anggaran ilustrasi.",
  "quotaSeats": 40
}

Jana kelas Dart `Programme` (immutable, semua medan `final`) dengan:
- constructor `const` bernama parameter, semua `required`
- factory `fromJson(Map<String, dynamic> json)`
- method `toJson()`
- enum berasingan untuk `studyLevel` (StudyLevel) dan `category`
  (EntryCategory), setiap satu dengan kaedah statik `fromString(String value)`
  yang guna `firstWhere(..., orElse: ...)` supaya tidak crash jika nilai
  tidak dikenali.
Ikut gaya projek Flutter sedia ada — field names camelCase Bahasa Inggeris.
```

### Hasil yang dijana (rujuk `lib/models/programme.dart` sebenar)

AI patut menghasilkan sesuatu yang sangat rapat dengan model sebenar projek — dua `enum` (`StudyLevel`, `EntryCategory`), setiap satu dengan `fromString`, dan kelas `Programme` dengan `fromJson`/`toJson` seperti yang dipetik penuh di Langkah 5 (SESI 6) di atas.

### Cara mengesahkannya — JANGAN terima buta-buta

Kod yang dijana AI **kelihatan** betul tidak bermakna ia **memang** betul. Semak setiap perkara ini:

1. **Nullability** — adakah medan yang sepatutnya boleh kosong (`String?`/`DateTime?`) ditanda `?` dengan betul? (Dalam `Programme`, **semua** medan `required` — tiada nullable, kerana data mock lengkap. Tetapi dalam `Application`, `submittedAt` **mesti** `DateTime?` kerana permohonan draf belum tentu dihantar lagi — jika AI terlepas ini, `flutter analyze`/runtime akan tunjuk masalah bila `submittedAt` masih kosong.)
2. **Parsing `enum`** — pastikan AI guna corak `firstWhere(..., orElse: () => ...)`, **bukan** `enum.values.byName(...)` (yang akan **crash** dengan `ArgumentError` jika pelayan hantar nilai yang tidak dijangka — cth. kategori kemasukan baharu yang belum wujud dalam `enum` semasa aplikasi belum dikemas kini).
3. **Nombor** — `(json['estimatedAnnualCostMyr'] as num).toDouble()`, bukan `as double` terus (JSON boleh hantar `23000` sebagai integer walaupun kita mahu `double`).
4. **Jangan tambah medan `DateTime` yang tidak wujud** — `Programme` sengaja **tiada** medan tarikh (`intakeMonth` cuma `String`); kadangkala AI "membantu lebih" dengan mereka-reka `DateTime.parse(...)` untuk medan yang sepatutnya kekal `String` — semak ini dengan teliti berbanding JSON sumber sebenar.
5. **Jalankan `flutter analyze`** selepas tampal kod yang dijana — tangkap ralat jenis/import yang AI mungkin terlepas.
6. **Uji dengan data sebenar** — panggil `Programme.fromJson(jsonDecode(contohJsonSebenar))` dalam ujian ringkas atau `print()` sementara, pastikan **semua** medan terisi betul, bukan hanya kompil tanpa ralat.

> Lihat lebih banyak contoh prompt & prinsip di [`nota/08-prompt-claude-code.md`](../nota/08-prompt-claude-code.md).

> 🧪 Cuba sendiri: [`snippets/lab.md`](./snippets/lab.md) Latihan 3 (bahagian menulis `fromJson` sendiri) menyediakan latihan tangan sebelum bandingkan dengan hasil AI di sini — buat dahulu **sendiri**, kemudian minta AI, baru banding kedua-duanya.

## Langkah 2: Submit Data — HTTP POST

Selain **GET** senarai, aplikasi perlu **hantar** data — contohnya borang permohonan eTT (`ApplicationFormScreen`, dibina Hari 3) yang menghasilkan objek `Application`.

### `Application.toJson()`

Model `lib/models/application.dart` sudah menyediakan `toJson()`:

```dart
Map<String, dynamic> toJson() => {
      'id': id,
      'fullName': fullName,
      'icNumber': icNumber,
      'email': email,
      'phoneNumber': phoneNumber,
      'academicCategory': academicCategory.name,
      'academicSummary': academicSummary,
      'country': country,
      'fieldOfStudy': fieldOfStudy,
      'universityChoiceIds': universityChoiceIds,
      'uploadedDocuments': uploadedDocuments,
      'status': status.name,
      'submittedAt': submittedAt?.toIso8601String(),
    };
```

Perhatikan `enum.name` (cth. `academicCategory.name` → `"spm"`), `submittedAt?.toIso8601String()` (`?` kerana `submittedAt` boleh `null` sebelum permohonan dihantar), dan `universityChoiceIds`/`uploadedDocuments` yang terus dihantar sebagai senarai `String` — arah **bertentangan** daripada `fromJson` yang kita lihat di SESI 6.

> **Ingat peraturan sebenar eTT:** satu permohonan = **SATU negara + SATU bidang**; dalam bidang itu pelajar boleh menyusun **sehingga 3 pilihan universiti** (`universityChoiceIds`, 1–3 id `Programme`). Borang `ApplicationFormScreen` (Hari 3) sudah menguatkuasakan peraturan ini menerusi dropdown negara/bidang tunggal + tiga slot pilihan universiti.

### Hantar dengan `http.post`

```dart
Future<bool> submitApplication(Application application) async {
  final response = await http.post(
    Uri.parse('$_baseUrl/applications'),
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode(application.toJson()),
  );
  return response.statusCode == 200 || response.statusCode == 201;
}
```

Perkara penting:

- **`headers: {'Content-Type': 'application/json'}`** — beritahu pelayan bahawa `body` yang dihantar berformat JSON, bukan teks biasa.
- **`body: jsonEncode(application.toJson())`** — `toJson()` hasilkan `Map<String, dynamic>`, `jsonEncode` tukar `Map` itu kepada `String` JSON yang dihantar dalam permintaan.
- Semak **`statusCode`**, bukan andaikan ia berjaya — lihat Langkah 3.

### ❌ Kesilapan biasa — hantar data (POST)

| ❌ Yang selalu ditulis | Kenapa ia masalah | ✅ Betulkan |
|---|---|---|
| `body: application.toJson()` terus (lupa `jsonEncode`) | `http.post` mengharap `body` jenis `String`/`List<int>`, bukan `Map` — pelayan terima teks yang bukan JSON sah (biasanya `.toString()` Dart, cth. `{id: ABC, ...}` tanpa tanda petik) | `body: jsonEncode(application.toJson())` — tukar `Map` kepada `String` JSON dahulu |
| Lupa `headers: {'Content-Type': 'application/json'}` | Sesetengah pelayan (termasuk `json-server`) anggap `body` teks biasa dan **tolak** permintaan atau salah hurai data | Sentiasa sertakan header `Content-Type: application/json` untuk permintaan yang bawa `body` JSON |
| `return response.statusCode == 200;` sahaja | Ramai API pulangkan `201 Created` (bukan `200`) untuk rekod **baharu** yang berjaya dicipta — semakan yang terlalu sempit anggap `POST` berjaya itu "gagal" | Semak **kedua-dua** `200` **dan** `201` untuk `POST` (rujuk jadual kod status, Langkah 3) |

> 🧪 Cuba sendiri: [`snippets/lab.md`](./snippets/lab.md) Latihan 7 — bina `submitApplication` langkah demi langkah dan sambungkan ke UI dengan `SnackBar`.

## Langkah 3: Kod Status HTTP — Apa Aplikasi Patut Buat

| Kod | Makna | Tindakan aplikasi |
|-----|-------|---------------------|
| **200** OK | Permintaan (biasanya GET) berjaya | Papar data (`LoadState.loaded`) |
| **201** Created | Rekod baharu berjaya dicipta (biasanya selepas POST) | Papar `SnackBar` kejayaan (permohonan diterima pelayan), kosongkan/tutup borang |
| **400** Bad Request | Data yang dihantar tidak sah/tidak lengkap | Papar mesej ralat borang — **jangan** biarkan pengguna fikir ia berjaya |
| **401** Unauthorized | Token/kebenaran akses tidak sah (relevan bila API perlu log masuk) | Halakan pengguna ke skrin log masuk semula |
| **404** Not Found | URL/ID rekod tidak wujud | Papar "Rekod tidak dijumpai" — semak `_endpoint`/ID yang dihantar |
| **500** Internal Server Error | Pelayan sendiri gagal (bukan salah aplikasi) | Papar mesej ralat umum + butang **Cuba Lagi**, jangan dedah butiran teknikal pelayan kepada pengguna |

> **Peraturan emas:** Sentiasa semak `response.statusCode` **sebelum** percaya `response.body`. Kod bukan-200/201 mungkin masih memulangkan `body` (contohnya mesej ralat JSON) — jangan terus `jsonDecode` dan anggap ia data sah.
>
> **Nota domain:** status HTTP (200/201/400/…) ialah **status permintaan rangkaian** — jangan keliru dengan `ApplicationStatus` (Draf/Dihantar/Dalam Semakan/**Layak**/**Tidak Layak**/Tawaran/Diterima/Ditolak) dalam model `Application`, yang mewakili **kitaran hayat permohonan sebenar** dalam sistem eTT (disemak ~7 hari bekerja selepas permohonan ditutup). POST yang berjaya (201) cuma bermakna permohonan **berjaya dihantar** — status peringkat kelayakan (`eligible`/`notEligible`) ditentukan kemudian oleh pihak KPT, bukan oleh kod status HTTP.

Pelayan sering pulangkan mesej ralat sebagai JSON juga (cth. `{"error": "icNumber tidak sah"}`), bukan sekadar kod status. Kalau anda perlu hurai badan ralat itu dan paparkannya kepada pengguna, ini boleh jadi rumit bila strukturnya berbeza-beza mengikut kod status — cuba minta AI:

```text
Tulis fungsi Dart yang terima http.Response daripada percubaan submitApplication().
Jika statusCode 201, pulangkan null (tiada ralat). Jika 400, cuba jsonDecode
response.body dan ambil medan "error" sebagai mesej; jika parsing gagal atau
medan tiada, pulangkan mesej lalai "Data tidak sah". Jika 401/404/500, pulangkan
mesej generik yang sesuai (rujuk jadual kod status). Jangan biarkan fungsi ini
throw — ia mesti sentiasa pulangkan String? mesej ralat atau null.
```

Semak: adakah ia cuba `jsonDecode` badan respons walaupun badan itu mungkin bukan JSON sah (cth. HTML halaman ralat 500 daripada sesetengah pelayan)? Draf AI yang tidak berhati-hati boleh terlontar ralat parsing baharu semasa cuba mengendalikan ralat asal — bungkus bahagian `jsonDecode` itu dalam `try/catch` tersendiri.

## Langkah 4: Pengendalian Ralat — `try-catch`, Loading & Retry

### Corak asas dengan `setState()` (kaedah rasmi kursus)

Kita gunakan **`enum LoadState`** untuk wakili empat keadaan kitaran hayat sesuatu operasi rangkaian — corak ini lebih jelas berbanding beberapa `bool` berasingan seperti `isLoading`/`hasError`:

```dart
enum LoadState { idle, loading, loaded, error }
```

| Keadaan | Bila | UI yang dipaparkan |
|---------|------|---------------------|
| `idle` | Sebelum fetch dipanggil buat kali pertama | Sama seperti loading (belum ada apa-apa) |
| `loading` | Semasa `fetchProgrammes()` sedang berjalan | `CircularProgressIndicator` |
| `loaded` | Berjaya dapat data (dari API **atau** fallback) | Senarai `ProgrammeCard` |
| `error` | Sesuatu gagal **dan tiada fallback berjaya** | Ikon + mesej ralat + butang **Cuba Lagi** |

Contoh `StatefulWidget` ringkas yang menguruskan keempat-empat keadaan **dengan `setState()` sahaja** (tiada `provider`):

```dart
class _DemoScreenState extends State<DemoScreen> {
  LoadState _state = LoadState.idle;
  List<Programme> _programmes = [];
  final _service = ProgrammeService();

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
        return ListView.builder(
          itemCount: _programmes.length,
          itemBuilder: (context, i) =>
              ProgrammeCard(programme: _programmes[i]),
        );
    }
  }
}
```

Sebab `switch` di sini menyemak `enum` yang sudah lengkap (`idle`, `loading`, `loaded`, `error`) tanpa `default`, Dart akan beri **amaran masa kompil** jika satu keadaan terlepas dipertimbangkan — corak ini dipanggil *exhaustive switch* dan sangat berguna supaya kita tidak pernah terlupa kendalikan sesuatu keadaan.

Widget ralat (ikon + mesej + butang Cuba Lagi) begini agak berulang untuk ditulis tangan setiap kali perlukan skrin baharu yang fetch data. Kalau anda perlukan versi lain (cth. untuk skrin senarai permohonan), boleh minta AI bina rangkanya:

```text
Bina widget Flutter reusable ErrorStateView yang terima String message dan
VoidCallback onRetry. Papar Column ditengah (Icon Icons.wifi_off, SizedBox,
Text(message), SizedBox, FilledButton dengan label "Cuba Lagi" yang panggil
onRetry). Guna const constructor di mana boleh.
```

Semak `const` diletak di tempat yang betul (widget statik dalam `Column` patut `const`, tetapi bukan `FilledButton` yang ada `onPressed` dinamik), dan jalankan `flutter analyze` sebelum guna widget ini menggantikan blok `Column` yang ditulis terus dalam `switch` di atas.

### `try-catch` — kenapa ia wajib di sini

`try-catch` yang membalut panggilan `_service.fetchProgrammes()` menangkap **sebarang** kegagalan (tiada internet, timeout, JSON tidak sah) dan menukarnya kepada `LoadState.error` dengan cara yang terkawal — tanpanya, ralat yang tidak ditangkap (*uncaught exception*) akan menyebabkan Flutter memaparkan skrin merah "ralat" yang menakutkan pengguna dan tidak memberi laluan untuk cuba lagi.

### `CircularProgressIndicator` — maklum balas visual semasa menunggu

`CircularProgressIndicator` ialah widget Material standard yang memberitahu pengguna "aplikasi sedang bekerja, sila tunggu" — **wajib** dipaparkan semasa `LoadState.loading`, kerana tanpanya skrin kosong buat pengguna keliru sama ada aplikasi *hang* atau memang sedang memuat.

### `mounted` — semakan wajib bila `context`/`setState` diguna selepas `await`

Bayangkan pengguna menekan butang yang memanggil operasi rangkaian (contohnya `submitApplication`), tetapi **sebelum** respons pulang, dia sudah tekan "kembali" dan tutup skrin itu. Bila respons akhirnya sampai dan kod cuba `setState(...)` atau guna `context` (contohnya untuk papar `SnackBar`) pada skrin yang **sudah tidak wujud**, Flutter melontar ralat runtime — paling biasa `setState() called after dispose()`.

Setiap objek `State` ada medan terbina-dalam `mounted` (`bool`) — `true` selagi `State` itu masih terpasang pada pokok widget, `false` sebaik sahaja `dispose()` dipanggil. **Corak wajib** setiap kali `context`/`setState` diguna **selepas** `await`:

```dart
Future<void> _hantarPermohonan() async {
  final berjaya = await _service.submitApplication(application);
  if (!mounted) return;               // 👈 semak DAHULU sebelum guna context
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text(berjaya ? 'Berjaya!' : 'Gagal.')),
  );
}
```

`if (!mounted) return;` mesti diletak **serta-merta selepas** baris `await` terakhir yang mendahului sebarang penggunaan `context`/`setState` — bukan di hujung function, dan bukan hanya sekali di awal (kerana pemeriksaan di awal function tidak melindungi daripada skrin ditutup **semasa** `await` sedang berjalan).

### ❌ Kesilapan biasa — pengendalian ralat & UI

| ❌ Yang selalu ditulis | Kenapa ia masalah | ✅ Betulkan |
|---|---|---|
| `ScaffoldMessenger.of(context).showSnackBar(...)` sejurus selepas `await` tanpa semak `mounted` | Jika pengguna tinggalkan skrin semasa menunggu, `context` sudah tidak sah — ralat runtime, kadang *silent crash* di production | Tambah `if (!mounted) return;` sebelum baris yang guna `context` (lihat contoh di atas) |
| Panggil `fetchProgrammes()`/`submitApplication()` terus dalam `build()` | `build()` dipanggil **berkali-kali** (setiap `setState`, setiap perubahan tema, dsb.) — setiap panggilan mencetuskan **permintaan rangkaian baharu** tanpa disedari | Panggil dalam `initState()` (untuk pemuatan pertama) atau sebagai tindak balas kepada peristiwa (`onPressed`, `onRefresh`) — **tidak pernah** terus dalam `build()` |
| `catch (Exception e) { ... }` sahaja | Sesetengah ralat (cth. `TimeoutException`, ralat jenis semasa `jsonDecode`) **bukan** turunan `Exception` dalam semua kes — `catch` yang terlalu spesifik boleh terlepas ralat sebenar dan aplikasi tetap *crash* | Guna `catch (_) { ... }` (tangkap **apa-apa** jenis ralat) melainkan anda **sengaja** perlu layan jenis ralat tertentu secara berbeza |
| Tiada apa-apa dipaparkan semasa `LoadState.loading` (skrin kosong) | Pengguna tidak tahu sama ada aplikasi *hang* atau sedang bekerja | Sentiasa papar `CircularProgressIndicator` (atau *skeleton loader*) semasa menunggu |

> 🧪 Cuba sendiri: [`snippets/lab.md`](./snippets/lab.md) Latihan 5 — bina skrin `LoadState` dari kosong, termasuk eksperimen "buang `setState()`" yang menunjukkan spinner berputar selama-lamanya walaupun data sebenarnya sudah sampai.

### Bagaimana projek sebenar (`ett_mobile`) membalut corak ini

Corak `LoadState` + `try-catch` di atas **tepat sama** dengan yang digunakan dalam projek sebenar — tetapi dibalut dalam **`ChangeNotifier`** (`ProgrammeProvider`, pakej `provider`) supaya carian & tapisan negara/kategori (dari Hari 3) boleh dikongsi automatik merentasi skrin:

```dart
// lib/providers/programme_provider.dart — guna pakej `provider`
enum LoadState { idle, loading, loaded, error }

class ProgrammeProvider extends ChangeNotifier {
  Future<void> load() async {
    _state = LoadState.loading;
    notifyListeners();
    try {
      _all = await _service.fetchProgrammes();
      _state = LoadState.loaded;
    } catch (_) {
      _state = LoadState.error;
    }
    notifyListeners();
  }
}
```

Dan `ProgrammeListScreen` (`lib/screens/programme_list_screen.dart`) memaparkan keadaan itu dengan `switch (provider.state)` — struktur **sama persis** dengan contoh `setState()` di atas, cuma sumber `_state` datang daripada `context.watch<ProgrammeProvider>()` dan bukan medan `State` sendiri. Jika anda faham contoh `setState()` di atas, anda **sudah** faham corak ini — hanya lokasi state yang berbeza.

> **`ApplicationProvider`:** projek sebenar juga menyimpan senarai permohonan pelajar secara **kekal di peranti** menggunakan pakej `shared_preferences` (`lib/providers/application_provider.dart`, `loadFromStorage()`/`_persist()`), supaya senarai permohonan pelajar tidak hilang bila app ditutup.

### Pendekatan alternatif: `FutureBuilder`

`setState()` + `LoadState` bukan satu-satunya cara mudah untuk paparkan hasil `Future`. Untuk kes **paling ringkas** (satu kali fetch, tiada carian/tapisan/pull-to-refresh di atasnya), widget terbina-dalam `FutureBuilder` sering memadai — dan tidak memerlukan pakej `provider` langsung:

```dart
class SimpleProgrammeList extends StatefulWidget {
  const SimpleProgrammeList({super.key});

  @override
  State<SimpleProgrammeList> createState() => _SimpleProgrammeListState();
}

class _SimpleProgrammeListState extends State<SimpleProgrammeList> {
  // PENTING: simpan Future dalam medan State, JANGAN panggil
  // ProgrammeService().fetchProgrammes() terus di dalam build().
  late Future<List<Programme>> _futureProgrammes;

  @override
  void initState() {
    super.initState();
    _futureProgrammes = ProgrammeService().fetchProgrammes();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Programme>>(
      future: _futureProgrammes,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text('Ralat: ${snapshot.error}'));
        }
        final items = snapshot.data ?? [];
        return ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) => ProgrammeCard(programme: items[index]),
        );
      },
    );
  }
}
```

`FutureBuilder` membina semula (rebuild) widget secara automatik berdasarkan `AsyncSnapshot` bagi satu `Future` — ringkas dan tidak perlukan `enum LoadState` berasingan. **Tetapi** ia ada dua batasan penting:

1. `future:` dinilai **sekali** semasa `build()` pertama. Jika widget dibina semula (rebuild) atas sebab lain, `FutureBuilder` boleh **panggil API berulang kali tanpa disengajakan** melainkan `Future` disimpan dalam pembolehubah `State` (seperti `_futureProgrammes` di atas) — mudah tersilap jika terlupa.
2. Ia tidak sedia untuk **pull-to-refresh** — anda perlu `setState()` sendiri untuk cetuskan semula `Future` (lihat method `_refresh()` dalam contoh penuh).

Untuk skrin senarai utama `ProgrammeListScreen` (yang perlu sokong carian, tapisan negara/kategori, **dan** muat semula), corak `setState()` + `LoadState` yang ditunjukkan di atas lebih sesuai kerana ia satu sumber kebenaran (single source of truth) yang eksplisit. `FutureBuilder` tetap pilihan yang bagus untuk skrin **ringkas** yang hanya fetch sekali.

> Lihat contoh penuh di [`snippets/futurebuilder_example.dart`](./snippets/futurebuilder_example.dart).

## Langkah 5: Pull-to-Refresh — `RefreshIndicator`

> 🧪 Cuba sendiri: [`snippets/lab.md`](./snippets/lab.md) Latihan 6 — bina Langkah 5 ini terus di atas skrin `LoadState` yang anda siapkan di Latihan 5.

`RefreshIndicator` membalut senarai dan memaparkan gelung (spinner) khas Material bila pengguna **tarik ke bawah** dari atas senarai:

```dart
RefreshIndicator(
  onRefresh: _load, // atau provider.load dalam corak provider
  child: ListView.builder(
    padding: const EdgeInsets.only(bottom: 16),
    itemCount: _programmes.length,
    itemBuilder: (context, index) {
      final p = _programmes[index];
      return ProgrammeCard(
        programme: p,
        onTap: () => Navigator.of(context).push(
          MaterialPageRoute(builder: (_) => ProgrammeDetailScreen(programme: p)),
        ),
      );
    },
  ),
);
```

Syarat penting: `onRefresh` **mesti** menerima `Future<void> Function()`. `RefreshIndicator` sendiri mengurus animasi spinner: ia menunggu `Future` yang dipulangkan `onRefresh` selesai sebelum spinner hilang.

> `RefreshIndicator` **memerlukan** widget scrollable (`ListView`, `GridView`, dsb.) sebagai anak terus — ia tidak berfungsi dengan `Column` biasa.

---

## Langkah 6: Menghos API Mock Anda Sendiri

Endpoint dalam `ProgrammeService._endpoint` cuma **placeholder**. Untuk kelas berfungsi sepenuhnya, setiap pelajar/kelas perlu ada URL JSON sebenar yang boleh dicapai melalui internet. Data sumbernya sudah disediakan di `projek/mock-api/programmes.json` (8 tawaran pengajian — Universiti Al-Azhar, Alexandria, Ain Shams, Tanta di Mesir; Al Quaraouiyine, Mohammed V di Maghribi). Berikut tiga cara untuk menghosnya:

### Opsyen A: GitHub raw URL (paling mudah, percuma, kekal)

1. Buat repositori GitHub baharu (atau guna repo sedia ada), muat naik `programmes.json`.
2. Buka fail itu di GitHub, klik butang **Raw**.
3. Salin URL — bentuknya seperti:
   ```
   https://raw.githubusercontent.com/<username>/<repo>/main/programmes.json
   ```
4. Tampal URL itu ke dalam `_endpoint` dalam `programme_service.dart`.

> Kelebihan: percuma, tiada had masa (unlike json-server tempatan yang mati bila komputer tutup). Kelemahan: setiap kali nak ubah data, perlu commit & push semula ke GitHub.

### Opsyen B: `json-server` tempatan (pantas untuk demo langsung)

```bash
npx json-server --watch projek/mock-api/programmes.json --port 3001
```

Ini melancarkan pelayan tempatan di `http://localhost:3001/programmes` (perhatikan nama endpoint menjadi jamak automatik oleh `json-server`, mengikut nama fail). Tampal URL itu ke `_endpoint`.

> **Had penting:** `localhost` di dalam **emulator Android** perlu ditukar kepada `http://10.0.2.2:3001/programmes` (alias khas emulator untuk mesin host — `10.0.2.2` bukan `127.0.0.1`, kerana emulator berjalan dalam mesin maya tersendiri). Untuk peranti fizikal, guna alamat IP rangkaian komputer anda (cth. `http://192.168.1.10:3001/programmes`) — telefon dan komputer mesti berada dalam WiFi yang sama.

### Opsyen C: Perkhidmatan mock percuma (mocki.io / mockapi.io)

1. Daftar percuma di [mocki.io](https://mocki.io) atau [mockapi.io](https://mockapi.io).
2. Tampal/import kandungan `programmes.json`.
3. Perkhidmatan akan beri anda URL unik (cth. `https://mocki.io/v1/xxxxxxxx`).
4. Tampal ke `_endpoint`.

> Kelebihan berbanding Opsyen B: URL boleh dicapai dari mana-mana peranti (tidak terhad kepada WiFi yang sama), sesuai untuk demo di rumah/luar kelas.

### Selepas tukar `_endpoint`

```dart
static const String _endpoint = 'https://raw.githubusercontent.com/<anda>/<repo>/main/programmes.json';
```

**Hot restart** (bukan sekadar hot reload — pemalar `static const` perlu dimuat semula) aplikasi, kemudian tarik-untuk-muat-semula pada senarai untuk sahkan data datang daripada pelayan sebenar, bukan fallback tempatan.

### ❌ Kesilapan biasa — mengehos & konfigurasi endpoint

| ❌ Yang selalu ditulis | Kenapa ia masalah | ✅ Betulkan |
|---|---|---|
| `http://localhost:3001/programmes` sebagai `_endpoint` untuk **emulator** Android | Di dalam emulator, `localhost` merujuk **emulator itu sendiri** (ia VM berasingan), bukan komputer pembangun tempat `json-server` berjalan — permintaan gagal dengan `Connection refused` | Guna `http://10.0.2.2:3001/programmes` — alias khas Android emulator untuk mesin host |
| Tukar `_endpoint` tetapi hanya **hot reload** (`r`), bukan hot restart (`R`) | `static const String _endpoint` dimalarkan (*compiled*) semasa `main()` mula — hot reload **tidak** memuat semula pemalar `static const`, jadi URL lama kekal digunakan | Tekan **`R`** besar (hot **restart**) selepas tukar mana-mana `static const`/`final` global |
| Uji URL API terus di dalam aplikasi Flutter, tanpa pengesahan berasingan | Sukar bezakan sama ada masalah di URL/pelayan, atau di kod Flutter — membazir masa *debug* | Uji URL dahulu dengan `curl <url>` atau buka terus di pelayar **sebelum** letak dalam `_endpoint` |
| Guna alamat IP peribadi (`192.168.x.x`) komputer pejabat/rumah dalam kod yang dikongsi rakan sekelas | IP itu **khusus** kepada rangkaian WiFi & komputer anda — tidak berfungsi untuk rakan lain yang cuba salinan kod yang sama | Setiap pelajar guna `_endpoint` **masing-masing** (GitHub raw URL lebih mudah dikongsi kerana ia tetap sama untuk semua) |

> 🧪 Cuba sendiri: [`snippets/lab.md`](./snippets/lab.md) Latihan 2 — pilih dan sediakan salah satu kaedah hosting, disahkan dengan `curl` sebelum digunakan dalam kod.

---

## Langkah 7: Semak Semula Alur Penuh

Ringkasan bagaimana semua kepingan bersambung (corak `setState()`, teras kursus):

```
ProgrammeService.fetchProgrammes()
  ├─ cuba http.get(_endpoint).timeout(8s)
  ├─ 200 OK → jsonDecode → List<Programme> (via fromJson)
  └─ gagal/timeout/status bukan 200 → _fallback() → sampleProgrammes
         │
         ▼
setState(() => _state = LoadState.loading)   (sebelum panggil)
_service.fetchProgrammes()
setState(() => _state = LoadState.loaded / error)  (selepas selesai)
         │
         ▼
build() — switch (_state)
  ├─ loading/idle → CircularProgressIndicator
  ├─ error        → skrin ralat (butang Cuba Lagi → panggil semula _load())
  └─ loaded       → RefreshIndicator(onRefresh: _load) → ListView.builder(ProgrammeCard)
```

Dalam projek sebenar `ett_mobile`, aliran yang **sama persis** ini dibungkus dalam `ProgrammeProvider` supaya `notifyListeners()` menggantikan `setState()` — tetapi logik `try-catch` + `LoadState` + `switch` kekal **sama**.

---

## Troubleshooting — Ralat Rangkaian Paling Biasa

Bahagian ini merangkumi ralat **khusus rangkaian/JSON** yang akan anda temui semasa lab hari ini. Untuk ralat Flutter am (widget, `RenderFlex`, dsb.), rujuk troubleshooting hari-hari sebelumnya.

| Simptom (apa yang anda nampak) | Punca biasa | Cara betulkan |
|---|---|---|
| Skrin merah menyebut **`SocketException: Failed host lookup`** atau **`Connection refused`** | Tiada internet/WiFi, atau (di emulator) guna `localhost` sedangkan patut `10.0.2.2`; atau `json-server` tidak dijalankan lagi | Semak sambungan rangkaian; semak `_endpoint` betul untuk platform (emulator vs peranti fizikal); pastikan `json-server` sedang berjalan di terminal berasingan |
| **`TimeoutException after 0:00:08.000000`** (atau tempoh `.timeout(...)` anda) | Pelayan terlalu lambat balas, atau URL salah/lapuk yang "menggantung" tanpa balas jelas | Sahkan URL masih sah dengan `curl`; jika pelayan memang perlahan (cth. GitHub raw kadang lambat kali pertama), naikkan tempoh `.timeout(...)` sedikit — tetapi jangan alih keluar terus, `timeout` melindungi daripada permintaan "gantung" selama-lamanya |
| **`FormatException: Unexpected character (at character 1)`** semasa `jsonDecode` | `response.body` bukan JSON sah — selalunya kerana `statusCode` bukan `200` (halaman ralat HTML pelayan) tetapi kod cuba `jsonDecode` tanpa semak status dahulu | Tambah semakan `if (response.statusCode == 200)` **sebelum** `jsonDecode` (Langkah 5) |
| Ralat rangkaian **hanya** berlaku semasa `flutter run -d chrome` (web), tidak di Android | Ralat **CORS** (*Cross-Origin Resource Sharing*) — pelayar sekat permintaan ke domain lain melainkan pelayan benarkan secara eksplisit menerusi header `Access-Control-Allow-Origin` | `json-server` sokong CORS lalai untuk kebanyakan kes; untuk pelayan lain yang menyekat, uji di Android/iOS (tiada sekatan CORS) semasa kelas, atau konfigur header CORS di sisi pelayan — ini isu **khusus web**, bukan mobile |
| **`type 'List<dynamic>' is not a subtype of type 'Map<String, dynamic>'`** (atau sebaliknya) | Kod anggap bentuk JSON salah — cuba `as Map` pada respons yang sebenarnya `[...]` (senarai), atau sebaliknya | Semak kurungan luar JSON sumber (Langkah 2); senarai → `List<dynamic>` + `.map(...)`, objek tunggal → `Map<String, dynamic>` terus |
| Data **langsung tidak bertukar** walaupun `_endpoint` sudah betul dan pelayan aktif | Hot reload (`r`) sahaja selepas tukar `static const` — pemalar tidak dimuat semula | Hot **restart** (`R` besar) selepas tukar sebarang `static const`/konfigurasi global |
| **`setState() called after dispose()`** atau ralat berkaitan `context` tidak sah selepas panggilan rangkaian | `context`/`setState` diguna selepas `await`, tanpa semak `mounted`, dan pengguna sudah tinggalkan skrin semasa menunggu respons | Tambah `if (!mounted) return;` sebelum guna `context`/`setState` selepas `await` (lihat bahagian **"`mounted`"** di Langkah 4) |
| APK **release** (bukan `flutter run`) tidak boleh langsung akses internet | Kebenaran `INTERNET` hanya wujud dalam `debug`/`profile` manifest (automatik), tiada dalam `main` | Tambah `<uses-permission android:name="android.permission.INTERNET"/>` ke `android/app/src/main/AndroidManifest.xml` (Langkah 3) |

> **Cara paling pantas mencari punca:** asingkan lapisan yang gagal. (1) Uji URL **di luar** Flutter dahulu (`curl`/pelayar) — kalau gagal di situ, masalah di pelayan/URL, bukan kod Dart. (2) Kalau URL okay tetapi Flutter gagal, tambah `print(response.statusCode)` dan `print(response.body)` **sementara** (macam Latihan 4.1 dalam lab) untuk lihat **tepat** apa yang pulang sebelum cuba `jsonDecode`.

---

## Wrap-Up & Git

Simpan kerja anda hari ini:

```bash
git add lib/services/programme_service.dart lib/models/programme.dart lib/screens/programme_list_screen.dart pubspec.yaml
git commit -m "hari 4: sambung senarai tawaran pengajian eTT ke REST API dengan loading/error/retry & pull-to-refresh"
```

> **Tip git:** Jangan commit `pubspec.lock` jika ia belum pernah dijejaki (`git status` akan tunjukkan) melainkan pasukan anda memang mengamalkan pin versi tepat — untuk projek kelas peribadi, biasa memadai untuk jejak `pubspec.yaml` sahaja.

### Semakan Kefahaman

Sebelum ke Hari 5, pastikan anda boleh jawab:

1. Kenapa `await` tidak "membekukan" (freeze) UI Flutter, berbeza dengan gelung `while (true)` biasa?
2. Apakah bezanya `LoadState.idle` dan `LoadState.loading`, dan kenapa kod di atas layan kedua-duanya sama?
3. Kenapa `ProgrammeService` masih pulangkan data (fallback) walaupun `http.get` gagal, bukannya terus lontar (`throw`) ralat?
4. Apakah beza tindakan aplikasi bila terima kod status `400` berbanding `500`?
5. Kenapa `submittedAt` dalam `Application` **mesti** `DateTime?` (nullable) tetapi hampir semua medan lain `required`?
6. Apakah beza antara kod status HTTP `201 Created` dengan status domain `ApplicationStatus.eligible` — kenapa POST yang berjaya **tidak** bermakna permohonan sudah "Layak"?

### Pratonton Hari 5

Esok kita gabungkan **kesemua** yang dipelajari sepanjang minggu ini — UI, Form, Navigasi, dan API — dalam satu **projek mini/hackathon** terbimbing (SESI 8), memaksimumkan alatan AI untuk mempercepatkan penulisan kod dan *debugging*. Selepas itu kita sudahkan projek dengan sesi **Clean Coding Principles** & **Refactoring** (memisahkan widget besar kepada komponen kecil) sebelum demo dan penyampaian sijil (SESI 9).

---

## Cabaran (Pilihan, untuk pelajar lanjutan)

1. **Tambah cap masa "Dikemaskini pada..."** — simpan `DateTime.now()` dalam medan `State` anda setiap kali fetch berjaya, dan papar di atas senarai (cth. `Dikemaskini: 4:32 PM`). *(≈ Cabaran A dalam lab.)*
2. **Tunjuk sumber data** — bezakan secara visual (cth. label kecil) sama ada data datang dari API sebenar atau daripada fallback tempatan. *(≈ Cabaran B dalam lab.)*
3. **Laksana `submitApplication` sebenar** — hantar `POST` permohonan (lihat SESI 7 Langkah 2) ke json-server/mocki.io anda, dan kendalikan respons `201 Created` di `ApplicationFormScreen`. *(≈ Cabaran D dalam lab.)*

Latihan berstruktur penuh (bina `Programme.fromJson`, `ProgrammeService`, dan skrin `LoadState` **langkah demi langkah** daripada fail permulaan, termasuk semua Cabaran di atas dan satu lagi — kendalikan kod status `400` berasingan daripada `500`) ada di [`snippets/lab.md`](./snippets/lab.md).

---

> 🎤 **Nota penceramah/jurulatih:** [`nota-penceramah.md`](./nota-penceramah.md) — kumpulan nota persembahan (asalnya *speaker notes* dalam slaid) untuk Hari 4.

## Nota Tambahan (fakta ringkas dari slaid)

- **`http` ialah pakej rasmi pasukan Dart.**
- Corak `fromString` untuk enum guna `firstWhere(..., orElse: ...)`, cth. `EntryCategory.fromString`:
  ```dart
  static EntryCategory fromString(String value) {
    return EntryCategory.values.firstWhere(
      (c) => c.name == value,
      orElse: () => EntryCategory.spm,
    );
  }
  ```
- **Satu `enum LoadState`** (idle/loading/loaded/error) lebih jelas daripada beberapa boolean berasingan seperti `isLoading` dan `hasError`.
- Selepas menukar `_endpoint`, tekan **`R` besar** dalam terminal untuk **hot restart** (bukan `r` kecil / hot reload) supaya `main()` dijalankan semula.
- **`quotaSeats`** dalam data `Programme` adalah **ilustrasi**, KECUALI laluan Maghribi (`ETT-007`, Universite Al Quaraouiyine) yang memang **15 tempat** — angka rasmi kerajaan Maghribi (laluan biasiswa berasingan). Ini nota penting bila menerangkan data kepada peserta supaya tidak disalah anggap semua kuota adalah rasmi.
- **Peraturan sebenar eTT:** satu permohonan = **1 negara + 1 bidang**; dalam bidang itu pelajar boleh menyusun **sehingga 3 pilihan universiti**. Panduan awam eTT menekankan 1 negara/1 bidang — borang `ApplicationFormScreen` menguatkuasakan ini.
- Status kelayakan sebenar guna istilah **LAYAK / TIDAK LAYAK** (disemak ~7 hari bekerja selepas permohonan ditutup) — bukan sekadar "diluluskan/ditolak" generik. Model `ApplicationStatus` kekalkan istilah ini (`eligible`/`notEligible`).
