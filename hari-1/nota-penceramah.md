# Nota Penceramah — Hari 1: Widget & Skrin Senarai

> Nota rujukan untuk **penceramah/jurulatih**. Setiap entri sepadan dengan satu slaid dalam [`../slides/flutter-training.html`](../slides/flutter-training.html). Nota ini asalnya *speaker notes* dalam deck — dikumpulkan di sini supaya bahan lengkap walaupun tanpa membuka slaid. Slaid tanpa nota penceramah tidak disenaraikan.

**Slaid 2 · Apa Akan Dibina Hari Ini**  
Tunjukkan matlamat akhir hari ini supaya peserta nampak destinasi sebelum bermula. Tekankan bahawa carian dan navigasi datang pada hari-hari seterusnya.

**Slaid 3 · Persediaan: 4 Komponen**  
Terangkan kenapa Android Studio masih diperlukan walaupun kita menulis kod dalam VS Code — ia membawa SDK dan emulator.

**Slaid 4 · Pasang Flutter SDK (Windows)**  
PATH hanya dimuat semula pada terminal baharu — ini punca paling biasa "flutter is not recognized". Minta semua peserta jalankan flutter --version sebelum teruskan.

**Slaid 5 · flutter doctor — Semakan Kesihatan**  
flutter doctor ialah kawan baik anda — ia beritahu apa yang tertinggal. Tanda amaran untuk peranti boleh diabaikan buat sementara; kita sediakan emulator selepas ini.

**Slaid 6 · VS Code + Sambungan Flutter/Dart**  
Extension Dart dipasang secara automatik bersama extension Flutter — peserta hanya perlu pasang satu.

**Slaid 7 · Emulator ATAU Telefon Sebenar — Pilih Satu**  
Untuk kelas, emulator lebih mudah dikawal. Telefon sebenar lebih pantas pada komputer berspesifikasi rendah.

**Slaid 8 · Cipta Projek Pertama**  
Larian pertama mengambil masa beberapa minit kerana Gradle memuat turun dependency — beri masa rehat pendek di sini.

**Slaid 9 · Anatomi Projek Flutter**  
Bandingkan dengan ekosistem yang peserta kenal — pubspec.yaml sepadan dengan package.json (Node) atau composer.json (Laravel).

**Slaid 10 · pubspec.yaml — Konfigurasi Projek**  
Ingatkan: YAML sensitif kepada indentasi — dua ruang, bukan tab.

**Slaid 11 · lib/main.dart — Versi Minimum**  
Ganti kandungan lalai dengan versi minimum ini supaya kita faham setiap baris dari kosong. Simpan dan lihat Hot Reload berlaku.

**Slaid 12 · Bedah main.dart**  
build() dipanggil semula setiap kali Flutter perlu melukis semula widget — konsep ini penting untuk memahami state nanti.

**Slaid 13 · Semuanya Adalah Widget**  
Struktur bersarang ini dipanggil widget tree. Lukiskan di papan putih sambil merujuk kod main.dart tadi.

**Slaid 14 · StatelessWidget vs StatefulWidget**  
Hari 1 hampir semua widget kita StatelessWidget — StatefulWidget mula digunakan Hari 2/3 apabila perlu simpan state seperti teks carian.

**Slaid 15 · Hot Reload — Kuasa Super Flutter**  
Demo secara langsung — ini momen "wow" pertama untuk pemula. Galakkan peserta bereksperimen dan Hot Reload dengan kerap sepanjang kursus.

**Slaid 16 · Widget Teras: Text & Container**  
Minta peserta tampal setiap contoh ke dalam body Scaffold dan lihat hasilnya dengan Hot Reload.

**Slaid 17 · Widget Teras: Column & Row**  
Column dan Row ialah asas semua susun atur — kad biasiswa kita nanti hanyalah gabungan Column dan Row bersarang.

**Slaid 18 · Widget Teras: Jarak & Bekas**  
SizedBox ialah cara paling ringan untuk jarak kosong. Card memberi bayang dan sudut bulat secara percuma — kita guna untuk setiap biasiswa nanti.

**Slaid 19 · Expanded — Elak "Overflow"**  
Ralat overflow ialah ralat pertama yang hampir semua pemula jumpa — tunjukkan jalur kuning-hitam secara sengaja, kemudian betulkan dengan Expanded.

**Slaid 20 · Tema Jenama KPT**  
Tema berpusat bermakna bila jenama berubah, kita hanya ubah satu fail — bukan setiap skrin.

**Slaid 21 · lib/theme.dart — KptTheme**  
ColorScheme.fromSeed ialah ciri Material 3 — beri satu warna benih, Flutter jana set warna harmoni lengkap secara automatik. useMaterial3 mengaktifkan gaya Google terkini.

**Slaid 22 · Model Data: Kenapa Class Scholarship?**  
Enum dengan getter label mengelakkan if/else berulang di setiap skrin — nilai enum dalam English, label paparan dalam Bahasa Melayu.

**Slaid 23 · lib/models/scholarship.dart**  
Fail sebenar ada 16 medan penuh serta fromJson/toJson untuk Hari 4 — hari ini fokus pada corak: final, required, const.

**Slaid 24 · Data Contoh: sampleScholarships**  
Kenapa final bukan const? DateTime.parse dikira pada runtime, jadi senarai tidak boleh const — tetapi final memastikan pembolehubah tidak boleh di-reassign.

**Slaid 25 · ListView.builder — Senarai Efisien**  
Ini versi Hari 1 yang ringkas — statik, tiada carian. Versi penuh dalam projek rujukan sudah ada carian dan tapisan yang kita bina Hari 3.

**Slaid 26 · ScholarshipCard — Kad Satu Biasiswa**  
Struktur penuh ialah Column berisi tiga Row — persis susun atur yang kita pelajari tadi. Buka fail penuh bersama peserta dan bedah baris demi baris.

**Slaid 27 · Corak Penting dalam ScholarshipCard**  
Corak pecahkan widget kecil seperti _Pill ialah amalan yang akan kita ulang sepanjang kursus — build() panjang sukar dibaca dan disenggara.

**Slaid 28 · Gabungkan Semuanya — main.dart Akhir**  
debugShowCheckedModeBanner buang lencana DEBUG merah — kosmetik sahaja. Skrin sebenar dalam projek rujukan sudah ada bar carian TextField dan ChoiceChip — itu untuk Hari 3.

**Slaid 29 · Ringkasan Hari 1 + Langkah Seterusnya**  
Pastikan flutter run setiap peserta masih berfungsi tanpa ralat sebelum tamat kelas. Galakkan tabiat git commit dari Hari 1.
