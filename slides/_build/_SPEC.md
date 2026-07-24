# Slide-authoring spec (reveal.js) — READ CAREFULLY

You are generating slide `<section>` blocks for a reveal.js deck: **"Kelas Flutter 5 Hari — eTT Mobile"** (KPT coaching course: mobile app for Sistem Pendidikan Tinggi Luar Negara, domain e-Timur Tengah).

## Output rules
- Output **ONLY** a sequence of `<section>…</section>` blocks. NO `<html>`, `<head>`, `<body>`, `<style>`, no `<div class="reveal">`, no `<div class="slides">`. Those already exist in the shell — you write only the slides that go between them.
- The CSS design system is ALREADY defined in the shell. Use ONLY the classes documented below. Do not invent new classes or add inline `style=` (except `data-background-color` on chapter/title slides).
- **Language:** slide prose in **Bahasa Melayu**; all code, identifiers, class names, technical terms (widget, provider, Future, StatelessWidget) in **English**.
- **Brand:** Kementerian Pendidikan Tinggi (KPT). Navy `#1A2B5C` + gold `#D4A017`. Do NOT invent a tagline.
- Every content slide should be **brief** (one idea per slide — short bullets, not paragraphs) but you should produce **MANY** slides (this deck must cover ~half a day of teaching per day, so be generous with slide count and depth of coverage).
- Add a `<aside class="notes">…</aside>` (Bahasa Melayu speaker notes, 1–3 sentences) to most content slides — this is what the trainer says aloud.
- Keep each code block short (5–18 lines). Use `<pre><code class="language-dart" data-trim data-line-numbers>` for Dart, `language-bash` for shell, `language-xml`/`language-yaml`/`language-json` as needed. Escape `<` as `&lt;` and `>` as `&gt;` and `&` as `&amp;` INSIDE code blocks (e.g. `List&lt;Programme&gt;`).
- Pull code from the REAL app at `/Users/habib/Git/kelas-flutter-5-hari/projek/ett_mobile/lib/` — read the files and keep identifiers/theme consistent. Show only the important lines, not whole files.

## Slide vocabulary (allowed classes)

### 1. Chapter divider (use ONE at the very start of a day)
```html
<section class="chapter" data-background-color="#1A2B5C">
  <span class="kicker">Hari 1</span>
  <h2>Aliran Kawalan Dart &amp; Widget Asas</h2>
  <p class="sub">Operators, control flow, looping, function &amp; widget asas</p>
  <ul class="agenda">
    <li>Persediaan &amp; anatomi projek</li>
    <li>Widget teras &amp; tema KPT</li>
    <li>Model data &amp; ListView</li>
  </ul>
</section>
```

### 2. Standard content slide
```html
<section>
  <h3>Tajuk Slaid</h3>
  <ul>
    <li>Poin ringkas satu</li>
    <li>Poin ringkas dua</li>
  </ul>
  <aside class="notes">Apa jurulatih patut jelaskan di sini.</aside>
</section>
```

### 3. Lead statement
`<p class="lead">Satu ayat besar yang penting.</p>`  ·  small text: `<p class="small muted">…</p>`

### 4. Two columns / three columns
```html
<div class="two-col">
  <div> …kiri… </div>
  <div> …kanan (cth. <pre><code class="language-dart" ...>…</code></pre>)… </div>
</div>
```
Also: `<div class="two-col wide-left">`, `<div class="three-col">`.

### 5. Card grid
```html
<div class="cards">           <!-- 2 columns; use class="cards c3" for 3 -->
  <div class="card"><h4>Tajuk</h4><p>Teks.</p></div>
  <div class="card accent"><h4>…</h4><p>…</p></div>   <!-- gold left border -->
  <div class="card navy"><h4>…</h4><p>…</p></div>     <!-- navy filled -->
</div>
```

### 6. Pills (tags): `<span class="pill">navy</span> <span class="pill gold">gold</span> <span class="pill green">ok</span> <span class="pill red">amaran</span>`

### 7. Callout note:
`<div class="note">💡 Petua…</div>` · `<div class="note gold">…</div>` · `<div class="note warn">⚠️ …</div>` · `<div class="note tip">✅ …</div>`

### 8. Tables: plain `<table>…</table>` (use `<table class="tight">` for dense tables).

### 9. Numbered steps: `<ul class="steps"><li>Langkah…</li><li>Langkah…</li></ul>`

### 10. Corner brand tag (optional, on a slide): `<div class="slide-tag">eTT Mobile</div>`

## Quality bar
- Vary layouts (don't make every slide a bullet list — mix cards, two-col code, tables, notes).
- Prefer real, concrete content over filler. Each day should thoroughly cover its topics.
- Ensure all tags are properly closed and HTML is valid.
