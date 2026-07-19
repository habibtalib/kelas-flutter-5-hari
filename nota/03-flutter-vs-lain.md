# Nota Konsep: Flutter vs Rangka Kerja Lain

> Perbandingan Flutter dengan pilihan pembangunan mobil lain, supaya anda faham **kelebihan & had** setiap pendekatan.

---

## Peta pilihan pembangunan mobil

```
Aplikasi Mobil
├── Asli (Native)
│   ├── Android  → Kotlin / Java  (Android Studio)
│   └── iOS      → Swift / Obj-C  (Xcode)
├── Merentas platform (Cross-platform)
│   ├── Flutter        → Dart      (dilukis sendiri)
│   ├── React Native   → JS/TS     (komponen asli)
│   ├── .NET MAUI      → C#
│   └── Kotlin Multiplatform → Kotlin
└── Hibrid / Web
    ├── Ionic / Capacitor → HTML/CSS/JS (webview)
    └── PWA (Progressive Web App)
```

---

## Jadual perbandingan penuh

| Kriteria | **Flutter** | React Native | Native (Kotlin/Swift) | Ionic (Webview) |
|----------|-------------|--------------|-----------------------|-----------------|
| **Bahasa** | Dart | JavaScript/TS | Kotlin / Swift | HTML/CSS/JS |
| **Pangkalan kod** | Satu | Satu | Dua | Satu |
| **Cara render UI** | Lukis piksel sendiri (Impeller/Skia) | Jambatan ke komponen asli | Komponen asli tulen | Webview (pelayar) |
| **Prestasi** | ⭐⭐⭐⭐ Sangat baik (AOT) | ⭐⭐⭐ Baik | ⭐⭐⭐⭐⭐ Terbaik | ⭐⭐ Sederhana |
| **Konsistensi UI** | ⭐⭐⭐⭐⭐ Sama semua peranti | ⭐⭐⭐ Ikut platform | ⭐⭐⭐ Ikut platform | ⭐⭐⭐⭐ |
| **Hot Reload** | ✅ Pantas | ✅ Ya | ⚠️ Terhad | ✅ |
| **Saiz aplikasi** | Sederhana-besar | Sederhana | Kecil | Kecil |
| **Akses ciri peranti** | Pakej + plugin | Pakej + bridge | Penuh & segera | Terhad (plugin) |
| **Keluk pembelajaran** | Sederhana | Rendah (jika tahu JS) | Tinggi (2 platform) | Rendah |
| **Sesuai bila** | UI berjenama, MVP pantas, satu pasukan | Pasukan web/JS sedia ada | Perlu kawalan penuh 1 platform | Aplikasi ringkas jenis kandungan |

---

## Kenapa kursus ini pilih Flutter?

1. **Satu bahasa, satu kod** — pelajar hanya perlu belajar **Dart**, bukan dua bahasa native.
2. **Hot Reload** — maklum balas segera menjadikan pembelajaran jauh lebih seronok & pantas.
3. **Widget kaya & konsisten** — mudah bina UI cantik tanpa perlu pakar reka bentuk.
4. **Peluang kerjaya** — permintaan tinggi di Malaysia & global untuk pembangun Flutter.
5. **Boleh kembang** — kemahiran sama boleh terbit ke web & desktop kemudian.

---

## Nota untuk pembangun web (JavaScript/React)

Jika anda datang dari latar web, konsep ini "berpindah" dengan mudah:

| Konsep Web/React | Padanan Flutter |
|------------------|-----------------|
| Komponen (Component) | **Widget** |
| JSX | Pokok widget (widget tree) dalam Dart |
| `useState` | `setState()` / provider / Riverpod |
| props | parameter constructor widget |
| `npm` / `package.json` | `pub` / `pubspec.yaml` |
| `fetch()` | pakej `http` |
| CSS | properti widget (`padding`, `color`, `TextStyle`) |

---

## Nota untuk pembangun mobil asli (Kotlin/Swift)

- Flutter **tidak** guna komponen asli — ia melukis UI sendiri. Jadi butang Material kelihatan sama di iOS & Android (kecuali anda guna widget Cupertino).
- Untuk ciri peranti khusus (Bluetooth, sensor, dll), Flutter guna **platform channels** atau pakej sedia ada dari pub.dev.
- Anda masih boleh tulis kod asli (Kotlin/Swift) dan sambung ke Flutter bila perlu.

---

Seterusnya: [`04-setup-windows.md`](./04-setup-windows.md) untuk memasang Flutter pada Windows.
