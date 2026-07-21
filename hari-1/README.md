# Hari 1 — Aliran Kawalan Dart & Widget Asas

Panduan langkah demi langkah untuk hari pertama kursus **Latihan Secara *Coaching* Aplikasi Mobil Bagi Sistem Pendidikan Tinggi Luar Negara Menggunakan Flutter** (Kementerian Pendidikan Tinggi/KPT, 20–24 Julai 2026). Nota ini mengikut **aturcara rasmi SESI 1** — lihat [`JADUAL.md`](../JADUAL.md) — bukan susunan bebas.

Projek kursus: **eTT Mobile** — companion latihan untuk sistem sebenar **e-Timur Tengah (eTT)**, Bahagian Pengantarabangsaan Pendidikan Tinggi (BPPT), KPT — permohonan pelajar Malaysia ke universiti di **Mesir** & **Maghribi (Morocco)**.

> **Nota untuk pemula:** Anda tidak perlu tahu Flutter atau Dart langsung. Setiap langkah diterangkan perlahan-lahan — termasuk **kenapa** setiap konsep wujud, bukan sekadar sintaksnya.

> **Konvensyen kod:** Penerangan dalam nota ini ditulis dalam **Bahasa Melayu**, tetapi semua kod, nama kelas/pembolehubah dan komen dalam fail `.dart` ditulis dalam **Bahasa Inggeris** — amalan standard industri Flutter/Dart yang kita ikut sepanjang kursus.

> **Cara guna nota ini:** Bahagian ini menerangkan **konsep** — kenapa sesuatu API wujud, apa ia buat, dan apa hasilnya. Latihan hands-on **langkah demi langkah** (dengan rangka kod penuh untuk taip sendiri) ada di [`snippets/lab.md`](./snippets/lab.md). Baca bahagian yang sepadan di sini dahulu, kemudian pindah ke lab untuk cuba sendiri.

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
   flutter create ett_mobile
   cd ett_mobile
   flutter run
   ```

   Jika aplikasi lalai (kaunter "+1") berjaya berjalan pada emulator/telefon — **persekitaran anda sedia**. Biarkan projek ini terbuka; kita akan edit `lib/main.dart` sepanjang sesi hari ini.

> Projek **rujukan penuh** (hasil akhir 5 hari) sudah disediakan di `projek/ett_mobile/` dalam repo ini. Jangan salin terus — kita bina **dari kosong**, berperingkat, sepanjang minggu supaya faham setiap baris. Boleh buka fail di sana untuk **banding** kod anda selepas setiap latihan.

Senarai semak penuh (dengan lokasi fail rujukan untuk banding) ada di [`snippets/lab.md`](./snippets/lab.md) bahagian "Senarai Semak Persediaan" — mulakan lab dari situ selepas baca bahagian konsep di bawah.

---

## SESI 1 (Pagi, 9.00 – 1.00) — Aliran Kawalan Dart

Sebelum sentuh sebarang widget, kita perlu selesa dengan **sintaks asas Dart** — bahasa pengaturcaraan di sebalik Flutter. Bahagian ini **tidak perlukan Flutter langsung**; kita akan tulis & jalankan kod Dart tulen dahulu, sama ada dalam [DartPad](https://dartpad.dev) (pelayar, tiada pemasangan) atau terus dalam terminal (`dart run`).

**Kenapa mula dengan Dart, bukan terus widget Flutter?** Setiap widget Flutter — tanpa kecuali — hanyalah satu `class` Dart. `Text('Hello')` yang kelihatan "ajaib" di skrin sebenarnya cuma pemanggilan constructor kelas Dart biasa. Jika asas Dart (pembolehubah, syarat, gelung, function) lemah, kod Flutter akan kelihatan seperti "hafalan sintaks pelik" tanpa anda faham **kenapa** ia begitu. Sebaliknya, jika Dart kukuh dahulu, widget Flutter jadi natural — anda hanya belajar **kelas-kelas baharu** dalam bahasa yang sudah anda faham.

> **Cadangan kelas:** buka [dartpad.dev](https://dartpad.dev) di tab pelayar berasingan — setiap contoh kod di bawah boleh ditampal terus dan diklik **Run** tanpa perlu tunggu `flutter run`/emulator. Ini jimat masa semasa bereksperimen. (Ini juga Latihan 0 dalam [lab](./snippets/lab.md).)

### Operators (Pengendali)

Dart menyokong pengendali standard: aritmetik, bandingan, logik, dan tugasan gabungan (*compound assignment*). Pengendali ini ialah **blok binaan** setiap syarat (`if`) dan pengiraan yang akan kita tulis sepanjang minggu — memahami mereka sekarang menjimatkan banyak kekeliruan kemudian.

```dart
const int kuotaEtt001 = 40;   // arithmetic: pemalar — Al-Azhar, Perubatan
const int kuotaEtt003 = 80;   // Al-Azhar, Ulum Islamiah

print(kuotaEtt001 + kuotaEtt003);              // + (tambah)
print(kuotaEtt003 > kuotaEtt001);              // > (bandingan)

const double kosFarmasiSetahun = 36000;        // RM, ilustrasi — ETT-004
const int tempohPengajianTahun = 5;
final double anggaranKosKeseluruhan = kosFarmasiSetahun * tempohPengajianTahun; // *

final bool dalamBajet = anggaranKosKeseluruhan <= 200000; // <=
const bool sijilLengkap = true;
print(dalamBajet && sijilLengkap);              // && (logik DAN)

int kiraan = 0;
kiraan += 1;   // tugasan gabungan
kiraan *= 3;
print(kiraan);
```

**Apa yang anda patut nampak** (tekan Run di DartPad, atau `dart run`):

```
120
true
true
3
```

- `120` — `kuotaEtt001 + kuotaEtt003` = `40 + 80`.
- `true` — `80 > 40` (ETT-003 memang ada kuota lebih besar).
- `true` — `anggaranKosKeseluruhan` = `36000 * 5` = `180000`, dan `180000 <= 200000` = `true`; `true && true` = `true`.
- `3` — `kiraan` mula `0`, `+= 1` jadi `1`, `*= 3` jadi `3`.

| Kategori | Contoh | Maksud |
|----------|--------|--------|
| Aritmetik | `+ - * / ~/ %` | tambah, tolak, darab, bahagi, bahagi integer, baki |
| Bandingan | `== != > < >= <=` | pulangkan `bool` |
| Logik | `&& \|\| !` | DAN, ATAU, TIDAK |
| Tugasan gabungan | `+= -= *= /= ??=` | kemas kini nilai pembolehubah terus |

**Perangkap tersembunyi: `/` sentiasa `double`.** `9 / 2` di Dart memulangkan `4.5` (jenis `double`) — **bukan** `4` — walaupun kedua-dua `9` dan `2` ialah `int`. Jika anda mahu hasil integer (`4`), guna `~/` (bahagi integer): `9 ~/ 2` → `4`. Ramai pemula terperangkap di sini kerana bahasa lain (cth. Java, C) beri `int / int` hasil `int` secara automatik.

> Rujukan rasmi: [dart.dev/language/operators](https://dart.dev/language/operators)

> Terjumpa operator yang tak biasa (contoh `~/` atau `??=`) dalam kod orang lain nanti? Tanya sahaja AI (Claude Code, ChatGPT) — *"Apa beza `/` dengan `~/` dalam Dart, bagi contoh guna kuota program"* — cara pantas faham sintaks tanpa kena scroll dokumentasi rasmi setiap kali.

#### Salah biasa: Operators

| ❌ Salah | ✅ Betul | Kenapa |
|---|---|---|
| `kuota1 = kuota2` bila maksud **bandingkan** | `kuota1 == kuota2` | Satu `=` ialah **tugasan** (letak nilai kanan ke pembolehubah kiri). Dua `=` (`==`) ialah **bandingan**, pulangkan `bool`. Tertukar dua ini punca ralat logik paling biasa untuk pemula (lihat juga jadual `if`/`else` di bawah). |
| `9 / 2` bila mahu hasil integer | `9 ~/ 2` | `/` di Dart **sentiasa** pulangkan `double`. Guna `~/` untuk bahagi integer. |
| Tulis nilai tetap tanpa `const`/`final` | `const kuotaEtt001 = 40;` | Tanpa `const`/`final`, pembolehubah boleh ditulis semula tanpa sengaja di tempat lain dalam kod — punca bug senyap yang payah dikesan. |

### Control Flow — `if` / `else`

**Kenapa `if`/`else` wujud?** Aplikasi sebenar jarang buat perkara sama setiap kali — ia perlu **buat keputusan** berdasarkan data. Dalam eTT, keputusan pertama setiap pemohon ialah: adakah sijil (SPM/STAM) mereka sepadan keperluan program? `if`/`else` ialah cara Dart nyatakan "kalau syarat ini benar, buat A; kalau tidak, buat B".

```dart
const String keperluanProgram = 'stam'; // ETT-002: Syariah dan Undang-undang
const String sijilPemohon = 'spm';

if (keperluanProgram == 'both') {
  print('Program ini terima kedua-dua SPM & STAM.');
} else if (keperluanProgram == sijilPemohon) {
  print('Layak memohon — sijil sepadan keperluan program.');
} else {
  print('Tidak layak — program ini hanya terima '
      '${keperluanProgram.toUpperCase()}.');
}
```

**Apa yang anda patut nampak:**

```
Tidak layak — program ini hanya terima STAM.
```

Kenapa cabang **ketiga** (`else`) yang jalan? Dart nilai syarat **dari atas ke bawah**: `keperluanProgram == 'both'` → `'stam' == 'both'` → `false`, langkau. `keperluanProgram == sijilPemohon` → `'stam' == 'spm'` → `false`, langkau. Sampai `else` — tiada syarat lagi perlu disemak, blok ini **automatik** jalan. Sebaik sahaja **satu** syarat `true`, blok itu dijalankan dan **yang lain dilangkau** — walaupun secara teori ia juga mungkin `true`.

> **Nota realiti eTT:** Setiap permohonan sebenar hanya untuk **SATU negara + SATU bidang** (butiran penuh borang permohonan — Hari 3, SESI 4). Contoh di atas mengelabelkan `keperluanProgram` sebagai `'spm'`, `'stam'` atau `'both'` — corak sebenar model `EntryCategory` yang kita formalkan sebagai `enum` di [Cabaran #2 lab](./snippets/lab.md).

#### Salah biasa: `if`/`else`

| ❌ Salah | ✅ Betul | Kenapa |
|---|---|---|
| `if (keperluanProgram = 'stam')` | `if (keperluanProgram == 'stam')` | Sama seperti operator bandingan — `=` letak nilai, `==` bandingkan. Dart menolak kebanyakan kod sebegini pada masa **kompil** (kerana `=` bukan ekspresi `bool`), jadi ralat kelihatan awal — tapi konsepnya penting difahami sebelum tersasar ke bahasa lain yang lebih "pemaaf". |
| Letak syarat **paling luas** dahulu, syarat spesifik kemudian | Letak syarat **paling spesifik dahulu** | `if`/`else if` dinilai atas ke bawah; sebaik satu `true`, cabang lain **dilangkau** — susunan salah buat cabang lebih spesifik "tidak pernah dicapai". |

### Control Flow — `switch`

**Kenapa `switch`, bukan rantaian `if/else if` panjang?** Bila anda bandingkan **satu nilai** dengan **banyak** kemungkinan tetap (bukan julat atau syarat kompleks), rantaian `if/else if` jadi panjang dan susah dibaca. `switch` lebih kemas untuk kes ini — contohnya, memetakan **nama universiti** kepada **label negara** Bahasa Melayu:

```dart
String countryLabelForUniversity(String universityName) {
  switch (universityName) {
    case 'Universiti Al-Azhar':
    case 'Universiti Alexandria':
    case 'Universiti Ain Shams':
    case 'Universiti Tanta':
      // empat case "jatuh melalui" (fall-through) ke return yang sama
      return 'Mesir';
    case 'Universite Al Quaraouiyine':
    case 'Universiti Mohammed V':
      return 'Maghribi';
    default:
      return 'Negara tidak diketahui';
  }
}

void main() {
  const universitiUjian = [
    'Universiti Al-Azhar',
    'Universiti Alexandria',
    'Universite Al Quaraouiyine',
    'Universiti Mohammed V',
    'Universiti Kaherah', // sengaja bukan dalam senarai eTT -> default
  ];

  for (final universiti in universitiUjian) {
    print('$universiti -> ${countryLabelForUniversity(universiti)}');
  }
}
```

**Apa yang anda patut nampak:**

```
Universiti Al-Azhar -> Mesir
Universiti Alexandria -> Mesir
Universite Al Quaraouiyine -> Maghribi
Universiti Mohammed V -> Maghribi
Universiti Kaherah -> Negara tidak diketahui
```

Perhatikan `case` "jatuh melalui" (*fall-through*): empat baris `case '...'` **berturutan tanpa kod di antaranya** kongsi **satu** `return 'Mesir';` — ini cara Dart elak menulis `return 'Mesir';` empat kali berasingan. `default:` menangkap **apa-apa** nilai yang tidak sepadan mana-mana `case` — di sinilah `'Universiti Kaherah'` (sengaja bukan universiti eTT sebenar) mendarat.

> **Nota Dart 3:** Selain `switch` *statement* klasik di atas, Dart 3 juga ada **`switch` *expression*** ringkas (`=>`) — kita akan jumpa corak ini apabila menulis `enum` di [Cabaran #2 lab](./snippets/lab.md). Kedua-dua bentuk sah; `switch` statement lebih biasa untuk **logik bercabang berbilang baris**, `switch` expression untuk **pulangkan satu nilai terus**.

> Selepas tulis function macam `countryLabelForUniversity` di atas, biasakan diri **sahkan** ia dengan AI sebelum yakin 100% — tampal kod, tanya *"Adakah ada universiti dalam senarai 8 program eTT yang saya terlepas dalam switch ini?"*. Kadang AI tercapture kesilapan kecil yang mata kita dah biasa dengan kod sendiri terlepas pandang.

> Rujukan rasmi: [dart.dev/language/branches](https://dart.dev/language/branches)

#### Salah biasa: `switch`

| ❌ Salah | ✅ Betul | Kenapa |
|---|---|---|
| Lupa `default:` dalam `switch` bertaip `String`/nilai terbuka | Sentiasa sertakan `default:` bila kemungkinan nilai tidak tertutup sepenuhnya | Tanpa `default`, nilai yang tak sepadan mana-mana `case` boleh menyebabkan ralat masa jalan atau tiada apa berlaku secara senyap — kesukaran nak nyahpepijat kemudian. |
| Cuba tulis `break;` selepas setiap `case` (kebiasaan dari bahasa lain macam Java lama) | Dart **tidak** perlukan `break` eksplisit | Setiap `case` di Dart automatik berhenti (tiada fall-through tersirat). Fall-through **hanya** berlaku bila `case` **kosong** (seperti contoh di atas) — kalau `case` ada kod, ia mesti berakhir dengan `break`, `return`, `continue`, atau `throw`, jika tidak Dart beri **ralat kompil** terus (bukan senyap seperti sesetengah bahasa lain). |

### Looping — `for` & Function

**Kenapa loop & function?** eTT menawarkan **8 program** (universiti + bidang) merentasi Mesir & Maghribi — tulis kod berasingan untuk setiap satu (`print` 8 kali secara manual) tidak *scale*: tambah program ke-9 bermakna tambah kod baharu, bukan guna semula yang sedia ada. **Loop** (`for`) proses koleksi data tanpa ulang kod bagi setiap item; **function** bungkus logik supaya boleh **dipanggil semula** dengan data berlainan tanpa tulis semula.

```dart
const List<Map<String, Object>> sampleProgrammes = [
  {'id': 'ETT-001', 'universityName': 'Universiti Al-Azhar', 'quotaSeats': 40},
  {'id': 'ETT-002', 'universityName': 'Universiti Al-Azhar', 'quotaSeats': 120},
  {'id': 'ETT-003', 'universityName': 'Universiti Al-Azhar', 'quotaSeats': 80},
  {'id': 'ETT-004', 'universityName': 'Universiti Alexandria', 'quotaSeats': 30},
  {'id': 'ETT-005', 'universityName': 'Universiti Ain Shams', 'quotaSeats': 25},
  {'id': 'ETT-006', 'universityName': 'Universiti Tanta', 'quotaSeats': 20},
  {'id': 'ETT-007', 'universityName': 'Universite Al Quaraouiyine', 'quotaSeats': 15},
  {'id': 'ETT-008', 'universityName': 'Universiti Mohammed V', 'quotaSeats': 10},
];

// Function — jumlahkan quotaSeats semua program dalam senarai.
int jumlahkanKuota(List<Map<String, Object>> data) {
  int jumlah = 0;
  for (final programme in data) {   // for (... in ...)
    jumlah += programme['quotaSeats'] as int;
  }
  return jumlah;
}

void main() {
  final jumlah = jumlahkanKuota(sampleProgrammes);
  print('Jumlah kuota keseluruhan (8 program): $jumlah tempat'); // 340
}
```

**Apa yang anda patut nampak:**

```
Jumlah kuota keseluruhan (8 program): 340 tempat
```

Sahkan sendiri secara manual jika mahu: `40 + 120 + 80 + 30 + 25 + 20 + 15 + 10 = 340`. Jika angka anda **tidak** 340, semak semula data yang ditaip — inilah sebab lab minta anda taip **kesemua 8 baris** sendiri (bukan salin-tampal), supaya kesilapan ketik jadi latihan *debugging* pertama anda.

- **`function`** — blok kod dinamakan yang boleh **dipanggil semula** (`jumlahkanKuota(...)`), menerima **parameter** (`List<Map<String, Object>> data`), dan **memulangkan** nilai (`return jumlah;`) berjenis `int`.
- **`for (final programme in data)`** — bentuk `for-in`, lelar (*iterate*) setiap program dalam senarai tanpa perlu urus indeks secara manual.
- **`as int`** — `programme['quotaSeats']` bertaip `Object` generik (kerana `Map<String, Object>`); Dart tak tahu ia sebenarnya `int` sehingga anda **cast** dengan `as`. Kita elak masalah ini terus mulai Hari 2 dengan `class Programme` sebenar (medan bertaip, tiada `as` diperlukan).

> Rujukan rasmi: [dart.dev/language/loops](https://dart.dev/language/loops) · [dart.dev/language/functions](https://dart.dev/language/functions)

> Nak lebih banyak latihan `for`/function sebelum move on? Minta AI: *"Beri saya 3 latihan Dart pendek pakai `for` untuk kira purata `quotaSeats` daripada senarai program, tahap pemula"* — cara cepat dapat soalan tambahan tanpa tunggu buku teks. Cuma ingat: taip & jalankan sendiri jawapannya, jangan sekadar baca.

### Looping — `while`

**Kenapa `while` selain `for`?** `for-in` sesuai bila anda **sudah tahu** koleksi apa hendak dilelar. `while` pula sesuai bila bilangan lelaran **tidak diketahui terlebih dahulu**, atau syarat berhenti bergantung pada sesuatu yang berubah semasa gelung berjalan (cth. "ulang sehingga jumpa data yang dicari" atau "ulang sehingga pengguna tekan berhenti").

```dart
const senaraiBidangPopular = ['Perubatan (Medicine)', 'Farmasi (Pharmacy)', 'Pergigian (Dentistry)'];

int i = 0;
while (i < senaraiBidangPopular.length) {
  print('Bidang popular #${i + 1}: ${senaraiBidangPopular[i]}');
  i++; // PENTING: jangan lupa naikkan i, jika tidak -> infinite loop
}
```

**Apa yang anda patut nampak:**

```
Bidang popular #1: Perubatan (Medicine)
Bidang popular #2: Farmasi (Pharmacy)
Bidang popular #3: Pergigian (Dentistry)
```

> **Kesilapan biasa pemula:** Lupa `i++` (atau apa-apa yang mengubah syarat `while`) menyebabkan **infinite loop** — program "tersangkut" selama-lamanya kerana `i < senaraiBidangPopular.length` kekal `true` untuk selamanya. Kalau ini berlaku dalam DartPad, klik **Stop**; dalam terminal, tekan `Ctrl+C`. Sentiasa sahkan syarat berhenti akan tercapai **sebelum** jalankan gelung `while`.

#### Salah biasa: Looping

| ❌ Salah | ✅ Betul | Kenapa |
|---|---|---|
| Lupa `i++` (atau apa-apa langkah mengubah syarat) dalam `while` | Sentiasa ubah syarat berhenti dalam badan gelung | Punca **infinite loop** — rujuk demo `whileDemo()` dalam [`dart_asas.dart`](./snippets/dart_asas.dart). |
| `programme['quotaSeats']` tanpa `as int` pada `Map<String, Object>` | `programme['quotaSeats'] as int` | Jenis nilai `Map<String, Object>` ialah `Object` generik — operasi macam `+=` gagal kompil tanpa **cast** eksplisit. |
| Guna `for (int i = 0; i < data.length; i++)` bila cuma perlukan **nilai** setiap elemen (bukan indeks) | `for (final programme in data)` (`for-in`) | Bentuk `for-in` lebih ringkas & kurang ruang untuk **off-by-one error** (cth. `<=` tertukar `<`) bila indeks tak diperlukan. |

> **Ringkasan setakat ini — Aliran Kawalan Dart.** Anda kini boleh: (1) guna operator aritmetik/bandingan/logik untuk kira & bandingkan nilai, (2) tulis `if`/`else` untuk keputusan bersyarat, (3) tulis `switch` untuk pemetaan satu nilai kepada banyak hasil tetap, (4) guna `for`/`while` untuk proses koleksi data berulang, dan (5) bungkus logik dalam `function` yang boleh dipanggil semula. Ini **asas** setiap baris kod Flutter yang akan anda tulis sepanjang minggu — widget hanyalah `class` Dart yang guna semua konsep ini di dalam `build()`. Latihan penuh: [Latihan 1–2 dalam lab](./snippets/lab.md#latihan-1--operators--control-flow-ifelse-switch), kod boleh jalan terus: [`dart_asas.dart`](./snippets/dart_asas.dart) (`dart run snippets/dart_asas.dart`).

---

## Anatomi Widget — Kenapa "Semuanya Widget"?

Sebelum sentuh `Text`, `Icon`, `Image` secara praktikal, penting fahami **struktur asas** setiap aplikasi Flutter — konsep yang berulang **setiap hari** sepanjang kursus.

**Semuanya widget.** Dalam Flutter, bukan sahaja elemen visual (teks, butang, ikon) yang widget — malah **susun atur** (`Column`, `Row` — Hari 2), **jarak** (`Padding`, `SizedBox` — petang ini), **tema** (`Theme`), navigasi antara "skrin" (Hari 3), dan malah **keseluruhan aplikasi** (`MaterialApp`) itu sendiri adalah widget. Falsafah ini (dipanggil "*everything is a widget*") bermaksud anda hanya perlu kuasai **satu** corak asas — kelas Dart dengan kaedah `build()` — dan corak itu terpakai di mana-mana sahaja dalam Flutter, dari teks paling ringkas hinggalah skrin borang permohonan yang kompleks di Hari 3.

**Widget tree (pepohon widget).** Setiap widget boleh ada widget lain sebagai anak (parameter `child` untuk **satu** anak, `children` untuk **senarai** anak), membentuk struktur macam pepohon:

```
MaterialApp
  └─ Scaffold
       ├─ AppBar
       │    └─ Text('eTT Mobile')
       └─ Center
            └─ Column
                 ├─ Text('Universiti Al-Azhar')
                 ├─ Icon(Icons.school)
                 └─ Text('🇪🇬')
```

Bila anda tulis kod bersarang (`Scaffold(appBar: AppBar(...), body: Center(child: Column(children: [...])))`), anda sebenarnya **melukis** pepohon ini dalam bentuk kod — setiap tahap lekukan (*indentation*) dalam kod sepadan dengan satu tahap dalam pepohon.

**Kaedah `build()`.** Setiap widget mesti "tahu" bagaimana ia hendak dilukis — itulah tugas kaedah `build(BuildContext context)`. Flutter panggil `build()` bila-bila masa widget itu perlu **dilukis semula**: kali pertama aplikasi bermula, atau selepas `setState()` dipanggil (lihat bahagian StatefulWidget di penghujung hari ini). `build()` sentiasa **memulangkan** satu widget (yang, pada gilirannya, mungkin ada banyak widget anak bersarang di dalamnya) — sebab itulah `build()` hampir selalu berbentuk `return SomeWidget(child: AnotherWidget(...));`.

> **Kenapa penting fahami ini sekarang?** Sepanjang 5 hari, kod yang anda tulis **hanyalah** susunan widget bersarang yang makin kompleks — Hari 2 tambah `Row`/`Column`/`ListView`, Hari 3 tambah navigasi antara "skrin" (yang sebenarnya cuma widget lain di belakang tabir), Hari 4–5 sambung data luaran ke widget yang sama. Kalau anda faham widget tree & `build()` sekarang, setiap hari seterusnya jadi "tambah lebih banyak cabang pada pepohon yang sama", bukan konsep baharu setiap kali.

---

## SESI 1 (Pagi, sambungan) — Eksperimen Widget Asas: Text, Icon, Image

Sekarang kita beralih dari Dart tulen ke **Flutter**. Buka `lib/main.dart` dalam projek `ett_mobile` yang anda cipta semasa Persediaan, dan gantikan kandungannya:

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
        appBar: AppBar(title: const Text('eTT Mobile')),
        body: const Center(child: Text('Selamat datang!')),
      ),
    );
  }
}
```

Simpan (`Ctrl+S`) — dengan `flutter run` masih berjalan, ini akan **Hot Reload** automatik. **Apa yang anda patut nampak:** satu skrin dengan bar biru lalai (`AppBar`) bertulis "eTT Mobile" di atas, dan teks "Selamat datang!" di tengah-tengah skrin putih di bawahnya. (`class MyApp extends StatelessWidget` di sini ialah contoh **pertama** anda sebenar sebuah widget — kita bedah konsep `StatelessWidget` penuh di penghujung hari ini.)

Sekarang cuba tiga widget paparan paling asas dalam Flutter, satu demi satu, dalam `body:`.

### `Text` — papar teks

**Kenapa `Text` perlukan `TextStyle` berasingan, bukan parameter terus?** Flutter pisahkan **kandungan** (`'Universiti Al-Azhar'`) daripada **rupa** (saiz, warna, berat fon) secara sengaja — corak ini (kandungan vs rupa berasingan) berulang di **seluruh** Flutter (Hari 2: `ThemeData` guna corak sama pada skala aplikasi penuh).

```dart
const Text(
  'Universiti Al-Azhar',
  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
)
```

**Apa yang anda patut nampak:** teks "Universiti Al-Azhar" tebal (*bold*), lebih besar daripada teks lalai, di tengah skrin.

`style: TextStyle(...)` mengawal saiz fon, berat (*weight*), warna, dsb. — kita akan bedah `TextStyle` penuh di SESI 3 (Hari 2).

### `Icon` — ikon Material terbina-dalam

```dart
const Icon(Icons.school, size: 32, color: Color(0xFF1A2B5C))
const Icon(Icons.flag, size: 32)
```

**Apa yang anda patut nampak:** ikon topi graduasi (🎓 gaya garis, bukan emoji) warna navy `0xFF1A2B5C`, saiz 32px — sama warna dengan `KptTheme.navy` yang kita formalkan Hari 2.

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
const Text('🇪🇬', style: TextStyle(fontSize: 40)) // Mesir (Egypt)
```

**Apa yang anda patut nampak:** Cara 1 — gambar burung hantu (foto ujian rasmi Flutter) tinggi 120px, muncul **selepas** seketika (perlukan panggilan rangkaian — perlahan sedikit berbanding widget lain). Cara 2 — emoji bendera Mesir 🇪🇬 bersaiz besar (fon 40), muncul **serta-merta** kerana ia sebenarnya teks, bukan imej rangkaian.

> **Kenapa emoji bendera?** Model sebenar `Programme` dalam projek kursus (`projek/ett_mobile/lib/models/programme.dart`) ada getter `flagEmoji` yang memetakan `country` (`'Egypt'`/`'Morocco'`) kepada emoji bendera (`🇪🇬`/`🇲🇦`) — corak ringan yang elakkan keperluan muat turun/urus fail imej bendera untuk setiap negara. Kita akan guna corak ini semula di Hari 2.

> Rujukan rasmi: [api.flutter.dev/flutter/widgets/Text-class.html](https://api.flutter.dev/flutter/widgets/Text-class.html) · [api.flutter.dev/flutter/widgets/Icon-class.html](https://api.flutter.dev/flutter/widgets/Icon-class.html) · [docs.flutter.dev/cookbook/images/network-image](https://docs.flutter.dev/cookbook/images/network-image)

#### Salah biasa: `Text`/`Icon`/`Image`

| ❌ Salah | ✅ Betul | Kenapa |
|---|---|---|
| Lupa `const` di depan `Text(...)`/`Icon(...)` yang nilainya tetap | `const Text('...')` | `const` beritahu Flutter widget ini **tidak akan berubah** — Flutter boleh guna semula objek yang sama tanpa bina semula, jimat kerja. Tanpa `const`, kod masih jalan (bukan ralat), tapi `flutter analyze` akan cadangkan `prefer_const_constructors`. |
| Terlupa koma (`,`) selepas parameter/widget terakhir dalam senarai berbilang baris | Sentiasa letak koma **selepas setiap item**, termasuk yang terakhir | Dart terima *trailing comma* — bukan kosmetik sahaja, ia buat `dart format` susun setiap parameter dalam baris berasingan, kod lebih mudah baca dan diff `git` lebih bersih. Koma tertinggal antara dua widget selalunya punca skrin merah "Expected ..." pertama pemula jumpa. |
| `Image.network(...)` tanpa internet semasa demo | Guna emoji bendera (Cara 2) sebagai *fallback* selamat | `Image.network` **perlukan** sambungan internet aktif pada emulator/telefon; kalau gagal, widget papar ikon "broken image" — bukan skrin merah, tapi tetap mengganggu demo. |

**Cross-ref:** Latihan hands-on penuh (rangka `lib/main.dart`, langkah demi langkah dengan penanda `👈 TAMBAH DI SINI`) ada di [Latihan 3, lab](./snippets/lab.md#latihan-3--widget-asas-text-icon-image). Fail rujukan sebenar: `projek/ett_mobile/lib/widgets/programme_card.dart` (bahagian atas — guna `Text` untuk nama universiti/bidang).

> **Ringkasan setakat ini — Widget Paparan Asas.** `Text`, `Icon`, `Image` ialah tiga widget **paling** kerap anda guna — hampir setiap skrin sepanjang kursus mengandungi ketiga-tiganya dalam pelbagai bentuk. Anda kini faham: (1) kandungan berasingan daripada rupa (`TextStyle`), (2) ikon Material terbina-dalam tak perlukan aset luar, (3) imej boleh datang dari rangkaian (`Image.network`) atau alternatif ringan (emoji sebagai `Text`).

---

## SESI 1 (Petang, 2.30 – 5.00) — Container, Padding, Margin, SizedBox

**Kenapa perlukan widget "kotak" & "jarak" berasingan daripada `Text`/`Icon`?** Widget paparan (`Text`, `Icon`, `Image`) tahu bagaimana **melukis diri sendiri**, tetapi tidak tahu bagaimana hendak **disusun** berbanding widget lain di sekelilingnya — itulah peranan `Container` (bekas serba boleh), `Padding`/`Margin` (jarak), dan `SizedBox` (saiz/jarak tepat). Tanpa mereka, setiap widget akan melekat rapat antara satu sama lain tanpa ruang bernafas — seperti teks yang menyentuh terus tepi kertas tanpa margin.

### `Container` — kotak serba boleh

`Container` ialah widget "kotak" paling serba boleh dalam Flutter — boleh ada warna latar, saiz, sempadan (*border*), sudut bulat, dan **padding**/**margin** terbina sekali:

```dart
Container(
  padding: const EdgeInsets.all(16),
  decoration: BoxDecoration(
    color: const Color(0xFF1A2B5C), // navy — warna tema KptTheme
    borderRadius: BorderRadius.circular(12),
  ),
  child: const Text('Kotak navy', style: TextStyle(color: Colors.white)),
);
```

**Apa yang anda patut nampak:** satu kotak segi empat tepat, warna latar **navy** (`0xFF1A2B5C`), sudut bulat lembut (`borderRadius: 12`), dengan teks putih "Kotak navy" di tengahnya — ada ruang kosong 16px di sekeliling teks (kesan `padding`) sebelum sampai ke sempadan kotak.

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
);
```

**Apa yang anda patut nampak:** kotak putih bersudut bulat yang **tidak** melekat ke tepi skrin (kesan `margin` — ada jurang 12px kiri/kanan, 8px atas/bawah antara kotak dengan tepi skrin), dan teks di dalamnya **tidak** melekat ke sempadan kotak (kesan `padding` — ada jurang 16px di semua sisi antara teks dengan sempadan).

`EdgeInsets` ada beberapa konstruktor berguna: `EdgeInsets.all(16)` (semua sisi sama), `EdgeInsets.symmetric(horizontal: 12, vertical: 8)` (kiri=kanan, atas=bawah berbeza), `EdgeInsets.only(top: 8, left: 16)` (sisi tertentu sahaja).

### `SizedBox` — jarak/saiz tepat

```dart
Column(
  children: const [
    Text('Universiti Al-Azhar'),
    SizedBox(height: 12), // jarak kosong 12px — TIADA widget lain buat ini seefisien ini
    Text('Kaherah (Cairo), Mesir'),
  ],
);
```

**Apa yang anda patut nampak:** dua baris teks tersusun **menegak**, dengan jurang kosong 12px yang jelas antara keduanya — tiada garis, tiada warna, hanya ruang kosong.

`SizedBox` boleh juga guna untuk **paksa saiz tepat** widget lain (`SizedBox(width: 200, height: 50, child: ...)`), tetapi kegunaan paling lazim ialah sebagai **jarak kosong** (*spacer*) ringkas antara widget dalam `Column`/`Row`.

### Latihan Bengkel: Kad Info Program (Statik)

Mari gabungkan `Container`, `Padding`, `SizedBox`, `Text`, dan `Icon` untuk bina **secara manual** satu kad maklumat program — pendahulu (*precursor*) kepada widget `ProgrammeCard` sebenar yang kita bina Hari 2. Data diambil daripada `sample_programmes.dart` (**ETT-001**: Universiti Al-Azhar, Perubatan):

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
        '🇪🇬  Universiti Al-Azhar',
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF1A2B5C)),
      ),
      SizedBox(height: 4),
      Text('Kaherah (Cairo), Mesir', style: TextStyle(color: Colors.grey)),
      SizedBox(height: 12),
      Text('Bidang: Perubatan (Medicine)'),
      SizedBox(height: 4),
      Text('Anggaran yuran: RM23,000/tahun (ilustrasi)'),
      SizedBox(height: 4),
      Text('Kuota (ilustrasi): 40 tempat · Pengambilan: September'),
    ],
  ),
);
```

Tampal kod ini sebagai `body:` `Scaffold` anda (atau dalam `Center(child: ...)`) dan Hot Reload. **Apa yang anda patut nampak:** satu **kad putih bersudut bulat** dengan sempadan kelabu nipis, tergantung dengan jurang kosong dari tepi skrin (kesan `margin`). Di dalam kad — dari atas ke bawah, dijajarkan ke **kiri** (`crossAxisAlignment: CrossAxisAlignment.start`) — teks navy tebal "🇪🇬 Universiti Al-Azhar", diikuti teks kelabu kecil "Kaherah (Cairo), Mesir", kemudian empat baris maklumat (bidang, yuran, kuota) dengan jurang kecil (`SizedBox(height: 4)`) antara setiap baris.

> **Intip Hari 2:** Kad statik ini akan jadi widget `ProgrammeCard` yang **boleh guna semula** (*reusable*) untuk **8 program**, dipaparkan dalam senarai skrol — kita belum sentuh `ListView`/`Card` hari ini, jadi buat masa ini kita hanya bina **satu** kad secara manual untuk faham struktur `Container`/`Padding`/`SizedBox` dahulu.

#### Salah biasa: `Container`/`Padding`/`Margin`/`SizedBox`

| ❌ Salah | ✅ Betul | Kenapa |
|---|---|---|
| `children: Text('...')` (letak satu widget terus, bukan senarai) | `children: [Text('...')]` **atau** `child: Text('...')` | `Column`/`Row` guna parameter **`children`** (jamak, jenis `List<Widget>`); `Container`/`Padding`/`Center` guna **`child`** (tunggal, satu `Widget`). Tertukar dua ini ialah antara ralat kompil paling kerap pemula Flutter jumpa — mesej ralatnya biasanya *"The argument type 'Text' can't be assigned to the parameter type 'List\<Widget\>'"*. |
| `EdgeInsets.all(16)` bila mahu jarak **berbeza** kiri-kanan vs atas-bawah | `EdgeInsets.symmetric(horizontal: 16, vertical: 8)` | `.all()` guna **satu** nilai untuk keempat-empat sisi. Jika kad kelihatan "terlalu tinggi" atau "terlalu lebar" berbanding rekaan, besar kemungkinan patut guna `.symmetric` atau `.only`. |
| Fikir `margin` dan `padding` boleh tukar ganti | Ingat: `padding` = **DALAM**, `margin` = **LUAR** | Konsep paling kerap tersilap pemula minggu pertama — rujuk jadual & eksperimen `margin`/`padding` di atas. |
| Lupa koma selepas item terakhir dalam `children: [...]` yang panjang | Sentiasa koma selepas **setiap** item | Sama seperti bahagian `Text`/`Icon`/`Image` di atas — trailing comma bukan hiasan, ia mengelakkan ralat sintaks bila anda tambah item baharu di baris seterusnya. |

**Cross-ref:** Latihan hands-on penuh (rangka `Container` kosong → tambah `decoration` → isi kad → eksperimen `margin`/`padding` → asingkan jadi widget `ProgrammeInfoCard`) ada di [Latihan 4, lab](./snippets/lab.md#latihan-4--container-padding-margin-sizedbox-kad-info-program). Fail rujukan sebenar (versi lebih maju, data dinamik + `Card`): `projek/ett_mobile/lib/widgets/programme_card.dart`.

> **Ringkasan setakat ini — Susun Atur & Jarak.** `Container` ialah kotak serba boleh (warna, sempadan, sudut bulat, padding/margin terbina). `padding` = jarak **dalam**, `margin` = jarak **luar** — dua konsep berbeza arah yang mudah tertukar pada minggu pertama. `SizedBox` ialah cara paling ringkas untuk jarak kosong tetap antara widget dalam `Column`/`Row`. Ketiga-tiganya digabung untuk hasilkan satu kad maklumat program yang kemas — corak yang kita ulang & perhalusi **setiap** hari seterusnya.

---

## SESI 1 (Petang) — StatelessWidget vs StatefulWidget

**Kenapa Flutter perlukan DUA jenis widget asas?** Sesetengah UI — seperti kad info program di atas — **tidak pernah berubah** selepas ia dibina; ia hanya papar data yang diberi. Tetapi sesetengah UI **mesti** berubah akibat interaksi pengguna — kaunter yang bertambah bila butang ditekan, borang yang papar ralat validasi semasa anda menaip (Hari 3). Flutter perlukan cara **eksplisit** untuk membezakan dua situasi ini, supaya ia tahu **bila** perlu lukis semula sesuatu widget dan bila tidak — itulah `StatelessWidget` lawan `StatefulWidget`.

Dua jenis widget asas yang anda akan tulis **setiap hari** sepanjang kursus:

| | `StatelessWidget` | `StatefulWidget` |
|---|---|---|
| **Bila guna** | UI **tidak berubah** selepas dibina (atau hanya bergantung pada data luaran yang diterima) | UI **perlu berubah** akibat interaksi pengguna atau data dalaman (cth. tekan butang, taip teks) |
| **Contoh dalam projek kita** | `ProgrammeCard` (papar sahaja — Hari 2) | Kaunter interaksi, borang permohonan (Hari 3) |
| **Cara ia berfungsi** | Satu kaedah `build()` sahaja | Ada objek `State` berasingan yang menyimpan data (*state*) & kaedah `setState()` untuk beritahu Flutter "lukis semula" |
| **Struktur kod** | `class Foo extends StatelessWidget { @override Widget build(...) { ... } }` | `class Foo extends StatefulWidget { @override State<Foo> createState() => _FooState(); }` diikuti `class _FooState extends State<Foo> { ... }` |

> **Analogi:** `StatelessWidget` seperti gambar bercetak — sekali dicetak, tidak berubah. `StatefulWidget` seperti papan tanda LED — ia boleh dikemas kini bila-bila masa (`setState()` = "tekan butang kemas kini papan").

### Teaser: Kaunter "Simpan Program"

Kita **belum** masuk mendalam kitaran hayat (*lifecycle*) penuh `setState()` — itu **SESI 5 (Hari 3)**. Tetapi mari lihat sepintas lalu **kenapa** `StatefulWidget` wujud, dengan satu kaunter ringkas — "berapa program telah anda simpan (bookmark)":

```dart
class SavedProgrammeCounter extends StatefulWidget {
  const SavedProgrammeCounter({super.key});

  @override
  State<SavedProgrammeCounter> createState() => _SavedProgrammeCounterState();
}

class _SavedProgrammeCounterState extends State<SavedProgrammeCounter> {
  int _savedCount = 0; // data yang boleh BERUBAH sepanjang widget ini hidup

  void _addProgramme() {
    setState(() {
      _savedCount++; // beritahu Flutter: "data berubah, lukis semula build()"
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text('Program disimpan: $_savedCount'),
        const SizedBox(height: 8),
        ElevatedButton(
          onPressed: _addProgramme,
          child: const Text('+ Simpan Program'),
        ),
      ],
    );
  }
}
```

Tampal `SavedProgrammeCounter()` sebagai `body:` dan cuba tekan butang berulang kali. **Apa yang anda patut nampak:** teks "Program disimpan: 0" pada mulanya, dengan satu butang berlabel "+ Simpan Program" di bawahnya. Setiap kali butang ditekan, angka dalam teks **bertambah serta-merta** (`0` → `1` → `2` → ...) — tanpa perlu `flutter run` semula. (Hot Reload kekalkan state semasa anda sedang menaip kod, tetapi tekanan butang berlaku semasa aplikasi berjalan, direkodkan oleh `setState()`.)

- **`class ... extends StatefulWidget`** — widget "cangkang" (*shell*) yang tidak menyimpan data sendiri; ia hanya cipta objek `State`.
- **`class _SavedProgrammeCounterState extends State<SavedProgrammeCounter>`** — di sinilah **data sebenar** (`_savedCount`) hidup, dan `build()` dipanggil semula setiap kali `setState()` dipanggil.
- **`setState(() { ... })`** — **satu-satunya** cara sah untuk beritahu Flutter "data telah berubah, sila lukis semula". Jika anda tukar `_savedCount++` **tanpa** bungkus dalam `setState()`, UI **TIDAK** akan kemas kini walaupun nilai berubah di belakang tabir — anda boleh buktikan sendiri dalam [eksperimen §5.6, lab](./snippets/lab.md#56--eksperimen-buang-setstate).

> **Pratonton SESI 5 (Hari 3):** Kita akan bedah **kitaran hayat penuh** `StatefulWidget` (`createState()` → `initState()` → `build()` → `dispose()`) dan `setState()` dalam borang permohonan sebenar (`ApplicationFormScreen`), dan bincang bila `provider` (pengurusan *state* lanjutan) berguna berbanding `setState()` semata-mata.

#### Salah biasa: StatelessWidget/StatefulWidget

| ❌ Salah | ✅ Betul | Kenapa |
|---|---|---|
| Ubah pembolehubah state (`_savedCount++`) **tanpa** bungkus dalam `setState()` | `setState(() { _savedCount++; });` | Nilai berubah dalam ingatan, tapi Flutter **tidak tahu** ia perlu lukis semula `build()` — skrin kekal statik walaupun data sudah berubah. |
| Letak `int _savedCount = 0;` dalam kelas `StatefulWidget` itu sendiri (`SavedProgrammeCounter`) | Letak dalam kelas `State` (`_SavedProgrammeCounterState`) | Kelas `StatefulWidget` hanya "cangkang" tak berubah; **semua** data yang boleh berubah (*state*) mesti tinggal dalam kelas `State` berpasangan. |
| Guna `StatefulWidget` untuk widget yang **tak pernah** berubah (cth. kad info program statik) | Guna `StatelessWidget` | `StatefulWidget` bawa overhead objek `State` tambahan — kalau UI tak pernah berubah selepas dibina, `StatelessWidget` lebih ringkas & cukup. |
| Guna `==` untuk semak `_savedCount` (atau apa-apa nilai) sedangkan maksud sebenar nak **letak** nilai baharu | `_savedCount = 0;` (tugasan) vs `if (_savedCount == 0)` (bandingan) | Sama seperti perangkap `=` vs `==` di bahagian Dart pagi tadi — konsep ini terus terpakai walaupun sudah masuk dunia widget/state. |

**Cross-ref:** Latihan hands-on penuh (rangka `StatefulWidget` dua kelas berpasangan → tambah state → tambah kaedah pengubah → bina UI → eksperimen buang `setState()`) ada di [Latihan 5, lab](./snippets/lab.md#latihan-5--statelesswidget-vs-statefulwidget-kaunter-simpan-program).

> **Ringkasan setakat ini — StatelessWidget vs StatefulWidget.** `StatelessWidget` = UI statik, satu `build()`. `StatefulWidget` = UI boleh berubah, ada kelas `State` berasingan yang simpan data dan `setState()` untuk beritahu Flutter "lukis semula". **Prinsip paling penting hari ini:** menukar nilai sahaja **tidak** cukup — Flutter hanya kemas kini skrin bila anda beritahu ia secara eksplisit melalui `setState()`. Prinsip ini akan anda gunakan **berulang kali** bermula Hari 3 (borang permohonan) sehingga Hari 5 (projek mini).

---

## Troubleshooting Hari 1

Ralat berikut paling kerap dijumpai pemula pada hari pertama — kenali corak ini supaya tidak panik bila ia muncul:

| Simptom | Punca lazim | Penyelesaian |
|---|---|---|
| Skrin **merah** penuh teks ralat semasa `flutter run`/Hot Reload | Ralat dalam kod widget (`build()` gagal) — cth. koma/kurungan tertinggal, atau widget tak dijangka jenisnya | Baca **baris PERTAMA** mesej ralat sahaja buat permulaan (biasanya nama ralat seperti `RenderFlex overflowed`, `type 'Null' is not a subtype of type 'String'`, atau `The argument type ... can't be assigned to the parameter type ...`) — itu **punca sebenar**; baris-baris selepas itu (*stack trace*) selalunya kurang berguna untuk pemula. Betulkan, simpan, Hot Reload semula. |
| `flutter: command not found` dalam terminal | Flutter SDK belum ditambah ke `PATH` sistem, atau terminal dibuka **sebelum** `PATH` dikemas kini | Tutup & buka semula terminal (kadang perlu **restart** VS Code sepenuhnya) selepas pasang Flutter; sahkan dengan `echo $PATH` (mac/Linux) atau `echo %PATH%` (Windows) mengandungi folder `flutter/bin`. Rujuk [`nota/04-setup-windows.md`](../nota/04-setup-windows.md). |
| Kod sudah dibetulkan tapi ralat lama **masih** kelihatan dalam terminal | PATH/terminal lama belum "refresh" (punca sama seperti di atas), atau fail yang disimpan **bukan** fail yang sedang dijalankan `flutter run` | Restart terminal; sahkan nama & lokasi fail betul (`lib/main.dart` projek yang sedang berjalan, bukan salinan lain di folder berbeza). |
| `flutter run` "tersekat" lama pada `Running Gradle task 'assembleDebug'...` | **Normal** — build Android **pertama** setiap projek muat turun & susun banyak dependency Gradle; boleh ambil 3–10+ minit bergantung kelajuan internet & spesifikasi komputer | Bersabar pada build **pertama** sahaja — build seterusnya jauh lebih pantas kerana Gradle cache tersimpan. Jangan `Ctrl+C` tengah proses — itu boleh rosakkan cache dan buat build seterusnya lebih lambat pula. |
| Tekan **Hot Reload** (`r`) tapi perubahan **tidak** kelihatan di skrin | Sesetengah perubahan (tambah `class`/`enum` baharu, ubah `main()`, ubah kod dalam `initState()`, tambah medan baharu ke `State`) **tidak** disokong Hot Reload | Guna **Hot Restart** (`R` besar dalam terminal, atau butang *restart* di VS Code) — ini mulakan semula aplikasi dari `main()` (state hilang, mula dari kosong), berbanding Hot Reload yang cuma "suntik" kod baharu ke aplikasi yang sedang jalan (state kekal, cth. `_savedCount` tak reset). |
| `flutter devices` senarai **kosong** / emulator tidak dikesan | Emulator belum dimulakan, atau USB debugging belum aktif untuk telefon sebenar | Mulakan emulator dari Android Studio (Device Manager) **sebelum** `flutter run`; untuk telefon sebenar, aktifkan **Developer Options** → **USB Debugging**, sambung kabel, terima prompt "Allow USB debugging" pada skrin telefon. |
| Ralat `Null check operator used on a null value` | Guna `!` (null-assertion) pada nilai yang sebenarnya `null` semasa masa jalan | Elak `!` melainkan **pasti** nilai tak pernah null; guna `?.`, `??`, atau semak `if (x != null)` dahulu. Kita akan jumpa ralat ini lebih kerap bila sambung API sebenar di Hari 4. |

> **Tabiat baik untuk semua ralat:** salin **baris pertama** mesej ralat, tampal terus kepada AI (Claude Code, ChatGPT) bersama satu ayat konteks ("saya baru tambah Container ke Column, ini ralat yang keluar") — cara ini jauh lebih pantas daripada teka sendiri, terutamanya untuk ralat panjang yang kelihatan menakutkan pada hari pertama.

---

## Penutup — Ringkasan & Langkah Seterusnya

### Ringkasan

Hari ini kita telah:

1. ✅ Kuasai **operators** Dart (aritmetik, bandingan, logik, tugasan gabungan) — termasuk perangkap `/` vs `~/` dan `=` vs `==`.
2. ✅ Kuasai **control flow** — `if`/`else if`/`else` dan `switch` (termasuk fall-through & `default:`).
3. ✅ Kuasai **looping** — `for` (termasuk `for-in`) dan `while` — serta cara tulis **function** dengan parameter & pulangan nilai.
4. ✅ Fahami **anatomi widget** — semuanya widget, widget tree, dan kaedah `build()`.
5. ✅ Cuba widget paparan asas: `Text`, `Icon`, `Image` (`Image.network` & emoji), dengan hasil visual setiap satu.
6. ✅ Fahami `Container`, beza **`Padding`** (dalam) vs **`Margin`** (luar), dan `SizedBox` (jarak/saiz) — digunakan untuk bina satu kad info program statik.
7. ✅ Fahami beza konsep **`StatelessWidget`** vs **`StatefulWidget`**, dengan pratonton `setState()` melalui kaunter ringkas — dan **kenapa** menukar nilai sahaja tidak cukup tanpa `setState()`.
8. ✅ Kenali ralat lazim hari pertama (skrin merah, `command not found`, Gradle lambat, Hot Reload vs Restart) dan cara membacanya.

### Simpan Kerja Anda (Git)

Jika projek anda belum dalam kawalan versi, mulakan sekarang — tabiat baik dari Hari 1:

```bash
git init
git add .
git commit -m "Hari 1: aliran kawalan Dart, widget asas, kad program eTT statik"
```

> **Nota:** `flutter create` sudah menjana fail `.gitignore` yang sesuai (mengabaikan `build/`, `.dart_tool/`, dll) — tidak perlu konfigurasi tambahan.

### Apa Seterusnya — Hari 2 (SESI 2 & 3)

Esok kita mula bina **seni bina layout** sebenar (`Row`, `Column`, `Expanded`, `Stack`, `Scaffold`, `AppBar`) — kemudian sambung ke **`BottomNavigationBar`** (Program / Permohonan Saya / Profil), **`Drawer`** (pilih negara: Mesir/Maghribi), **`ListView.builder`**, `Card`, dan `ThemeData` untuk papar **8 program** dalam senarai boleh skrol bertema navy/gold.

Sehingga esok — pastikan `flutter run` anda masih berfungsi tanpa ralat sebelum tamat kelas hari ini!

---

> 🎤 **Nota penceramah/jurulatih:** [`nota-penceramah.md`](./nota-penceramah.md) — kumpulan nota persembahan (asalnya *speaker notes* dalam slaid) untuk Hari 1.

## Nota Tambahan (fakta ringkas dari slaid)

- **Operator tugasan gabungan:** `kiraan += 1;` **sama dengan** `kiraan = kiraan + 1;` — ia hanya cara ringkas menulis semula nilai ke pembolehubah yang sama. Begitu juga `-=`, `*=`, `/=`.
- **Operator `??` (if-null):** pulangkan nilai di sebelah kiri jika ia **bukan** null; jika null, guna nilai lalai di sebelah kanan.
  ```dart
  // jika kadar tukaran tiada dalam peta, guna 1.0 sebagai lalai
  final kadar = kadarTukaranAnggaran[currency] ?? 1.0;
  ```
- **Istilah kelayakan sebenar:** eTT menyemak permohonan dan menandakan **LAYAK / TIDAK LAYAK** (bukan istilah rekaan). Inilah keputusan pertama setiap pemohon.
- **1 negara + 1 bidang + sehingga 3 pilihan universiti:** peraturan sebenar eTT ialah **satu negara dan satu bidang** setiap permohonan; dalam bidang itu pelajar boleh menyusun **sehingga 3 pilihan universiti**. (Didalami Hari 3.)
- **Pratonton Hari 2:** untuk memformat kos ke RM secara automatik, kita akan guna pakej `intl` (`NumberFormat.currency`) — hari ini kita format manual dengan `toStringAsFixed`.
