# Audit Liputan: Slaid vs Nota Bertulis (domain eTT)

Audit ini menyemak sama ada **setiap perkara pengajaran dalam slaid** ([`flutter-training.html`](./flutter-training.html), 190 slaid) juga wujud dalam **nota bertulis** (`hari-N/README.md` + `hari-N/snippets/`, dan `README.md`/`JADUAL.md`/`nota/*` untuk pembuka & penutup), serta menjalankan **semakan ketepatan fakta** dan **semakan kebocoran butiran sistem dalaman**.

**Kaedah:** 6 ejen audit selari (Hari 1–5 + Pembuka/Penutup). Setiap satu menyenaraikan perkara pengajaran slaid (termasuk *speaker notes*) dan menyemaknya terhadap nota bertulis **bebas**. Nota penceramah (`hari-N/nota-penceramah.md`) **tidak** digunakan sebagai sumber semakan (ia diekstrak *daripada* slaid — pusingan).

**Dijalankan terhadap:** bahan domain **eTT — e-Timur Tengah** (permohonan ke universiti Mesir & Maghribi).

---

## Keputusan Ringkas

| Bahagian | Slaid | Jurang | Ketepatan | Kebocoran |
|----------|-------|--------|-----------|-----------|
| Pembuka & Penutup | 28 | 9 (7 kecil, 2 penting) | 2 penting → ✅ dibaiki | ✅ tiada |
| Hari 1 · SESI 1 | 26 | 4 (2 penting, 2 kecil) | 1 → ✅ disahkan/didokumen | ✅ tiada |
| Hari 2 · SESI 2–3 | 31 | 1 kecil | ✅ tiada | ✅ tiada |
| Hari 3 · SESI 4–5 | 36 | 1 kecil | ✅ tiada | ✅ tiada |
| Hari 4 · SESI 6–7 | 38 | 0 | 1 → ✅ didokumen | ✅ tiada |
| Hari 5 · SESI 8–9 | 31 | 3 (1 penting, 2 kecil) | 1 → ✅ dibaiki | ✅ tiada |
| **Jumlah** | **190** | **18 jurang** | **semua diselesaikan** | **✅ tiada kebocoran** |

> **Rumusan:** Liputan **tinggi** — nota bertulis pada umumnya superset kepada slaid. **TIADA kebocoran butiran sistem dalaman** (fail PHP, jadual DB, aliran back-office, rayuan) dalam mana-mana slaid — kekal hanya dalam `.local/` (gitignored). Semua item aturcara rasmi (4 Slot AI, `setState()` lifecycle) tersedia dalam nota bertulis.

---

## Isu Ketepatan (2 penting) — telah dibaiki

### 1. URL semakan pengiktirafan tidak disahkan
Slaid penutup + `hari-4`/`hari-5` + data aplikasi menyebut `app.mohe.gov.my/iktiraf` (URL tidak disahkan) untuk semakan pengiktirafan.
→ **Dibaiki:** ditukar kepada portal **disahkan** **eSisraf (MQA)** `www2.mqa.gov.my/esisraf` di **15 tempat** (data app, JSON, skrin, slaid, README) — aplikasi disahkan semula bersih.

### 2. Fakta domain tanpa sumber tertulis
Slaid pembuka menyatakan tarikh penubuhan (Al-Azhar ~970M; Al Quaraouiyine 859M "universiti tertua di dunia") dan bidang terhad tanpa didokumen dalam nota.
→ **Dibaiki:** ditambah bahagian **"Fakta Domain eTT (disahkan)"** dalam [`README.md`](../README.md) — jadual universiti (bandar/tarikh/bidang), bidang terhad, LAYAK/TIDAK LAYAK, portal Mesir+Maghribi, eSisraf, kuota Maghribi 15 + **sumber** (Syarat_Mesir, Panduan Morocco, JPT/TCER).

---

## Jurang Penting (5) — telah ditutup

| Bahagian | Perkara slaid sahaja | Penyelesaian |
|----------|----------------------|--------------|
| Hari 1 | Istilah **LAYAK / TIDAK LAYAK** (disahkan sebenar) | `hari-1/README.md` → Nota Tambahan |
| Hari 1 | Peraturan **sehingga 3 pilihan universiti** (dalam 1 negara + 1 bidang) | `hari-1/README.md` → Nota Tambahan |
| Hari 5 | **Bidang terhad** (Perubatan/Pergigian/Farmasi/Pengajian Islam) sebagai peraturan | `hari-5/README.md` → Nota Tambahan + `README.md` |
| Pembuka | Senarai **bidang terhad** & jadual universiti (bandar/tarikh) | `README.md` → Fakta Domain eTT |
| Pembuka | Laluan portal **Maghribi** (`/morocco`) | `README.md` → Fakta Domain eTT |

## Jurang Kecil (13)

Ditutup di mana bernilai (cth. `createState()` → `hari-3`; nama universiti contoh → `hari-5`; pratonton `intl` → `hari-1`). Baki jurang kecil ialah **variasi contoh/petikan** (cth. senarai syarikat Google Classroom/Toyota tambahan pada slaid "Kenapa Flutter", kadar tukaran ilustrasi 4.6, `Supabase`/`FCM` dalam kad "langkah seterusnya", `dart.dev/effective-dart` sebagai pautan khusus) — contoh sah pada slaid yang tidak memerlukan salinan verbatim dalam prosa. Tiada satu pun menghalang pembelajaran atau menyalahi fakta.

---

## Kebocoran Butiran Sistem Dalaman — TIADA ✅

Kesemua 6 ejen menyemak khusus untuk nama fail PHP, jadual/view DB, aliran back-office, dan pengendalian rayuan (**Wahyu**). **Tiada satu pun** ditemui dalam mana-mana slaid, README, lab, atau nota. Butiran ini kekal **hanya** dalam `.local/USE-CASE-eTT-INTERNAL.md` (gitignored, tidak akan di-push).

---

## Nota penceramah

**178 nota penceramah** disimpan penuh dalam `hari-N/nota-penceramah.md` + [`nota-penceramah.md`](./nota-penceramah.md) untuk rujukan jurulatih (diekstrak daripada deck; bukan sumber audit).
