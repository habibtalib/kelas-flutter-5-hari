# Hari 3 — Navigasi Skrin & Borang Input

> **22 Julai 2026 (Rabu)** · SESI 4 (9.00 pagi – 1.00 petang) & SESI 5 (2.30 – 5.00 petang)
>
> Hari 1–2 kita membina **senarai tawaran pengajian eTT** (`ProgrammeListScreen`) dengan carian, cip tapisan negara & kategori, dan `BottomNavigationBar`/`Drawer` — tetapi menekan kad tawaran **tidak membawa ke mana-mana**. Hari ini kita sambungkan senarai itu kepada **skrin butiran** dan **borang permohonan** yang benar-benar berfungsi: navigasi antara skrin, penghantaran data dua-hala, pengesahan (*validation*) input, dan cara Flutter menguruskan **state** borang menggunakan `setState()`.

Projek kita: **eTT Mobile** — aplikasi latihan yang meneroka tawaran pengajian di Mesir & Maghribi (Morocco) dan membuat permohonan, mencerminkan konsep sistem sebenar **e-Timur Tengah (eTT)** di bawah Bahagian Pengantarabangsaan Pendidikan Tinggi (BPPT), Kementerian Pendidikan Tinggi (KPT).

---

## Imbas Kembali Hari 1–2

- **Hari 1:** widget asas (`Text`, `Icon`, `Image`, `Container`), `StatelessWidget` vs `StatefulWidget`, model data `Programme` + enum (`StudyLevel`, `EntryCategory`).
- **Hari 2:** susun atur (`Row`/`Column`/`Expanded`), `Scaffold`/`AppBar`, `BottomNavigationBar` (tab "Program" / "Permohonan Saya" / "Profil") & `Drawer` negara (`HomeScreen`), senarai dinamik (`ListView.builder` di `ProgrammeListScreen`), kad boleh guna semula (`ProgrammeCard`), dan kemasan jenama melalui `KptTheme` (navy `#1A2B5C` + emas `#D4A017`).

Pada penghujung Hari 2, struktur projek `ett_mobile` sepatutnya kelihatan seperti ini:

```
lib/
  main.dart                      # MaterialApp + KptTheme
  theme.dart
  models/programme.dart
  data/sample_programmes.dart    # senarai sampel 8 tawaran (Mesir + Maghribi)
  widgets/programme_card.dart
  screens/
    home_screen.dart             # BottomNavigationBar (3 tab) + Drawer negara
    programme_list_screen.dart   # carian + cip negara/kategori + ListView.builder
```

Hari ini kita **tambah** dua skrin baharu (`ProgrammeDetailScreen`, `ApplicationFormScreen`) dan satu model baharu (`Application`) — struktur sedia ada **tidak diubah**.

### Kenapa hari ini penting

Sebuah senarai tawaran yang tidak boleh ditekan **bukan aplikasi** — ia sekadar poster elektronik. Dua Hari lepas kita fokus kepada **memaparkan** data (widget, layout, senarai, kemasan). Hari ini kita fokus kepada **interaksi** — apa yang berlaku bila pengguna sebenar **buat sesuatu**: tekan kad untuk lihat butiran, isi borang, tekan hantar. Ini juga hari pertama pengguna **memasukkan** data ke dalam aplikasi (bukan sekadar membaca data sedia ada), jadi kita perlu belajar bagaimana Flutter **mengingati** apa yang ditaip pengguna dan bagaimana ia **mengesahkan** input sebelum diterima. Dua keperluan ini — navigasi antara skrin, dan mengingati/mengesahkan input — adalah asas kepada **setiap** aplikasi mudah alih yang berguna, bukan hanya eTT Mobile.

---

> 📱 **Demo interaktif dalam aplikasi.** Konsep hari ini ada demo yang boleh anda **jalankan & main-main** pada telefon/emulator — ubah kawalan, lihat kesannya serta-merta:
>
> Navigator push/pop · TextField vs TextFormField · Form & Validation · **setState() & Lifecycle** · Button & GestureDetector
>
> Jalankan galeri demo: `cd projek/ett_mobile && flutter run -t lib/demos_main.dart` → pilih **Hari 3**. Kod: [`projek/ett_mobile/lib/demos/hari3/`](../projek/ett_mobile/lib/demos/hari3/).

## Fokus Hari Ini

| Topik | Rujukan Rasmi |
|---|---|
| Navigasi & `Navigator` | https://docs.flutter.dev/ui/navigation |
| `Navigator.push` / `MaterialPageRoute` | https://api.flutter.dev/flutter/widgets/Navigator-class.html |
| Named routes (`routes`, `onGenerateRoute`) | https://docs.flutter.dev/cookbook/navigation/named-routes |
| Menghantar & memulangkan data antara skrin | https://docs.flutter.dev/cookbook/navigation/passing-data · https://docs.flutter.dev/cookbook/navigation/returning-data |
| Membina borang (`Form`) & pengesahan | https://docs.flutter.dev/cookbook/forms/validation |
| Mengambil nilai input (`TextEditingController`) | https://docs.flutter.dev/cookbook/forms/retrieve-input |
| `TextField` & `TextFormField` | https://api.flutter.dev/flutter/material/TextFormField-class.html |
| Gerak isyarat (`GestureDetector`, `InkWell`) | https://docs.flutter.dev/ui/interactivity |
| Kitaran hayat `StatefulWidget` (`setState`, `initState`, `dispose`) | https://docs.flutter.dev/ui/interactivity#state |

---

## Struktur Sesi Hari Ini

| Masa | Sesi | Topik |
|---|---|---|
| 9.00 pagi – 1.00 petang | **SESI 4 — Navigasi Skrin & Borang Input** | `Navigator.push`/`pop` · Named routes & navigation stack · Menghantar data antara skrin · Pengenalan `TextField` & `TextFormField` |
| 1.00 – 2.30 petang | *Rehat & makan tengah hari* | |
| 2.30 – 5.00 petang | **SESI 5 — Kawalan Borang & State Management Asas** | Input Controller (`TextEditingController`) · Button & `GestureDetector` · Validator borang (regex IC/emel) · `setState()` & kitaran hayat `StatefulWidget` |

---

# SESI 4 — Navigasi Skrin & Borang Input

## 1. Konsep Navigasi: Tindanan (Stack) Skrin

### Kenapa perlu konsep "tindanan"?

Dalam aplikasi web, setiap laman ada URL — pelayar simpan sejarah dan anda boleh klik "kembali" untuk pulang ke laman sebelumnya. Aplikasi mudah alih **tiada** URL secara lalai, tetapi pengguna tetap perlukan gelagat yang sama: buka sesuatu → buat kerja → **kembali** ke tempat asal, tanpa kehilangan tempat mereka. Flutter menyelesaikan ini dengan model mental yang mudah: setiap skrin ialah satu **kad**, dan kad-kad itu disusun sebagai **tindanan (stack)** — sama seperti setumpuk kad fizikal di atas meja. Skrin **teratas** ialah satu-satunya yang kelihatan dan boleh berinteraksi; skrin di bawahnya "bersembunyi" tetapi **tidak dimusnahkan** — ia menunggu untuk kelihatan semula bila kad di atasnya dikeluarkan.

```
┌───────────────────────────┐
│  ApplicationFormScreen      │  ← skrin teratas (aktif sekarang)
├───────────────────────────┤
│  ProgrammeDetailScreen      │
├───────────────────────────┤
│  ProgrammeListScreen (root) │  ← skrin asal, tab "Program"
└───────────────────────────┘
```

Widget yang menguruskan tindanan ini ialah **`Navigator`**. Dua kaedah asas:

| Kaedah | Fungsi |
|---|---|
| `Navigator.of(context).push(route)` | Tolak skrin baharu ke atas tindanan |
| `Navigator.of(context).pop([hasil])` | Keluarkan skrin teratas; boleh sertakan nilai `hasil` untuk skrin sebelumnya |

### Bagaimana tindanan berubah mengikut masa

Bayangkan urutan tindakan pengguna sebenar — perhatikan bagaimana tindanan **tumbuh** apabila `push` dan **mengecil** apabila `pop`:

```
1. Buka app                     [ProgrammeListScreen]

2. Tekan kad "Al-Azhar"          push →  [ProgrammeListScreen, ProgrammeDetailScreen]

3. Tekan "Mohon"                 push →  [ProgrammeListScreen, ProgrammeDetailScreen, ApplicationFormScreen]

4. Tekan "Hantar Permohonan"     pop  →  [ProgrammeListScreen, ProgrammeDetailScreen]
   (ApplicationFormScreen keluar, ProgrammeDetailScreen kelihatan semula)

5. Tekan "←" (kembali)           pop  →  [ProgrammeListScreen]
   (kembali ke senarai asal, tempat carian/tapisan pengguna KEKAL tersimpan)
```

Perhatikan baris 5: `ProgrammeListScreen` yang pengguna tinggalkan pada langkah 2 **tidak dibina semula dari kosong** — ia hanya "didedahkan semula" apabila skrin di atasnya dikeluarkan. Tapisan carian yang pengguna sudah taip masih ada. Inilah sebab tindanan (bukan sekadar "tukar skrin") menjadi model yang berguna: ia menjaga **state** setiap skrin secara automatik selagi skrin itu belum di-`pop`.

---

## 2. `Navigator.push` & `Navigator.pop` dengan `MaterialPageRoute`

Cara paling asas untuk pergi ke skrin baharu ialah `MaterialPageRoute`, yang membina animasi peralihan gaya Material secara automatik (skrin baharu meluncur masuk dari kanan pada Android):

```dart
Navigator.of(context).push(
  MaterialPageRoute(
    builder: (_) => const SomeScreen(),
  ),
);
```

Dalam projek sebenar, `ProgrammeListScreen` menggunakan corak ini untuk membuka `ProgrammeDetailScreen` apabila kad tawaran ditekan (`lib/screens/programme_list_screen.dart`):

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

Dan untuk kembali:

```dart
Navigator.of(context).pop();
```

**Apa yang anda patut nampak:** menekan kad tawaran memaparkan animasi peralihan — skrin baharu meluncur masuk dari tepi kanan, menutupi senarai sepenuhnya. `AppBar` skrin baharu secara **automatik** memaparkan anak panah `←` di kiri (Flutter menambahnya sendiri apabila `Navigator` mengesan ada skrin sebelumnya untuk kembali) — anda tidak perlu tulis kod untuk butang kembali itu.

### ❌ Salah biasa — Bahagian Navigasi

| ❌ Kod biasa ditulis pelajar | Akibat | ✅ Pembetulan |
|---|---|---|
| `Navigator.push(context, MaterialPageRoute(...))` (guna `Navigator.push` statik, bukan `.of(context)`) | Sebenarnya **masih berfungsi** — `Navigator.push(context, route)` ialah alias ringkas untuk `Navigator.of(context).push(route)` — tetapi tidak konsisten dengan gaya `.of(context)` yang digunakan `pop`, `pushNamed` dsb. dalam projek ini | Guna `Navigator.of(context).push(...)` secara konsisten supaya mudah dibaca bersama `Navigator.of(context).pop()` |
| Lupa `builder: (_) => ...` dan terus letak `SomeScreen()` | Ralat kompilasi: `MaterialPageRoute` jangka parameter `builder` jenis fungsi, bukan widget terus | `builder:` **mesti** fungsi `(BuildContext) => Widget` — walaupun `context` tidak digunakan, tanda `(_)` |
| Panggil `Navigator.of(context).pop()` pada skrin **root** (`ProgrammeListScreen`, tiada skrin sebelumnya) | Ralat masa jalan: tiada apa berlaku / `assertion failed` dalam mod debug kerana tindanan sudah kosong | Semak dahulu `Navigator.of(context).canPop()` sebelum `pop()` jika butang itu mungkin dipaparkan pada skrin root |

---

## 3. Named Routes & Navigation Stack

Agenda rasmi hari ini secara khusus meminta kita fahami **named routes** — cara berdaftar untuk menguruskan navigasi menggunakan **nama** (String) dan bukan rujukan kelas terus. Ini amat berguna apabila aplikasi membesar (banyak skrin, navigasi dari pelbagai tempat, atau kelak deep-linking).

### 3.1 Daftar laluan di `MaterialApp`

```dart
MaterialApp(
  title: 'eTT Mobile',
  initialRoute: '/',
  routes: {
    '/': (context) => const HomeScreen(),
    '/tentang': (context) => const AboutScreen(),
  },
  // ...
);
```

Setiap kunci (`'/'`, `'/tentang'`) ialah **nama laluan**; nilainya ialah fungsi `WidgetBuilder` yang membina skrin berkenaan. Navigasi menggunakan nama:

```dart
Navigator.of(context).pushNamed('/tentang');
```

### 3.2 `onGenerateRoute` — bila laluan perlukan DATA

Peta `routes: {}` sahaja **tidak boleh** menerima parameter (contoh: `ProgrammeDetailScreen` memerlukan `Programme programme`). Untuk laluan yang perlu data, Flutter sediakan `onGenerateRoute`, dipanggil dengan `RouteSettings` yang mengandungi nama laluan **dan** `arguments`:

```dart
MaterialApp(
  title: 'eTT Mobile',
  initialRoute: '/',
  routes: {
    '/': (context) => const HomeScreen(),
  },
  onGenerateRoute: (settings) {
    if (settings.name == '/detail') {
      final programme = settings.arguments as Programme;
      return MaterialPageRoute(
        builder: (_) => ProgrammeDetailScreen(programme: programme),
      );
    }
    return null; // laluan tidak dikenali — Flutter papar skrin ralat lalai
  },
);
```

Navigasi dengan menghantar `arguments`:

```dart
Navigator.of(context).pushNamed(
  '/detail',
  arguments: p, // objek Programme dihantar di sini
);
```

Di dalam `ProgrammeDetailScreen`, `arguments` boleh dibaca semula (jika skrin tidak dibina melalui constructor terus) dengan:

```dart
final programme =
    ModalRoute.of(context)!.settings.arguments as Programme;
```

### 3.3 Named routes vs `push` terus — mana satu digunakan projek ini?

> **Jujur & telus:** Fail sebenar `lib/main.dart` dalam projek `ett_mobile` **tidak** mendaftar sebarang laluan langsung — tiada `routes:`, tiada `onGenerateRoute`. `MaterialApp` terus memaparkan `home: const HomeScreen()`, dan setiap peralihan skrin (`ProgrammeListScreen → ProgrammeDetailScreen → ApplicationFormScreen`) menggunakan `Navigator.push` + `MaterialPageRoute` + argumen constructor **terus** (Bahagian 2 di atas). Untuk aplikasi kecil dengan hierarki navigasi mudah (senarai → butiran → borang, semuanya linear), ini cara paling ringkas dan selamat jenis (*type-safe*) — tiada `as Programme` yang boleh gagal masa jalan (*runtime*) jika data salah jenis.
>
> Named routes lebih bernilai apabila: (a) banyak tempat berbeza perlu navigasi ke skrin yang sama, (b) anda mahu sokongan URL/deep-link (contohnya versi web), atau (c) navigasi perlu dikawal berpusat (contoh: log analitik setiap laluan). Agenda kursus meminta kita **faham kedua-dua corak** — gunakan `push` terus untuk projek kecil seperti eTT Mobile, dan named routes bila keperluan di atas timbul.

### ❌ Salah biasa — Named Routes

| ❌ Kod biasa ditulis pelajar | Akibat | ✅ Pembetulan |
|---|---|---|
| `onGenerateRoute` tidak pulangkan `return null;` untuk laluan tidak dikenali (fungsi "jatuh" tanpa `return`) | Ralat kompilasi: fungsi jangka pulangkan `Route<dynamic>?` pada **setiap laluan kod**, bukan hanya cabang `if` | Sentiasa tutup dengan `return null;` di penghujung fungsi — Flutter papar skrin ralat lalai secara automatik untuk laluan tidak dikenali |
| Panggil `pushNamed('/detail', arguments: p)` tetapi **lupa** daftar `onGenerateRoute`/`routes['/detail']` dalam `MaterialApp` | App tidak crash serta-merta, tetapi papar skrin **kelabu "Unknown route"** bukan `ProgrammeDetailScreen` | Pastikan setiap nama laluan yang dipanggil `pushNamed()` benar-benar didaftarkan; semak ejaan `'/detail'` sepadan **tepat** (case-sensitive) |
| `settings.arguments as Programme` tanpa semak jenis dahulu | Ralat masa jalan `type 'X' is not a subtype of type 'Programme'` jika pemanggil hantar jenis salah (rujuk eksperimen Lab Latihan 2) | Untuk data kritikal, pertimbang `push` terus (Bahagian 2) yang disahkan jenis semasa **kompilasi**, bukan masa jalan |

---

## 4. Menghantar Data Antara Skrin (Passing Data)

### Kenapa perlu dua arah?

Data dalam aplikasi mengalir **dua arah** antara skrin, dan setiap arah perlukan corak berbeza. Skrin senarai perlu **beritahu** skrin butiran "ini tawaran yang ditekan pengguna" — itu **data masuk**. Selepas borang berjaya dihantar, skrin borang perlu **beritahu** skrin butiran "berjaya, sini objek permohonan yang baru dicipta" — itu **data keluar**, dan ia lebih rumit kerana skrin borang mungkin ditutup **tanpa** apa-apa dihantar (pengguna tekan "kembali" sahaja), jadi skrin butiran mesti tahu membezakan "berjaya" daripada "dibatalkan".

### 4.1 Hantar data MASUK — parameter constructor

Cara paling ringkas untuk menghantar data ke skrin baharu: lalukan sebagai `required` parameter constructor. Ini corak yang digunakan di seluruh eTT Mobile:

```dart
// lib/screens/programme_detail_screen.dart
class ProgrammeDetailScreen extends StatelessWidget {
  const ProgrammeDetailScreen({super.key, required this.programme});

  final Programme programme;
  // ...
}
```

```dart
Navigator.of(context).push(
  MaterialPageRoute(
    builder: (_) => ProgrammeDetailScreen(programme: p),
  ),
);
```

Tiada pangkalan data, tiada `Future`, tiada `id` untuk dicari semula — cukup lalukan objek Dart biasa. `ProgrammeDetailScreen` kemudian menggunakan `programme.universityName`, `programme.country`, `programme.estimatedAnnualCostMyr`, dan lain-lain terus daripada objek yang diterima.

### 4.2 Hantar data KELUAR — `pop(value)` + `await push`

Kadangkala skrin **kedua** perlu memulangkan sesuatu kepada skrin **pertama** — contohnya borang permohonan yang, selepas berjaya dihantar, perlu "beritahu" skrin sebelumnya supaya boleh mengemas kini paparan, tanpa perlu berkongsi state global antara skrin.

Fail sebenar `lib/screens/application_form_screen.dart` menyimpan permohonan melalui `ApplicationProvider.add()` (pakej `provider`, digunakan di seluruh projek `ett_mobile` untuk kongsi data antara tab), kemudian memanggil `Navigator.of(context).pop();` **tanpa** sebarang nilai — skrin butiran tidak menunggu (`await`) hasil apa-apa pun, kerana ia boleh terus baca data terkini daripada provider. Di sini kita bina corak yang berfungsi **tanpa** provider — corak "hantar data keluar": skrin borang memulangkan objek `Application` terus melalui `Navigator.pop(context, application)`, dan skrin butiran `await` hasil `push()`:

```dart
// Skrin PERTAMA — tunggu hasil daripada skrin borang
final Application? hasil = await Navigator.of(context).push<Application>(
  MaterialPageRoute(
    builder: (_) => ApplicationFormScreen(programme: programme),
  ),
);

if (hasil != null) {
  // borang berjaya dihantar — hasil ialah Application baharu
  setState(() => _sudahMohon = true);
}
```

```dart
// Skrin KEDUA (borang) — pulangkan objek Application semasa pop
Navigator.of(context).pop(application);
```

`push<Application>()` generik (`<Application>`) memberitahu Dart jenis nilai yang dijangka pulang — jika borang ditutup tanpa hantar (cth. pengguna tekan butang "kembali" biasa), `hasil` akan `null`, jadi kita **mesti** semak `if (hasil != null)` sebelum menggunakannya. Kita gunakan corak ini dalam Latihan 3 lab hari ini untuk membina skrin butiran dengan `setState()` (lihat Bahagian 9 untuk bandingan dengan corak `provider` yang digunakan projek sebenar).

**Apa yang anda patut nampak:** apabila borang ditutup selepas `_submit()` berjaya, skrin butiran (yang menunggu di sebalik `await`) **serta-merta** meneruskan kod selepas `push()` — butang "Mohon" bertukar kepada "Anda Telah Memohon" dan `SnackBar` muncul di bawah skrin, tanpa pengguna perlu buat apa-apa tambahan.

### ❌ Salah biasa — Passing Data

| ❌ Kod biasa ditulis pelajar | Akibat | ✅ Pembetulan |
|---|---|---|
| `Navigator.of(context).push<Application>(...)` **tanpa** `await` di hadapan | Kod selepas baris itu terus jalan **sebelum** borang sempat dibuka/ditutup — `hasil` sentiasa bernilai `Future`, bukan `Application?` | Sentiasa `final hasil = await Navigator.of(context).push<T>(...)` bila anda perlukan **nilai** hasil `pop()` |
| Terus guna `hasil.id` tanpa semak `if (hasil != null)` dahulu | Ralat masa jalan `Null check operator used on a null value` bila pengguna tutup borang **tanpa** hantar (guna `!` atau baca terus) | **Sentiasa** semak `if (hasil != null) { ... }` sebelum guna nilai yang mungkin `null` daripada `pop()` tanpa argumen |
| `Navigator.pop(context)` (lupa hantar `application`) dalam skrin borang, tetapi skrin pertama jangka nilai bukan-null | Skrin pertama terima `null`, ingat borang **dibatalkan** walaupun sebenarnya berjaya dihantar | Pastikan `pop(context, application)` — bukan `pop(context)` kosong — pada laluan **kejayaan** dalam `_submit()` |

---

## Ringkasan Setakat Ini — Navigasi (SESI 4, Bahagian 1–4)

- **Tindanan (stack):** setiap `push` menambah skrin di atas, setiap `pop` mengeluarkan skrin teratas; skrin di bawah **tidak dimusnahkan**, hanya disembunyikan.
- **`push` terus** (constructor + `MaterialPageRoute`) selamat jenis, mudah — digunakan sepanjang `ett_mobile`. **Named routes** (`routes`/`onGenerateRoute`/`pushNamed`) berguna bila banyak tempat panggil skrin yang sama atau perlukan deep-link, tetapi kurang selamat jenis (`as Programme` boleh gagal masa jalan).
- **Data masuk** = parameter constructor. **Data keluar** = `Navigator.pop(context, value)` + `await push<T>()`, **wajib** semak `!= null` sebelum guna hasilnya.

---

## 5. Pengenalan Komponen Borang: `TextField` & `TextFormField`

### Kenapa dua widget untuk "input teks"?

Setakat ini kita hanya **memaparkan** teks (`Text`). Borang permohonan perlukan pengguna **menaip** teks — dan Flutter sediakan dua widget nampak serupa tetapi tujuan berbeza. `TextField` sesuai bila anda hanya perlu tahu "apa nilai semasa" (cth. carian — setiap ketukan terus tapis senarai, tiada konsep "sah/tidak sah"). `TextFormField` sesuai bila input itu **sebahagian daripada borang lebih besar** yang perlu disahkan **secara kolektif** sebelum dihantar — dan itulah keperluan borang permohonan eTT hari ini.

| | `TextField` | `TextFormField` |
|---|---|---|
| Kegunaan | Input teks **mandiri**, tiada kaitan dengan borang lain | Input teks **di dalam** widget `Form`, disahkan (*validated*) bersama medan lain |
| Baca nilai | `onChanged: (value) => ...` atau `TextEditingController` | Sama, **plus** parameter `validator` |
| Pengesahan terbina | Tiada — anda uruskan sendiri | Ya — `validator: (value) => ...` |

Contoh `TextField` ringkas (digunakan untuk carian di `ProgrammeListScreen` — tiada keperluan pengesahan, hanya tapis semasa menaip):

```dart
TextField(
  onChanged: provider.search,
  decoration: const InputDecoration(
    hintText: 'Cari universiti, bidang atau negara…',
    prefixIcon: Icon(Icons.search),
  ),
);
```

**Apa yang anda patut nampak:** setiap huruf yang ditaip dalam bar carian **serta-merta** menapis senarai di bawahnya (`ListView.builder` membina semula dengan senarai lebih pendek) — tiada butang "Cari" perlu ditekan, kerana `onChanged` dipanggil pada **setiap** ketukan kekunci.

Untuk **borang** (di mana input perlu **disahkan** sebelum dihantar), kita guna `TextFormField` sebaliknya — perbincangan penuh (`Form`, `validator`, `TextEditingController`) diteruskan di SESI 5 seterusnya.

### ❌ Salah biasa — `TextField` vs `TextFormField`

| ❌ Kod biasa ditulis pelajar | Akibat | ✅ Pembetulan |
|---|---|---|
| Guna `TextField` di dalam `Form`, jangka `validator` berfungsi | `TextField` **tiada** parameter `validator` — ralat kompilasi "no named parameter" | Guna `TextFormField` untuk **sebarang** medan yang perlu disahkan bersama medan lain |
| Guna `TextFormField` untuk bar carian mudah (tiada `Form` membungkusnya) | Berfungsi, tetapi lebih berat & mengelirukan — pembaca kod jangka ada `Form`/`validate()` di suatu tempat, sedangkan tiada | Guna `TextField` biasa bila **tiada** keperluan pengesahan kolektif — pilih widget mengikut **keperluan**, bukan sebarang guna yang "lebih maju" |

---

# SESI 5 — Kawalan Borang & State Management Asas

## 6. `Form`, `GlobalKey<FormState>`, `validator` & `TextEditingController`

Sekarang kita bina bahagian paling penting hari ini: `ApplicationFormScreen` — borang permohonan eTT lengkap dengan pengesahan.

### 6.1 Kenapa `StatefulWidget`?

Borang perlu **mengingati** apa yang pengguna telah taip, pilihan dropdown (kategori sijil, negara, bidang, pilihan universiti), dan senarai semak dokumen yang ditanda — nilai ini **berubah** sepanjang hayat skrin. Oleh itu borang mesti `StatefulWidget`:

```dart
// lib/screens/application_form_screen.dart
class ApplicationFormScreen extends StatefulWidget {
  const ApplicationFormScreen({super.key, required this.programme});

  /// Tawaran yang dipilih daripada skrin butiran — menetapkan negara & bidang
  /// awal serta pilihan universiti pertama.
  final Programme programme;

  @override
  State<ApplicationFormScreen> createState() => _ApplicationFormScreenState();
}
```

### 6.2 `GlobalKey<FormState>` — pintu masuk ke widget `Form`

Widget `Form` membalut semua `TextFormField` dan menguruskan pengesahan mereka **secara kolektif**. Masalahnya: `Form` sendiri **tidak** ada butang "sahkan sekarang" terbina — anda perlu satu cara untuk **mencapai** state dalaman `Form` (yang tahu status setiap medan) daripada **luar** pokok widget itu, contohnya daripada `onPressed` butang hantar yang berada **di luar** `Form` dalam struktur widget. `GlobalKey` ialah "pemegang rujukan" yang membolehkan ini:

```dart
final _formKey = GlobalKey<FormState>();
```

Kunci ini kemudian dipasang pada `Form(key: _formKey, ...)`, dan boleh dicapai bila-bila masa melalui `_formKey.currentState`.

### 6.3 `TextEditingController` — Input Controller

Setiap `TextFormField` dipasangkan dengan `TextEditingController` untuk membaca/menetapkan nilai teks:

```dart
final _nameCtrl = TextEditingController();
final _icCtrl = TextEditingController();
final _emailCtrl = TextEditingController();
final _phoneCtrl = TextEditingController();
final _academicCtrl = TextEditingController();
```

Perhatikan permohonan eTT **tidak** memerlukan No. Pasport dalam borang (berbeza daripada aplikasi latihan hari-hari sebelum ini) — hanya No. Kad Pengenalan. Selain lima controller ini, borang turut menyimpan pilihan menerusi pembolehubah `State` biasa (bukan controller): `EntryCategory? _academicCategory`, `String _country`, `String _fieldOfStudy`, `String? _choice1/_choice2/_choice3`, dan `Map<String, bool> _documents` untuk senarai semak dokumen.

### 6.4 Kitaran hayat: isi controller & nilai awal dalam `initState`, bersihkan dalam `dispose`

```dart
@override
void initState() {
  super.initState();
  _country = widget.programme.country;
  _fieldOfStudy = widget.programme.fieldOfStudy;
  _choice1 = widget.programme.id;
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
```

> **Kenapa `dispose()` PENTING?** `TextEditingController` memegang sumber sistem (*listener*, buffer teks). Jika anda lupa `.dispose()`, ia **bocor memori (memory leak)** — controller kekal dalam ingatan walaupun skrin sudah ditutup. Peraturan mudah: **setiap `Controller` yang dicipta dalam `State`, mesti di-`dispose()`.**
>
> 📦 Fail sebenar `initState()` turut mengisi nama & No. KP daripada `ProfileProvider` jika pengguna telah menyimpan profil (`context.read<ProfileProvider>()`) — corak `provider` yang digunakan di seluruh projek `ett_mobile` (lihat Bahagian 9). Di sini kita cukup tetapkan negara/bidang/pilihan-1 awal seperti di atas.

Kalau anda pernah nampak ralat `setState() called after dispose()` semasa menguji borang (biasanya bila `Future`/timer selesai **selepas** pengguna sudah tutup skrin), ini titik yang sesuai untuk minta bantuan AI menjelaskan puncanya — tampal jejak (*stack trace*) ralat dan tanya sebab ia berlaku. Jawapannya hampir selalu sama: semak `if (!mounted) return;` sebelum `setState()` dalam callback tak segerak (Bahagian 8.4) — tetapi biar AI bantu anda kenal pasti **di baris mana** semakan itu patut ditambah dalam kod anda sendiri.

### 6.5 `TextFormField` + `validator`

```dart
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
  validator: validateIcNumber,   // rujuk hari-3/snippets/validators.dart
);
```

`inputFormatters` **menyekat** aksara tidak sah daripada dimasukkan sejak awal (huruf tidak boleh ditaip terus dalam medan IC). `validator` **menyemak** nilai akhir selepas siap ditaip. Kedua-duanya sering digunakan bersama; memerlukan import `package:flutter/services.dart`.

Apabila `_formKey.currentState!.validate()` dipanggil, **setiap** `validator` dalam `Form` dijalankan serentak; jika mana-mana satu mengembalikan mesej (bukan `null`), mesej itu dipaparkan di bawah medan berkenaan dan `validate()` memulangkan `false`.

Borang ini perlukan lima validator (`fullName`, `icNumber`, `email`, `phoneNumber`, `academicSummary`) — menulis semuanya sendiri dari kosong agak berulang, terutamanya format No. KP dan emel yang perlukan regex yang betul. Ini masa yang sesuai untuk minta bantuan AI menjana draf pertama:

```text
Saya membina borang permohonan pelajar Flutter (Dart) untuk sistem eTT dengan
medan:
- No. Kad Pengenalan Malaysia (icNumber) — format 051231-14-5678
- Emel (email)

Tulis dua fungsi validator standalone Dart (TIADA import package:flutter),
dengan tandatangan `String? Function(String?)`, supaya boleh dihantar terus
sebagai `validator:` pada TextFormField:

1. validateIcNumber — mesti tepat 12 digit selepas sengkang dibuang.
2. validateEmail — format asas nama@domain.hujung.

Semua mesej ralat dalam Bahasa Melayu.
```

Draf pertama AI sering **kelihatan** betul tetapi gagal pada kes tepi (*edge case*). Contoh biasa:

```dart
// ⚠️ DRAF AI — JANGAN terus guna tanpa semak
String? validateIcNumber(String? value) {
  if (value == null || value.isEmpty) return 'No. KP diperlukan';
  if (value.length != 12) return 'No. KP mesti 12 digit';   // ❌ pepijat
  return null;
}
```

Sebelum kod begini masuk ke projek, uji dahulu senarai kes tepi secara manual — jangan sekadar baca kod dan rasa yakin ia betul:

| Input | Sepatutnya | Draf AI di atas | Sebab |
|---|---|---|---|
| `"051231145678"` (12 digit, tiada sengkang) | ✅ sah | ✅ sah | `.length == 12` |
| `"051231-14-5678"` (format berhint, 14 aksara) | ✅ sah | ❌ **DITOLAK** | `.length` kira sengkang sekali — draf AI **tidak** membuang sengkang dahulu! |
| `""` (kosong) | ❌ "diperlukan" | ❌ "diperlukan" | betul |
| `"12345678901a"` (ada huruf) | ❌ tak sah | ✅ **diterima secara silap** | draf AI tidak semak jenis aksara |

Baris kedua & keempat mendedahkan **dua** pepijat — draf gagal kes yang sepatutnya **lulus** (format bersengkang yang digalakkan UI sendiri!) dan kes yang sepatutnya **gagal**. Versi yang telah disemak (lihat `hari-3/snippets/validators.dart`, fungsi `validateIcNumber`) membuang sengkang **dahulu** dan menyemak set aksara **sebelum** mengira panjang:

```dart
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
```

Jalankan `flutter analyze`/`dart analyze` selepas tampal kod janaan AI — ia menangkap ralat jenis dan amaran gaya sebelum kod itu masuk projek. AI mempercepatkan draf pertama; ia tidak menggantikan tanggungjawab anda untuk **memahami** dan **mengesahkan** kod, lebih-lebih lagi untuk logik yang menyentuh data peribadi sebenar (No. KP). Rujuk [`nota/08-prompt-claude-code.md`](../nota/08-prompt-claude-code.md) untuk lebih banyak contoh prinsip prompt yang baik.

Fail penuh empat validator (`validateRequired`, `validateIcNumber`, `validateEmail`, `validatePhoneNumber`) tersedia di [`snippets/validators.dart`](./snippets/validators.dart) — lulus `dart analyze` tanpa isu.

### 6.6 Peraturan sebenar eTT: 1 negara + 1 bidang + sehingga 3 pilihan universiti

Ini **teras domain** borang permohonan eTT — bukan sekadar medan borang biasa. Panduan awam eTT menekankan **satu negara + satu bidang** setiap permohonan; dalam bidang itu, pelajar boleh menyusun **sehingga 3 pilihan universiti** (daripada use-case dalaman BPM). Borang menguatkuasakan ini dengan dua `DropdownButtonFormField<String>` (negara, bidang) yang **saling bergantung (cascading)** — menukar negara menyusun semula senarai bidang, dan menukar bidang menyusun semula senarai pilihan universiti:

```dart
// lib/screens/application_form_screen.dart
void _onCountryChanged(String? value) {
  if (value == null) return;
  setState(() {
    _country = value;
    final fields = _fields;                 // bidang unik dalam negara baharu
    _fieldOfStudy = fields.isNotEmpty ? fields.first : '';
    _resetChoices();                         // pilihan universiti tidak lagi sah
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
  final programmes = _choiceProgrammes;      // tawaran dalam negara+bidang terpilih
  _choice1 = programmes.isNotEmpty ? programmes.first.id : null;
  _choice2 = null;
  _choice3 = null;
}
```

Logik "saling bergantung" begini (tukar dropdown A, dropdown B & C perlu susun semula, dan nilai lama yang tidak lagi sah perlu di-reset) mudah tersilap jika ditulis tergesa-gesa — cuba minta AI bantu rangka fungsinya dahulu:

```text
Saya ada tiga DropdownButtonFormField<String> berperingkat dalam satu Form Flutter:
negara → bidang pengajian → pilihan universiti (1-3). Tukar negara mesti
menyusun semula senarai bidang (dan pilih bidang pertama secara automatik),
dan tukar bidang mesti menyusun semula senarai pilihan universiti. Tulis
_onCountryChanged, _onFieldChanged, dan _resetChoices yang memanggil
setState() dengan betul, dan pastikan pilihan universiti lama yang tidak
lagi sah (kerana negara/bidang sudah tukar) turut di-reset.
```

Semak hasilnya terhadap tingkah laku sebenar yang anda mahu — cuba tukar negara dalam app dan pastikan pilihan universiti lama benar-benar hilang (bukan sekadar kekal terpapar sedangkan ia sudah tidak tergolong dalam negara/bidang baharu) — sebelum menerimanya ke dalam projek.

Tiga dropdown pilihan universiti (Pilihan 1 **wajib**, Pilihan 2 & 3 **pilihan**) dibina daripada satu widget boleh guna semula `_ChoiceDropdown`:

```dart
_ChoiceDropdown(
  label: 'Pilihan 1 (wajib)',
  value: _choice1,
  programmes: choiceProgrammes,
  onChanged: (v) => setState(() => _choice1 = v),
  validator: (v) => v == null ? 'Pilihan 1 diperlukan' : null,
),
_ChoiceDropdown(
  label: 'Pilihan 2 (pilihan)',
  value: _choice2,
  programmes: choiceProgrammes,
  includeNone: true,               // benarkan "Tiada" — medan opsional
  onChanged: (v) => setState(() => _choice2 = v),
),
```

Diikuti oleh senarai semak dokumen (`ettDocumentChecklist` — "Borang Permohonan", "Senarai Semak", "Borang Aku Janji", "Salinan Kad Pengenalan", "Sijil SPM/STAM", "Slip Bayaran (JomPAY)") melalui `CheckboxListTile`:

```dart
for (final doc in ettDocumentChecklist)
  CheckboxListTile(
    dense: true,
    controlAffinity: ListTileControlAffinity.leading,
    title: Text(doc),
    value: _documents[doc],
    onChanged: (v) => setState(() => _documents[doc] = v ?? false),
  ),
```

> ⚠️ Dalam sistem sebenar, dokumen sokongan **hanya** dimuat naik selepas status permohonan **LAYAK** (~7 hari bekerja selepas permohonan ditutup), bukan semasa mengisi borang awal. Senarai semak di sini adalah penyederhanaan untuk latihan — bukan aliran muat naik sebenar.

**Apa yang anda patut nampak:** apabila anda tukar dropdown **Negara** daripada "Mesir" kepada "Maghribi", dropdown **Bidang** di bawahnya serta-merta menyusun semula (senarai berubah daripada "Perubatan, Farmasi, ..." kepada "Usuluddin, Bahasa Arab"), dan dropdown **Pilihan 1–3** turut menyusun semula mengikut bidang baharu — semuanya berlaku dalam satu ketukan, tanpa perlu tekan mana-mana butang "kemas kini".

### 6.7 `_submit()` — versi `setState()`-sahaja hari ini

Fail sebenar `application_form_screen.dart` menyimpan permohonan melalui `ApplicationProvider` (Bahagian 9) dan hanya memanggil `Navigator.of(context).pop();` tanpa nilai:

```dart
// lib/screens/application_form_screen.dart — versi projek sebenar (guna provider)
void _submit() {
  if (!_formKey.currentState!.validate()) return;
  if (_choice1 == null) {
    _snack('Sila pilih sekurang-kurangnya satu universiti (Pilihan 1).');
    return;
  }

  final choices = <String>[];
  for (final id in [_choice1, _choice2, _choice3]) {
    if (id != null && !choices.contains(id)) choices.add(id);
  }

  final provider = context.read<ApplicationProvider>();
  final application = Application(
    id: provider.nextId(),
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
  provider.add(application);

  _snack('Permohonan ${application.id} berjaya dihantar!');
  Navigator.of(context).pop(); // tutup borang
}
```

Tanpa `provider` (dan tanpa state global untuk mengira `nextId()`), kita gantikan dua baris terakhir dengan corak "hantar data keluar" daripada Bahagian 4.2 — `id` dijana terus daripada cap masa, dan objek `application` dipulangkan terus kepada skrin sebelumnya:

```dart
// versi setState()-sahaja — digunakan dalam Latihan 4 lab hari ini
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

Navigator.of(context).pop(application);   // pulangkan objek ke skrin sebelumnya
```

### 6.8 Salah Biasa Dalam Borang

Lima kesilapan ini menyumbang kepada hampir semua pepijat borang yang pelajar hadapi — kenal pasti sekarang supaya anda dapat elak semasa Latihan 4 lab:

| ❌ Kod biasa ditulis pelajar | Akibat | ✅ Pembetulan |
|---|---|---|
| Bina `Form` tanpa `GlobalKey<FormState>` langsung, atau lupa pasang `key: _formKey` pada `Form(...)` | `_formKey.currentState` sentiasa `null` → `_formKey.currentState!.validate()` lontar `Null check operator used on a null value` | Cipta `final _formKey = GlobalKey<FormState>();` sebagai field kelas, **dan** pasang `Form(key: _formKey, child: ...)` — dua langkah, kedua-duanya wajib |
| `validator: (v) { if (v.isEmpty) return 'ralat'; }` — fungsi tiada `return` untuk kes **sah** | Dart amaran/ralat: fungsi jangka pulangkan `String?` pada **setiap laluan kod**; medan sentiasa dianggap tidak sah walaupun diisi betul kerana laluan "sah" tiada `return null;` | Setiap `validator` **mesti** ada `return null;` eksplisit untuk kes sah — corak selamat: `return kondisiSalah ? 'mesej ralat' : null;` |
| Cipta `TextEditingController()` baharu di dalam `build()` (bukan sebagai field kelas) | `Controller` baharu dicipta **setiap kali** `build()` dipanggil; yang lama tidak pernah `dispose()` — bocor memori, dan teks yang ditaip pengguna **hilang** setiap kali rebuild | Cipta `Controller` **sekali** sebagai field kelas (Bahagian 6.3), rujuk instance yang **sama** dalam `build()` |
| Lupa panggil `.dispose()` pada satu (atau lebih) daripada lima `Controller` dalam `dispose()` | Bocor memori senyap — tiada ralat kelihatan serta-merta, tetapi aplikasi guna lebih banyak ingatan lama-kelamaan bila banyak skrin borang dibuka & ditutup | Semak **setiap** `Controller` yang dicipta ada padanan `.dispose()` — bilangan mesti **sama** (5 cipta = 5 dispose dalam contoh ini) |
| `setState()` dipanggil dalam callback tak segerak (`Future.then`, `Timer`) **selepas** pengguna sudah tutup skrin, tanpa semak `mounted` dahulu | Ralat masa jalan `setState() called after dispose()` — `State` sudah dimusnahkan tetapi kod cuba ubahnya | Semak `if (!mounted) return;` **sebelum** `setState()` dalam mana-mana kod tak segerak (rujuk Bahagian 8.4) |

---

## 7. Button & GestureDetector

### Kenapa ada tiga jenis butang?

Material Design membezakan **kepentingan visual** tindakan — bukan semua butang patut menonjol sama. Butang "Hantar Permohonan" ialah tindakan **paling penting** pada skrin borang, jadi ia patut paling menonjol; butang "Batal" kurang penting, jadi ia patut lebih senyap secara visual supaya tidak bersaing tumpuan dengan tindakan utama. Flutter sediakan tiga widget siap-guna untuk hierarki ini:

| Widget | Gaya visual | Bila guna |
|---|---|---|
| `ElevatedButton` | Latar berwarna + bayang (*elevation*) | Tindakan sekunder yang perlu menonjol sedikit |
| `FilledButton` | Latar berwarna pekat, tanpa bayang tebal | Tindakan **utama** skrin (cth. "Hantar Permohonan") |
| `TextButton` | Teks sahaja, tiada latar | Tindakan kurang penting (cth. "Batal") |

```dart
FilledButton.icon(
  onPressed: _submit,
  icon: const Icon(Icons.send),
  label: const Text('Hantar Permohonan'),
);
```

### 7.2 `GestureDetector` — gerak isyarat tersuai

Butang Material sedia guna hanya sokong satu gerak isyarat ringkas (`onPressed` = ketuk). Kadangkala anda perlukan gerak isyarat **lain** (tekan lama, dua kali ketuk) atau perlu jadikan **seluruh kawasan** (bukan satu butang kecil) boleh ditekan — contohnya seluruh kad tawaran. `GestureDetector` mengesan gerak isyarat sentuhan (`onTap`, `onLongPress`, `onDoubleTap`, seret/*drag*, dsb.) pada **mana-mana** widget — tetapi **tidak** memberi sebarang maklum balas visual sendiri (tiada kesan riak). Berguna untuk kawasan sentuhan tersuai yang bukan butang Material standard:

```dart
GestureDetector(
  onTap: () => Navigator.of(context).push(
    MaterialPageRoute(builder: (_) => ProgrammeDetailScreen(programme: p)),
  ),
  onLongPress: () => ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text('${p.quotaSeats} tempat (ilustrasi) di ${p.universityName}')),
  ),
  child: ProgrammeCard(programme: p),
);
```

### 7.3 `InkWell` vs `GestureDetector` — bila guna yang mana?

Projek sebenar menggunakan `InkWell`, bukan `GestureDetector`, untuk kawasan sentuhan kad tawaran (`lib/widgets/programme_card.dart`):

```dart
// lib/widgets/programme_card.dart
Card(
  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
  child: InkWell(
    onTap: onTap,
    child: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(/* ... */),
    ),
  ),
);
```

> **Peraturan mudah:** Guna **`InkWell`** apabila kawasan sentuhan berada di atas permukaan Material (kad, kotak, senarai) — ia memberi **kesan riak (ripple)** visual mengikut Material Design secara percuma, jadi pengguna dapat maklum balas sentuhan yang jelas. Guna **`GestureDetector`** apabila anda perlukan gerak isyarat yang `InkWell` tidak sokong (`onLongPress` gabungan kompleks, seret, cubit/*pinch*), atau kawasan sentuhan tanpa sebarang kesan visual (cth. kawasan telus di atas imej).

### ❌ Salah biasa — Button & GestureDetector

| ❌ Kod biasa ditulis pelajar | Akibat | ✅ Pembetulan |
|---|---|---|
| `GestureDetector` membalut `Container` **tanpa** `color`/`decoration` (kotak "kosong"/lutsinar) | Ketukan pada bahagian kosong kotak **tidak** mengesan — Flutter anggap kawasan lutsinar "tembus", ketukan jatuh ke widget di belakangnya | Beri `color` (walaupun `Colors.transparent`) pada `Container`, atau tetapkan `behavior: HitTestBehavior.opaque` pada `GestureDetector` |
| `onPressed: _submit()` (panggil terus fungsi, dengan kurungan) pada `FilledButton` | Fungsi `_submit()` dipanggil **serta-merta** semasa `build()` dijalankan (bukan bila butang ditekan) — selalunya punca ralat "setState() called during build" | Hantar **rujukan** fungsi: `onPressed: _submit` (**tanpa** kurungan) |
| `onPressed: null` secara tidak sengaja (lupa sambung kepada kaedah sebenar) | Butang kelihatan **pudar/kelabu** dan tidak bertindak balas langsung — Flutter reka bentuk `onPressed: null` sebagai cara **rasmi** untuk lumpuhkan butang | Semak `onPressed:` menuding kepada kaedah yang betul; kalau butang **sengaja** dilumpuhkan bersyarat, itu memang corak betul (rujuk `_sudahMohon ? null : _mohon`) |

---

## 8. `setState()` & Kitaran Hayat `StatefulWidget`

`setState()` ialah **satu-satunya** mekanisme pengurusan state yang diajar secara rasmi dalam kursus ini. Mari fahami sepenuhnya bagaimana ia berfungsi.

### 8.1 Apa yang berlaku bila `setState()` dipanggil?

```dart
setState(() {
  _fieldOfStudy = value;
});
```

1. Kod di dalam *closure* (`{ _fieldOfStudy = value; }`) dijalankan **serta-merta**, mengubah pembolehubah state.
2. `setState()` kemudian memberitahu Flutter: *"data dalam widget ini telah berubah, sila jadualkan `build()` semula."*
3. Flutter memanggil semula kaedah `build()` widget ini (dan hanya widget ini — bukan seluruh aplikasi), menghasilkan UI yang mencerminkan nilai `_fieldOfStudy` yang baharu — termasuk dropdown pilihan universiti yang telah disusun semula (Bahagian 6.6).

### 8.2 Kenapa **wajib** `setState()`, bukan tetapkan terus?

```dart
// ❌ SALAH — data berubah, tetapi UI TIDAK rebuild
onChanged: (v) => _country = v,

// ✅ BETUL — data berubah DAN UI diberitahu untuk rebuild
onChanged: (v) => _onCountryChanged(v),   // dalaman memanggil setState()
```

Flutter **tidak** memantau pembolehubah Dart secara automatik. Jika anda menetapkan `_country = v` tanpa `setState()`, nilai dalaman berubah, tetapi Flutter tidak tahu ia perlu melukis semula skrin — UI akan kelihatan **tidak berubah** walaupun data sebenarnya sudah berbeza (sehingga sesuatu yang lain mencetuskan rebuild).

**Bayangkan begini:** `setState()` seperti mengangkat tangan dalam bilik mesyuarat dan berkata "saya nak beri maklumat terkini" — Flutter (pengerusi mesyuarat) hanya dengar dan bertindak bila ada isyarat itu. Jika anda hanya tulis nota peribadi (`_country = v` tanpa `setState`) tanpa mengangkat tangan, tiada sesiapa di bilik itu tahu maklumat sudah berubah.

### 8.3 Susunan kitaran hayat (*lifecycle*)

```
createState()  →  initState()  →  build()  →  ... setState() → build() (berulang) ...  →  dispose()
                       │                              ▲
                       │                              │
                 (sekali sahaja,               (setiap kali state
                  bila widget dicipta)           berubah semasa
                                                  widget aktif)
```

| Kaedah | Bila dipanggil | Kegunaan biasa |
|---|---|---|
| `createState()` | **Sekali**, apabila widget dicipta — tugasnya **mencipta objek `State`** sahaja | Tidak perlu diubah dalam kebanyakan kes — `@override State<X> createState() => _XState();` sahaja |
| `initState()` | **Sekali sahaja**, sebaik `State` dicipta, sebelum `build()` pertama | Isi nilai awal, baca `widget.xxx`, mulakan `TextEditingController` |
| `build()` | Selepas `initState()`, dan **setiap kali** `setState()` dipanggil | Bina/lukis semula UI berdasarkan state terkini |
| `dispose()` | **Sekali sahaja**, sebaik `State` dimusnahkan (skrin ditutup) | `.dispose()` setiap `Controller`, batalkan `Timer`/`Stream` |

Contoh lengkap dalam `ApplicationFormScreen`:

```dart
class _ApplicationFormScreenState extends State<ApplicationFormScreen> {
  final _nameCtrl = TextEditingController();
  EntryCategory? _academicCategory;

  @override
  void initState() {
    super.initState();                       // WAJIB panggil dahulu
    _country = widget.programme.country;     // guna widget.xxx untuk baca constructor
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<EntryCategory>(
      initialValue: _academicCategory,
      onChanged: (v) => setState(() => _academicCategory = v),   // trigger rebuild
      // ...
    );
  }

  @override
  void dispose() {
    _nameCtrl.dispose();                      // WAJIB bersihkan
    super.dispose();                          // WAJIB panggil terakhir
  }
}
```

**Apa yang anda patut nampak (log konsol):** jika anda tambah `debugPrint()` pada setiap kaedah (rujuk Lab Latihan 6 — `LifecycleDemo`), urutan konsol semasa borang dibuka, diisi, dan ditutup akan kelihatan seperti: `initState()` **sekali** di awal, `build()` **berulang kali** (satu kali bagi setiap dropdown/checkbox yang ditekan), kemudian `dispose()` **sekali** bila skrin ditutup — **tidak pernah** sebelum itu.

### 8.4 Kesilapan biasa

| Kesilapan | Akibat | Pembetulan |
|---|---|---|
| `setState()` dipanggil **selepas** `dispose()` (cth. dalam callback `Future` yang selesai lewat, selepas skrin ditutup) | Ralat masa jalan: `setState() called after dispose()` | Semak `if (!mounted) return;` sebelum `setState()` dalam callback tak segerak (*async*) |
| `setState()` dipanggil **di dalam** `build()` terus (bukan dalam `onPressed`/`onTap`) | Gelung rebuild tak terhingga (*infinite loop*) atau ralat "setState() called during build" | `setState()` hanya boleh dipanggil daripada **pengendali** (*handler*) seperti `onPressed`, `onChanged`, bukan terus dalam `build()` |
| Lupa panggil `super.initState()` / `super.dispose()` | Kelakuan luar jangka — kelas induk (`State`) tidak sempat sedia/bersih dengan betul | `super.initState()` **baris pertama** dalam `initState()`; `super.dispose()` **baris terakhir** dalam `dispose()` |
| Cipta `Controller` baharu setiap kali `build()` dipanggil | `Controller` lama tidak pernah `dispose()` — bocor memori | Cipta `Controller` **sekali** sebagai `field` kelas (Bahagian 6.3), bukan di dalam `build()` |
| `Navigator.of(context).pop()` dipanggil selepas `await` sesuatu operasi panjang (cth. panggilan rangkaian), tanpa semak `mounted` dahulu | Ralat masa jalan bila pengguna sudah tinggalkan skrin sebelum operasi selesai — `context` tidak lagi sah untuk digunakan | Semak `if (!mounted) return;` **sebelum** guna `context`/`Navigator.of(context)` selepas mana-mana `await` |

---

## Ringkasan Setakat Ini — Borang & State (SESI 5, Bahagian 6–8)

- **`Form` + `GlobalKey<FormState>`** = bungkusan pengesahan kolektif; `TextEditingController` = cara baca/tetap nilai setiap medan; **kedua-duanya** field kelas, dicipta sekali, `Controller` **mesti** di-`dispose()`.
- **Peraturan eTT** (1 negara + 1 bidang + 1–3 pilihan universiti) dikuatkuasakan melalui dropdown **saling bergantung** — tukar satu, `setState()` reset yang bergantung kepadanya.
- **`setState()`** ialah satu-satunya cara memberitahu Flutter "lukis semula" — data berubah **tanpa** `setState()` tidak kelihatan pada skrin. Kitaran hayat: `createState → initState → build → (setState → build)* → dispose`, setiap satu **sekali** kecuali `build`.

---

## 9. `provider` Dalam Projek Sebenar

Fail sebenar `lib/providers/application_provider.dart`, `lib/providers/programme_provider.dart`, dan `lib/providers/profile_provider.dart` dalam projek `ett_mobile` menggunakan pakej **`provider`** (`ChangeNotifier` + `context.watch()`/`context.read()`) supaya data permohonan & tawaran dikongsi merentasi tab "Program", "Permohonan Saya", dan "Profil" — dan `shared_preferences` (`loadFromStorage()`) supaya data kekal selepas app ditutup. Ini corak yang berguna sebaik aplikasi membesar kepada banyak skrin yang perlu berkongsi data yang sama, bukan sekadar hantar data terus antara dua skrin seperti Bahagian 4. Baca lanjut di [`nota/05-state-management.md`](../nota/05-state-management.md).

---

## 10. Troubleshooting Hari Ini

Ralat yang paling kerap muncul semasa membina navigasi & borang — simptom, punca, dan pembetulan:

| Simptom | Punca | Pembetulan |
|---|---|---|
| `Null check operator used on a null value` bila tekan "Hantar Permohonan" | `_formKey.currentState` bernilai `null` (kunci tidak dipasang pada `Form`), atau `_academicCategory!` dipanggil sedangkan pengguna belum pilih kategori | Semak `Form(key: _formKey, ...)` benar-benar dipasang. **Punca paling kerap:** `Form` membalut `ListView` — `ListView` malas (*lazy*), medan yang ditatal keluar skrin dilupuskan & terkeluar daftar `Form`, jadi `validate()` "lulus" walaupun borang kosong. Guna `SingleChildScrollView` + `Column`, dan tambah pengawal `if (_academicCategory == null) return;` sebelum baris `!` |
| `setState() called after dispose()` | `setState()` dipanggil dalam callback (`Future`, `Timer`) selepas skrin sudah ditutup pengguna | Tambah `if (!mounted) return;` sebelum `setState()` dalam kod tak segerak (Bahagian 8.4) |
| `RenderFlex overflowed by NN pixels` pada dropdown pilihan universiti (nama universiti panjang) | `DropdownButtonFormField` tanpa `isExpanded: true`, atau `Text` tanpa `overflow: TextOverflow.ellipsis` cuba muat dalam ruang sempit | Tambah `isExpanded: true` pada dropdown, dan `overflow: TextOverflow.ellipsis` pada `Text` item senarai |
| Skrin merah/kelabu "Unknown route" selepas `pushNamed('/detail', ...)` | Laluan `/detail` tidak didaftar dalam `routes:`/`onGenerateRoute` `MaterialApp` | Pastikan setiap nama laluan yang dipanggil sepadan **tepat** (case-sensitive) dengan yang didaftarkan |
| Skrin borang kelihatan **sama** selepas anda ubah kod, walaupun sudah simpan fail | Hot Reload **tidak** mengesan perubahan pada `main()`, `initState()` yang sudah dijalankan, atau perubahan struktur `enum`/`class` besar | Guna **Hot Restart** (`R` besar dalam terminal, atau ikon *restart* penuh di VS Code) — bukan sekadar Hot Reload (`r`) — bila perubahan melibatkan `initState`, tambah `field` baharu pada `State`, atau struktur kelas |
| `type 'Null' is not a subtype of type 'String'` bila baca `hasil.id` selepas `push<Application>()` | Skrin borang ditutup **tanpa** hantar (`pop()` kosong / butang kembali biasa), `hasil` bernilai `null`, tetapi kod terus guna `hasil.id` tanpa semak dahulu | Semak `if (hasil != null) { ... }` sebelum guna sebarang medan pada `hasil` (Bahagian 4.2) |
| Borang "kosongkan diri sendiri" setiap kali anda taip huruf seterusnya dalam mana-mana medan | `TextEditingController` dicipta semula di dalam `build()` (bukan field kelas) — setiap `setState()`/rebuild mencipta controller **baharu** kosong | Pindah semua `final xCtrl = TextEditingController();` ke **luar** `build()`, sebagai field kelas (Bahagian 6.3) |

---

## 11. Rumusan

Hari ini anda telah:

- Memahami konsep tindanan (*stack*) navigasi dan `Navigator.push`/`pop` dengan `MaterialPageRoute`.
- Mendaftar **named routes** (`routes:`, `onGenerateRoute`, `Navigator.pushNamed`) dan memahami bila ia lebih sesuai berbanding `push` terus.
- Menghantar data **masuk** (parameter constructor) dan **keluar** (`Navigator.pop(value)` + `await push<T>()`) antara skrin.
- Membezakan `TextField` (mandiri) dan `TextFormField` (disahkan dalam `Form`).
- Membina borang lengkap dengan `Form`, `GlobalKey<FormState>`, `TextEditingController`, `validator`, dropdown negara/bidang saling bergantung, senarai semak dokumen, dan kitaran hayat `initState`/`dispose`.
- Menggunakan `ElevatedButton`/`FilledButton`/`TextButton`, `GestureDetector`, dan memahami bila `InkWell` lebih sesuai.
- Menulis logik pengesahan borang dengan bantuan AI — **dan** menyemaknya secara kritikal dengan ujian kes tepi + `dart analyze`.
- Menguasai `setState()` dan kitaran hayat penuh `StatefulWidget`, termasuk kesilapan biasa yang perlu dielakkan.

### Tip Git

```bash
git add lib/screens/programme_detail_screen.dart \
        lib/screens/application_form_screen.dart \
        lib/models/application.dart
git commit -m "Hari 3: navigasi, named routes, borang permohonan eTT & setState()"
```

> **Amalan baik:** `flutter analyze` sebelum setiap commit — terutamanya penting hari ini kerana banyak fungsi validator baharu ditambah.

### Pratonton Hari 4

Esok kita sambungkan senarai tawaran kepada **REST API** sebenar menggunakan pakej `http` — `GET`/`POST`, `async`/`await`, dan pengendalian ralat rangkaian.

---

**Sebelum ini:** Hari 2 — Layout, Senarai & Kemasan
**Selepas ini:** [Hari 4 — REST API & Data Dinamik](../hari-4/README.md)

Lihat juga: [Lab Hari 3 — Latihan Tangan](./snippets/lab.md) · [`validators.dart`](./snippets/validators.dart)

---

> 🎤 **Nota penceramah/jurulatih:** [`nota-penceramah.md`](./nota-penceramah.md) — kumpulan nota persembahan untuk Hari 3.

## Nota Tambahan (fakta ringkas dari slaid)

- 📊 **PENTING — `quotaSeats` adalah ILUSTRASI, KECUALI laluan Maghribi (Morocco).** Kuota Maghribi (`ETT-007`, `ETT-008`) — **15 tempat** — ialah angka **rasmi** kerajaan Maghribi; semua kuota Mesir dalam data sampel adalah anggaran latihan. Jangan salah tafsir semasa memaparkannya pada skrin butiran.
- **`ProgrammeDetailScreen` memaparkan:** baris `_InfoRow` untuk **Kategori** (kelayakan kemasukan), **Kos Anggaran** (RM/tahun, berlabel "ilustrasi"), **Peringkat**, **Ambilan**, dan **Kuota** (berlabel "ilustrasi"); ditambah kotak **Nota Pengiktirafan** (`recognitionNote`) yang membawa kaveat kos, dan `CategoryPill` untuk kategori sijil (SPM/STAM/kedua-dua).
- **Peraturan permohonan sebenar eTT: SATU negara + SATU bidang** setiap permohonan (panduan awam), dengan sehingga **3 pilihan universiti** disusun dalam bidang itu (daripada use-case dalaman BPM) — lihat Bahagian 6.6.
- **`createState()`** dalam kitaran hayat `StatefulWidget`: dipanggil **sekali** apabila widget dicipta — tugasnya **mencipta objek `State`**. Selepas itu barulah `initState()` → `build()` → (`setState()` → `build()` berulang) → `dispose()`.
