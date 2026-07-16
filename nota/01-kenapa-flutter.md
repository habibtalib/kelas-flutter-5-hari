# Nota Konsep: Kenapa Flutter?

> Nota latar belakang — baca **sebelum** mula coding pada Hari 1. Fahami **kenapa** kita pilih Flutter sebelum belajar **bagaimana** menggunakannya.

---

## Apa itu Flutter?

**Flutter** ialah *toolkit* sumber terbuka daripada **Google** untuk membina aplikasi **merentas platform (cross-platform)** daripada **satu pangkalan kod (single codebase)**. Satu kod Dart yang sama boleh dijalankan pada:

- 📱 **Android** & **iOS** (mobil)
- 🖥️ **Windows**, **macOS**, **Linux** (desktop)
- 🌐 **Web** (pelayar)

Ditulis dalam bahasa **Dart** (juga dari Google). Flutter melukis setiap piksel antara muka sendiri menggunakan enjin grafik **Impeller/Skia**, jadi aplikasi kelihatan **sama** pada semua peranti.

---

## Kenapa Flutter (bukan yang lain)?

| Sebab | Penjelasan |
|-------|-----------|
| **Satu kod, banyak platform** | Tulis sekali, terbit ke Android + iOS (+ web/desktop). Jimat masa & kos berbanding bina 2 aplikasi berasingan. |
| **Hot Reload** | Ubah kod → tekan simpan → lihat perubahan pada emulator dalam **< 1 saat**, tanpa hilang keadaan (state) aplikasi. Kitaran belajar sangat pantas. |
| **Prestasi hampir asli (native)** | Kod Dart dikompil ke kod mesin ARM/x64 sebenar (AOT) untuk keluaran — bukan "webview" atau *bridge* yang perlahan. |
| **Widget yang kaya** | Ratusan widget siap sedia (Material Design & Cupertino/iOS) — butang, borang, senarai, navigasi, animasi. |
| **Komuniti & pakej besar** | [pub.dev](https://pub.dev) ada puluhan ribu pakej percuma (HTTP, pangkalan data, peta, kamera, dll). |
| **Disokong Google** | Digunakan dalam produk Google sendiri (Google Pay, Google Ads, Earth) dan berterusan dibangunkan. |

---

## Bila **sesuai** guna Flutter

- ✅ Anda perlu aplikasi **Android + iOS** tetapi ada masa/bajet terhad — satu pasukan, satu kod.
- ✅ Aplikasi dengan **UI tersuai / berjenama** yang perlu kelihatan sama merentas peranti.
- ✅ **MVP / prototaip pantas** — dari idea ke aplikasi berjalan dengan cepat.
- ✅ Aplikasi CRUD biasa: senarai, borang, papar butiran, sambung ke API (macam projek kursus ini).

## Bila **kurang sesuai**

- ⚠️ Aplikasi yang **sangat bergantung pada ciri platform khusus** yang belum ada pakej (jarang berlaku hari ini).
- ⚠️ Saiz fail aplikasi lebih besar sedikit berbanding aplikasi asli tulen (kerana enjin Flutter dibundel).
- ⚠️ Jika pasukan anda **sudah** pakar Kotlin/Swift dan hanya sasar **satu** platform sahaja.

---

## Flutter vs pilihan lain (ringkas)

| Ciri | **Flutter** | React Native | Android/iOS Asli (Native) |
|------|-------------|--------------|---------------------------|
| Bahasa | Dart | JavaScript/TS | Kotlin / Swift |
| Kod | Satu | Satu | Dua (berasingan) |
| UI | Dilukis sendiri (konsisten) | Komponen asli | Asli penuh |
| Prestasi | Sangat baik (AOT) | Baik (bridge JS) | Terbaik |
| Hot Reload | ✅ Ya | ✅ Ya | Terhad (Compose/SwiftUI) |
| Sesuai untuk | Merentas platform pantas | Pasukan JS/web | Satu platform, kawalan penuh |

> Perbandingan lebih lanjut: lihat [`03-flutter-vs-lain.md`](./03-flutter-vs-lain.md).

---

## Siapa guna Flutter? (contoh sebenar)

Aplikasi komersial yang dibina/menggunakan Flutter:

- **Google Pay** — aplikasi pembayaran Google
- **BMW** — aplikasi *My BMW*
- **Alibaba** — aplikasi e-dagang
- **eBay Motors**
- **Nubank** — bank digital terbesar Amerika Latin
- **ByteDance / TikTok** — beberapa aplikasi dalaman

Ini membuktikan Flutter bukan sekadar untuk projek kecil — ia digunakan pada skala jutaan pengguna.

---

## Kaitan dengan projek kursus

Sepanjang 5 hari, kita akan bina **satu aplikasi mobil sebenar** untuk domain **Kementerian Pengajian Tinggi (KPT)** menggunakan Flutter — bermula dari widget asas sehingga aplikasi lengkap yang menyambung ke API dan boleh dibina (`build`) sebagai fail APK Android.

Seterusnya: [`02-dart-asas.md`](./02-dart-asas.md) — asas bahasa Dart yang perlu anda tahu sebelum menulis widget pertama.
