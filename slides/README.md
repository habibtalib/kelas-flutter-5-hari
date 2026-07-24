# Slaid Kursus Flutter 5 Hari — eTT Mobile

## ▶️ Deck sedia guna: [`flutter-training.html`](./flutter-training.html)

Buka fail ini terus dalam pelayar (Chrome/Edge/Safari) — **tiada pelayan diperlukan**:

```text
slides/flutter-training.html
```

Deck **reveal.js** ini mengandungi **190 slaid** yang mengikut [aturcara rasmi](../JADUAL.md) (9 sesi, 20–24 Julai 2026), kira-kira **separuh hari pembentangan setiap hari** (baki masa = lab amali):

| Bahagian | Slaid | Kandungan |
|----------|-------|-----------|
| Pembuka & Konsep | 19 | Gambaran, aturcara 9 sesi, jadual Slot AI, kenapa Flutter, asas Dart, domain eTT (Mesir/Maghribi), entiti |
| **Hari 1** · SESI 1 | 26 | Operators, control flow, looping & function; Text/Icon/Image; Container/Padding/Margin/SizedBox; Stateless vs Stateful |
| **Hari 2** · SESI 2–3 | 31 | Row/Column/Expanded/Flexible, Stack/Positioned; Scaffold/AppBar; 🤖 Slot AI (mockup UI); BottomNav & Drawer; ListView/GridView; Card/ListTile; ThemeData |
| **Hari 3** · SESI 4–5 | 36 | Navigator push/pop; named routes; passing data; TextField/TextFormField; Input Controller; Button/GestureDetector; 🤖 Slot AI (validation); **`setState()` & lifecycle** |
| **Hari 4** · SESI 6–7 | 38 | REST API; HTTP methods & JSON; `http`; async/await; fetch + fallback; 🤖 Slot AI (JSON→model); POST; status codes; try-catch/loading/retry |
| **Hari 5** · SESI 8–9 | 31 | Projek mini (hackathon); 🤖 alatan AI untuk coding & debugging; troubleshooting; Clean Coding; Refactoring; demo & sijil |
| Penutup | 9 | Ringkasan 5 hari, prinsip AI, langkah seterusnya, sumber, penafian |

Pustaka reveal.js di-*vendor* secara tempatan di `vendor/reveal/` (berfungsi dari `file://`). Slaid ringkas (satu idea satu slaid) dengan **nota penceramah** pada hampir setiap slaid (tekan `S`) — **178 nota**.

## 📊 Versi PowerPoint — [`flutter-training.pptx`](./flutter-training.pptx)

Tersedia juga versi **`.pptx` yang boleh disunting** (190 slaid, 16:9, **178 nota penceramah** dibawa masuk ke pane *Notes*):

- **PowerPoint / Keynote:** buka terus fail `flutter-training.pptx`.
- **Google Slides:** **File → Import slides** → muat naik fail tersebut.

> **Nota:** Dalam versi `.pptx`, blok kod dipaparkan sebagai teks *monospace* pada latar gelap **tanpa penyerlahan warna sintaks** (reveal.js menggunakan highlight.js yang tiada padanan dalam PowerPoint). Untuk kekalkan penyerlahan semasa sesi teknikal, **deck reveal.js (`.html`) kekal sumber utama**; guna `.pptx` bila perlu edit/kongsi dalam PowerPoint.

### Menjana semula `.pptx`

Dijana daripada `flutter-training.html` menggunakan [`build-pptx.py`](./build-pptx.py):

```bash
python3 -m venv venv
./venv/bin/pip install python-pptx beautifulsoup4 lxml
./venv/bin/python slides/build-pptx.py    # tulis semula slides/flutter-training.pptx
```

Skrip memetakan sistem reka bentuk deck (lihat [`_build/_SPEC.md`](./_build/_SPEC.md)) kepada bentuk PowerPoint: slaid pembahagi navy, kad, cip (*pill*), kotak nota berwarna, jadual, dan blok kod — mengekalkan tema navy/emas KPT. **Jana semula setiap kali deck HTML berubah.**

### 🎤 Nota penceramah (versi teks)

Semua nota penceramah turut disalin ke markdown supaya bahan lengkap walaupun tanpa membuka slaid:

- Setiap hari: [`../hari-1/nota-penceramah.md`](../hari-1/nota-penceramah.md) … [`../hari-5/nota-penceramah.md`](../hari-5/nota-penceramah.md)
- Pembuka & Penutup: [`nota-penceramah.md`](./nota-penceramah.md)

## Kawalan

- Anak panah kanan / bawah / Space: slaid seterusnya
- Anak panah kiri / atas: slaid sebelumnya
- **Esc**: gambaran keseluruhan slaid
- **S**: nota penceramah (speaker notes)
- Ctrl/Cmd + F: carian · Alt + klik: zum

## Eksport ke PDF

```text
slides/flutter-training.html?print-pdf
```

Kemudian guna dialog cetak pelayar → "Save as PDF".

## 🔁 Menjana semula / mengemas kini

Deck dibina secara **modular** daripada [`_build/`](./_build/):

```bash
cd slides
cat _build/00-head.html _build/intro.html _build/day1.html _build/day2.html \
    _build/day3.html _build/day4.html _build/day5.html _build/closing.html \
    _build/99-foot.html > flutter-training.html
```

| Fail | Peranan |
|------|---------|
| `_build/_SPEC.md` | Sistem reka bentuk — kelas CSS yang dibenarkan & contoh slaid |
| `_build/00-head.html` | `<head>`, CSS, pembuka `<div class="slides">` |
| `_build/intro.html` … `closing.html` | Blok `<section>` setiap bahagian |
| `_build/99-foot.html` | Penutup + `Reveal.initialize` + skrip plugin |

> ⚠️ **Perangkap:** plugin reveal.js yang di-*vendor* menggunakan laluan **rata** — `vendor/reveal/dist/plugin/highlight.js`, **bukan** `plugin/highlight/highlight.js`. Laluan salah = deck kosong (`RevealHighlight is not defined`). CSS highlight pula di `plugin/highlight/monokai.css`.

Selepas mengubah slaid, jana semula nota penceramah dan semak [`COVERAGE-AUDIT.md`](./COVERAGE-AUDIT.md).

Untuk menjana **dari kosong** (atau ubah gaya menyeluruh), guna prompt penuh dalam [`PROMPT.md`](./PROMPT.md).

## Identiti visual

- Navy `#1A2B5C` (utama) + Emas `#D4A017` (aksen).
- ⚠️ Ini **pilihan reka bentuk**, **bukan palet rasmi KPT** — KPT tidak menerbitkan garis panduan jenama awam. Jangan dakwa ia rasmi, dan **jangan cipta tagline**.
- Teks Bahasa Melayu; kod & istilah teknikal Bahasa Inggeris.
