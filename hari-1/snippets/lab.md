# Lab Hari 1 — Widget & Senarai Biasiswa

Lab ini mengiringi [`README.md`](../README.md) Hari 1. Ikut latihan **secara berurutan** — setiap latihan bina di atas latihan sebelumnya. Rujuk projek akhir sebenar di `projek/mybiasiswa_kpt/lib/` untuk **banding** jawapan anda selepas cuba sendiri dahulu.

> **Peraturan lab:** Cuba tulis kod **sendiri** dahulu berdasarkan penerangan dalam README sebelum tengok fail rujukan. Belajar Flutter paling berkesan dengan **taip kod sendiri**, bukan salin-tampal.

---

## Senarai Semak Persediaan (Setup Checklist)

Sebelum mula Latihan 0, pastikan semua berikut sudah **✓**:

- [ ] `flutter --version` berjaya dijalankan dalam terminal
- [ ] `flutter doctor` — tiada tanda `[✗]` kritikal (Android toolchain & VS Code sekurangnya `[✓]`)
- [ ] VS Code dipasang dengan sambungan **Flutter** (dan **Dart** — dipasang automatik sekali)
- [ ] Emulator Android boleh dimulakan **ATAU** telefon sebenar disambung dengan USB debugging aktif
- [ ] `flutter devices` menyenaraikan sekurang-kurangnya satu peranti

Jika ada yang belum ✓, rujuk semula **Bahagian 1 — Persediaan** dalam `README.md` sebelum teruskan.

---

## Latihan 0 — Orientasi Projek

**Objektif:** Kenal pasti struktur projek sebenar sebelum mula menulis kod sendiri.

1. Buka folder `projek/mybiasiswa_kpt/` dalam VS Code (tab baharu, atau `code projek/mybiasiswa_kpt`).
2. Buka `pubspec.yaml` — cari baris `name:` dan `dependencies:`. Berapa banyak *package* luaran disenaraikan? (Petunjuk: `provider`, `shared_preferences`, `http`, `intl`.)
3. Buka `lib/main.dart` — cari fungsi `main()`. Apakah widget pertama yang dihantar ke `runApp()`?
4. Senaraikan **semua** fail dalam folder `lib/screens/` — berapa banyak skrin ada dalam aplikasi **akhir** (selepas 5 hari)?
5. Bandingkan dengan apa yang akan kita bina **hari ini sahaja** — hanya `main.dart`, `theme.dart`, satu model, satu widget kad, dan satu skrin senarai.

> **Soalan renungan:** Kenapa projek akhir jauh lebih besar daripada apa yang kita bina hari ini? (Jawapan: kita bina **berperingkat** — setiap hari tambah satu lapisan ciri baharu di atas asas yang kukuh.)

---

## Latihan 1 — Cipta Projek & Larikan Aplikasi Lalai

**Objektif:** Pastikan persekitaran anda benar-benar berfungsi hujung ke hujung.

1. Dalam terminal, navigasi ke folder kerja anda (bukan di dalam repo kursus — buat folder projek berasingan, cth. `~/flutter-projects/`).
2. Cipta projek baharu:

   ```bash
   flutter create mybiasiswa_kpt
   cd mybiasiswa_kpt
   ```

3. Jalankan aplikasi:

   ```bash
   flutter run
   ```

4. Tunggu sehingga aplikasi lalai (contoh kaunter "You have pushed the button this many times") muncul pada emulator/telefon anda.
5. **Uji Hot Reload:** Buka `lib/main.dart`, cari teks `'You have pushed the button this many times:'`, tukar kepada teks lain, simpan (`Ctrl+S`), dan perhatikan skrin berubah tanpa aplikasi *restart*.

✅ **Semakan:** Aplikasi berjalan tanpa ralat merah pada skrin, dan Hot Reload berfungsi.

---

## Latihan 2 — Tema Jenama KPT

**Objektif:** Gantikan tema Material lalai dengan tema navy + gold KPT.

1. Cipta fail `lib/theme.dart`.
2. Tulis kelas `KptTheme` dengan:
   - `static const Color navy = Color(0xFF1A2B5C);`
   - `static const Color gold = Color(0xFFD4A017);`
   - `static const Color bgLight = Color(0xFFF5F6FA);`
   - Getter `static ThemeData get light` yang memulangkan `ThemeData` dengan `useMaterial3: true`, `colorScheme` dijana daripada `ColorScheme.fromSeed(seedColor: navy, primary: navy, secondary: gold)`, dan `appBarTheme` berwarna navy.
3. Dalam `main.dart`, ganti `MyApp` supaya `MaterialApp` guna `theme: KptTheme.light` dan `debugShowCheckedModeBanner: false`.
4. Kekalkan `Scaffold` ringkas dengan `AppBar(title: Text('MyBiasiswa KPT'))` dan `body: Center(child: Text('Selamat datang!'))` buat sementara.
5. Hot Reload — sahkan `AppBar` kini **navy**, bukan ungu/biru lalai Material.

✅ **Semakan:** Bandingkan `lib/theme.dart` anda dengan `projek/mybiasiswa_kpt/lib/theme.dart`. Sepatutnya hampir sama.

---

## Latihan 3 — Model `Scholarship` & Data Contoh

**Objektif:** Bina struktur data untuk mewakili satu biasiswa, dan senarai data contoh.

1. Cipta folder `lib/models/` dan fail `lib/models/scholarship.dart`.
2. Tulis `enum ScholarshipCategory` dengan 4 nilai: `praPerkhidmatan`, `dalamPerkhidmatan`, `bantuanKewangan`, `antarabangsa` — setiap satu ada getter `label` yang memulangkan versi Bahasa Melayu (guna `switch` expression Dart 3).
3. Tulis `enum StudyLevel` dengan 6 nilai: `sijil`, `diploma`, `bachelor`, `master`, `phd`, `postDoctoral` — dengan getter `label` yang sama konsepnya.
4. Tulis `class Scholarship` dengan **15 medan `final`**: `id`, `code`, `name`, `provider`, `category`, `studyLevel`, `fieldOfStudy`, `monthlyAllowance`, `tuitionCoverage`, `minCgpa`, `maxAge`, `applicationDeadline`, `isOpen`, `description`, `requirements`, `websiteUrl`.
5. Tulis konstruktor `const Scholarship({required this.id, ...})` — **semua** parameter `required` dan **bernama** (named parameters).
6. Cipta folder `lib/data/` dan fail `lib/data/sample_scholarships.dart`. Salin **kesemua 8 entri** biasiswa daripada `projek/mybiasiswa_kpt/lib/data/sample_scholarships.dart` (MyBrainSc, MyBrain 2.0, Biasiswa Yang di-Pertuan Agong, HLP, SLAI, BKOKU, BKPKK, Malaysia International Scholarship).
7. Tambah `intl: ^0.19.0` di bawah `dependencies:` dalam `pubspec.yaml`, kemudian jalankan `flutter pub get`.

✅ **Semakan:** Kod anda sepatutnya *compile* tanpa ralat (`flutter analyze` tiada isu merah). Bandingkan medan & susunan dengan `projek/mybiasiswa_kpt/lib/models/scholarship.dart`.

---

## Latihan 4 — Widget `ScholarshipCard`

**Objektif:** Bina satu widget yang memaparkan ringkasan satu biasiswa dalam bentuk kad.

1. Cipta folder `lib/widgets/` dan fail `lib/widgets/scholarship_card.dart`.
2. Tulis `class ScholarshipCard extends StatelessWidget` dengan konstruktor `const ScholarshipCard({super.key, required this.scholarship, this.onTap})`.
3. Dalam `build()`, pulangkan `Card` yang mengandungi (guna `Column` + `Row` bersarang):
   - **Baris 1:** nama biasiswa (`Expanded(child: Text(...))`) + pill status "Dibuka"/"Tutup" berwarna hijau/merah bergantung `scholarship.isOpen`.
   - **Baris 2:** `scholarship.fieldOfStudy` dalam teks kecil kelabu.
   - **Baris 3:** dua pill — kategori (`scholarship.category.label`) dan peringkat (`scholarship.studyLevel.label`).
   - **Baris 4:** elaun bulanan diformat RM (guna `NumberFormat.currency(locale: 'ms_MY', symbol: 'RM', decimalDigits: 0)`) di kiri, tarikh tutup diformat (`DateFormat('d MMM yyyy', 'ms')`) di kanan — guna `Row(mainAxisAlignment: MainAxisAlignment.spaceBetween)`.
4. Bungkus kandungan dengan `InkWell(onTap: onTap, child: Padding(...))` supaya kad boleh diketuk (walaupun `onTap` belum digunakan sepenuhnya hari ini).
5. Cipta widget kecil `_Pill` (private) untuk elak ulang kod cip berwarna.

✅ **Semakan:** Bandingkan dengan `projek/mybiasiswa_kpt/lib/widgets/scholarship_card.dart`.

> **Petunjuk format RM/tarikh:** Jangan lupa `import 'package:intl/intl.dart';` di atas fail. Jika `DateFormat('d MMM yyyy', 'ms')` bermasalah (locale `ms` belum dimuat), untuk lab hari ini boleh guna `DateFormat('d MMM yyyy')` sahaja (tanpa locale) — kita akan muatkan locale Bahasa Melayu penuh dalam `main()` pada hari-hari seterusnya.

---

## Latihan 5 — Skrin Senarai dengan `ListView.builder`

**Objektif:** Gabungkan semua — papar 8 biasiswa dalam senarai boleh skrol.

1. Cipta folder `lib/screens/` dan fail `lib/screens/scholarship_list_screen.dart`.
2. Tulis `class ScholarshipListScreen extends StatelessWidget` yang dalam `build()` memulangkan `ListView.builder(itemCount: sampleScholarships.length, itemBuilder: (context, index) => ScholarshipCard(scholarship: sampleScholarships[index]))`.
3. Kemas kini `main.dart` — dalam `Scaffold`, tukar `body:` daripada `Center(...)` kepada `const ScholarshipListScreen()`.
4. Hot Reload / `flutter run` semula — sahkan senarai **8 kad biasiswa** kelihatan dan **boleh diskrol**.
5. Uji: skrol sampai bawah — kad terakhir sepatutnya "Malaysia International Scholarship".

✅ **Semakan akhir:** Aplikasi anda kini sepatutnya kelihatan **sama** dengan `projek/mybiasiswa_kpt` apabila dijalankan (tanpa bar carian/cip tapisan — itu Hari 3). Jalankan `flutter analyze` — pastikan tiada ralat.

---

## Cabaran (Bonus)

Pilih **sekurang-kurangnya satu** untuk cuba selepas Latihan 5 siap:

1. **Badge kiraan** — Tambah `Text('${sampleScholarships.length} biasiswa dijumpai')` kecil di bawah `AppBar` (atas senarai), guna `Column` untuk susun teks kiraan + `Expanded(child: ListView.builder(...))` di bawahnya.
2. **Susun atur kad berbeza** — Ubah `ScholarshipCard` supaya ikon `Icons.payments_outlined` dan jumlah elaun dipaparkan di **penjuru kanan atas** kad (bukan baris bawah), guna `Stack` atau susun semula `Row`/`Column`.
3. **Warna status dinamik** — Tambah kes ketiga untuk pill status: jika `applicationDeadline` sudah lepas (`DateTime.now().isAfter(scholarship.applicationDeadline)`) tetapi `isOpen` masih `true`, papar "Tamat Tempoh" berwarna oren dan bukan "Dibuka" hijau.
4. **Ikon kategori** — Petakan setiap `ScholarshipCategory` kepada satu `IconData` berbeza (cth. `praPerkhidmatan` → `Icons.school`, `antarabangsa` → `Icons.public`) dan paparkan di sebelah nama biasiswa.
5. **Susun senarai** — Sebelum hantar ke `ListView.builder`, cipta senarai baharu yang disusun (`sorted`) mengikut `applicationDeadline` paling hampir dahulu, guna `List.of(sampleScholarships)..sort((a, b) => a.applicationDeadline.compareTo(b.applicationDeadline))`.

> Tiada jawapan "betul" tunggal untuk Cabaran — matlamatnya berlatih gabungkan widget yang sudah dipelajari. Tunjukkan hasil kepada fasilitator/rakan sekelas sebelum tamat kelas.

---

## Rujukan Fail Sebenar

Untuk banding kod anda, fail rujukan lengkap (hasil akhir 5 hari) ada di:

| Fail anda (lab) | Fail rujukan (projek sebenar) |
|------------------|-------------------------------|
| `lib/theme.dart` | `projek/mybiasiswa_kpt/lib/theme.dart` |
| `lib/models/scholarship.dart` | `projek/mybiasiswa_kpt/lib/models/scholarship.dart` |
| `lib/data/sample_scholarships.dart` | `projek/mybiasiswa_kpt/lib/data/sample_scholarships.dart` |
| `lib/widgets/scholarship_card.dart` | `projek/mybiasiswa_kpt/lib/widgets/scholarship_card.dart` |
| `lib/screens/scholarship_list_screen.dart` | `projek/mybiasiswa_kpt/lib/screens/scholarship_list_screen.dart` (versi lebih maju — ada carian & tapisan, Hari 3) |

> Lihat juga [`dart_asas.dart`](./dart_asas.dart) dalam folder ini untuk contoh Dart asas yang boleh dijalankan terus (`dart run snippets/dart_asas.dart`) — berguna jika anda mahu berlatih sintaks Dart di luar konteks widget Flutter.
