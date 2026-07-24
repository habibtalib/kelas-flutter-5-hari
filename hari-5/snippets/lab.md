# Lab Hari 5 — Projek Mini, Clean Code & Refactoring

Lab ini **ialah** *hackathon* hari ini. Anda akan membina prototaip berfungsi **eTT Mobile** — senarai tawaran pengajian (Mesir/Maghribi) dari API, skrin butiran, borang permohonan, dan senarai "Permohonan Saya" — semuanya menggunakan `setState()` (silibus rasmi kursus). Kemudian anda akan menggilapkannya dengan *refactoring* dan bersedia untuk demo.

> **Foundation siap:** folder [`starter/`](./starter/) mengandungi **keseluruhan foundation terkumpul** (models, data, servis, tema, widget) — salin ke `lib/` supaya anda fokus **membina skrin** sahaja (lihat Persediaan). `projek/ett_mobile/lib/` ialah rujukan hasil akhir; `screens/` + `providers/` di sana guna pakej `provider` (pratonton state dikongsi) — hari ini anda bina versi **`setState()`** anda sendiri untuk `screens/`. Cuba dahulu sebelum mengintai jawapan!

**Cara baca kod dalam lab ini** (sama seperti Hari 1): blok kod menunjukkan **sekeping fail sebenar**, bukan baris terpencil. `// ...` bermaksud "kod sedia ada, jangan ubah". Kotak `╔═╗` atau komen `👈 TAMBAH DI SINI` menunjukkan **tempat tepat** anda menaip kod baharu. Selepas setiap langkah, bandingkan hasil anda dengan blok "hasil"/checkpoint yang disediakan.

```dart
// ╔══════════════════════════════════════════╗
// ║  LANGKAH X.Y — kod anda masuk DI SINI    ║
// ╚══════════════════════════════════════════╝
```

### Dua penanda ujian — apa bezanya

Lab ini ada **dua** jenis arahan menguji. Jangan keliru:

| Penanda | Maksud | Perlu buat? |
|---|---|---|
| ▶ **Jalankan** | Semakan **pantas** di tengah langkah — Hot Reload / `flutter analyze`, pandang skrin sekejap, teruskan. Ambil ~10 saat. | Ya, tetapi ringkas |
| 🧪 **Uji Latihan N** | Ujian **penuh** di hujung setiap latihan. Ada **laluan navigasi** ("macam mana nak sampai ke skrin itu"), jadual langkah demi langkah, dan petua bila gagal. | **Ya — jangan langkau.** Ini bukti latihan anda betul |

Setiap blok 🧪 **Uji** disusun begini:

> **Sampai ke sana:** langkah navigasi dari skrin mula — supaya anda tidak tercari-cari.
>
> Kemudian jadual: **Buat ini** → **Patut nampak**. Buat ikut turutan, dari atas ke bawah. Bila latihan ada lebih daripada satu laluan (berjaya vs gagal, kosong vs berisi), jadual dipecah kepada **Bahagian A / B / C** — buat kesemuanya.
>
> Akhir sekali **❌ Tak jadi?** — senarai punca paling biasa, supaya anda boleh baiki sendiri tanpa tunggu jurulatih.

> ⚠️ **Perhatian data sepanjang lab ini:** kad **1, 2 dan 3 semuanya "Universiti Al-Azhar"** — bezanya pada **bidang** (Perubatan · Syariah dan Undang-undang · Ulum Islamiah). Jangan sekali-kali banding kad 1 lawan kad 2 untuk membuktikan data dihantar dengan betul; anda akan nampak nama sama dan tersilap sangka ada pepijat. Guna kad **1, 4 dan 7** yang jelas berbeza.

---

## Persediaan

1. Cipta projek Flutter baharu (atau teruskan projek `ett_mobile` Hari 1–4):
   ```bash
   flutter create ett_mobile
   cd ett_mobile
   flutter pub add http intl
   ```
2. **Salin fail permulaan (foundation).** Hari ini anda memasang **skrin** di atas foundation terkumpul 4 hari — jangan taip semula model/data/servis. Salin folder [`starter/`](./starter/) ke `lib/` (rujuk [`starter/README.md`](./starter/README.md)):
   ```bash
   # dari dalam folder projek ett_mobile anda
   mkdir -p lib/models lib/data lib/services lib/widgets
   cp <laluan-repo>/hari-5/snippets/starter/theme.dart                    lib/theme.dart
   cp <laluan-repo>/hari-5/snippets/starter/models/programme.dart         lib/models/programme.dart
   cp <laluan-repo>/hari-5/snippets/starter/models/application.dart        lib/models/application.dart
   cp <laluan-repo>/hari-5/snippets/starter/data/sample_programmes.dart    lib/data/sample_programmes.dart
   cp <laluan-repo>/hari-5/snippets/starter/data/document_checklist.dart   lib/data/document_checklist.dart
   cp <laluan-repo>/hari-5/snippets/starter/services/programme_service.dart lib/services/programme_service.dart
   cp <laluan-repo>/hari-5/snippets/starter/widgets/programme_card.dart    lib/widgets/programme_card.dart
   cp <laluan-repo>/hari-5/snippets/starter/widgets/status_badge.dart      lib/widgets/status_badge.dart
   ```
   > Jika anda membina `ett_mobile` sepanjang Hari 1–4, kebanyakan fail ini **sudah ada** — folder `starter/` cuma jaring keselamatan supaya semua orang mula dengan foundation yang **sama**. Skrin (`screens/`) sahaja yang anda bina hari ini.
3. **JANGAN salin folder `providers/`** — anda akan urus *state* dengan `setState()` + callback sahaja hari ini (silibus rasmi kursus).
4. **Sediakan `main()` untuk tarikh Bahasa Melayu.** Skrin "Permohonan Saya" (Latihan 5.3) memaparkan tarikh dengan `DateFormat(..., 'ms')`. Data locale `ms` **mesti** dimuatkan dahulu, jika tidak aplikasi ranap dengan `LocaleDataException` sebaik sahaja permohonan pertama dipapar. Tetapkan sekarang — jangan tunggu ia ranap:

   ```dart
   // lib/main.dart
   import 'package:flutter/material.dart';
   import 'package:intl/date_symbol_data_local.dart';   // 👈 TAMBAH

   import 'screens/home_screen.dart';
   import 'theme.dart';

   Future<void> main() async {                          // 👈 UBAH: async
     WidgetsFlutterBinding.ensureInitialized();         // 👈 TAMBAH
     await initializeDateFormatting('ms', null);        // 👈 TAMBAH
     runApp(const EttMobileApp());
   }
   ```

5. Jalankan `flutter pub get`, kemudian sahkan projek boleh `flutter run` (skrin kosong/`Placeholder()` tidak mengapa buat masa ini).

▶ **Jalankan** (`flutter analyze`, sebelum tambah apa-apa skrin) → anda patut nampak **`No issues found!`**. Ini titik permulaan bersih anda — kalau ada ralat di sini, ia dari fail starter yang tersalin separuh, bukan kod anda.

✅ **Semakan Persediaan:**

- [ ] `flutter analyze` bersih **sebelum** anda tambah sebarang skrin (fail yang disalin sahaja).
- [ ] Kelapan-lapan fail starter wujud dalam `lib/` (`theme.dart`, 2 model, 2 data, 1 servis, 2 widget) — dan `lib/providers/` **tidak** disalin.
- [ ] Anda sudah baca bahagian **"Peta Projek"** dalam [`README.md`](../README.md#peta-projek--fail-skrin--susunan-pembinaan) — faham aliran data `HomeScreen → ProgrammeListScreen → ProgrammeDetailScreen → ApplicationFormScreen`, dan callback yang "naik balik".

---

## Latihan 1 — Rangka Projek: `HomeScreen` & Tab

**Objektif:** Bina rangka utama aplikasi — dua tab (Tawaran / Permohonan Saya) yang berkongsi **satu** senarai `Application`, tersimpan di titik paling atas yang perlu.

### 1.1 — Fail permulaan

Buka `lib/screens/home_screen.dart` (fail kosong), tampal rangka ini:

```dart
// lib/screens/home_screen.dart — FAIL PERMULAAN LAB HARI 5
import 'package:flutter/material.dart';

import '../models/application.dart';
import 'my_applications_screen.dart';
import 'programme_list_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentTab = 0;

  // ╔══════════════════════════════════════════════════╗
  // ║  1.2 — Senarai permohonan (state kongsi) DI SINI ║
  // ╚══════════════════════════════════════════════════╝

  // ╔══════════════════════════════════════════════════╗
  // ║  1.3 — Kaedah tambah permohonan DI SINI          ║
  // ╚══════════════════════════════════════════════════╝

  @override
  Widget build(BuildContext context) {
    // 👈 1.4 — GANTI baris di bawah dengan Scaffold + tab sebenar
    return const Scaffold(body: Center(child: Text('TODO')));
  }
}
```

### 1.2 — Tambah state kongsi

Ganti kotak `╔ 1.2 ╗`. Ini medan **paling penting** hari ini — kerana ia disimpan di `HomeScreen` (bukan dalam salah satu tab), KEDUA-DUA tab boleh mengaksesnya:

```dart
  // ── 1.2 — Senarai permohonan (state kongsi) ───────────
  final List<Application> _applications = [];
```

### 1.3 — Tambah kaedah pengubah

Ganti kotak `╔ 1.3 ╗`:

```dart
  // ── 1.3 — Kaedah tambah permohonan ────────────────────
  void _addApplication(Application application) {
    setState(() {
      _applications.add(application);
    });
  }
```

### 1.4 — Bina `Scaffold` + tab

Ganti `return const Scaffold(...)`:

```dart
  @override
  Widget build(BuildContext context) {
    // ── 1.4 — Scaffold + tab ──────────────────────────
    final tabs = [
      ProgrammeListScreen(onApplicationSubmitted: _addApplication),
      MyApplicationsScreen(applications: _applications),
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('eTT Mobile')),
      body: tabs[_currentTab],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentTab,
        onDestinationSelected: (i) => setState(() => _currentTab = i),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.list_alt), label: 'Tawaran'),
          NavigationDestination(
            icon: Icon(Icons.assignment_outlined),
            label: 'Permohonan Saya',
          ),
        ],
      ),
    );
  }
```

Fail ini **tidak akan** `flutter analyze` bersih lagi kerana `ProgrammeListScreen` dan `MyApplicationsScreen` belum wujud dengan parameter yang betul — itu normal, kita bina keduanya seterusnya. Set `main.dart` anda memanggil `HomeScreen()` sebagai `home:` dalam `MaterialApp`.

▶ **Jalankan** (`flutter analyze`) → anda patut nampak ralat "The name 'ProgrammeListScreen' isn't defined" (dan sama untuk `MyApplicationsScreen`). **Baca ralat itu** — ia dijangka: kedua-dua skrin dibina di Latihan 2 & 5. Ralat *lain* (cth. `_addApplication` tidak digunakan) menandakan salah taip pada kotak 1.2/1.3 — betulkan dahulu.

**Soalan renungan:** kenapa `_applications` diletak di `HomeScreen` dan bukan di `MyApplicationsScreen`? (Petunjuk: `ApplicationFormScreen` — skrin yang jauh lebih dalam — juga perlu **menambah** kepadanya, sedangkan ia bukan keturunan `MyApplicationsScreen` dalam pepohon widget. State kongsi mesti duduk di **nenek moyang sepunya** kedua-dua penulis dan pembaca.)

### 🧪 Uji Latihan 1

> **Sampai ke sana:** buka **terminal** dalam folder projek anda (`cd ett_mobile`). Latihan ini **tiada** ujian skrin — `flutter run` belum boleh berjaya kerana kedua-dua tab (`ProgrammeListScreen`, `MyApplicationsScreen`) belum wujud. Yang kita sahkan sekarang ialah **struktur** `home_screen.dart` + mesej `flutter analyze`.

| # | Buat ini | Patut nampak |
|---|---|---|
| 1 | Jalankan `flutter analyze` | Ralat "The name 'ProgrammeListScreen' isn't defined" **dan** "The name 'MyApplicationsScreen' isn't defined" |
| 2 | Baca **baki** senarai ralat | **Tiada ralat lain.** Dua ralat di atas sahaja yang dijangka pada peringkat ini |
| 3 | Buka `home_screen.dart`, cari `final List<Application> _applications = [];` | Ia berada di dalam `_HomeScreenState` — **bukan** di dalam `build()`, dan bukan dalam mana-mana fail tab |
| 4 | Baca `_addApplication` | `_applications.add(application);` berada **di dalam** `setState(() { ... })`, bukan di luarnya |
| 5 | Baca `build()` | `NavigationBar` ada **dua** destinasi berlabel **"Tawaran"** dan **"Permohonan Saya"**; `body:` ialah `tabs[_currentTab]` |
| 6 | Semak baris `final tabs = [...]` | Tab pertama menerima `onApplicationSubmitted: _addApplication`, tab kedua menerima `applications: _applications` |

❌ **Tak jadi?**
- `flutter analyze` **bersih sepenuhnya** → anda belum simpan fail, atau `return const Scaffold(body: Center(child: Text('TODO')));` masih di tempatnya (langkah 1.4 belum diganti).
- Ralat `The name '_addApplication' isn't defined` → kotak `1.3` belum diganti, atau kaedah itu tertulis di **luar** kelas `_HomeScreenState`.
- Ralat `Undefined class 'Application'` → `import '../models/application.dart';` tertinggal di atas fail.
- Amaran `The declaration '_addApplication' isn't referenced` → anda belum ganti kotak `1.4`; `_addApplication` hanya "digunakan" apabila ia dihantar kepada `ProgrammeListScreen`.
- Ralat menyebut `lib/models/...` atau `lib/widgets/...` → itu fail **starter**, bukan kod anda: salin semula fail berkenaan dari `hari-5/snippets/starter/`.

---

## Latihan 2 — API + Senarai Tawaran Pengajian (`ProgrammeListScreen`)

**Objektif:** Bina `ProgrammeListScreen` yang mengambil data daripada `ProgrammeService` dan memaparkannya dalam `ListView.builder`, dengan keadaan *loading*.

### 2.1 — Fail permulaan

```dart
// lib/screens/programme_list_screen.dart — FAIL PERMULAAN
import 'package:flutter/material.dart';

import '../models/application.dart';
import '../models/programme.dart';
import '../services/programme_service.dart';
import '../widgets/programme_card.dart';
// import 'programme_detail_screen.dart'; // 👈 aktifkan (buang //) di Latihan 3.4

class ProgrammeListScreen extends StatefulWidget {
  const ProgrammeListScreen({super.key, required this.onApplicationSubmitted});

  final ValueChanged<Application> onApplicationSubmitted;

  @override
  State<ProgrammeListScreen> createState() => _ProgrammeListScreenState();
}

class _ProgrammeListScreenState extends State<ProgrammeListScreen> {
  // ╔══════════════════════════════════════════════╗
  // ║  2.2 — Medan state (data + loading) DI SINI  ║
  // ╚══════════════════════════════════════════════╝

  // ╔══════════════════════════════════════════════╗
  // ║  2.3 — initState() + _loadProgrammes() DI SINI║
  // ╚══════════════════════════════════════════════╝

  @override
  Widget build(BuildContext context) {
    // 👈 2.4 — GANTI baris di bawah
    return const SizedBox.shrink();
  }
}
```

### 2.2 — Medan state

```dart
  // ── 2.2 — Medan state ──────────────────────────
  List<Programme> _programmes = [];
  bool _isLoading = true;
```

### 2.3 — `initState()` + pengambilan data

Ini **langkah paling penting** latihan ini — perhatikan `if (!mounted) return;` **sebelum** `setState`:

```dart
  // ── 2.3 — initState() + _loadProgrammes() ──────
  @override
  void initState() {
    super.initState();
    _loadProgrammes();
  }

  Future<void> _loadProgrammes() async {
    final data = await ProgrammeService().fetchProgrammes();
    // Skrin ini mungkin sudah ditutup pengguna semasa API masih menunggu —
    // setState() selepas skrin ditutup akan lontar ralat. Semak dahulu.
    if (!mounted) return;
    setState(() {
      _programmes = data;
      _isLoading = false;
    });
  }
```

**Kenapa `initState()`, bukan `build()`?** `initState()` jalan **sekali** semasa skrin dicipta; `build()` jalan **berpuluh kali** — panggil API dalam `build()` = hantar permintaan berulang tanpa sebab. (Rujuk nota Hari 3 — kitaran hayat `StatefulWidget`.)

### 2.4 — `build()`: loading atau senarai

```dart
  @override
  Widget build(BuildContext context) {
    // ── 2.4 — build(): loading atau senarai ────────
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    return ListView.builder(
      itemCount: _programmes.length,
      itemBuilder: (context, index) {
        final p = _programmes[index];
        return ProgrammeCard(
          programme: p,
          onTap: () {
            // 👈 2.5 (Latihan 3) — Navigator.push ke ProgrammeDetailScreen
          },
        );
      },
    );
  }
```

**Uji skrin ini secara berasingan.** `HomeScreen` (Latihan 1) mengimport `my_applications_screen.dart` yang **belum wujud**, jadi selagi `main.dart` mengimport `HomeScreen`, projek tak dapat *compile*. Dalam `main.dart`, **komen sementara** import itu dan halakan `home:` terus ke skrin hari ini:

```dart
// import 'screens/home_screen.dart';          // 👈 komen sementara — pulih di Latihan 5.4
import 'screens/programme_list_screen.dart';   // 👈 tambah sementara

// ... di dalam MaterialApp:
      home: ProgrammeListScreen(onApplicationSubmitted: (_) {}), // sementara — Latihan 2
```

> **Kenapa ini berkesan:** `flutter run` hanya *compile* fail yang boleh **dicapai** (reachable) daripada `main.dart`. Dengan import `home_screen.dart` dikomen, fail rosak itu tak disentuh langsung. (`flutter analyze` pula memeriksa **semua** fail dalam `lib/`, jadi ia masih akan merungut — itu dijangka sehingga Latihan 5.)

▶ **Jalankan** (`flutter run`) → anda patut nampak, mengikut urutan: (1) `CircularProgressIndicator` di tengah skrin selama ~0.6 saat, kemudian (2) senarai **8** kad tawaran pengajian (kad `ProgrammeCard` starter — bendera + universiti + kos RM). Menekan kad belum buat apa-apa (itu Latihan 3).

**Eksperimen — keadaan `_isLoading`:**

| Cuba tukar | Perhatikan | Kesimpulan |
|---|---|---|
| `bool _isLoading = true;` → `false` (nilai awal) | Skrin melompat terus ke senarai kosong seketika, kemudian kad muncul — **tiada** spinner | `build()` bergantung terus pada `_isLoading`; nilai awal `true` yang menyebabkan spinner mula-mula |
| Padam sementara `_isLoading = false;` dalam `setState` (2.3) | Spinner **kekal selamanya**, kad tak muncul walaupun data sudah sampai | UI tidak berubah **melainkan** `setState` mengubah medan yang `build()` baca — data sampai sahaja tak cukup |

Kembalikan kedua-dua baris kepada asal (`_isLoading = true;` awal, `_isLoading = false;` dalam `setState`) selepas mencuba.

> **Eksperimen `mounted`:** Sengaja padam baris `if (!mounted) return;`, kemudian navigasi cepat masuk-keluar skrin ini semasa data masih dimuat. Selalunya tiada kesan segera dalam mod *debug*, tetapi ini punca **sebenar** ralat `setState() called after dispose()` yang akan anda cetuskan secara sengaja dalam Latihan 6. Kembalikan baris itu sebelum teruskan.

> **Rujukan:** `projek/ett_mobile/lib/services/programme_service.dart`, `lib/widgets/programme_card.dart`

### 🧪 Uji Latihan 2

> **Sampai ke sana:** dalam `main.dart`, komen import `home_screen.dart`, tambah import `programme_list_screen.dart`, dan tetapkan `home: ProgrammeListScreen(onApplicationSubmitted: (_) {})` (lihat blok di atas). Kemudian `flutter run` — atau tekan **`R`** besar (Hot **Restart**) jika app sudah berjalan, kerana `main.dart` berubah.

**Bahagian A — laluan berjaya (spinner → senarai):**

| # | Buat ini | Patut nampak |
|---|---|---|
| 1 | `flutter run` (atau `R`) | `CircularProgressIndicator` di **tengah** skrin selama ~0.6 saat |
| 2 | Tunggu spinner hilang | Senarai **8** kad tawaran, boleh ditatal |
| 3 | Kira kad mengikut bendera | **6** kad 🇪🇬 Mesir (Al-Azhar ×3, Alexandria, Ain Shams, Tanta) + **2** kad 🇲🇦 Maghribi (Al Quaraouiyine, Mohammed V) |
| 4 | Pandang kad **ke-1** | 🇪🇬 · "Universiti Al-Azhar" · "Perubatan (Medicine)" · "Kaherah (Cairo), Mesir" · **RM23,000** `/tahun` · cip **SPM** |
| 5 | Pandang kad **ke-4** | 🇪🇬 · "Universiti Alexandria" · "Farmasi (Pharmacy)" · "Iskandariah (Alexandria), Mesir" · **RM36,000** |
| 6 | Tatal ke kad **ke-7** | 🇲🇦 · "Universite Al Quaraouiyine" · "Usuluddin" · "Fes, Maghribi" · **RM6,000** · cip **SPM atau STAM** |
| 7 | Tekan mana-mana kad | **Tiada apa berlaku** — betul; `onTap` masih kosong sehingga Latihan 3 |

> ⚠️ Kad **1, 2 dan 3** semuanya bernama "Universiti Al-Azhar" (bidang: Perubatan · Syariah dan Undang-undang · Ulum Islamiah). Ini **data sebenar**, bukan pepijat pemaparan.

**Bahagian B — buktikan `_isLoading` benar-benar mengawal skrin:**

| # | Buat ini | Patut nampak |
|---|---|---|
| 8 | Tekan `R` (Hot Restart) sekali lagi | Spinner muncul **semula** dahulu, kemudian senarai — bukti `_isLoading = true` ialah nilai **awal** |
| 9 | Terminal: `flutter analyze` | Ralat **hanya** dari `home_screen.dart` (`MyApplicationsScreen` belum wujud) — dijangka sehingga Latihan 5.4 |
| 10 | Semak senarai ralat itu | **Tiada** ralat dalam `programme_list_screen.dart`. Jika ada, betulkan sekarang sebelum teruskan |

❌ **Tak jadi?**
- Spinner **kekal selamanya**, kad tak muncul → `_isLoading = false;` tertinggal daripada `setState` dalam `_loadProgrammes()` (2.3), atau anda masih dalam mod eksperimen jadual di atas.
- Skrin putih kosong, **tiada** spinner langsung → `build()` masih `return const SizedBox.shrink();` (kotak 2.4 belum diganti).
- Ralat `Target of URI doesn't exist: 'my_applications_screen.dart'` semasa `flutter run` → import `home_screen.dart` dalam `main.dart` belum dikomen.
- `Undefined name 'ProgrammeService'` → `import '../services/programme_service.dart';` tertinggal di atas `programme_list_screen.dart`.
- Senarai keluar **serta-merta** tanpa spinner → `bool _isLoading = true;` tersalah tulis sebagai `false`.
- Kad muncul tetapi tiada bendera / kos tanpa "RM" → `widgets/programme_card.dart` starter tersalin separuh; salin semula fail penuh.
- Senarai bukan 8 kad → `ProgrammeService` gagal mencapai API **dan** fallback `sampleProgrammes` tersalin separuh; sahkan `data/sample_programmes.dart` ada `ETT-001` hingga `ETT-008`.

---

## Latihan 3 — Skrin Butiran + Navigasi (`ProgrammeDetailScreen`)

**Objektif:** Navigasi daripada kad senarai ke skrin butiran penuh, menghantar objek `Programme` yang dipilih **dan** *callback* `onApplicationSubmitted` yang perlu "diteruskan" hingga ke borang.

### 3.1 — Fail permulaan

```dart
// lib/screens/programme_detail_screen.dart — FAIL PERMULAAN
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../data/sample_programmes.dart';
import '../models/application.dart';
import '../models/programme.dart';
import '../theme.dart';
import '../widgets/programme_card.dart';
import 'application_form_screen.dart';

class ProgrammeDetailScreen extends StatelessWidget {
  const ProgrammeDetailScreen({
    super.key,
    required this.programme,
    required this.onApplicationSubmitted,
  });

  final Programme programme;
  final ValueChanged<Application> onApplicationSubmitted;

  @override
  Widget build(BuildContext context) {
    final rm = NumberFormat.currency(locale: 'ms_MY', symbol: 'RM', decimalDigits: 0);

    return Scaffold(
      appBar: AppBar(title: Text(programme.universityName)),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          // ╔════════════════════════════════════════╗
          // ║  3.2 — Kandungan butiran DI SINI       ║
          // ╚════════════════════════════════════════╝

          // ╔════════════════════════════════════════╗
          // ║  3.3 — Butang "Mohon Sekarang" DI SINI ║
          // ╚════════════════════════════════════════╝
        ],
      ),
    );
  }
}
```

### 3.2 — Kandungan butiran

```dart
          // ── 3.2 — Kandungan butiran ────────────────
          Text(programme.flagEmoji, style: const TextStyle(fontSize: 40)),
          const SizedBox(height: 8),
          Text(
            programme.fieldOfStudy,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: KptTheme.navy,
            ),
          ),
          const SizedBox(height: 4),
          Text('${programme.city}, ${programme.countryLabel}'),
          const SizedBox(height: 12),
          CategoryPill(category: programme.category),
          const SizedBox(height: 16),
          Text('Kos anggaran: ${rm.format(programme.estimatedAnnualCostMyr)} / tahun '
              '(ilustrasi)'),
          Text('Kuota: ${programme.quotaSeats} tempat (ilustrasi)'),
          Text('Ambilan: ${programme.intakeMonth}'),
          const SizedBox(height: 16),
          Text(programme.recognitionNote, style: const TextStyle(fontSize: 13)),
```

### 3.3 — Butang navigasi ke borang

Perhatikan kita hantar `sampleProgrammes` penuh sebagai `allProgrammes` — diperlukan borang untuk cari calon Pilihan 2 & 3 (negara+bidang yang sama):

```dart
          // ── 3.3 — Butang "Mohon Sekarang" ──────────
          const SizedBox(height: 24),
          FilledButton.icon(
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => ApplicationFormScreen(
                  programme: programme,
                  allProgrammes: sampleProgrammes,
                  onSubmitted: onApplicationSubmitted,
                ),
              ),
            ),
            icon: const Icon(Icons.app_registration),
            label: const Text('Mohon Sekarang'),
          ),
```

### 3.4 — Sambungkan daripada senarai

Kembali ke `programme_list_screen.dart`. Mula-mula **aktifkan semula** import yang dikomen di Latihan 2.1 (buang `//`):

```dart
import 'programme_detail_screen.dart'; // kini wujud
```

Kemudian ganti komen `// 👈 2.5` dalam `onTap` dengan:

```dart
          onTap: () => Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => ProgrammeDetailScreen(
                programme: p,
                onApplicationSubmitted: widget.onApplicationSubmitted,
              ),
            ),
          ),
```

`ProgrammeDetailScreen` mengimport `application_form_screen.dart` (untuk butang 3.3) yang **belum wujud** — jadi projek tak dapat *compile* lagi. Untuk **melihat** skrin butiran sekarang (tanpa tunggu Latihan 4), cipta **stub sementara** `lib/screens/application_form_screen.dart`:

```dart
// lib/screens/application_form_screen.dart — STUB SEMENTARA (diganti penuh di Latihan 4)
import 'package:flutter/material.dart';
import '../models/application.dart';
import '../models/programme.dart';

class ApplicationFormScreen extends StatelessWidget {
  const ApplicationFormScreen({
    super.key,
    required this.programme,
    required this.allProgrammes,
    required this.onSubmitted,
  });

  final Programme programme;
  final List<Programme> allProgrammes;
  final ValueChanged<Application> onSubmitted;

  @override
  Widget build(BuildContext context) =>
      const Scaffold(body: Center(child: Text('Borang — Latihan 4')));
}
```

Guna `home:` sementara `ProgrammeListScreen(onApplicationSubmitted: (_) {})` seperti Latihan 2.

▶ **Jalankan** → tekan kad **pertama** (Al-Azhar · Perubatan) → skrin butiran patut buka dengan bendera 🇪🇬, "Perubatan (Medicine)", "Kaherah (Cairo), Mesir", kos RM, dan butang **Mohon Sekarang**. Tekan *back*, kemudian tekan kad **ketujuh** (Al Quaraouiyine) → butiran patut tunjuk 🇲🇦 "Usuluddin", "Fes, Maghribi" — **bukan** data Al-Azhar.

**Soalan renungan:** Kenapa `ProgrammeDetailScreen` cukup `StatelessWidget`, tetapi `ProgrammeListScreen` perlu `StatefulWidget`? (Petunjuk: butiran tak pernah **ubah** datanya sendiri; senarai perlu simpan `_isLoading`/`_programmes` yang berubah. Rujuk jadual "Ringkasan setakat ini" dalam `README.md`.)

> **Rujukan:** `projek/ett_mobile/lib/screens/programme_detail_screen.dart`

### 🧪 Uji Latihan 3

> **Sampai ke sana:** `main.dart` masih guna `home: ProgrammeListScreen(onApplicationSubmitted: (_) {})` (seperti Latihan 2) → `flutter run` → tunggu spinner → senarai **8** kad. Semua ujian di bawah bermula dari senarai itu.

> ⚠️ **Guna kad 1, 4 dan 7 sahaja untuk ujian ini.** Kad 1, 2, 3 semuanya "Universiti Al-Azhar" — kalau anda banding kad 1 lawan kad 2, `AppBar` akan tunjuk nama **sama** dan anda akan tersilap sangka data tidak dihantar. Kad 1 (Mesir · Perubatan), kad 4 (Mesir · Farmasi) dan kad 7 (Maghribi · Usuluddin) berbeza pada **setiap** medan.

**Bahagian A — data yang betul mengalir ke skrin butiran:**

| # | Buat ini | Patut nampak |
|---|---|---|
| 1 | Tekan kad **ke-1** (Al-Azhar · Perubatan) | `AppBar` = "Universiti Al-Azhar". Badan: 🇪🇬 besar, "Perubatan (Medicine)" tebal navy, "Kaherah (Cairo), Mesir", cip **SPM** |
| 2 | Tatal ke bawah pada skrin yang sama | "Kos anggaran: RM23,000 / tahun (ilustrasi)" · "Kuota: 40 tempat" · "Ambilan: September" · nota pengiktirafan (eSisraf/MQA, MMC) |
| 3 | Tekan `←`, tekan kad **ke-4** | `AppBar` = "Universiti Alexandria" — **bukan** Al-Azhar. "Farmasi (Pharmacy)", "Iskandariah (Alexandria), Mesir", RM36,000, kuota 30 |
| 4 | Tekan `←`, tatal, tekan kad **ke-7** | 🇲🇦, `AppBar` = "Universite Al Quaraouiyine", "Usuluddin", "Fes, Maghribi", cip **SPM atau STAM**, kuota **15**, "Ambilan: October" |
| 5 | *(pilihan)* Tekan `←`, tekan kad **ke-2** | `AppBar` **sama** dengan kad 1 ("Universiti Al-Azhar"), tetapi bidang "Syariah dan Undang-undang" & cip **STAM** — ini betul, bukan pepijat |

> **Nota fakta:** skrin menulis "(ilustrasi)" pada setiap kuota. Kos memang ilustrasi (diselaras dengan jadual USD rasmi 2021/22), dan kuota Mesir juga ilustrasi — tetapi **15 tempat laluan Maghribi ialah angka rasmi**. Rujuk komen dalam `data/sample_programmes.dart`.

**Bahagian B — navigasi ke borang (stub) & jalan balik:**

| # | Buat ini | Patut nampak |
|---|---|---|
| 6 | Pada mana-mana skrin butiran, tekan **Mohon Sekarang** | Skrin baharu dengan teks "Borang — Latihan 4" di tengah (stub sementara) |
| 7 | Tekan `←` | Kembali ke skrin butiran yang **sama** seperti tadi |
| 8 | Tekan `←` sekali lagi | Kembali ke senarai; kesemua 8 kad masih di tempatnya, **tiada** spinner (skrin senarai tak dibina semula) |
| 9 | Terminal: `flutter analyze` | Ralat **hanya** dari `home_screen.dart`. Tiada ralat dalam `programme_detail_screen.dart` atau `application_form_screen.dart` |

❌ **Tak jadi?**
- Menekan kad **tak buat apa-apa** → komen `// 👈 2.5` dalam `onTap` belum diganti dengan `Navigator.of(context).push(...)` (langkah 3.4).
- `Target of URI doesn't exist: 'programme_detail_screen.dart'` → `//` di depan import itu (Latihan 2.1) belum dibuang.
- `Target of URI doesn't exist: 'application_form_screen.dart'` → stub sementara di hujung 3.4 belum dicipta.
- **Semua** kad membuka butiran Al-Azhar → anda hantar `sampleProgrammes.first` / `sampleProgrammes[0]` dan bukan `p` (item gelung `itemBuilder`).
- Kad 4 & 7 tunjuk data betul tetapi kad 2 tunjuk "Universiti Al-Azhar" seperti kad 1 → **normal**, itu memang data sebenar (tiga tawaran Al-Azhar).
- `Undefined name 'KptTheme'` / `CategoryPill` / `NumberFormat` → import `../theme.dart`, `../widgets/programme_card.dart` atau `package:intl/intl.dart` tertinggal di atas fail.
- `The named parameter 'onApplicationSubmitted' is required` → anda lupa meneruskan `widget.onApplicationSubmitted` semasa `push` dari senarai (3.4).
- Butang **Mohon Sekarang** tiada → kotak `╔ 3.3 ╗` belum diganti, atau ia diletak di luar senarai `children:` `ListView`.

---

## Latihan 4 — Borang Permohonan + Validation (`ApplicationFormScreen`)

**Objektif:** Bina `ApplicationFormScreen` dengan pengesahan borang, kuatkuasakan **1 negara + 1 bidang** (daripada `programme` yang dipilih), dan hantar hasil kembali melalui *callback*.

### 4.1 — Fail permulaan

**Ganti keseluruhan kandungan** *stub* `application_form_screen.dart` (Latihan 3) dengan rangka penuh ini:

```dart
// lib/screens/application_form_screen.dart — FAIL PERMULAAN
import 'package:flutter/material.dart';

import '../data/document_checklist.dart';
import '../models/application.dart';
import '../models/programme.dart';

class ApplicationFormScreen extends StatefulWidget {
  const ApplicationFormScreen({
    super.key,
    required this.programme,
    required this.allProgrammes,
    required this.onSubmitted,
  });

  final Programme programme;
  final List<Programme> allProgrammes;
  final ValueChanged<Application> onSubmitted;

  @override
  State<ApplicationFormScreen> createState() => _ApplicationFormScreenState();
}

class _ApplicationFormScreenState extends State<ApplicationFormScreen> {
  final _formKey = GlobalKey<FormState>();

  // ╔══════════════════════════════════════════════╗
  // ║  4.2 — Controller & medan state DI SINI      ║
  // ╚══════════════════════════════════════════════╝

  @override
  void initState() {
    super.initState();
    // ╔══════════════════════════════════════════╗
    // ║  4.3 — Kira calon Pilihan 2 & 3 DI SINI  ║
    // ╚══════════════════════════════════════════╝
  }

  @override
  void dispose() {
    // 👈 4.4 — dispose() semua TextEditingController DI SINI
    super.dispose();
  }

  // ╔══════════════════════════════════════════════╗
  // ║  4.5 — Validator (_validateIc, dll.) DI SINI ║
  // ╚══════════════════════════════════════════════╝

  // ╔══════════════════════════════════════════════╗
  // ║  4.6 — _submit() DI SINI                     ║
  // ╚══════════════════════════════════════════════╝

  @override
  Widget build(BuildContext context) {
    // 👈 4.7 — GANTI baris di bawah dengan Form penuh
    return const Scaffold(body: SizedBox.shrink());
  }
}
```

### 4.2 — Controller & medan state

```dart
  // ── 4.2 — Controller & medan state ─────────────
  final _nameCtrl = TextEditingController();
  final _icCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _phoneCtrl = TextEditingController();
  final _academicCtrl = TextEditingController();

  EntryCategory? _academicCategory;
  late List<Programme> _candidates; // calon Pilihan 2 & 3
  String? _choice2;
  String? _choice3;
  final Map<String, bool> _documents = {
    for (final doc in ettDocumentChecklist) doc: false,
  };
```

### 4.3 — Kira calon Pilihan 2 & 3

Ganti kotak `╔ 4.3 ╗` dalam `initState()`. Ini **menguatkuasakan** peraturan sebenar eTT — calon **mesti** negara+bidang yang **sama** dengan `widget.programme`:

```dart
    // ── 4.3 — Kira calon Pilihan 2 & 3 ─────────────
    _candidates = widget.allProgrammes
        .where((p) =>
            p.country == widget.programme.country &&
            p.fieldOfStudy == widget.programme.fieldOfStudy &&
            p.id != widget.programme.id)
        .toList();
```

### 4.4 — `dispose()`

```dart
    // ── 4.4 — dispose() controller ─────────────────
    _nameCtrl.dispose();
    _icCtrl.dispose();
    _emailCtrl.dispose();
    _phoneCtrl.dispose();
    _academicCtrl.dispose();
```

> Kenapa `dispose()`? Setiap `TextEditingController` pegang memori yang tidak dilepaskan automatik — lupa `dispose()` = kebocoran memori (*memory leak*). (Rujuk nota Hari 3 — pengurusan `TextEditingController`.)

### 4.5 — Validator

```dart
  // ── 4.5 — Validator ─────────────────────────────
  String? _validateIc(String? v) {
    if (v == null || v.trim().isEmpty) return 'No. KP diperlukan';
    final digits = v.replaceAll('-', '');
    if (digits.length != 12) return 'No. KP mesti 12 digit';
    return null;
  }

  String? _validateEmail(String? v) {
    if (v == null || v.trim().isEmpty) return 'Emel diperlukan';
    final regex = RegExp(r'^[\w.+-]+@[\w-]+\.[\w.-]+$');
    return regex.hasMatch(v.trim()) ? null : 'Format emel tidak sah';
  }

  String? _validatePhone(String? v) {
    if (v == null || v.trim().isEmpty) return 'No. telefon diperlukan';
    final digits = v.replaceAll(RegExp(r'[\s-]'), '');
    if (!RegExp(r'^\+?\d{9,15}$').hasMatch(digits)) return 'No. telefon tidak sah';
    return null;
  }
```

> Menulis *regex* dari kosong memang makan masa — sini tempat AI berguna. Cuba: *"Tulis fungsi Dart `String? validateIc(String? v)` yang menolak nilai kosong dan menuntut tepat 12 digit selepas buang tanda `-`, pulangkan mesej ralat Bahasa Melayu."* Uji hasilnya dengan input `'051231-14-5678'` (patut lulus) dan `'12345'` (patut gagal) sebelum terima.

### 4.6 — `_submit()`

```dart
  // ── 4.6 — _submit() ─────────────────────────────
  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    // Pengawal tambahan: jangan sesekali guna `!` tanpa pastikan nilai ada.
    if (_academicCategory == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Sila pilih kategori sijil (SPM/STAM).')),
      );
      return;
    }

    final choices = <String>[widget.programme.id];
    for (final id in [_choice2, _choice3]) {
      if (id != null && !choices.contains(id)) choices.add(id);
    }

    final application = Application(
      id: 'APP-${DateTime.now().millisecondsSinceEpoch}',
      fullName: _nameCtrl.text.trim(),
      icNumber: _icCtrl.text.trim(),
      email: _emailCtrl.text.trim(),
      phoneNumber: _phoneCtrl.text.trim(),
      academicCategory: _academicCategory!,
      academicSummary: _academicCtrl.text.trim(),
      country: widget.programme.country,
      fieldOfStudy: widget.programme.fieldOfStudy,
      universityChoiceIds: choices,
      uploadedDocuments:
          _documents.entries.where((e) => e.value).map((e) => e.key).toList(),
      status: ApplicationStatus.submitted,
      submittedAt: DateTime.now(),
    );

    widget.onSubmitted(application); // "naik balik" ke HomeScreen
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Permohonan ${application.id} berjaya dihantar!')),
    );
    Navigator.of(context).pop();
  }
```

### 4.7 — `build()`: Form penuh

```dart
  @override
  Widget build(BuildContext context) {
    // ── 4.7 — build(): Form penuh ──────────────────
    return Scaffold(
      appBar: AppBar(title: const Text('Borang Permohonan eTT')),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _nameCtrl,
                decoration: const InputDecoration(labelText: 'Nama Penuh'),
                validator: (v) =>
                    (v == null || v.trim().isEmpty) ? 'Nama diperlukan' : null,
              ),
              const SizedBox(height: 14),
              TextFormField(
                controller: _icCtrl,
                decoration: const InputDecoration(labelText: 'No. Kad Pengenalan'),
                validator: _validateIc,
              ),
              const SizedBox(height: 14),
              TextFormField(
                controller: _emailCtrl,
                decoration: const InputDecoration(labelText: 'Emel'),
                validator: _validateEmail,
              ),
              const SizedBox(height: 14),
              TextFormField(
                controller: _phoneCtrl,
                decoration: const InputDecoration(labelText: 'No. Telefon'),
                validator: _validatePhone,
              ),
              const SizedBox(height: 14),
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
              const SizedBox(height: 14),
              TextFormField(
                controller: _academicCtrl,
                decoration: const InputDecoration(labelText: 'Ringkasan Keputusan'),
                validator: (v) => (v == null || v.trim().isEmpty)
                    ? 'Ringkasan keputusan diperlukan'
                    : null,
              ),
              const SizedBox(height: 20),
              Text('Pilihan 1 (wajib): ${widget.programme.universityName}'),
              const SizedBox(height: 8),
              DropdownButtonFormField<String>(
                initialValue: _choice2,
                decoration: const InputDecoration(labelText: 'Pilihan 2 (pilihan)'),
                items: [
                  const DropdownMenuItem<String>(value: null, child: Text('Tiada')),
                  for (final p in _candidates)
                    DropdownMenuItem(value: p.id, child: Text(p.universityName)),
                ],
                onChanged: (v) => setState(() => _choice2 = v),
              ),
              const SizedBox(height: 8),
              DropdownButtonFormField<String>(
                initialValue: _choice3,
                decoration: const InputDecoration(labelText: 'Pilihan 3 (pilihan)'),
                items: [
                  const DropdownMenuItem<String>(value: null, child: Text('Tiada')),
                  for (final p in _candidates)
                    DropdownMenuItem(value: p.id, child: Text(p.universityName)),
                ],
                onChanged: (v) => setState(() => _choice3 = v),
              ),
              const SizedBox(height: 20),
              for (final doc in ettDocumentChecklist)
                CheckboxListTile(
                  title: Text(doc),
                  value: _documents[doc],
                  onChanged: (v) => setState(() => _documents[doc] = v ?? false),
                ),
              const SizedBox(height: 20),
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
```

Kini stub sudah diganti, seluruh aliran list → detail → borang boleh dilaksana. Kekalkan `home:` sementara `ProgrammeListScreen(onApplicationSubmitted: (_) {})`.

▶ **Jalankan** → tekan mana-mana kad → **Mohon Sekarang** → borang penuh muncul (medan Nama, No. KP, Emel, Telefon, dropdown kategori, senarai semak dokumen).

**Eksperimen — validation gagal vs lulus:**

| Cuba lakukan | Perhatikan | Kesimpulan |
|---|---|---|
| Tekan **Hantar Permohonan** dengan semua medan kosong | Borang **kekal** di skrin; mesej ralat merah muncul di bawah **setiap** medan (cth. "No. KP mesti 12 digit") | `_formKey.currentState!.validate()` memulangkan `false` → `_submit()` berhenti awal (`return`), tiada permohonan dicipta |
| Isi No. KP `12345` (5 digit) sahaja, tekan Hantar | Ralat "No. KP mesti 12 digit" pada medan itu | `_validateIc` menolak panjang ≠ 12; UI tunjuk pulangan `String` sebagai ralat |
| Isi **semua** medan betul (No. KP 12 digit, emel sah, pilih kategori), tekan Hantar | `SnackBar` "Permohonan APP-… berjaya dihantar!" muncul, skrin **pop** kembali ke butiran | Semua `validator` pulangkan `null` → `validate()` = `true` → callback `onSubmitted` dipanggil |

> **Perhatikan:** kerana `home:` sementara guna callback **kosong** `(_) {}`, permohonan tak disimpan ke mana-mana lagi — ia baru "naik" ke tempat yang membuang datanya. Latihan 5 menyambungnya ke senarai sebenar melalui `HomeScreen`.

**Soalan renungan:** Kenapa `country` dan `fieldOfStudy` permohonan **tidak** ada medan sendiri dalam borang — ia diambil terus daripada `widget.programme`? (Jawapan: peraturan sebenar eTT ialah **1 negara + 1 bidang setiap permohonan**; dengan mewarisinya terus daripada tawaran yang sudah dipilih — bukan minta pilih semula — kita **jamin secara struktur** peraturan itu tak boleh dilanggar, bukan sekadar berharap pengguna pilih betul.)

> **Rujukan:** `projek/ett_mobile/lib/screens/application_form_screen.dart` (nota: versi rujukan guna `ApplicationProvider`/`ProgrammeProvider` — pratonton state dikongsi — dengan dropdown negara/bidang berasingan; versi lab ini lebih ringkas kerana negara+bidang diwarisi terus daripada tawaran yang dipilih)

### 🧪 Uji Latihan 4

> **Sampai ke sana:** `flutter run` (tekan **`R`** besar — Hot **Restart** — kerana `application_form_screen.dart` diganti sepenuhnya) → tunggu senarai 8 kad → tekan kad **ke-1** (Al-Azhar · Perubatan) → tekan **Mohon Sekarang**. Anda kini di borang penuh.

> ⚠️ **Kenapa kad ke-1, bukan sembarang kad?** `_candidates` (langkah 4.3) hanya mengambil tawaran dengan **negara + bidang yang sama** dan bukan diri sendiri. Dalam 8 rekod eTT, hanya bidang **Perubatan (Medicine)** ada dua universiti Mesir — Al-Azhar (kad 1) dan Ain Shams (kad 5). Jadi:
>
> - Buka borang dari kad **1** → Pilihan 2/3 ada **1** calon: Universiti Ain Shams
> - Buka borang dari kad **5** → Pilihan 2/3 ada **1** calon: Universiti Al-Azhar
> - Buka borang dari **mana-mana kad lain** → Pilihan 2/3 hanya ada "Tiada". Itu **betul**, bukan pepijat.

**Bahagian A — pengesahan mesti MENGHALANG (laluan gagal):**

| # | Buat ini | Patut nampak |
|---|---|---|
| 1 | Terus tekan **Hantar Permohonan** tanpa isi apa-apa | Mesej ralat **merah** di bawah Nama Penuh, No. Kad Pengenalan, Emel, No. Telefon, Kategori Sijil dan Ringkasan Keputusan. Borang **TIDAK** tertutup |
| 2 | Isi No. Kad Pengenalan `12345`, tekan Hantar | "No. KP mesti 12 digit" |
| 3 | Tukar kepada `051231-14-5678`, tekan Hantar | Ralat No. KP itu **hilang** — sengkang dibuang dahulu sebelum digit dikira |
| 4 | Isi Emel `abc` (tiada `@`), tekan Hantar | "Format emel tidak sah" |
| 5 | Isi No. Telefon `12345`, tekan Hantar | "No. telefon tidak sah" (perlu 9–15 digit) |
| 6 | Isi semua medan teks betul tetapi biar **Kategori Sijil** kosong, tekan Hantar | "Sila pilih kategori sijil" pada dropdown — borang **masih** tidak tertutup |

**Bahagian B — pilihan universiti & senarai semak dokumen:**

| # | Buat ini | Patut nampak |
|---|---|---|
| 7 | Cari baris **"Pilihan 1 (wajib)"** | Teks tetap "Pilihan 1 (wajib): Universiti Al-Azhar" — **bukan** dropdown. Ia diwarisi terus daripada tawaran yang anda buka (peraturan eTT: 1 negara + 1 bidang) |
| 8 | Buka dropdown **Pilihan 2 (pilihan)** | Dua item sahaja: **"Tiada"** dan **"Universiti Ain Shams"** |
| 9 | Pilih "Universiti Ain Shams" | Nama itu kekal terpapar dalam medan (kerja `setState(() => _choice2 = v)`) |
| 10 | Kira `CheckboxListTile` di bahagian bawah | **6** dokumen: Borang Permohonan · Senarai Semak · Borang Aku Janji · Salinan Kad Pengenalan · Sijil SPM/STAM · Slip Bayaran (JomPAY) |
| 11 | Tanda "Salinan Kad Pengenalan" dan "Sijil SPM/STAM" | Kedua-dua kotak **kekal** bertanda |

**Bahagian C — laluan berjaya:**

| # | Buat ini | Patut nampak |
|---|---|---|
| 12 | Isi semua betul: Nama `Ahmad bin Ali`, KP `051231-14-5678`, Emel `ahmad@contoh.my`, Telefon `0123456789`, Kategori **SPM**, Ringkasan `SPM 2025 — 9A` | Tiada lagi mesej ralat merah selepas tekan Hantar |
| 13 | Tekan **Hantar Permohonan** | `SnackBar` "Permohonan **APP-…** berjaya dihantar!" **dan** borang tertutup — kembali ke skrin butiran Al-Azhar |
| 14 | Tekan **Mohon Sekarang** semula | Borang terbuka dengan **semua medan kosong** semula — betul: skrin baharu = objek `State` baharu |
| 15 | Terminal: `flutter analyze` | Ralat **hanya** dari `home_screen.dart`; tiada ralat dalam `application_form_screen.dart` |

❌ **Tak jadi?**
- Borang **tertutup** walaupun medan kosong (baris 1) → `if (!_formKey.currentState!.validate()) return;` bukan baris **pertama** `_submit()`, atau `Form(key: _formKey, ...)` tidak membalut medan-medan itu.
- Ranap `Null check operator used on a null value` semasa Hantar → pengawal `if (_academicCategory == null) { ... return; }` (4.6) tertinggal, jadi `_academicCategory!` dinilai pada `null`.
- `LateInitializationError: Field '_candidates' has not been initialized` → kotak `╔ 4.3 ╗` dalam `initState()` belum diganti.
- Dropdown Pilihan 2 & 3 **hanya ada "Tiada"** → sahkan anda buka borang dari kad **ke-1** atau **ke-5**. Untuk enam kad yang lain, memang tiada calon — itu jangkaan, bukan pepijat.
- Senarai semak dokumen **kosong** → baris `for (final doc in ettDocumentChecklist) doc: false` dalam `_documents` (4.2) tertinggal; atau `import '../data/document_checklist.dart';` tiada.
- Kotak semak tak boleh ditanda → `onChanged` tidak membungkus perubahan dalam `setState`.
- `SnackBar` tak sempat kelihatan → ia dipaparkan **sebelum** `Navigator.pop()`; jika anda tersusun terbalik (`pop()` dahulu), mesej itu hilang bersama skrin.
- Amaran `The value of the field '_choice3' isn't used` → dropdown Pilihan 3 belum dipasang dalam `build()` (4.7).

---

## Latihan 5 — "Permohonan Saya" (`MyApplicationsScreen`)

**Objektif:** Bina skrin paparan senarai permohonan, lengkap dengan cip status berwarna.

### 5.1 — Fail permulaan

```dart
// lib/screens/my_applications_screen.dart — FAIL PERMULAAN
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/application.dart';
import '../theme.dart';
import '../widgets/status_badge.dart';

class MyApplicationsScreen extends StatelessWidget {
  const MyApplicationsScreen({super.key, required this.applications});

  final List<Application> applications;

  @override
  Widget build(BuildContext context) {
    // 👈 5.2 — GANTI baris di bawah dengan keadaan kosong + senarai
    return const SizedBox.shrink();
  }
}
```

### 5.2 — Keadaan kosong

```dart
  @override
  Widget build(BuildContext context) {
    // ── 5.2 — Keadaan kosong ────────────────────────
    if (applications.isEmpty) {
      return const Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.inbox_outlined, size: 56, color: Colors.grey),
            SizedBox(height: 12),
            Text('Belum ada permohonan.'),
          ],
        ),
      );
    }

    // 👈 5.3 — TAMBAH ListView.builder SELEPAS BARIS INI
    return const SizedBox.shrink();
  }
```

### 5.3 — Senarai permohonan

```dart
    // ── 5.3 — Senarai permohonan ────────────────────
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: applications.length,
      itemBuilder: (context, index) {
        final application = applications[index];
        final tarikh = application.submittedAt == null
            ? '-'
            : DateFormat('d MMM yyyy, h:mm a', 'ms')
                .format(application.submittedAt!);

        return Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        '${application.countryLabel} · ${application.fieldOfStudy}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: KptTheme.navy,
                        ),
                      ),
                    ),
                    StatusBadge(status: application.status),
                  ],
                ),
                const SizedBox(height: 6),
                Text('Pemohon: ${application.fullName}'),
                Text('Dihantar: $tarikh'),
              ],
            ),
          ),
        );
      },
    );
```

### 5.4 — Pulangkan `home:` kepada `HomeScreen`

Kedua-dua tab kini wujud, jadi `HomeScreen` akhirnya boleh *compile*. **Batalkan** semua suisan sementara Latihan 2 dalam `main.dart`:

```dart
import 'screens/home_screen.dart';             // 👈 buang // — aktifkan semula
// import 'screens/programme_list_screen.dart'; // 👈 buang baris sementara ini

// ... di dalam MaterialApp:
      home: const HomeScreen(), // KEKAL mulai sekarang
```

▶ **Jalankan** → aplikasi buka pada tab **Tawaran** (senarai 8 kad). Tekan tab **Permohonan Saya** → anda patut nampak **keadaan kosong**: ikon peti masuk kelabu + "Belum ada permohonan." (kerana `_applications` masih kosong).

**Eksperimen — keadaan kosong vs berisi:**

| Cuba lakukan | Perhatikan | Kesimpulan |
|---|---|---|
| Buka tab "Permohonan Saya" **sebelum** hantar apa-apa | Ikon peti masuk + "Belum ada permohonan." | Cabang `applications.isEmpty` (5.2) dipilih |
| Tawaran → butiran → **Mohon Sekarang** → isi borang betul → Hantar, kemudian buka tab "Permohonan Saya" | Satu `Card` muncul: negara · bidang + cip status **"Dihantar"** biru | Cabang `ListView.builder` (5.3) dipilih; senarai tak lagi kosong |
| Hantar **2–3** permohonan lagi (bidang/negara berbeza) | Setiap satu muncul sebagai kad baharu, **tanpa** *restart* | `setState()` di `HomeScreen` mengalir turun ke tab secara automatik |

> **Perhatikan** perpindahan kritikal: kad muncul di "Permohonan Saya" **serta-merta** selepas Hantar. Callback `onSubmitted` → `_addApplication` (Latihan 1.3) → `setState` di `HomeScreen` → kedua-dua tab dibina semula dengan senarai terkini. Inilah "state kongsi" yang anda susun di Latihan 1 kini berfungsi hujung-ke-hujung.

> **Rujukan:** `projek/ett_mobile/lib/screens/my_applications_screen.dart`, `lib/widgets/status_badge.dart`

### 🧪 Uji Latihan 5 — ujian MVP hujung-ke-hujung

> **Sampai ke sana:** siapkan langkah **5.4** dahulu (aktifkan semula `import 'screens/home_screen.dart';`, buang import sementara, tetapkan `home: const HomeScreen()`). Kemudian tekan **`R`** besar (Hot **Restart**) — bukan `r` kecil — kerana `main.dart` berubah. Aplikasi patut buka pada tab **Tawaran** dengan `AppBar` "eTT Mobile" dan dua tab di bawah.

**Bahagian A — keadaan KOSONG (sebelum sebarang permohonan):**

| # | Buat ini | Patut nampak |
|---|---|---|
| 1 | Tekan tab **Permohonan Saya** | Ikon peti masuk **kelabu** + teks "Belum ada permohonan." di tengah skrin — cabang `applications.isEmpty` (5.2) |
| 2 | Tekan balik tab **Tawaran** | Spinner sekejap, kemudian 8 kad. (Spinner muncul semula kerana `tabs` dibina semula setiap `build()` — `ProgrammeListScreen` mendapat `State` baharu dan `initState()` berjalan lagi. Ini jangkaan.) |

**Bahagian B — keadaan BERISI (state kongsi mengalir):**

| # | Buat ini | Patut nampak |
|---|---|---|
| 3 | Tab **Tawaran** → kad **ke-1** (Al-Azhar · Perubatan) → **Mohon Sekarang** | Borang penuh Latihan 4 |
| 4 | Isi semua medan betul, tekan **Hantar Permohonan** | `SnackBar` "Permohonan APP-… berjaya dihantar!"; borang tertutup ke skrin butiran |
| 5 | Tekan `←` ke senarai, kemudian tab **Permohonan Saya** | **Satu** `Card`: tajuk navy "**Mesir · Perubatan (Medicine)**" + cip **"Dihantar"** biru di kanan, "Pemohon: Ahmad bin Ali", "Dihantar: \<tarikh & masa\>" |
| 6 | Balik ke tab **Tawaran**, tatal, ulang aliran itu untuk kad **ke-7** (Al Quaraouiyine · Usuluddin) | Tab Permohonan Saya kini ada **2** kad; yang baharu bertajuk "**Maghribi · Usuluddin**" |
| 7 | Tekan tab **Tawaran**, kemudian balik ke **Permohonan Saya** | Kedua-dua kad **masih ada** — `_applications` hidup dalam `_HomeScreenState`, bukan dalam tab |
| 8 | Terminal: `flutter analyze` | **No issues found!** untuk seluruh projek — ralat `home_screen.dart` akhirnya hilang |

> ⚠️ Tekan **`R`** (Hot Restart) sekarang akan **mengosongkan** semula senarai. Itu betul: `_applications` disimpan dalam ingatan sahaja, tiada storan kekal dalam skop kursus ini.

❌ **Tak jadi?**
- Ranap `LocaleDataException: Locale data has not been initialized, call initializeDateFormatting(<locale>)` sebaik sahaja tab Permohonan Saya **berisi** → `DateFormat('d MMM yyyy, h:mm a', 'ms')` (5.3) perlukan data locale `ms`. Dalam `main.dart`: import `package:intl/date_symbol_data_local.dart`, jadikan `main()` sebagai `async`, dan sebelum `runApp(...)` panggil `WidgetsFlutterBinding.ensureInitialized();` diikuti `await initializeDateFormatting('ms', null);`.
- Tab Permohonan Saya **kekal kosong** walaupun sudah hantar → callback terputus di salah satu daripada tiga sambungan: `ProgrammeListScreen(onApplicationSubmitted: _addApplication)` (1.4) → `ProgrammeDetailScreen(onApplicationSubmitted: widget.onApplicationSubmitted)` (3.4) → `ApplicationFormScreen(onSubmitted: onApplicationSubmitted)` (3.3). Semak ketiga-tiganya.
- Sama seperti di atas, dan `main.dart` masih `home: ProgrammeListScreen(onApplicationSubmitted: (_) {})` → callback kosong `(_) {}` itu membuang setiap permohonan. Pulangkan `home: const HomeScreen()` (5.4).
- Skrin putih kosong walaupun ada permohonan → `return const SizedBox.shrink();` selepas komen `👈 5.3` belum dipadam, jadi `ListView.builder` tak pernah dicapai.
- Kad hanya muncul selepas tukar tab dua kali / restart → `_addApplication` tidak membungkus `_applications.add(...)` dalam `setState` (1.3).
- Ralat "The name 'MyApplicationsScreen' isn't defined" masih ada → nama fail tersalah eja (mesti `my_applications_screen.dart`) atau import dalam `home_screen.dart` tertinggal.
- Cip status tunjuk "Draf" kelabu, bukan "Dihantar" biru → `status: ApplicationStatus.submitted` tertinggal semasa membina `Application` dalam `_submit()` (4.6).

---

## Latihan 6 — Debugging Berbantukan AI

**Objektif:** Amalkan teknik *debugging* berbantukan AI yang berkesan — bukan sekadar tampal ralat dan tunggu jawapan.

1. Sengaja cetuskan **satu** ralat biasa dalam projek anda (pilih satu):
   - Buang `if (!mounted) return;` daripada `_loadProgrammes()` (Latihan 2.3), kemudian navigasi keluar `ProgrammeListScreen` dengan pantas semasa data masih dimuat.
   - Guna `!` pada `_academicCategory` (cth. `_academicCategory!.label`) sebelum dropdown dipilih, di luar `_submit()`.
   - Bina `Row` dengan `Text` panjang tanpa `Expanded` di ruang sempit (cth. dalam `MyApplicationsScreen`).
2. Tangkap mesej ralat **penuh** daripada konsol/*debug console*.
3. Susun prompt AI menggunakan templat ini (rujuk [`nota/08-prompt-claude-code.md`](../../nota/08-prompt-claude-code.md)):
   ```text
   Konteks: Projek Flutter "eTT Mobile". State: setState() (StatefulWidget).
   Ralat: [tampal MESEJ RALAT PENUH]
   Kod berkaitan: [tampal fungsi/widget yang relevan sahaja]
   Soalan: Apakah puncanya, dan bagaimana membaikinya tanpa mengubah kelakuan lain?
   ```
4. Selepas mendapat cadangan pembaikan, **jangan terus tampal** — baca dan pastikan anda faham **kenapa** ia berlaku, kemudian terapkan.
5. Jalankan `flutter analyze` untuk sahkan tiada isu baharu diperkenalkan, dan kembalikan kod kepada keadaan **betul** (jangan biarkan ralat sengaja ini kekal).

**Soalan renungan:** Kenapa menampal "kod berkaitan sahaja" (bukan seluruh fail 300 baris) biasanya menghasilkan jawapan AI yang lebih tepat?

### 🧪 Uji Latihan 6

> **Sampai ke sana:** mulakan dari projek yang **sudah lulus** 🧪 Uji Latihan 5 (`flutter analyze` → **No issues found!**, aliran penuh berfungsi). Anda akan **merosakkannya dengan sengaja**, jadi titik permulaan mesti betul — kalau tidak, anda takkan tahu ralat mana yang anda cetuskan dan mana yang sedia ada.

**Bahagian A — cetuskan & tangkap ralat (laluan gagal):**

| # | Buat ini | Patut nampak |
|---|---|---|
| 1 | Pilih **satu** ralat dari senarai langkah 1 dan terapkan ke kod anda | `flutter analyze` mula mengadu, atau app ranap/berkelakuan pelik semasa dijalankan |
| 2 | Jalankan app dan cetuskan ralat itu betul-betul | Mesej ralat muncul dalam *debug console* terminal |
| 3 | Salin mesej itu **sepenuhnya** | Termasuk baris pertama (jenis ralat), **dan** jejak tindanan `#0`, `#1`, `#2 …` — bukan setakat satu ayat |
| 4 | Jika anda pilih ralat `Row` tanpa `Expanded` | Jalur **kuning-hitam** di tepi skrin + `RenderFlex overflowed by … pixels on the right` dalam konsol |
| 5 | Jika anda pilih `_academicCategory!` sebelum dipilih | `Null check operator used on a null value` + baris fail & nombor baris yang tepat |

**Bahagian B — prompt, faham, baiki, pulihkan:**

| # | Buat ini | Patut nampak |
|---|---|---|
| 6 | Hantar templat prompt (langkah 3) dengan mesej ralat **penuh** + **fungsi berkaitan sahaja** | Jawapan AI menyebut punca **khusus** (cth. "`Text` tanpa `Expanded` dalam `Row`"), bukan nasihat umum |
| 7 | **Sebelum** menerima cadangan, terangkan kepada rakan sebelah kenapa ralat itu berlaku | Anda boleh terangkan tanpa membaca semula jawapan AI |
| 8 | Terapkan pembaikan | Ralat hilang; skrin kembali normal |
| 9 | Kembalikan kod kepada keadaan **betul** (buang ralat sengaja), jalankan `flutter analyze` | **No issues found!** — sama seperti sebelum Latihan 6 bermula |
| 10 | Jalankan semula 🧪 Uji Latihan 5 secara ringkas (hantar satu permohonan) | Aliran penuh masih berfungsi — anda tidak tertinggal kerosakan |
| 11 | Ulang baris 1–10 dengan ralat **kedua** dari [jadual troubleshooting README](../README.md#jadual-troubleshooting) | Kitaran sama: tangkap → prompt → faham → baiki → sahkan |

❌ **Tak jadi?**
- Ralat `setState() called after dispose()` tidak muncul walaupun `if (!mounted) return;` dibuang → masanya terlalu ketat: anda mesti navigasi **keluar** `ProgrammeListScreen` dalam ~0.6 saat pertama, semasa `_fallback()` masih menunggu. Cuba tekan tab **Permohonan Saya** sebaik sahaja spinner muncul.
- AI hanya beri jawapan umum ("semak kod anda", "pastikan pemboleh ubah tidak null") → prompt anda kurang **mesej ralat penuh** atau kurang **kod berkaitan**; tampal kedua-duanya.
- AI mencadang menulis semula seluruh fail → minta ia jawab dalam bentuk "baris mana sahaja yang berubah" atau *diff*. Anda mesti boleh melihat perubahannya dalam 5 saat.
- Cadangan AI mengubah kelakuan lain (cth. membuang validator) → tolak dan minta pembaikan yang **minimum**; kembalikan kepada versi Latihan 4/5 dahulu.
- `flutter analyze` tidak kembali bersih selepas dibaiki → ralat sengaja masih tertinggal di tempat lain; guna *Undo* editor berulang kali sehingga kembali ke titik sebelum langkah 1.

---

## Latihan 7 — Refactor: Pecahkan Widget Besar

**Objektif:** Ambil satu bahagian borang anda dan pecahkan kepada komponen kecil, kemudian pastikan projek bersih dari segi format & lint. Ini latihan **wajib** — jangan langkau, walaupun sudah tergesa-gesa.

### 7.1 — Kenal pasti bahagian untuk diekstrak

Dalam `application_form_screen.dart`, bahagian **senarai semak dokumen** (langkah 4.7, blok `for (final doc in ettDocumentChecklist) CheckboxListTile(...)`) ialah calon baik — ia satu "konsep visual" berasingan (~7 baris) yang boleh dijelaskan dalam satu ayat: "papar senarai semak dokumen yang boleh ditanda".

**SEBELUM** — terus dalam `build()` skrin (seperti yang anda tulis di Latihan 4.7):

```dart
// SEBELUM — terus dalam ListView build() ApplicationFormScreen
for (final doc in ettDocumentChecklist)
  CheckboxListTile(
    title: Text(doc),
    value: _documents[doc],
    onChanged: (v) => setState(() => _documents[doc] = v ?? false),
  ),
```

### 7.2 — Cipta kelas widget baharu

Tambah **di bawah sekali** fail `application_form_screen.dart` (selepas `_ApplicationFormScreenState` tutup):

```dart
// SELEPAS — widget StatelessWidget berasingan, `_documents` DAN
// callback `onChanged` dihantar sebagai parameter, bukan diakses terus.
class _DocumentChecklist extends StatelessWidget {
  const _DocumentChecklist({
    required this.documents,
    required this.onChanged,
  });

  final Map<String, bool> documents;
  final void Function(String doc, bool value) onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (final doc in documents.keys)
          CheckboxListTile(
            title: Text(doc),
            value: documents[doc],
            onChanged: (v) => onChanged(doc, v ?? false),
          ),
      ],
    );
  }
}
```

### 7.3 — Ganti kod asal

Dalam `build()` induk, ganti blok `for` asal dengan satu panggilan:

```dart
            // ── 7.3 — Panggil widget yang diekstrak ─────
            _DocumentChecklist(
              documents: _documents,
              onChanged: (doc, value) => setState(() => _documents[doc] = value),
            ),
```

Perhatikan `build()` utama kini **lebih pendek** dan mudah dibaca sebagai "senarai kandungan" borang. Ulang corak yang sama untuk **sekurang-kurangnya satu lagi** bahagian pilihan anda (cth. blok Pilihan 2 & 3, atau kumpulan medan "Kelayakan Akademik").

### 7.4 — Get bersih: format + analyze

```bash
dart format .
flutter analyze
```

Baiki **semua** amaran sehingga `flutter analyze` melaporkan **"No issues found!"**.

▶ **Jalankan** → buka borang → senarai semak dokumen kelihatan **sama persis** seperti sebelum ini. Tanda beberapa kotak semak, tekan Hantar → permohonan tersimpan seperti biasa.

**Eksperimen — bukti *refactoring* betul (kelakuan kekal):**

| Cuba lakukan | Perhatikan | Kesimpulan |
|---|---|---|
| Banding bilangan kotak semak sebelum vs selepas ekstrak | Sama — **6** dokumen (`ettDocumentChecklist`) | Ekstrak widget tak ubah data yang dipaparkan |
| Tanda "Sijil SPM/STAM", hantar borang, semak `uploadedDocuments` permohonan | Dokumen bertanda masih direkod dengan betul | Callback `onChanged` yang dihantar sebagai parameter masih sampai ke `setState` induk |
| Baca `build()` induk sebelum vs selepas | Blok `for … CheckboxListTile` (~7 baris) → satu baris `_DocumentChecklist(...)` | `build()` jadi lebih pendek & mudah dibaca — **inti** *refactoring* |

Ini definisi *refactoring* yang betul: struktur kod berubah, **kelakuan tidak**.

**Soalan renungan:** Selepas *refactoring*, adakah `build()` utama skrin anda lebih mudah dibaca sebagai "senarai kandungan"? Jika tidak, bahagian mana masih perlu dipecahkan lagi?

> **Rujukan:** [`snippets/refactor_before_after.dart`](./refactor_before_after.dart) — contoh penuh sebelum/selepas (kad `ProgrammeCard`) dengan penjelasan "kenapa widget, bukan kaedah". Bahagian **"Amalan Refactoring"** dalam [`README.md`](../README.md) ada satu lagi contoh berpandu (`ProgrammeDetailScreen`).

### 🧪 Uji Latihan 7 — kelakuan mesti KEKAL SAMA

> **Sampai ke sana:** `flutter run` → tab **Tawaran** → kad **ke-1** (Al-Azhar · Perubatan) → **Mohon Sekarang** → tatal ke bahagian **Senarai Semak Dokumen** di bawah borang.
>
> Ujian ini istimewa: ia **tidak** mencari ciri baharu. Ia membuktikan yang anda **tidak** merosakkan apa-apa. Kalau anda perasan sebarang perbezaan pada skrin, refactoring anda salah.

**Bahagian A — kelakuan sebelum vs selepas ekstrak:**

| # | Buat ini | Patut nampak |
|---|---|---|
| 1 | Kira kotak semak dokumen | **6** — sama seperti sebelum ekstrak: Borang Permohonan · Senarai Semak · Borang Aku Janji · Salinan Kad Pengenalan · Sijil SPM/STAM · Slip Bayaran (JomPAY) |
| 2 | Tanda "Salinan Kad Pengenalan" | Kotak bertanda **serta-merta** dan kekal begitu |
| 3 | Tanda "Sijil SPM/STAM" juga | Kedua-duanya bertanda — callback `onChanged` sampai ke `setState` induk |
| 4 | Nyahtanda "Salinan Kad Pengenalan" | Ia kembali kosong; "Sijil SPM/STAM" **tidak** terjejas |
| 5 | Isi semua medan betul & tekan **Hantar Permohonan** | `SnackBar` "Permohonan APP-… berjaya dihantar!" — sama persis seperti sebelum refactor |
| 6 | Tab **Permohonan Saya** | Kad permohonan baharu muncul seperti biasa (cip **Dihantar** biru) |

**Bahagian B — kod mesti jadi lebih pendek & bersih:**

| # | Buat ini | Patut nampak |
|---|---|---|
| 7 | Buka `application_form_screen.dart`, baca `build()` induk | Blok `for … CheckboxListTile` (~7 baris) sudah menjadi **satu** panggilan `_DocumentChecklist(...)` |
| 8 | Semak kedudukan kelas `_DocumentChecklist` | Ia di **luar** `_ApplicationFormScreenState`, di bawah sekali fail |
| 9 | Jalankan `dart format .` | Senarai fail yang diformat (atau "0 changed" jika sudah kemas) |
| 10 | Jalankan `flutter analyze` | **No issues found!** |
| 11 | Ekstrak **satu lagi** bahagian (cth. dropdown Pilihan 2 & 3, atau kumpulan medan kelayakan), kemudian ulang baris 1–10 | Skrin masih **tidak berubah** langsung — itulah bukti refactoring betul |

❌ **Tak jadi?**
- Kotak semak **tidak boleh** ditanda lagi → `onChanged:` `_DocumentChecklist` tidak disambung ke `setState` induk (7.3); pastikan `onChanged: (doc, value) => setState(() => _documents[doc] = value)` dihantar.
- Tiada kotak semak langsung → `_DocumentChecklist` menggelung `documents.keys`; jika `_documents` kosong (baris `for (final doc in ettDocumentChecklist) doc: false` pada 4.2 tertinggal), tiada apa dipapar.
- Bilangan kotak bukan 6 → anda menghantar Map lain (bukan `_documents`), atau `document_checklist.dart` starter tersalin separuh.
- `The class '_DocumentChecklist' isn't defined` → kelas itu diletak dalam fail lain, atau **di dalam** kelas `_ApplicationFormScreenState`. Ia mesti kelas peringkat atas di hujung fail.
- Dokumen bertanda tidak direkod dalam permohonan → widget yang diekstrak mesti menulis kembali ke `_documents` **yang sama** (melalui callback), bukan ke salinan tempatannya sendiri.
- `flutter analyze` melaporkan `unused_element` atau kod mati → blok `for … CheckboxListTile` asal masih tertinggal dalam `build()`; padamkannya (7.3).
- Skrin nampak berbeza (jarak/jajaran berubah) → `_DocumentChecklist` membalut dengan `Column` sahaja; jangan tambah `Padding`/`Card` baharu semasa ekstrak. Refactoring **tidak** mengubah rupa.

---

## Latihan 8 — Sediakan Demo

**Objektif:** Sediakan demo 2–3 minit yang jelas dan meyakinkan.

1. Jalankan aplikasi anda dari **awal** (`flutter run` bersih, bukan sambung dari sesi lama) untuk pastikan aliran utama berfungsi tanpa halangan.
2. Sediakan **satu** ayat pembuka: masalah apa yang eTT Mobile selesaikan (cth. "pelajar sukar menyemak tawaran pengajian Mesir/Maghribi & memohon minat tanpa aplikasi berpusat").
3. Rancang **laluan demo** tetap (jangan improvisasi semasa demo sebenar): senarai → butiran → mohon → lihat dalam "Permohonan Saya".
4. Sediakan **satu** perkara yang anda akan tambah jika ada masa lagi (rujuk Cabaran di bawah) — ini menunjukkan anda faham skop projek anda, bukan sekadar "siap".
5. Uji demo sekali dengan rakan sebelah sebagai penonton — minta maklum balas ringkas: adakah jelas dalam 2–3 minit?

**Senarai Semak Sebelum Demo** (rujuk juga rubrik penuh "Apa itu SIAP?" dalam [`README.md`](../README.md#apa-itu-siap-rubrik-demo)):

- [ ] `flutter analyze` — sifar isu.
- [ ] `dart format .` telah dijalankan.
- [ ] Aliran penuh (senarai → butiran → borang → permohonan saya) diuji **dari awal** sekali lagi.
- [ ] Tiada `print()` debug tertinggal dalam kod.
- [ ] Sekurang-kurangnya **dua** widget telah diekstrak melalui *refactoring* (Latihan 7).
- [ ] Anda boleh terangkan **setiap** baris kod dalam projek anda, termasuk yang dijana AI.

### 🧪 Uji Latihan 8 — larian kering demo

> **Sampai ke sana:** **tutup** app sepenuhnya dan jalankan `flutter run` **dari awal** — bukan sambung sesi Hot Reload yang sudah berjam-jam terbuka. Demo sebenar bermula dari *cold start*, jadi ujian ini mesti bermula dari situ juga. Sediakan pemasa (telefon) dan seorang rakan sebagai penonton.

**Bahagian A — laluan demo tetap (sasaran 2–3 minit):**

| # | Buat ini | Patut nampak |
|---|---|---|
| 1 | Mulakan pemasa; sebut ayat pembuka (masalah yang eTT Mobile selesaikan) | Habis dalam ≤ 20 saat, tanpa membaca skrip |
| 2 | Aplikasi buka pada tab **Tawaran** | Spinner sekejap → **8** kad (6 🇪🇬 Mesir, 2 🇲🇦 Maghribi) |
| 3 | Tekan kad **ke-1** (Al-Azhar · Perubatan) | Butiran: bidang, "Kaherah (Cairo), Mesir", kos RM23,000, kuota, ambilan September, nota pengiktirafan |
| 4 | **Mohon Sekarang** → isi borang betul → **Hantar Permohonan** | `SnackBar` "Permohonan APP-… berjaya dihantar!" |
| 5 | Tekan `←`, tekan tab **Permohonan Saya** | Kad "**Mesir · Perubatan (Medicine)**" + cip **Dihantar** biru |
| 6 | Balik ke tab **Tawaran**, ulang untuk kad **ke-7** (Al Quaraouiyine · Usuluddin) | Kad kedua "**Maghribi · Usuluddin**" — menunjukkan kedua-dua laluan negara berfungsi |
| 7 | Henti pemasa; sebut **satu** perkara yang anda akan tambah seterusnya | Jumlah masa **≤ 3 minit** |

**Bahagian B — pemeriksaan akhir sebelum menghadap penilai:**

| # | Buat ini | Patut nampak |
|---|---|---|
| 8 | `flutter analyze` | **No issues found!** |
| 9 | `dart format .` | Tiada fail berubah (anda sudah format di Latihan 7) |
| 10 | Cari `print(` dalam kod: `grep -rn "print(" lib/` | Tiada hasil (kecuali `debugPrint` yang memang disengajakan) |
| 11 | Buka `build()` setiap skrin | Sekurang-kurangnya **dua** widget sudah diekstrak (Latihan 7) |
| 12 | Rakan tunjuk **3 baris rawak** dan tanya "kenapa baris ini?" | Anda boleh terangkan kesemuanya — termasuk baris yang dijana AI |

❌ **Tak jadi?**
- Demo melebihi 3 minit → anda mengembara di luar laluan tetap. Ikut turutan baris 2–6 sahaja; jangan improvisasi ciri tambahan semasa demo.
- App ranap / skrin kosong pada larian bersih walaupun "tadi berfungsi" → anda bergantung pada keadaan Hot Reload. Uji `flutter run` dari cold start sekurang-kurangnya **sekali** sebelum demo sebenar.
- Spinner lama sebelum senarai keluar → `ProgrammeService` tidak dapat mencapai API mock dan berpatah balik ke `sampleProgrammes`. Terangkan kepada penonton sebagai **ciri** (`try/catch` + fallback), bukan pepijat.
- "Permohonan Saya" kosong di tengah demo → anda tekan `R` (Hot Restart) selepas menghantar. `_applications` disimpan dalam ingatan sahaja — hantar semula satu permohonan sebelum menunjukkan tab itu.
- Ranap `LocaleDataException` pada tab Permohonan Saya → lihat ❌ **Tak jadi?** 🧪 Uji Latihan 5 (data locale `ms` untuk `DateFormat`).
- Anda tersekat menjawab "kenapa baris ini?" → baris itu datang dari AI tanpa disemak. Fahamkan atau gantikan dengan versi yang anda faham **sebelum** demo.

---

## Cabaran (Pilih Satu atau Lebih)

Jika pasukan anda menyiapkan MVP lebih awal, cuba salah satu cabaran berikut:

1. **Carian & Tapisan** — tambah `TextField` di atas senarai tawaran yang menapis mengikut universiti/negara/bidang (`setState` mengubah senarai yang dipaparkan), serta cip tapisan mengikut negara (Mesir/Maghribi) (guna `ChoiceChip` seperti dalam `programme_list_screen.dart` rujukan).
2. **GridView Kategori Bidang** — bina skrin/tab baharu memaparkan `GridView.count` senarai bidang unik (Perubatan, Pergigian, Farmasi, Syariah, Ulum Islamiah, dll.) sebagai kad kecil 2 lajur, dengan bilangan tawaran bagi setiap bidang.
3. **Dashboard Statistik** — bina skrin/bahagian memaparkan statistik ringkas jumlah kuota (`quotaSeats`) mengikut negara/universiti daripada 8 rekod `Programme` — ingat: kuota adalah **ilustrasi** kecuali laluan Maghribi (15 tempat, angka rasmi).
4. **POST Permohonan ke API** — ubah `ProgrammeService`/cipta `ApplicationService` baharu yang menghantar (`POST`) objek `Application.toJson()` ke endpoint mock, dengan pengendalian ralat (`try/catch`) jika penghantaran gagal.
5. **Kemas Kini Status** — pada skrin "Permohonan Saya", tambah `showModalBottomSheet` membenarkan pengguna menukar `ApplicationStatus` rekod secara manual (simulasi kemas kini daripada pihak BPPT — Draf → Dihantar → Dalam Semakan → Layak/Tidak Layak → Tawaran → Diterima/Ditolak), guna `setState` (di `HomeScreen`, kerana di situ `_applications` disimpan) untuk kemas kini senarai.
6. **Refactor Lanjutan** — ekstrak **satu lagi** widget daripada skrin lain yang belum disentuh dalam Latihan 7, dan tulis satu *widget test* ringkas (`flutter test`) yang mengesahkan ia memaparkan data dengan betul.
7. **Butang Padam** — tambah `IconButton` padam pada setiap kad dalam "Permohonan Saya" yang mengalihkan rekod daripada `_applications` (`setState` di `HomeScreen`, dihantar turun sebagai *callback* `onDelete`, sama corak seperti `onApplicationSubmitted`).

---

### Cabaran E — Tab "Profil" & statistik permohonan

> **Kenapa cabaran ini istimewa:** sejak Hari 2 aplikasi anda ada tab **Profil** yang masih kosong — ini peluang menyiapkannya. Aplikasi rujukan (`projek/ett_mobile/lib/screens/profile_screen.dart`) memang ada versi penuh, **tetapi ia guna `provider`** (di luar sukatan). Di sini kita bina versi **`setState()`-sahaja** — logiknya sama, cuma datanya dihantar turun sebagai parameter.

**Konsep utama:** `ProfileScreen` **tidak** menyimpan state. Ia `StatelessWidget` yang *menerima* `List<Application>` dan mengiranya — sama corak seperti `MyApplicationsScreen` (Latihan 5) dan `countryFilter` (Hari 3).

**Langkah 1 — kira ikut status (Dart tulen, tiada pakej):**

```dart
  /// Kira bilangan permohonan bagi setiap status.
  Map<ApplicationStatus, int> get _countByStatus {
    final map = <ApplicationStatus, int>{};
    for (final status in ApplicationStatus.values) {
      map[status] = applications.where((a) => a.status == status).length;
    }
    return map;
  }
```

**Langkah 2 — papar sebagai grid.** Terdapat **8** nilai `ApplicationStatus`; memaparkan kesemuanya bermakna 6–7 petak "0" yang mengganggu. Tapis kepada status yang ada rekod sahaja:

```dart
    final counts = _countByStatus;
    final aktif = counts.entries.where((e) => e.value > 0).toList();
```

kemudian:

```dart
        GridView.count(
          crossAxisCount: 2,
          shrinkWrap: true,                                   // 👈 WAJIB
          physics: const NeverScrollableScrollPhysics(),      // 👈 WAJIB
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          childAspectRatio: 1.6,
          children: [
            for (final e in aktif)
              _StatTile(label: e.key.label, count: e.value, color: e.key.color),
          ],
        ),
```

> ⚠️ `shrinkWrap: true` + `NeverScrollableScrollPhysics` adalah **wajib** kerana `GridView` ini berada **di dalam** `ListView`. Tanpanya anda dapat ralat `Vertical viewport was given unbounded height` — dua widget boleh-skrol bersarang saling meminta tinggi tak terhad. (Rujuk nota Hari 2 Bahagian 6.)

**Langkah 3 — sambungkan di `HomeScreen`.** `_applications` sudah pun ada di sana (Latihan 1), jadi hantar turun sahaja:

```dart
    final tabs = [
      ProgrammeListScreen(onApplicationSubmitted: _addApplication),
      MyApplicationsScreen(applications: _applications),
      ProfileScreen(applications: _applications),   // 👈 TAMBAH
    ];
```

Tambah destinasi ketiga pada `NavigationBar`:

```dart
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            label: 'Profil',
          ),
```

### 🧪 Uji Cabaran E

> **Sampai ke sana:** `flutter run` → tekan **`R`** besar (struktur tab berubah).

| # | Buat ini | Patut nampak |
|---|---|---|
| 1 | Buka tab **Profil** sebelum menghantar apa-apa | "Jumlah Permohonan **0**" + mesej "Belum ada permohonan…" — **tiada** petak statistik |
| 2 | Tab **Tawaran** → kad ke-1 → **Mohon** → isi borang → **Hantar Permohonan** | Borang tertutup, `SnackBar` muncul |
| 3 | Buka tab **Profil** semula | "Jumlah Permohonan **1**", satu petak **"Dihantar: 1"** |
| 4 | Hantar satu lagi permohonan, kembali ke **Profil** | Jumlah jadi **2**, petak "Dihantar" jadi **2** |
| 5 | Kira petak status | Hanya status yang **ada rekod** dipapar — bukan kesemua 8 |

❌ **Tak jadi?**
- Ralat `Vertical viewport was given unbounded height` → `shrinkWrap: true` / `NeverScrollableScrollPhysics` tertinggal pada `GridView` (Langkah 2).
- Jumlah kekal **0** walaupun sudah hantar → `ProfileScreen(applications: _applications)` tidak dihantar, atau `_addApplication` tidak memanggil `setState`.
- Semua 8 status dipapar dengan banyak "0" → penapis `.where((e) => e.value > 0)` tertinggal.

Selamat mencuba, dan **tahniah kerana menamatkan kursus Flutter 5 Hari!**

---

## Rujukan Fail Sebenar

Untuk banding kod anda, fail rujukan lengkap (hasil akhir 5 hari) ada di:

| Fail anda (lab) | Fail rujukan (projek sebenar) |
|------------------|-------------------------------|
| `screens/home_screen.dart` (Latihan 1) | `projek/ett_mobile/lib/screens/home_screen.dart` (versi rujukan guna `provider` + `Drawer` — struktur tab sama) |
| `screens/programme_list_screen.dart` (Latihan 2) | `projek/ett_mobile/lib/screens/programme_list_screen.dart` (versi rujukan ada carian & cip tapisan — ciri Cabaran #1) |
| `screens/programme_detail_screen.dart` (Latihan 3) | `projek/ett_mobile/lib/screens/programme_detail_screen.dart` |
| `screens/application_form_screen.dart` (Latihan 4) | `projek/ett_mobile/lib/screens/application_form_screen.dart` (versi rujukan ada dropdown negara/bidang berasingan — lebih maju) |
| `screens/my_applications_screen.dart` (Latihan 5) | `projek/ett_mobile/lib/screens/my_applications_screen.dart` (versi rujukan ada butang kemas kini status & padam) |
| Widget diekstrak (Latihan 7) | `projek/ett_mobile/lib/widgets/programme_card.dart`, `lib/widgets/status_badge.dart` |
| Data 8 program eTT | `projek/ett_mobile/lib/data/sample_programmes.dart` (lihat juga jadual dalam [`README.md` utama](../../README.md)) |

> Fail rujukan menggunakan pakej `provider` untuk kongsi state antara skrin (bukan `setState()` + callback seperti lab ini) — kedua-dua corak **sah**; `provider` sesuai untuk aplikasi yang membesar, `setState()`/callback sesuai untuk aplikasi kecil seperti hari ini. Baca [`nota/05-state-management.md`](../../nota/05-state-management.md) bila anda bersedia meneroka `provider` selepas kursus tamat.
