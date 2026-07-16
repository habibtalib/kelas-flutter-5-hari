# Lab Hari 1 — Aliran Kawalan Dart & Widget Asas

Lab ini mengiringi [`README.md`](../README.md) Hari 1. Ikut latihan **secara berurutan** — setiap latihan bina di atas latihan sebelumnya. Rujuk projek akhir sebenar di `projek/mypelajar_ln/lib/` untuk **banding** jawapan anda selepas cuba sendiri dahulu.

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
- [ ] Projek `mypelajar_ln` (dicipta semasa Persediaan) berjaya `flutter run`

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

3. Buka folder projek `projek/mypelajar_ln/` (projek **rujukan penuh**, hasil akhir 5 hari) dalam VS Code — jangan edit fail ini, ia untuk **rujukan/banding** sahaja.
4. Buka `projek/mypelajar_ln/lib/models/overseas_university.dart` — cari `enum StudyLevel` dan `enum RecognitionStatus`. Kita akan tulis versi **sama konsep** fail ini sendiri hari ini (bukan salin terus).
5. Buka `projek/mypelajar_ln/lib/data/sample_universities.dart` — kira berapa banyak universiti tersenarai. (Jawapan: 8.)

> **Soalan renungan:** Kenapa kita mula dengan Dart **tanpa** Flutter dahulu pagi ini, sebelum sentuh widget? (Jawapan: Flutter **dibina di atas** Dart — setiap widget cuma `class` Dart. Kalau asas Dart lemah, kod Flutter jadi sukar difahami.)

✅ **Semakan:** DartPad berjaya jalankan kod ringkas, dan anda sudah kenal pasti lokasi `overseas_university.dart` & `sample_universities.dart` dalam projek rujukan.

---

## Latihan 1 — Operators & Control Flow (`if`/`else`, `switch`)

**Objektif:** Tulis dan jalankan kod Dart tulen menggunakan operator dan aliran kawalan bersyarat.

Boleh guna **DartPad** ATAU cipta fail `.dart` tempatan dan jalankan dengan `dart run`.

1. Tulis pembolehubah `const` untuk statistik rasmi pelajar Malaysia luar negara: `totalPelajarLN = 54903`, `pelajarTajaan = 14697`, `pelajarSendiri = 40206`. Guna operator `+` dan `==` untuk sahkan `pelajarTajaan + pelajarSendiri` sepadan `totalPelajarLN`.
2. Tulis pembolehubah `yuranMelbourneAud = 52000.0` dan `kadarTukaranAudMyr = 3.0`. Guna operator `*` untuk kira `yuranMelbourneMyr`. Guna operator `<=` untuk semak jika ia dalam bajet `200000`, gabungkan dengan `&&` bersama satu syarat `bool` lain (cth. `statusDiiktiraf`).
3. Tulis blok `if`/`else if`/`else` yang menyemak pembolehubah `String recognitionStatus` (nilai `'recognised'` atau `'checkWithMqa'`) dan cetak mesej berbeza untuk setiap kes — **plus** satu `else` untuk kes tidak dijangka.
4. Tulis function `String emOfficeForCountry(String country)` menggunakan `switch` **statement** (bukan expression) yang memetakan sekurang-kurangnya **5 negara** kepada nama pejabat Education Malaysia (rujuk jadual 12 pejabat EM dalam `projek/mypelajar_ln/lib/data/em_offices.dart`), dengan satu `default:` untuk negara tidak dikenali. Sertakan **sekurang-kurangnya satu** pasangan `case` "jatuh melalui" (fall-through) ke `return` yang sama (cth. `'United Kingdom'` dan `'Ireland'` kedua-duanya → `'Education Malaysia London'`).
5. Panggil `emOfficeForCountry(...)` dengan 5 negara berbeza (termasuk satu yang **tiada** dalam senarai anda, untuk uji `default:`) dan `print()` hasilnya.

✅ **Semakan:** Kod anda jalan tanpa ralat, dan `switch` anda betul kembalikan `default:` untuk negara yang tiada `case` sepadan. Banding pendekatan anda dengan bahagian **"Control Flow"** dalam `README.md`.

---

## Latihan 2 — Looping (`for`, `while`) & Function

**Objektif:** Guna gelung untuk memproses koleksi data sebenar, dan bungkus logik berulang dalam function.

1. Tulis `const Map<String, int> pelajarMengikutNegara` dengan **kesemua 12 negara** dan bilangan pelajar 2024 (rujuk jadual dalam `README.md`, bahagian "Looping — `for` & Function").
2. Tulis function `int jumlahkanPelajar(Map<String, int> data)` yang guna `for (final entry in data.entries)` untuk jumlahkan semua nilai, dan `return` jumlahnya.
3. Panggil function tersebut, `print()` jumlahnya (sepatutnya **53,035**), dan bandingkan dengan jumlah rasmi keseluruhan **54,903** — cetak juga **baki** (`54903 - jumlah12Negara`).
4. Tulis gelung `for` **kedua** yang, semasa melintasi `pelajarMengikutNegara`, cetak setiap negara dengan format `'${negara.padRight(16)}: $bilangan pelajar'` (guna `String.padRight()` untuk jajaran kemas).
5. Tulis gelung `while` yang melintasi senarai `['Australia', 'United Kingdom', 'Egypt']` dan cetak `'Destinasi popular #<nombor>: <negara>'` — **pastikan** anda tambah pengira (`i++`) supaya gelung tamat (elak *infinite loop*).

✅ **Semakan:** Jumlah 12 negara anda **mesti** 53,035. Jika tidak, semak semula data yang anda taip. Banding dengan fungsi `loopingAndFunctionDemo()` dan `whileDemo()` dalam [`dart_asas.dart`](./dart_asas.dart).

---

## Latihan 3 — Widget Asas: `Text`, `Icon`, `Image`

**Objektif:** Beralih dari Dart tulen ke Flutter — cuba tiga widget paparan paling asas.

1. Dalam projek `mypelajar_ln` anda (dicipta semasa Persediaan), buka `lib/main.dart` dan pastikan `MaterialApp` + `Scaffold` asas berjalan (rujuk bahagian "Eksperimen Widget Asas" dalam `README.md`).
2. Dalam `body:` `Scaffold`, tambah satu `Text('University of Melbourne', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold))`. Hot Reload — sahkan teks tebal kelihatan.
3. Tambah satu `Icon(Icons.school, size: 32, color: Color(0xFF1A2B5C))` di sebelah/bawah teks tersebut (bungkus kedua-duanya dalam `Column` jika perlu).
4. Cuba **kedua-dua** cara papar imej:
   - `Image.network('https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg', height: 120)`
   - `Text('🇦🇺', style: TextStyle(fontSize: 40))` (emoji bendera Australia)
5. Susun ketiga-tiga widget (`Text`, `Icon`, `Image`/emoji) dalam satu `Column` supaya kelihatan tersusun menegak.

✅ **Semakan:** Ketiga-tiga widget kelihatan pada emulator/telefon tanpa ralat merah. Jika `Image.network` gagal (tiada internet semasa demo), guna emoji bendera sahaja — itu sah.

---

## Latihan 4 — `Container`, `Padding`, `Margin`, `SizedBox`: Kad Info Universiti

**Objektif:** Bina secara **manual** satu kad maklumat universiti statik, gabungan widget susun atur asas — pendahulu kepada `UniversityCard` sebenar (Hari 2).

1. Dalam `body:`, cipta satu `Container` dengan:
   - `margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8)` (jarak **LUAR**)
   - `padding: const EdgeInsets.all(16)` (jarak **DALAM**)
   - `decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14), border: Border.all(color: Colors.grey.shade300))`
2. Dalam `child:`, letak `Column(crossAxisAlignment: CrossAxisAlignment.start, children: [...])` mengandungi (guna `SizedBox(height: ...)` sebagai jarak antara setiap baris, **bukan** `Padding` berasingan setiap kali):
   - `Text('🇦🇺  University of Melbourne', ...)` — tebal, warna navy `Color(0xFF1A2B5C)`
   - `Text('Melbourne, Australia')` — warna kelabu
   - `Text('Bidang popular: Medicine, Engineering, Commerce')`
   - `Text('Anggaran yuran: RM156,000/tahun')`
   - `Text('Pelajar Malaysia (Australia, 2024): 18,348')`
3. Hot Reload — sahkan kad putih bersudut bulat dengan sempadan kelabu nipis kelihatan, kandungan tersusun kemas dengan jarak sekata antara baris.
4. **Eksperimen:** Tukar `margin` kepada `EdgeInsets.zero` sementara, perhatikan kad "melekat" ke tepi skrin — ini tunjukkan **beza** kesan `margin` (luar) berbanding `padding` (dalam) secara visual. Kembalikan semula selepas cuba.

✅ **Semakan:** Banding susun atur kad anda dengan contoh dalam `README.md` bahagian "Latihan Bengkel: Kad Info Universiti (Statik)", dan dengan struktur sebenar `projek/mypelajar_ln/lib/widgets/university_card.dart` (versi Hari 2 — lebih maju, guna data dinamik & `Card`, bukan `Container` manual).

---

## Latihan 5 — StatelessWidget vs StatefulWidget: Kaunter "Simpan Destinasi"

**Objektif:** Rasa sendiri **kenapa** `StatefulWidget` + `setState()` diperlukan, melalui satu kaunter interaktif ringkas.

1. Cipta widget baharu `SavedDestinationCounter` sebagai `class ... extends StatefulWidget`, dengan `createState()` memulangkan `_SavedDestinationCounterState()`.
2. Dalam `_SavedDestinationCounterState extends State<SavedDestinationCounter>`, tambah medan `int _savedCount = 0;`.
3. Tulis kaedah `_addDestination()` yang memanggil `setState(() { _savedCount++; })`.
4. Dalam `build()`, pulangkan `Column` mengandungi `Text('Destinasi disimpan: $_savedCount')` dan `ElevatedButton(onPressed: _addDestination, child: const Text('+ Simpan Destinasi'))`.
5. Letak `SavedDestinationCounter()` sebagai `body:` `Scaffold`, `flutter run`, dan **tekan butang beberapa kali** — sahkan angka bertambah setiap kali ditekan **tanpa** perlu *restart* aplikasi.
6. **Eksperimen (penting untuk faham konsep):** Sementara, tukar `_addDestination()` supaya **hanya** `_savedCount++;` **tanpa** bungkus dalam `setState(...)`. Tekan butang lagi — perhatikan **angka pada skrin TIDAK berubah** walaupun nilai sebenarnya bertambah "di belakang tabir". Kembalikan semula `setState(...)` selepas faham kesannya.

✅ **Semakan akhir:** Kaunter bertambah setiap tekan **hanya bila** `setState()` digunakan. Anda faham beza `StatelessWidget` (`UniversityCard` Latihan 4 — statik) berbanding `StatefulWidget` (`SavedDestinationCounter` — berubah ikut interaksi).

> **Nota:** Ini **baru pengenalan**. Kitaran hayat penuh `StatefulWidget` (`initState()`, `dispose()`) dan `setState()` dalam konteks borang sebenar ialah **SESI 5, Hari 3** — jangan risau jika belum faham semua bahagian `State` lagi.

---

## Cabaran (Bonus)

Pilih **sekurang-kurangnya satu** untuk cuba selepas Latihan 5 siap:

1. **Function tukar mata wang** — Tulis `double convertTuitionToMyr(double amount, String currency)` dengan `Map<String, double>` kadar tukaran anggaran untuk sekurang-kurangnya 4 mata wang (`AUD`, `GBP`, `EGP`, `JOD`). Panggil untuk **4 universiti** (Melbourne/AUD, Imperial/GBP, Al-Azhar/EGP, Jordan/JOD) dan `print()` hasil dalam format `'<nama>: <yuran> <currency> ≈ RM<anggaran>/tahun'`. Banding jawapan anda dengan `tuitionConversionDemo()` dalam [`dart_asas.dart`](./dart_asas.dart).
2. **Enum dengan getter** — Tulis semula `enum StudyLevel` (4 nilai: `diploma`, `bachelor`, `master`, `doctorate`) dan `enum RecognitionStatus` (2 nilai: `recognised`, `checkWithMqa`), setiap satu dengan getter `label` (guna `switch` expression Dart 3) memulangkan label Bahasa Melayu. Cetak label **semua** nilai `StudyLevel.values` dalam satu gelung `for`.
3. **Kad kedua** — Ulang Latihan 4 untuk **satu lagi** universiti (cth. Kyoto University — Jepun, yuran anggaran RM16,000/tahun, bidang Engineering/Science/Economics). Susun **kedua-dua** kad dalam satu `Column` supaya kelihatan berturutan pada skrin.
4. **Kaunter dua arah** — Tambah **dua** butang pada `SavedDestinationCounter`: satu `+` (tambah) dan satu `-` (tolak), dengan syarat `_savedCount` **tidak boleh** jadi negatif (guna `if (_savedCount > 0)` sebelum tolak dalam `setState()`).
5. **Switch bilangan negara** — Tulis function `String kategoriBilanganPelajar(int bilangan)` yang guna `switch` **expression** dengan corak julat (*pattern* + `when` guard, Dart 3) atau rantaian `if/else` untuk pulangkan `'Sangat Ramai'` (≥10,000), `'Ramai'` (≥2,000), `'Sederhana'` (≥500), atau `'Sedikit'` (<500) berdasarkan `pelajarMengikutNegara` — panggil untuk semua 12 negara.

> Tiada jawapan "betul" tunggal untuk Cabaran — matlamatnya berlatih gabungkan konsep yang sudah dipelajari. Tunjukkan hasil kepada fasilitator/rakan sekelas sebelum tamat kelas.

---

## Rujukan Fail Sebenar

Untuk banding kod anda, fail rujukan lengkap (hasil akhir 5 hari) ada di:

| Fail anda (lab) | Fail rujukan (projek sebenar) |
|------------------|-------------------------------|
| Dart operators/control flow/loops (Latihan 1–2) | [`dart_asas.dart`](./dart_asas.dart) — boleh jalan terus (`dart run snippets/dart_asas.dart`) |
| Widget `Text`/`Icon`/`Image` (Latihan 3) | `projek/mypelajar_ln/lib/widgets/university_card.dart` (bahagian atas) |
| `enum StudyLevel`/`RecognitionStatus` (Cabaran #2) | `projek/mypelajar_ln/lib/models/overseas_university.dart` |
| Kad info universiti (Latihan 4) | `projek/mypelajar_ln/lib/widgets/university_card.dart` (versi Hari 2 — lebih maju) |
| Kaunter Stateful (Latihan 5) | *(tiada padanan terus — teaser konsep sahaja; `setState()` penuh di SESI 5, Hari 3)* |
| Data statistik 12 negara | `nota-spec` domain (lihat jadual dalam `README.md`) |

> Lihat juga [`dart_asas.dart`](./dart_asas.dart) untuk contoh Dart penuh yang boleh dijalankan terus (`dart run snippets/dart_asas.dart`) — berguna untuk berlatih sintaks Dart di luar konteks widget Flutter.
