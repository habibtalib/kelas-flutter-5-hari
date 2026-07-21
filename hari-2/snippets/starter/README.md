# Fail Starter — Hari 2

Fail-fail dalam folder ini ialah **asas (foundation)** yang anda perlu **salin ke projek anda** SEBELUM mula Lab Hari 2. Anda **tidak perlu menaipnya dari kosong** — ia data & model yang kita bina UI di atasnya.

## Cara guna (2 minit)

Salin kandungan folder `starter/` ini ke folder `lib/` projek `ett_mobile` anda, kekalkan struktur folder:

```
starter/theme.dart                    →  lib/theme.dart
starter/models/programme.dart         →  lib/models/programme.dart
starter/data/sample_programmes.dart   →  lib/data/sample_programmes.dart
starter/widgets/programme_card.dart   →  lib/widgets/programme_card.dart
```

Cara pantas dari terminal (dari dalam folder projek anda):

```bash
mkdir -p lib/models lib/data lib/widgets
cp <laluan-repo>/hari-2/snippets/starter/theme.dart                 lib/theme.dart
cp <laluan-repo>/hari-2/snippets/starter/models/programme.dart      lib/models/programme.dart
cp <laluan-repo>/hari-2/snippets/starter/data/sample_programmes.dart lib/data/sample_programmes.dart
cp <laluan-repo>/hari-2/snippets/starter/widgets/programme_card.dart lib/widgets/programme_card.dart
```

## Apa yang anda dapat

| Fail | Kandungan | Guna dalam lab |
|------|-----------|-----------------|
| `theme.dart` | `KptTheme.navy` (0xFF1A2B5C) + `KptTheme.gold` (0xFFD4A017) + `KptTheme.light` (ThemeData) | Warna & tema (Latihan ThemeData) |
| `models/programme.dart` | Kelas `Programme` + `enum StudyLevel`, `EntryCategory` | Setiap kad & senarai |
| `data/sample_programmes.dart` | `sampleProgrammes` — 8 tawaran sebenar (Al-Azhar, Alexandria, dll.) | Data untuk `ListView`, `GridView`, `Card` |

> Selepas menyalin, dalam mana-mana fail Dart anda cuma perlu:
> ```dart
> import 'models/programme.dart';   // atau '../models/programme.dart' bergantung lokasi
> import 'data/sample_programmes.dart';
> import 'theme.dart';
> ```
> dan `sampleProgrammes` serta `KptTheme.navy` terus boleh digunakan.

**Nota:** `Programme` mempunyai kaedah `fromJson`/`toJson` — itu untuk **Hari 4** (API). Abaikan buat masa ini; Hari 2 hanya guna medan biasa.
