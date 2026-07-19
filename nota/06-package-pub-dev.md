# Nota Konsep: Pakej & pub.dev

> Anda tidak perlu tulis semuanya dari kosong. **[pub.dev](https://pub.dev)** ialah repositori rasmi pakej Dart & Flutter — puluhan ribu pakej percuma.

---

## Apa itu pakej (package)?

Kod boleh guna semula yang ditulis orang lain (atau pasukan Flutter) — cth. untuk buat panggilan HTTP, simpan data, akses kamera. Sama seperti `npm` (Node.js) atau `pip` (Python).

---

## `pubspec.yaml` — fail konfigurasi pakej

Setiap projek Flutter ada fail `pubspec.yaml` yang menyenaraikan dependency:

```yaml
dependencies:
  flutter:
    sdk: flutter
  provider: ^6.1.2            # state management
  shared_preferences: ^2.3.2 # simpanan tempatan
  http: ^1.2.2               # panggilan REST API
  intl: ^0.19.0             # format tarikh & nombor (RM)
```

**Makna simbol versi:**

| Tulisan | Maksud |
|---------|--------|
| `^6.1.2` | Terima 6.1.2 sehingga (tapi bukan) 7.0.0 — kemas kini selamat |
| `6.1.2` | Versi tepat 6.1.2 sahaja |
| `any` | Mana-mana versi (elakkan) |

---

## Arahan `pub` penting

```bash
flutter pub add http              # tambah pakej (auto-kemas pubspec.yaml)
flutter pub get                   # muat turun pakej dalam pubspec.yaml
flutter pub upgrade               # naik taraf ke versi terkini yang dibenarkan
flutter pub outdated              # senarai pakej yang ada versi lebih baharu
flutter pub remove http           # buang pakej
```

> Selepas edit `pubspec.yaml` secara manual, jalankan `flutter pub get`.

---

## Cara menilai pakej sebelum guna

Di halaman pub.dev, semak:

- 👍 **Likes** & **Pub Points** (skor kualiti /160) & **Popularity**.
- 🏅 Lencana **"Flutter Favorite"** — disyorkan pasukan Flutter.
- 📅 **Tarikh kemas kini terakhir** — elak pakej yang terbengkalai.
- ✅ **Platform disokong** (Android/iOS/web/desktop).
- 📄 **Null safety** & **dokumentasi/contoh** yang jelas.
- ⚖️ **Lesen** (MIT, BSD, Apache biasanya selamat).

---

## Pakej berguna yang biasa digunakan

| Keperluan | Pakej |
|-----------|-------|
| Panggil REST API | `http`, `dio` |
| State management | `provider`, `flutter_riverpod`, `flutter_bloc` |
| Simpanan ringan | `shared_preferences` |
| Pangkalan data tempatan | `sqflite`, `hive`, `isar`, `drift` |
| Format tarikh/nombor | `intl` |
| Navigasi (routing) | `go_router` |
| Ikon & imej | `cached_network_image`, `font_awesome_flutter` |
| Borang | (built-in `Form`) |
| Firebase | `firebase_core`, `cloud_firestore`, `firebase_auth` |
| Muat turun & buka fail | `url_launcher`, `path_provider` |
| Persekitaran/keselamatan | `flutter_dotenv`, `flutter_secure_storage` |

---

## Pakej dalam projek eTT Mobile

| Pakej | Kegunaan | Hari |
|-------|----------|------|
| `http` | Ambil senarai program dari REST API + hantar permohonan | Hari 4 (SESI 6–7) |
| `intl` | Papar RM & tarikh dalam format Malaysia | Hari 2–5 |
| `provider` | State dikongsi antara skrin (guna dalam aplikasi rujukan) | [`05-state-management.md`](./05-state-management.md) |
| `shared_preferences` | Simpan pendaftaran supaya kekal | [`05-state-management.md`](./05-state-management.md) |

> Pengurusan state asas kursus ini guna **`setState()`** (SESI 5) — tiada pakej diperlukan, ia terbina dalam Flutter. `provider`/`shared_preferences` di atas ialah langkah seterusnya apabila state perlu dikongsi atau kekal merentasi skrin.

---

Seterusnya: [`07-deployment.md`](./07-deployment.md) — cara bina & terbitkan aplikasi.
