# eTT Mobile — Latihan

Aplikasi rujukan (reference app) untuk kursus coaching Flutter KPT — **companion latihan** bagi sistem **e-Timur Tengah (eTT)**. Pelajar Malaysia meneliti program pengajian di universiti **Mesir** & **Maghribi (Morocco)**, membaca butiran (kelayakan, kos anggaran, ambilan), memohon (daftar, SPM/STAM, pilih 1 negara + 1 bidang + sehingga 3 pilihan universiti, muat naik dokumen), dan menjejak status kelayakan/tawaran. Nama universiti & syarat kelayakan adalah benar; kos & kuota dalam data aplikasi adalah ilustrasi.

eTT ialah sistem **Bahagian Pengantarabangsaan Pendidikan Tinggi (BPPT)**, Jabatan Pendidikan Tinggi (JPT), Kementerian Pendidikan Tinggi (KPT).

## Kaedah pengajaran

- **Prosa/nota Bahasa Melayu; kod & pengecam (identifier) English.**
- Pengurusan state menggunakan `setState()` (SESI 5) di peringkat asas, dan `provider` + `shared_preferences` di aplikasi rujukan ini untuk state dikongsi merentas skrin.
- Warna navy `0xFF1A2B5C` + emas `0xFFD4A017` adalah **pilihan reka bentuk**, bukan palet rasmi KPT.

## Peraturan sebenar eTT (dimodelkan tepat)

- **1 negara + 1 bidang** setiap permohonan. Dalam bidang itu, pemohon menyusun **sehingga 3 pilihan universiti** (pilihan 1 wajib; 2 & 3 pilihan).
- Terbuka kepada lepasan **SPM & STAM**.
- Istilah status sebenar: **LAYAK / TIDAK LAYAK**. Nota: dalam sistem sebenar terdapat peringkat muat naik dokumen + bayaran antara LAYAK dan surat tawaran — status "diterima/ditolak" di sini penyederhanaan model.

## Struktur `lib/`

```
lib/
├── main.dart                         # MultiProvider + MaterialApp + initializeDateFormatting('ms')
├── theme.dart                        # KptTheme (navy + emas — design choice)
├── models/
│   ├── programme.dart                # Programme + StudyLevel, EntryCategory (label BM, fromString, fromJson/toJson)
│   └── application.dart              # Application + ApplicationStatus (label + warna BM, copyWith, fromJson/toJson)
├── data/
│   ├── sample_programmes.dart        # 8 tawaran contoh (data sandaran/fallback)
│   └── document_checklist.dart       # 6 label dokumen sokongan eTT
├── services/
│   └── programme_service.dart        # HTTP GET + timeout + try/catch + fallback ke data contoh
├── providers/                        # state dikongsi (provider + shared_preferences)
│   ├── programme_provider.dart       # senarai + carian + tapis negara/kategori + LoadState
│   ├── application_provider.dart     # permohonan + add/updateStatus/remove + nextId (ETT-2026-0001) + countByStatus
│   └── profile_provider.dart         # profil pelajar (nama, No. KP, kategori akademik)
├── widgets/
│   ├── programme_card.dart           # kad Row: bendera + Column(universiti, bidang) + Expanded + kos RM
│   └── status_badge.dart             # badge status berwarna
└── screens/
    ├── home_screen.dart              # BottomNavigationBar 3 tab + Drawer (Negara: Mesir/Maghribi)
    ├── programme_list_screen.dart    # carian + cip tapisan + ListView.builder + RefreshIndicator + loading/error
    ├── programme_detail_screen.dart  # header + info (kategori, kos, peringkat, ambilan, kuota, nota) + butang "Mohon"
    ├── application_form_screen.dart  # Form + TextFormField + dropdown kategori/negara/bidang + 3 pilihan universiti + senarai semak dokumen
    ├── my_applications_screen.dart   # senarai permohonan + StatusBadge + bottom sheet tukar status + padam
    └── profile_screen.dart           # kad profil + statistik countByStatus (GridView.count)
```

## Peta hari kursus (agenda TETAP; hanya contoh domain berubah)

| Hari | Topik dengan data eTT |
|------|------------------------|
| 1 | Dart: loop program, jumlah kuota, if/else SPM vs STAM, switch negara→ambilan, enum; widget asas; kad Container/Padding |
| 2 | Layout; Scaffold/AppBar "eTT Mobile"; BottomNav + Drawer; ListView.builder; GridView; Card/ListTile; ThemeData |
| 3 | Navigator → detail; named routes; passing data; borang + validation (IC 12-digit, emel, telefon); setState() & lifecycle |
| 4 | REST API; `http`; async; fetch program; `Programme.fromJson`; submit `Application` (toJson); LoadState; RefreshIndicator |
| 5 | Projek mini (browse+detail+form+API); alat AI; clean code; refactoring; demo |

## Cara jalankan

```bash
cd projek/ett_mobile
flutter pub get
flutter analyze      # mesti: No issues found!
flutter test         # mesti lulus
flutter run          # jalankan aplikasi eTT Mobile penuh
```

## 📱 Galeri Demo — konsep interaktif (Hari 2–5)

Selain aplikasi penuh, ada **galeri demo** berasingan: satu skrin interaktif untuk **setiap konsep**, supaya jurulatih/pelajar boleh tunjuk & lihat konsep berfungsi secara langsung — ubah kawalan pada skrin, lihat kesannya serta-merta.

```bash
flutter run -t lib/demos_main.dart   # lancarkan Galeri Demo (bukan aplikasi penuh)
```

Kod demo ada di [`lib/demos/`](./lib/demos/). Setiap demo ialah satu fail berdiri sendiri, boleh dibaca sebagai contoh:

| Hari | Demo (`lib/demos/hariN/`) |
|------|---------------------------|
| **Hari 2** | Row & Column · Expanded vs Flexible · Stack & Positioned · **ListView vs ListView.builder** (1000 item, kira widget dibina) · GridView · Card & ListTile · ThemeData |
| **Hari 3** | Navigator push/pop (visual stack) · TextField vs TextFormField · Form & Validation · **setState() & Lifecycle** (log initState/build/dispose; lihat skrin beku tanpa setState) · Button & GestureDetector |
| **Hari 4** | async/await (UI tak beku) · Fetch JSON dari API · LoadState (idle/loading/loaded/error) · Pengendalian Ralat (try/catch) |
| **Hari 5** | Refactoring (Sebelum vs Selepas) |

> Contoh: demo **ListView vs ListView.builder** membina 1000 tawaran dan memaparkan pembilang "widget dibina: N" yang hanya bertambah semasa anda menatal — membuktikan `ListView.builder` membina secara **malas (lazy)**.

## API tiruan (mock)

Fail `projek/mock-api/programmes.json` mengandungi 8 tawaran (dijana daripada `Programme.toJson`) untuk latihan HTTP hari-4. Hos di GitHub Pages / json-server / mocki.io, kemudian kemas kini `_endpoint` dalam `services/programme_service.dart`. Jika API gagal, aplikasi berpatah balik ke data contoh tempatan.
