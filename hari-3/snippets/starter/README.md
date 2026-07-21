# Fail Starter — Hari 3

Folder ini mengandungi **semua fail asas** yang diperlukan untuk Lab Hari 3 (borang permohonan). Ia **kumulatif** — termasuk fail Hari 2 (supaya boleh dimulakan terus walaupun anda terlepas Hari 2) **dan** dua fail baharu untuk borang.

## Cara guna

Salin kandungan folder `starter/` ke `lib/` projek anda (kekalkan struktur):

```
starter/theme.dart                    →  lib/theme.dart
starter/models/programme.dart         →  lib/models/programme.dart
starter/models/application.dart       →  lib/models/application.dart      ← BAHARU (Hari 3)
starter/data/sample_programmes.dart   →  lib/data/sample_programmes.dart
starter/data/document_checklist.dart  →  lib/data/document_checklist.dart ← BAHARU (Hari 3)
starter/widgets/programme_card.dart   →  lib/widgets/programme_card.dart
starter/widgets/status_badge.dart     →  lib/widgets/status_badge.dart    ← BAHARU (Hari 3)
```

> Jika anda sudah salin fail Hari 2, anda cuma perlu **tiga fail baharu**: `models/application.dart`, `data/document_checklist.dart`, dan `widgets/status_badge.dart`.

## Fail baharu untuk Hari 3

| Fail | Kandungan | Guna dalam lab |
|------|-----------|-----------------|
| `models/application.dart` | Kelas `Application` (permohonan pelajar) + `enum ApplicationStatus` (Draf → Dihantar → Layak/Tidak Layak → …) dengan warna badge | Data borang & skrin "Permohonan Saya" |
| `data/document_checklist.dart` | `ettDocumentChecklist` — senarai label dokumen | `CheckboxListTile` dalam borang |
| `widgets/status_badge.dart` | `StatusBadge` — cip berwarna ikut `ApplicationStatus` | Skrin "Permohonan Saya" |

**Nota:** `Application` memodelkan peraturan sebenar eTT — **1 negara + 1 bidang** setiap permohonan, dengan **sehingga 3 pilihan universiti** (`universityChoiceIds`). Lihat komen dalam fail.
