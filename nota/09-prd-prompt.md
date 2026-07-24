# Nota Rujukan: Prompt PRD — Merancang Aplikasi Sebelum Mengekod

Sebelum menulis satu baris kod pun, pembangun berpengalaman menulis **PRD** (*Product Requirements Document*) — dokumen ringkas yang menjawab **apa** yang hendak dibina, **untuk siapa**, dan **bila ia dianggap siap**. Dengan AI, PRD lebih penting lagi: prompt yang kabur menghasilkan kod yang kabur. Satu PRD yang jelas menjadi "arahan induk" yang boleh anda serahkan kepada Claude Code untuk memandu keseluruhan projek — sesuai digunakan untuk **projek mini Hari 5**.

Nota ini memberi anda **satu prompt lengkap** untuk menjana PRD, satu contoh yang telah diisi, dan cara menyambungnya menjadi kod.

---

## Kenapa PRD dahulu, bukan terus mengekod?

| Tanpa PRD | Dengan PRD |
|---|---|
| "Buatkan saya app" → AI meneka skop, hasil tak menentu | Skop jelas; AI membina apa yang anda **betul-betul** mahu |
| Ciri bertambah tanpa kawalan (*scope creep*) | Senarai ciri tetap + bahagian "Di Luar Skop" |
| Susah tahu bila projek "siap" | Ada **kriteria penerimaan** yang boleh disemak |
| Setiap prompt bermula dari kosong | Satu dokumen rujukan dikongsi untuk semua prompt |

Peraturan emas kekal sama seperti [nota 08](./08-prompt-claude-code.md): **AI membantu, anda memandu.** PRD ialah cara anda memandu.

---

## Prompt Lengkap — Jana PRD

Salin prompt ini ke Claude Code. Ganti bahagian dalam `< >` dengan idea projek anda; buang baris yang tidak berkenaan. Kalau sesuatu medan anda belum pasti, tulis `(belum pasti — cadangkan)` dan biarkan AI mencadangkan.

```text
Peranan: Anda ialah jurutera perisian mudah alih yang membantu saya menulis
PRD (Product Requirements Document) yang RINGKAS dan BOLEH DILAKSANAKAN untuk
sebuah aplikasi Flutter bersaiz projek mini (boleh disiapkan dalam 1–2 hari).

Konteks projek:
- Nama aplikasi        : <nama>
- Masalah yang diselesaikan : <1–2 ayat: masalah sebenar + siapa yang alami>
- Pengguna sasaran     : <cth: pelajar lepasan SPM, peniaga kecil, dsb.>
- Platform             : Flutter (Material 3), Dart

Kekangan teknikal (WAJIB dipatuhi):
- Pengurusan state : setState() + StatefulWidget sahaja (bukan provider/Bloc).
- Struktur folder  : lib/{models, data, services, widgets, screens}.
- Bahasa           : teks UI dalam Bahasa Melayu; nama pengecam (identifier)
                     kod dalam Bahasa Inggeris.
- Data             : mula dengan data contoh dalam aplikasi (hardcoded);
                     jika ada API, guna pakej http + JSON.
- Tema             : satu ThemeData berpusat (warna jenama, AppBar, Card).

Skop ciri (fungsi teras yang mesti ada):
1. <ciri 1 — cth: senarai item boleh ditatal>
2. <ciri 2 — cth: skrin butiran bila item ditekan>
3. <ciri 3 — cth: borang input dengan pengesahan (validation)>
4. <ciri 4 — cth: simpan/papar rekod yang dihantar pengguna>

Sila hasilkan PRD dengan STRUKTUR berikut, guna tajuk Markdown:

1. **Ringkasan** — 2–3 ayat: apa aplikasi ini & nilai utamanya.
2. **Pengguna & Keperluan** — 2–4 "user story" format:
   "Sebagai <pengguna>, saya mahu <tindakan> supaya <faedah>."
3. **Keperluan Fungsi** — senarai bernombor setiap ciri, cukup terperinci
   untuk dilaksanakan (input, tindakan, hasil di skrin).
4. **Skrin & Navigasi** — senaraikan setiap skrin, dan bagaimana pengguna
   bergerak antara skrin (cth: Senarai → Butiran → Borang).
5. **Model Data** — kelas Dart yang diperlukan, dengan medan + jenis
   (cth: `Item { String id; String name; double price; }`).
6. **Seni Bina** — pemetaan ringkas ke lib/{models,data,services,widgets,screens}.
7. **Di Luar Skop** — senaraikan dengan JELAS apa yang TIDAK dibina kali ini
   (elak scope creep). Cadangkan sekurang-kurangnya 3 perkara.
8. **Kriteria Penerimaan** — senarai semak boleh-tanda "Definition of Done":
   setiap satu mesti boleh diuji dengan mata (cth: "Menekan Hantar dengan
   medan kosong memaparkan mesej ralat merah, borang tidak tertutup").
9. **Susunan Pembinaan** — pecahkan kepada 4–6 langkah tersusun, setiap satu
   menghasilkan sesuatu yang boleh dijalankan (`flutter run`).

Peraturan penulisan:
- Ringkas dan konkrit. Elak istilah pemasaran.
- Jangan reka ciri yang saya tidak minta; jika anda cadangkan sesuatu,
  letak di bawah tajuk "Cadangan (pilihan)" yang berasingan.
- Jangan tulis kod lagi — hanya PRD. Kita bina selepas saya sahkan PRD.
- Akhiri dengan SATU soalan penjelasan sahaja jika ada ambiguiti penting.
```

---

## Contoh Terisi — eTT Mobile

Beginilah rupa bahagian atas prompt itu jika diisi dengan aplikasi kursus ini. Guna sebagai model untuk projek anda sendiri.

```text
Konteks projek:
- Nama aplikasi        : eTT Mobile
- Masalah yang diselesaikan : Pelajar lepasan SPM/STAM sukar meneliti &
  membanding tawaran pengajian di universiti Timur Tengah, dan menjejak
  status permohonan mereka di satu tempat.
- Pengguna sasaran     : Pelajar lepasan SPM & STAM yang memohon ke Mesir/Maghribi
- Platform             : Flutter (Material 3), Dart

Skop ciri (fungsi teras yang mesti ada):
1. Senarai tawaran pengajian (universiti, bidang, negara, anggaran kos).
2. Tapis senarai mengikut negara (Mesir / Maghribi).
3. Skrin butiran bila satu tawaran ditekan (kelayakan, kos, ambilan, kuota).
4. Borang permohonan dengan pengesahan (nama, No. KP 12 digit, emel, telefon)
   — peraturan sebenar: 1 negara + 1 bidang, sehingga 3 pilihan universiti.
5. Skrin "Permohonan Saya" memaparkan rekod yang telah dihantar + statusnya.
```

> **Fakta domain mesti tepat:** universiti Mesir sebenar (Al-Azhar, Alexandria,
> Ain Shams, Mansoura, Tanta); Maghribi hanya Universiti Al Quaraouiyine (Fes)
> yang disahkan. Status guna istilah **LAYAK / TIDAK LAYAK**. Kos & kuota adalah
> **ilustrasi** kecuali kuota Maghribi (15 tempat). Jangan reka nama, logo,
> atau statistik. (Beritahu AI perkara ini supaya ia tidak berhalusinasi.)

---

## Daripada PRD kepada Kod

Selepas AI hasilkan PRD dan anda semak/betulkan, sambung dengan prompt susulan **satu langkah pada satu masa** (jangan minta semua sekali gus):

```text
1) "Setuju dengan PRD ini. Mulakan dengan Langkah 1 dalam 'Susunan Pembinaan':
    jana kelas model + data contoh sahaja. Jangan sentuh skrin dahulu."

2) "flutter analyze bersih. Teruskan Langkah 2: skrin senarai (ListView.builder)
    yang memaparkan data contoh itu."

3) "... dan seterusnya, satu langkah satu masa, dengan flutter analyze +
    Hot Reload selepas setiap langkah."
```

Corak ini memastikan setiap bahagian **boleh diuji** sebelum anda teruskan — sama seperti setiap Latihan dalam lab harian.

---

## Senarai Semak PRD yang Baik

Sebelum mula membina, pastikan PRD anda:

- [ ] Ada **skop yang tertutup** — bahagian "Di Luar Skop" tidak kosong.
- [ ] Setiap ciri ada **hasil yang boleh dilihat** (bukan "sistem yang bagus").
- [ ] **Model data** ditakrif sebelum skrin (skrin bergantung padanya).
- [ ] **Kriteria penerimaan** boleh disemak dengan mata, bukan pendapat.
- [ ] **Susunan pembinaan** bermula dengan sesuatu yang boleh `flutter run`.
- [ ] Kekangan kursus dinyatakan: `setState()`, BM untuk UI, English untuk kod.

---

Kembali ke [README utama](../README.md) atau lihat [nota 08 — Contoh Prompt Claude Code](./08-prompt-claude-code.md).

---
