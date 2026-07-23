# Fail Starter — Hari 5 (Projek Mini / Hackathon)

Folder ini mengandungi **keseluruhan foundation terkumpul** 4 hari pertama —
model, data, servis, tema, dan widget — supaya hari ini anda boleh **fokus
sepenuhnya membina skrin** (assemble `screens/`), bukan menaip semula struktur
data dari kosong.

Semua fail di sini ialah **salinan sebenar** daripada `projek/ett_mobile/lib/`
(kecuali `widgets/programme_card.dart` yang versi bebas-`intl` supaya terus
berfungsi dalam projek `flutter create` baharu). Setiap fail ada kotak header
`// FAIL STARTER — salin ke: …` yang memberitahu destinasinya.

## Pakej diperlukan

Servis API guna pakej `http`, dan skrin butiran/senarai permohonan guna `intl`
untuk format mata wang & tarikh:

```bash
flutter pub add http intl
```

⚠️ **`intl` sahaja tidak cukup.** Tarikh dipapar dengan locale `'ms'`, jadi data
locale mesti dimuatkan dalam `main()` sebelum `runApp()` — jika tidak aplikasi
ranap dengan `LocaleDataException` sebaik sahaja "Permohonan Saya" berisi:

```dart
import 'package:intl/date_symbol_data_local.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('ms', null);
  runApp(const EttMobileApp());
}
```

> `http` mungkin sudah ditambah dari Hari 4 — arahan di atas selamat dijalankan
> semula (tiada kesan jika sudah ada).

## Cara guna

Salin kandungan folder `starter/` ke `lib/` projek anda (kekalkan struktur):

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

> Jika anda sudah membina projek `ett_mobile` sepanjang Hari 1–4, kebanyakan
> fail ini **sudah ada** dalam `lib/` anda — folder ini cuma jaring keselamatan
> supaya sesiapa yang terlepas mana-mana hari boleh mula terus hari ini dengan
> foundation yang **sama** seperti orang lain.

## Fail dalam folder ini

| Fail | Kandungan | Guna dalam lab |
|------|-----------|-----------------|
| `theme.dart` | `KptTheme` — navy `0xFF1A2B5C` + emas `0xFFD4A017` | Warna seluruh aplikasi |
| `models/programme.dart` | Kelas `Programme` (+ `StudyLevel`, `EntryCategory`) **penuh** dengan `fromJson`/`toJson` | Data tawaran, senarai, butiran |
| `models/application.dart` | Kelas `Application` (+ `ApplicationStatus`, `copyWith`) penuh | Borang & "Permohonan Saya" |
| `data/sample_programmes.dart` | `sampleProgrammes` — 8 tawaran eTT | Fallback API + cari calon Pilihan 2/3 |
| `data/document_checklist.dart` | `ettDocumentChecklist` — 6 label dokumen | `CheckboxListTile` dalam borang |
| `services/programme_service.dart` | `ProgrammeService` — HTTP GET + timeout + fallback tempatan | Latihan 2 (muat senarai) |
| `widgets/programme_card.dart` | `ProgrammeCard` + `CategoryPill` (versi bebas-`intl`) | Item senarai tawaran |
| `widgets/status_badge.dart` | `StatusBadge` — cip berwarna ikut `ApplicationStatus` | "Permohonan Saya" |

## Apa yang anda bina sendiri hari ini

Folder ini **tidak** mengandungi `screens/` — itulah kerja hackathon anda:

```
lib/screens/home_screen.dart              ← Latihan 1
lib/screens/programme_list_screen.dart    ← Latihan 2
lib/screens/programme_detail_screen.dart  ← Latihan 3
lib/screens/application_form_screen.dart  ← Latihan 4
lib/screens/my_applications_screen.dart   ← Latihan 5
```

**Nota state:** hari ini state diurus dengan **`setState()` + callback** sahaja
(silibus rasmi kursus). Jangan salin folder `providers/` dari projek rujukan —
versi rujukan itu guna pakej `provider` sebagai *pratonton* selepas kursus.

**Nota fakta:** `Application` memodelkan peraturan sebenar eTT — **1 negara +
1 bidang** setiap permohonan, dengan **sehingga 3 pilihan universiti**
(`universityChoiceIds`). Lihat komen dalam fail.
