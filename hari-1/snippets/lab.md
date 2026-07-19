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

## Latihan 3 — Widget Asas: `Text`, `Icon`, `Image`

**Objektif:** Beralih dari Dart tulen ke Flutter — cuba tiga widget paparan paling asas.

1. Dalam projek `ett_mobile` anda (dicipta semasa Persediaan), buka `lib/main.dart` dan pastikan `MaterialApp` + `Scaffold` asas berjalan (rujuk bahagian "Eksperimen Widget Asas" dalam `README.md`).
2. Dalam `body:` `Scaffold`, tambah satu `Text('Universiti Al-Azhar', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold))`. Hot Reload — sahkan teks tebal kelihatan.
3. Tambah satu `Icon(Icons.school, size: 32, color: Color(0xFF1A2B5C))` di sebelah/bawah teks tersebut (bungkus kedua-duanya dalam `Column` jika perlu).
4. Cuba **kedua-dua** cara papar imej:
   - `Image.network('https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg', height: 120)`
   - `Text('🇪🇬', style: TextStyle(fontSize: 40))` (emoji bendera Mesir)
5. Susun ketiga-tiga widget (`Text`, `Icon`, `Image`/emoji) dalam satu `Column` supaya kelihatan tersusun menegak.

✅ **Semakan:** Ketiga-tiga widget kelihatan pada emulator/telefon tanpa ralat merah. Jika `Image.network` gagal (tiada internet semasa demo), guna emoji bendera sahaja — itu sah.

---

## Latihan 4 — `Container`, `Padding`, `Margin`, `SizedBox`: Kad Info Program

**Objektif:** Bina secara **manual** satu kad maklumat program eTT statik, gabungan widget susun atur asas — pendahulu kepada `ProgrammeCard` sebenar (Hari 2).

1. Dalam `body:`, cipta satu `Container` dengan:
   - `margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8)` (jarak **LUAR**)
   - `padding: const EdgeInsets.all(16)` (jarak **DALAM**)
   - `decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14), border: Border.all(color: Colors.grey.shade300))`
2. Dalam `child:`, letak `Column(crossAxisAlignment: CrossAxisAlignment.start, children: [...])` mengandungi (guna `SizedBox(height: ...)` sebagai jarak antara setiap baris, **bukan** `Padding` berasingan setiap kali) — data **ETT-001** (Universiti Al-Azhar, Perubatan):
   - `Text('🇪🇬  Universiti Al-Azhar', ...)` — tebal, warna navy `Color(0xFF1A2B5C)`
   - `Text('Kaherah (Cairo), Mesir')` — warna kelabu
   - `Text('Bidang: Perubatan (Medicine)')`
   - `Text('Anggaran yuran: RM23,000/tahun (ilustrasi)')`
   - `Text('Kuota (ilustrasi): 40 tempat · Pengambilan: September')`
3. Hot Reload — sahkan kad putih bersudut bulat dengan sempadan kelabu nipis kelihatan, kandungan tersusun kemas dengan jarak sekata antara baris.
4. **Eksperimen:** Tukar `margin` kepada `EdgeInsets.zero` sementara, perhatikan kad "melekat" ke tepi skrin — ini tunjukkan **beza** kesan `margin` (luar) berbanding `padding` (dalam) secara visual. Kembalikan semula selepas cuba.

✅ **Semakan:** Banding susun atur kad anda dengan contoh dalam `README.md` bahagian "Latihan Bengkel: Kad Info Program (Statik)", dan dengan struktur sebenar `projek/ett_mobile/lib/widgets/programme_card.dart` (versi Hari 2 — lebih maju, guna data dinamik & `Card`, bukan `Container` manual).

---

## Latihan 5 — StatelessWidget vs StatefulWidget: Kaunter "Simpan Program"

**Objektif:** Rasa sendiri **kenapa** `StatefulWidget` + `setState()` diperlukan, melalui satu kaunter interaktif ringkas.

1. Cipta widget baharu `SavedProgrammeCounter` sebagai `class ... extends StatefulWidget`, dengan `createState()` memulangkan `_SavedProgrammeCounterState()`.
2. Dalam `_SavedProgrammeCounterState extends State<SavedProgrammeCounter>`, tambah medan `int _savedCount = 0;`.
3. Tulis kaedah `_addProgramme()` yang memanggil `setState(() { _savedCount++; })`.
4. Dalam `build()`, pulangkan `Column` mengandungi `Text('Program disimpan: $_savedCount')` dan `ElevatedButton(onPressed: _addProgramme, child: const Text('+ Simpan Program'))`.
5. Letak `SavedProgrammeCounter()` sebagai `body:` `Scaffold`, `flutter run`, dan **tekan butang beberapa kali** — sahkan angka bertambah setiap kali ditekan **tanpa** perlu *restart* aplikasi.
6. **Eksperimen (penting untuk faham konsep):** Sementara, tukar `_addProgramme()` supaya **hanya** `_savedCount++;` **tanpa** bungkus dalam `setState(...)`. Tekan butang lagi — perhatikan **angka pada skrin TIDAK berubah** walaupun nilai sebenarnya bertambah "di belakang tabir". Kembalikan semula `setState(...)` selepas faham kesannya.

✅ **Semakan akhir:** Kaunter bertambah setiap tekan **hanya bila** `setState()` digunakan. Anda faham beza `StatelessWidget` (`ProgrammeCard` Latihan 4 — statik) berbanding `StatefulWidget` (`SavedProgrammeCounter` — berubah ikut interaksi).

> **Nota:** Ini **baru pengenalan**. Kitaran hayat penuh `StatefulWidget` (`initState()`, `dispose()`) dan `setState()` dalam konteks borang permohonan sebenar ialah **SESI 5, Hari 3** — jangan risau jika belum faham semua bahagian `State` lagi.

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
