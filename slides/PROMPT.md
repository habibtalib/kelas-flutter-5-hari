# Prompt Reka Bentuk Slaid — untuk Claude

> Fail ini **bukan** slaid. Ia adalah **prompt lengkap** untuk menjana semula deck slaid kursus ini dari awal menggunakan **Claude**.
>
> **Deck sedia ada:** [`flutter-training.html`](./flutter-training.html) — sudah dijana. Untuk **kemas kini kecil**, lebih mudah edit bahagian dalam [`_build/`](./_build/) dan gabung semula (lihat [`README.md`](./README.md)). Guna prompt ini hanya jika mahu jana **dari kosong** atau ubah gaya secara menyeluruh.

> **Cara guna:** Salin blok antara `=== MULA PROMPT ===` dan `=== TAMAT PROMPT ===` ke Claude. Cara terbaik: jalankan **Claude Code di dalam folder repo ini** supaya ia boleh membaca `JADUAL.md`, `hari-*/README.md`, dan kod sebenar `projek/ett_mobile/lib/`.

---

=== MULA PROMPT ===

Anda seorang pereka bentuk pembentangan teknikal. Hasilkan **deck slaid reveal.js** lengkap untuk kursus:

**Latihan Secara *Coaching* Aplikasi Mobil Bagi Sistem Pendidikan Tinggi Luar Negara Menggunakan Flutter Berteraskan Amalan Pengekodan Moden Dengan Bantuan *Artificial Intelligence* (AI)**
Anjuran **Bahagian Pengurusan Maklumat (BPM), Kementerian Pendidikan Tinggi (KPT)** · 20–24 Julai 2026 · Bilik Latihan Al-Khazini 2, Putrajaya.

## ⚠️ Aturcara rasmi ialah sumber kebenaran
**Baca `JADUAL.md` dahulu.** Ia mengandungi aturcara rasmi (Lampiran A surat jemputan): **9 sesi** merentasi 5 hari dengan **waktu tetap**. Deck MESTI mengikutnya. Jangan ubah skop hari.

| Hari | Sesi | Tajuk |
|------|------|-------|
| 1 | SESI 1 | Widget Asas & Aliran Kawalan Dart |
| 2 | SESI 2–3 | Seni Bina Layout & Struktur UI · Senarai Dinamik & Kemasan (Styling) |
| 3 | SESI 4–5 | Navigasi Skrin & Borang Input · Kawalan Borang & State Management Asas |
| 4 | SESI 6–7 | Konsep REST API & Sambungan Backend · Model Data & Pengendalian Ralat |
| 5 | SESI 8–9 | Projek Mini Terbimbing · Projek Mini (Bhg 2), Amalan Kod Moden & Penutup |

### Peraturan keras daripada aturcara
- **`setState()` ialah state management kursus** (SESI 5). `provider` / `shared_preferences` **di luar sukatan** → nota bonus sahaja.
- **Tiada sesi deployment / `flutter build apk`.** Hari 5 ialah **projek mini + clean code + refactoring + demo**.
- 🤖 **"Slot AI" ialah item aturcara rasmi** (SESI 2, 5, 7; teras SESI 8–9) — beri berat sebenar, bukan bonus.
- Nama rasmi: **Kementerian Pendidikan Tinggi (KPT)** (bukan "Pengajian Tinggi").

## Sumber kandungan
Baca dahulu sebelum mereka bentuk:
- `JADUAL.md` — aturcara rasmi (waktu, sesi)
- `README.md` — gambaran kursus, domain, jadual Slot AI, jadual di luar sukatan
- `hari-1/README.md` … `hari-5/README.md` — modul harian terperinci
- `nota/01`–`nota/08` — nota konsep
- `projek/ett_mobile/lib/` — **kod sebenar aplikasi** (petik kod dari sini; kekalkan identifier)

## Domain: eTT Mobile
Aplikasi *companion* latihan bagi sistem sebenar KPT **e-Timur Tengah (eTT)** — pelajar Malaysia memohon ke universiti di **Mesir** & **Maghribi (Morocco)**. Diselia **Bahagian Pengantarabangsaan Pendidikan Tinggi (BPPT), JPT**.
Entiti: `Programme` (tawaran universiti + bidang), `Application` (permohonan pelajar).
Peraturan sebenar: **1 negara + 1 bidang** setiap permohonan, sehingga **3 pilihan universiti**. Status guna istilah sebenar **LAYAK / TIDAK LAYAK**.

## ⚠️ Ketepatan fakta (jangan reka)
- **Jangan cipta tagline, logo, atau statistik bilangan pelajar** — KPT tiada tagline rasmi dan tiada statistik pelajar-eTT awam untuk dipetik. eTT bukan sistem pendaftaran pelajar luar negara berskala besar; jangan pinjam statistik bilangan pelajar daripada sistem KPT lain.
- **Warna navy `#1A2B5C` + emas `#D4A017` ialah pilihan reka bentuk, BUKAN palet rasmi KPT** (KPT tiada garis panduan jenama awam). Jangan dakwa ia rasmi.
- Nama universiti (Al-Azhar, Alexandria, Ain Shams, Mansoura, Tanta, Al Quaraouiyine) & syarat kelayakan adalah **benar**; kos & kuota adalah **ilustrasi** (kecuali kuota Maghribi — 15 tempat rasmi).
- Data Maghribi **nipis** — hanya Al Quaraouiyine disahkan; Mohammed V/Hassan II ialah pemadanan ilustrasi, label sebagai sedemikian.
- Kekalkan penafian: **bahan latihan, BUKAN sistem e-Timur Tengah rasmi**; permohonan sebenar hanya di dohe.mohe.gov.my/timurtengah; KPT tidak melantik ejen.
- **Jangan sertakan butiran sistem dalaman** (fail PHP, jadual pangkalan data, aliran kerja back-office, rayuan) — bukan bahan kursus.

## Bahasa
Teks slaid **Bahasa Melayu**; kod & istilah teknikal (widget, StatelessWidget, setState, Future) **Bahasa Inggeris**.

## Identiti visual
Navy `#1A2B5C` (utama), emas `#D4A017` (aksen), latar `#F5F6FA`, teks `#1A1A2E`. Moden, kemas, banyak ruang putih, tipografi besar (mudah dibaca dari belakang kelas). Slaid pembahagi hari = latar navy penuh + tajuk emas. Font sistem sahaja. **Jangan guna CDN luar** — deck mesti berfungsi dari `file://`.

## Format teknikal
- **reveal.js**, pustaka di-*vendor* di `slides/vendor/reveal/`. Fail utama: `slides/flutter-training.html`.
- ⚠️ Plugin di-*vendor* menggunakan laluan **rata**: `vendor/reveal/dist/plugin/highlight.js` (BUKAN `plugin/highlight/highlight.js`). CSS highlight pula di `plugin/highlight/monokai.css`.
- Hidupkan: nombor slaid (`c/t`), bar kemajuan, gambaran keseluruhan (Esc), **nota penceramah** (`S`), mod cetak PDF (`?print-pdf`).
- Blok kod Dart dengan penyerlahan sintaks. Escape `<` `>` `&` dalam kod (cth. `List&lt;Programme&gt;`).
- **Nota penceramah** (`<aside class="notes">`) pada hampir setiap slaid teknikal.
- Responsif untuk projektor 16:9 (1280×720).

## Struktur deck
1. **Pembuka & Konsep** (~18–20): tajuk, jurulatih, hasil pembelajaran, **aturcara 9 sesi**, rentak harian, tech stack, **jadual Slot AI**, kenapa Flutter, Flutter vs lain, asas Dart (3–4), domain eTT & BPPT, universiti Mesir/Maghribi, entiti `Programme`, entiti `Application` + kitaran status LAYAK/TIDAK LAYAK, penafian.
2. **Hari 1 — SESI 1** (~22–26): operators; control flow (if/else, switch); looping (for/while) & function; widget asas Text/Icon/Image; Container/Padding/Margin/SizedBox; StatelessWidget vs StatefulWidget.
3. **Hari 2 — SESI 2–3** (~26–30): Row/Column/Expanded/Flexible; Stack/Positioned/Align/Center; Scaffold/AppBar; 🤖 Slot AI (mockup UI); BottomNavigationBar & Drawer; ListView/ListView.builder/GridView; Card & ListTile; TextStyle/ThemeData.
4. **Hari 3 — SESI 4–5** (~26–30): Navigator push/pop; named routes & stack; passing data; TextField/TextFormField; Input Controller; Button & GestureDetector; 🤖 Slot AI (form validation); **`setState()` & lifecycle**.
5. **Hari 4 — SESI 6–7** (~26–30): REST API backend vs frontend; HTTP methods & JSON; pakej `http` + kebenaran INTERNET; async/Future/await; fetch + fallback; 🤖 Slot AI (JSON→Dart model); submit POST; status codes; try-catch/CircularProgressIndicator/retry; RefreshIndicator; hos mock API.
6. **Hari 5 — SESI 8–9** (~24–28): projek mini brief + MVP + rubrik + time-box; 🤖 alatan AI untuk coding & debugging; troubleshooting; Clean Coding Principles; Refactoring (before→after); demo & sijil.
7. **Penutup** (~8–10): ringkasan 5 hari, prinsip AI, prompt template, langkah seterusnya (pasca-kursus), sumber, penafian, terima kasih.

**Jumlah ~150–170 slaid** — cukup untuk kira-kira separuh hari pembentangan setiap hari (baki masa = lab amali).

## Keperluan kualiti
- Satu idea satu slaid; ringkas tetapi banyak slaid. Elak slaid padat teks.
- Pelbagaikan susun atur: kad, dua lajur + kod, jadual, callout — bukan senarai bullet semata.
- Slaid kod: 5–18 baris penting sahaja, dipetik dari `projek/ett_mobile/lib/`.
- Setiap hari bermula dengan slaid pembahagi navy + **jadual sesi/waktu** dari `JADUAL.md`.

## Output tambahan
Kemas kini `slides/README.md` (cara buka, kawalan, eksport PDF, kandungan deck).

Mula dengan membaca `JADUAL.md` dan fail sumber, kemudian jana `slides/flutter-training.html` sepenuhnya (jangan tinggalkan "TODO").

=== TAMAT PROMPT ===

---

## Nota

Deck sedia ada dibina secara **modular** — lihat [`_build/`](./_build/): `_SPEC.md` (sistem reka bentuk & kelas CSS), `00-head.html`, `intro.html`, `day1..day5.html`, `closing.html`, `99-foot.html`. Gabung dengan `cat` (arahan penuh dalam [`README.md`](./README.md)). Ini biasanya lebih cepat daripada menjana semula dari kosong.
