# Nota Rujukan: Contoh Prompt Claude Code untuk Flutter

> Claude Code (dan pembantu AI lain) boleh mempercepat pembangunan Flutter — bina widget, debug ralat, refactor, tulis ujian. Nota ini mengumpulkan **contoh prompt** untuk projek eTT Mobile (Flutter + Dart).

> **Bahasa:** Claude faham Bahasa Melayu **dan** Bahasa Inggeris. Kekalkan **istilah teknikal** (widget, StatefulWidget, setState, validator, Future) dalam Bahasa Inggeris supaya tepat.

---

## Prinsip Prompt yang Baik

| Prinsip | ❌ Lemah | ✅ Baik |
|---------|---------|--------|
| **Khusus** | "tambah carian" | "Tambah `TextField` carian di atas `ListView` dalam `programme_list_screen.dart` yang menapis senarai mengikut `universityName` dan `fieldOfStudy` guna `setState()`" |
| **Beri konteks** | "ada ralat" | "Ralat `setState() called after dispose()` bila keluar `ApplicationFormScreen` semasa SnackBar dipapar. Lihat method `_submit`" |
| **Rujuk fail** | "ubah model" | "Dalam `models/programme.dart`, tambah medan `requiresArabicTest` jenis `bool` dan kemas kini `fromJson`/`toJson`" |
| **Satu langkah** | "bina borang + validation + simpan + API" | Pecahkan kepada beberapa prompt kecil |
| **Nyatakan hasil** | "buat ia elok" | "Papar mesej ralat merah di bawah `TextFormField` bila No. KP bukan 12 digit" |

---

## Contoh Prompt Mengikut Tujuan

### A. Memahami kod (sebelum mengubah)

```text
Terangkan bagaimana ProgrammeService.fetchProgrammes() mengendalikan
kegagalan rangkaian dan bila ia berpatah balik ke data tempatan,
langkah demi langkah.
```
```text
Lukiskan aliran data dari borang "Mohon" sehingga permohonan muncul
dalam skrin "Permohonan Saya" — fail mana yang terlibat?
```

### B. Bina ciri baharu (scaffold)

```text
Tambah widget StatelessWidget baharu `IntakeChip` dalam lib/widgets/ yang
memaparkan bulan ambilan (intakeMonth) sesuatu Programme. Jika ambilan
kurang 30 hari lagi, papar warna merah. Guna dalam ProgrammeCard.
```
```text
Tambah tapisan mengikut EntryCategory (SPM/STAM) pada ProgrammeListScreen
guna setState() — cip "Semua / SPM / STAM" di atas senarai.
```

### C. Debug ralat

```text
Bila saya tekan "Hantar", aplikasi crash dengan ralat:
"Null check operator used on a null value" dalam application_form_screen.dart.
Ini kod _submit: [tampal kod]. Apa puncanya dan bagaimana membaikinya?
```

### D. Refactor & kemas kini

```text
Refactor ProgrammeDetailScreen — asingkan nota pengiktirafan (recognitionNote)
ke widget berasingan `RecognitionNote` dalam lib/widgets/. Kekalkan gaya sama.
```

### E. Tulis ujian

```text
Tulis widget test untuk ApplicationFormScreen yang mengesahkan borang
menolak No. KP kurang 12 digit dan memaparkan mesej ralat.
```

### F. Sambung API

```text
Ubah ProgrammeService supaya ia juga menyokong POST permohonan ke endpoint
/applications, hantar body JSON dari Application.toJson().
Kendalikan ralat rangkaian dengan try/catch dan semak status code 201.
```

---

## Templat Prompt Boleh Guna Semula

Guna templat ini untuk **kerja kursus** (mengikut sukatan rasmi — `setState()`):

```text
Konteks: Projek Flutter "eTT Mobile" — companion latihan sistem e-Timur Tengah (KPT), permohonan pelajar ke universiti Mesir & Maghribi.
State: setState() (StatefulWidget). Struktur: lib/{models,data,services,widgets,screens}.

Tugas: <apa yang anda mahu>
Fail terlibat: <lib/...>
Hasil dijangka: <kelakuan akhir yang anda mahu lihat>
Kekangan: kekalkan gaya sedia ada; teks UI dalam Bahasa Melayu; nama kod dalam Bahasa Inggeris.
```

> **Nota:** Aplikasi rujukan [`projek/ett_mobile`](../projek/ett_mobile/) menggunakan **`provider`** (folder tambahan `providers/`) sebagai corak state dikongsi. Jika anda bekerja pada aplikasi rujukan itu, tukar baris `State:` kepada `provider (ChangeNotifier)` dan tambah `providers` ke struktur. Untuk kerja kursus, kekalkan `setState()`.

---

## Petua Penggunaan AI yang Berkesan

1. **Jalankan `flutter analyze` selepas setiap perubahan** — tangkap ralat awal.
2. **Uji dengan Hot Reload** — sahkan setiap ciri berfungsi sebelum minta ciri seterusnya.
3. **Jangan terima kod buta-buta** — minta AI **terangkan** bahagian yang anda tak faham.
4. **Guna kawalan versi (git)** — commit kerap supaya boleh patah balik jika AI silap.
5. **AI membantu, anda memandu** — anda mesti faham kod yang dihasilkan, terutama untuk tugasan/penilaian.

---

Untuk merancang **keseluruhan** aplikasi sebelum mengekod (bukan sekadar satu ciri), lihat [nota 09 — Prompt PRD](./09-prd-prompt.md) — berguna khususnya untuk projek mini Hari 5.

Kembali ke [README utama](../README.md) atau mula [Hari 1](../hari-1/).

---

## Nota Tambahan (dari slaid)

- **Apa itu Claude Code?** Ia pembantu AI dalam **terminal** yang boleh **membaca dan menulis** kod projek anda secara langsung (bukan sekadar chat) — ia melihat fail sebenar dalam repo.
- **Pengujian:** selain **widget test** (menguji satu widget), ada juga **integration test** — menguji **aliran penuh** aplikasi hujung-ke-hujung sebagai satu konsep berasingan.
