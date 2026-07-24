# Projek Kursus

## 🎓 `ett_mobile/` — **eTT Mobile** (aplikasi rujukan semasa)

Aplikasi mobil *companion* latihan bagi sistem **e-Timur Tengah (eTT)** — inilah aplikasi rujukan untuk kursus **Latihan Secara *Coaching* Aplikasi Mobil Bagi Sistem Pendidikan Tinggi Luar Negara** (20–24 Julai 2026, BPM KPT).

> Diilhamkan daripada sistem sebenar KPT: [e-TimurTengah](https://dohe.mohe.gov.my/timurtengah/) — permohonan pelajar Malaysia ke universiti di **Mesir** & **Maghribi (Morocco)**, beroperasi sejak 2014. Diselia oleh **Bahagian Pengantarabangsaan Pendidikan Tinggi (BPPT), JPT**.

### Apa yang aplikasi ini buat?

- 🌏 **Terokai Program** — senarai tawaran pengajian (universiti + bidang) di Mesir & Maghribi (carian + tapisan negara)
- 🔍 **Butiran** — kelayakan (SPM/STAM), anggaran kos (RM), bulan ambilan, kuota tempat, nota pengiktirafan
- ✍️ **Mohon** — borang permohonan dengan pengesahan (No. KP, emel, telefon), pilih **1 negara + 1 bidang** + sehingga **3 pilihan universiti**
- 📌 **Permohonan Saya** — jejak status: Draf → Dihantar → Dalam Semakan → Layak/Tidak Layak → Tawaran → Diterima/Ditolak
- 👤 **Profil & Statistik** — ringkasan mengikut status
- 🌐 Data program dari **REST API** dengan *fallback* tempatan (Hari 4)

### Menjalankan

```bash
cd ett_mobile
flutter pub get
flutter analyze     # No issues found!
flutter test        # semua lulus
flutter run
```

Butiran penuh struktur `lib/` ada dalam [`ett_mobile/README.md`](./ett_mobile/README.md).

### Pemetaan kod ↔ sesi rasmi

| Hari | Sesi | Fail utama |
|------|------|-----------|
| **Hari 1** | SESI 1 | *(Dart asas + widget asas — lihat [`../hari-1/snippets/dart_asas.dart`](../hari-1/snippets/dart_asas.dart))* |
| **Hari 2** | SESI 2–3 | `theme.dart`, `widgets/programme_card.dart`, `screens/home_screen.dart`, `screens/programme_list_screen.dart`, `data/sample_programmes.dart` |
| **Hari 3** | SESI 4–5 | `screens/programme_detail_screen.dart`, `screens/application_form_screen.dart`, `models/application.dart` |
| **Hari 4** | SESI 6–7 | `services/programme_service.dart`, `models/programme.dart` (`fromJson`), `providers/programme_provider.dart` (`LoadState`), [`mock-api/programmes.json`](./mock-api/programmes.json) |
| **Hari 5** | SESI 8–9 | Projek mini — gabung semua; `widgets/` sebagai contoh refactoring |

Aplikasi ini guna `provider` untuk state dikongsi di seluruh skrin — lihat [`../nota/05-state-management.md`](../nota/05-state-management.md) untuk perbandingan dengan `setState()` (SESI 5) dan Riverpod.

---

## 🌐 `mock-api/` — data untuk Hari 4

[`programmes.json`](./mock-api/programmes.json) — 8 tawaran pengajian, padan tepat dengan `Programme.fromJson`. Hos percuma sebagai REST API:

- **GitHub (raw):** muat naik → guna URL `raw.githubusercontent.com/...`
- **json-server:** `npx json-server mock-api/programmes.json`
- **mocki.io / mockapi.io:** tampal JSON, dapatkan URL

Kemudian kemas kini pemalar `_endpoint` dalam `ett_mobile/lib/services/programme_service.dart`.

> Emulator Android: `localhost` mesin anda ialah **`10.0.2.2`** dari dalam emulator.

---

## 📦 `mybiasiswa_kpt/` — aplikasi lama (arkib)

Aplikasi **MyBiasiswa KPT** (domain biasiswa) daripada versi kursus terdahulu, sebelum domain ditukar kepada *Sistem Pendidikan Tinggi Luar Negara* mengikut aturcara rasmi. **Bukan lagi aplikasi rujukan kursus** — dikekalkan sebagai contoh tambahan sahaja. Ia masih berfungsi (`flutter analyze` bersih).

---

Nama universiti & syarat kelayakan dalam data aplikasi adalah benar; kos anggaran & kuota tempat adalah ilustrasi, kecuali laluan Maghribi — 15 tempat adalah angka rasmi.
