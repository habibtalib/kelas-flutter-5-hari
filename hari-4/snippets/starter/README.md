# Fail Starter — Hari 4

Folder ini mengandungi **semua fail asas** yang diperlukan untuk Lab Hari 4 (REST API, async & error handling). Ia **kumulatif** — termasuk semula fail Hari 2–3 (supaya boleh dimulakan terus walaupun anda terlepas hari sebelumnya). Tiada fail baharu Hari 4 di sini kerana lapisan baharu hari ini (`Programme.fromJson`, `ProgrammeService`, skrin API) semuanya **anda bina sendiri** dalam lab.

## Cara guna

Salin kandungan folder `starter/` ke `lib/` projek anda (kekalkan struktur):

```bash
# dari dalam folder projek ett_mobile anda
mkdir -p lib/models lib/data lib/widgets
cp <laluan-repo>/hari-4/snippets/starter/theme.dart                 lib/theme.dart
cp <laluan-repo>/hari-4/snippets/starter/models/programme.dart      lib/models/programme.dart
cp <laluan-repo>/hari-4/snippets/starter/models/application.dart     lib/models/application.dart
cp <laluan-repo>/hari-4/snippets/starter/data/sample_programmes.dart lib/data/sample_programmes.dart
cp <laluan-repo>/hari-4/snippets/starter/data/document_checklist.dart lib/data/document_checklist.dart
cp <laluan-repo>/hari-4/snippets/starter/widgets/programme_card.dart  lib/widgets/programme_card.dart
cp <laluan-repo>/hari-4/snippets/starter/widgets/status_badge.dart    lib/widgets/status_badge.dart
```

> Jika anda sudah teruskan projek Hari 3 anda, fail-fail ini kemungkinan besar sudah ada — anda **tidak perlu** salin semula. Salin hanya jika anda mula dari `flutter create` baharu, ATAU jika `flutter analyze` mengadu fail hilang.

## Fail dalam folder ini

| Fail | Kandungan | Guna dalam lab |
|------|-----------|-----------------|
| `theme.dart` | `KptTheme` (navy + emas) | Warna AppBar/Card/butang sepanjang lab |
| `models/programme.dart` | Kelas `Programme` + enum `StudyLevel`/`EntryCategory` — **tanpa** `fromString`/`fromJson` | Model yang anda **lengkapkan** di Latihan 3 |
| `models/application.dart` | Kelas `Application` + `enum ApplicationStatus`, lengkap dengan `toJson()` (tanpa `Application.fromJson` — lihat nota bawah) | Body `POST` di Latihan 7 |
| `data/sample_programmes.dart` | `sampleProgrammes` — 8 tawaran | Data sandaran (`_fallback()`) di Latihan 4 |
| `data/document_checklist.dart` | `ettDocumentChecklist` — senarai label dokumen | Rujukan borang (Hari 3, kumulatif) |
| `widgets/programme_card.dart` | `ProgrammeCard` + `CategoryPill` | Papar hasil fetch API di Latihan 6 |
| `widgets/status_badge.dart` | `StatusBadge` — cip status permohonan | Rujukan skrin "Permohonan Saya" (Hari 3, kumulatif) |

## ⚠️ Yang SENGAJA tiada dalam `programme.dart`

`models/programme.dart` di sini **tidak** mengandungi:

- `StudyLevel.fromString(...)` dan `EntryCategory.fromString(...)`
- `factory Programme.fromJson(...)`

Ini **bukan** silap — ketiga-tiganya **anda bina sendiri** dalam **Latihan 3** (itulah inti pelajaran Hari 4: menukar JSON → objek Dart). Cari komen penanda di dalam fail:

- `// Latihan 3.1: tambah ... fromString di sini` (dalam kedua-dua enum)
- `// Latihan 3.2–3.3: tambah factory Programme.fromJson di sini` (dalam `class Programme`)

Fail ini **masih sah (valid) Dart dan boleh `flutter analyze` bersih** seadanya — kerana `toJson()` (yang kekal) tidak bergantung pada `fromString`/`fromJson`. Anda hanya belum boleh menghurai JSON masuk sehingga Latihan 3 selesai.

Atas sebab yang **sama**, `models/application.dart` juga dikeluarkan `Application.fromJson`-nya (ia bergantung pada `EntryCategory.fromString`). Lab Hari 4 hanya perlu `Application(...)` + `toJson()` untuk `POST` (Latihan 7), jadi ini tidak menjejaskan mana-mana latihan.

**Nota data:** nama universiti & syarat asas adalah **benar** (rujukan Syarat_Mesir, portal dohe.mohe.gov.my/timurtengah); `estimatedAnnualCostMyr` & `quotaSeats` adalah **ilustrasi** kecuali laluan Maghribi (15 tempat, angka rasmi). Lihat komen dalam `sample_programmes.dart`.
