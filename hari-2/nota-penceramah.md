# Nota Penceramah — Hari 2: Layout, Senarai Dinamik & Styling (SESI 2-3)

> Nota rujukan untuk **penceramah/jurulatih**. Setiap entri sepadan dengan satu slaid dalam [`../slides/flutter-training.html`](../slides/flutter-training.html). Nota ini asalnya *speaker notes* dalam deck — dikumpulkan di sini supaya bahan lengkap walaupun tanpa membuka slaid. Slaid tanpa nota penceramah tidak disenaraikan.

**Slaid 2 · Jadual Sesi Hari Ini**  
Dua sesi rasmi hari ini. Pagi fokus susun atur; petang fokus senarai data dan penggayaan konsisten. Semua contoh guna data 8 program eTT dari semalam.

**Slaid 3 · Imbas Kembali & Skop Hari Ini**  
Kekalkan momentum: hari ini kad statik semalam berkembang jadi senarai skrol 8 program dengan tema navy/gold konsisten.

**Slaid 4 · Row & Column — Susun Atur Asas**  
Setiap skrin Flutter dibina dengan menyusun widget kecil jadi widget besar. Row dan Column ialah dua alat susun atur paling asas — hampir setiap skrin guna kedua-duanya.

**Slaid 5 · MainAxisAlignment vs CrossAxisAlignment**  
Konsep dua paksi ialah kunci memahami Row/Column. Lukis di papan putih: Row paksi utama mendatar, Column paksi utama menegak — paksi silang sentiasa yang satu lagi.

**Slaid 6 · Kod Sebenar: Header ProgrammeCard**  
Corak biasa: Row untuk bahagian besar mendatar, Column bersarang di dalam untuk susun menegak universiti, bidang dan lokasi. crossAxisAlignment.start menjajarkan semua ke atas.

**Slaid 7 · Ralat Klasik: RenderFlex overflowed**  
Demokan ralat ini secara sengaja — nama universiti Maghribi yang panjang sesuai untuk mencetuskannya. Peserta akan jumpa jalur kuning-hitam ini banyak kali; penting mereka kenal dan tahu puncanya.

**Slaid 8 · Penyelesaian: Expanded**  
Corak sama dalam ProgrammeCard sebenar: tanpa Expanded, Column maklumat program menolak lajur kos RM keluar dari skrin. Dengan Expanded, ia mengisi ruang yang tinggal sahaja.

**Slaid 9 · Layout Leceh? Minta AI**  
Tunjuk secara langsung jika sempat: taip prompt ini, baca kod yang dijana bersama kelas, dan bandingkan dengan widgets/programme_card.dart sebenar. Prompt spesifik — nama widget, medan model, rujukan tema — memberi hasil jauh lebih baik daripada "buatkan saya kad cantik".

**Slaid 10 · Expanded vs Flexible**  
Jangan berlarutan dengan teori — peraturan mudah di bawah slaid ini mencukupi untuk pemula.

**Slaid 11 · Stack & Positioned — Susun Atur Bertindan**  
Row/Column tidak membenarkan tindanan. Stack untuk kes widget di atas widget — cth. pill kategori kemasukan SPM/STAM di sudut banner.

**Slaid 12 · Latihan: ProgrammeBanner**  
Banner satu Programme: latar navy dengan bendera besar di tengah, universiti dan bidang dilabuhkan bawah kiri, pill SPM/STAM ditindan kanan atas. CategoryPill diguna semula daripada widgets/programme_card.dart — bukan tulis baharu.

**Slaid 13 · Dah Selesa Dengan Stack? Lanjutkan**  
Perhatikan susunan prompt: konteks, model data, tugas khusus, kekangan — empat bahagian ini menjadikan output jauh lebih tepat. Lebih banyak contoh: nota/08-prompt-claude-code.md. Beri peserta masa menulis prompt sendiri dan menjana.

**Slaid 14 · Hasil AI Jarang Sempurna — Ini Yang Biasa Kena Betulkan**  
AI biasanya pulangkan sesuatu yang berfungsi tetapi jarang sempurna — ia jarang fikirkan skrin sempit, jadi pengetahuan overflow pagi tadi terus terpakai. Minta peserta cari isu dalam kod janaan mereka sendiri sebelum tunjuk senarai ini.

**Slaid 15 · Align & Center**  
Perbezaan praktikal: "12px dari kanan atas" guna Positioned dalam Stack; "tengah-kanan" guna Align dalam mana-mana induk yang lebih besar daripada anaknya.

**Slaid 16 · Scaffold & AppBar — Rangka Skrin**  
Hampir setiap skrin Material bermula dengan Scaffold. Semalam kita sudah guna secara minimum — hari ini kita faham anatominya penuh.

**Slaid 17 · Kenapa AppBar() Kita Automatik Navy?**  
Contoh pertama kuasa ThemeData: kita tidak pernah menetapkan warna AppBar di mana-mana skrin, tetapi semuanya navy. Ini pratonton — struktur penuh KptTheme di SESI 3.

**Slaid 18 · Slaid 18**  
Petang ini kad statik semalam berkembang menjadi aplikasi bernavigasi dengan senarai skrol sebenar. Semua data daripada sample_programmes.dart.

**Slaid 19 · BottomNavigationBar — 3 Tab eTT Mobile**  
HomeScreen mesti StatefulWidget kerana indeks tab berubah. onTap panggil setState supaya body ditukar kepada skrin tab baharu. setState diterangkan penuh Hari 3 — buat masa ini anggap ia "beritahu Flutter: lukis semula".

**Slaid 20 · Perkara Penting BottomNavigationBar**  
Tiga tab mencerminkan perjalanan pengguna eTT: teliti program, jejak permohonan sendiri, urus profil. Ini navigasi peringkat aplikasi — Navigator antara skrin datang esok.

**Slaid 21 · Drawer — Panel Negara (Mesir/Maghribi)**  
Daripada screens/home_screen.dart. Scaffold automatik tambah ikon hamburger bila drawer disediakan. Corak collection-for menjana satu ListTile bagi setiap negara. value null bermaksud tiada tapisan. Kod sebenar juga guna provider untuk tapisan — itu mula Hari 3; hari ini cukup print sahaja dalam onSelect.

**Slaid 22 · ListView vs ListView.builder**  
Analogi 10,000 item: ListView biasa bina semua serentak — lambat dan makan memori; builder bina ~10-15 yang kelihatan sahaja. Untuk 8 program bezanya tak ketara, tetapi tabiat .builder untuk senarai data patut bermula sekarang — selepas API Hari 4, senarai boleh berkembang.

**Slaid 23 · Kod Sebenar: ProgrammeListScreen**  
Daripada screens/programme_list_screen.dart. Dalam kod sebenar, items datang daripada provider (ditapis carian/negara) dan onTap menavigasi — kedua-duanya Hari 3. Hari ini guna terus sampleProgrammes dan onTap kosong.

**Slaid 24 · GridView — 8 Program Sebagai Grid**  
GridView.builder juga lazy seperti ListView.builder. crossAxisCount = bilangan lajur; childAspectRatio = nisbah lebar:tinggi petak. Cabaran nanti: tukar ke 3 lajur dan laraskan nisbah. Kuota anggaran latihan kecuali Maghribi 15.

**Slaid 25 · Card & ListTile**  
ListTile sudah kita guna dalam Drawer negara tadi. Bandingkan dengan bina Row+Column manual setiap kali — ListTile jimat banyak kod untuk corak baris standard.

**Slaid 26 · Gabungan: Card + ListTile**  
Dua tahap: ListTile untuk baris seragam pantas; widget tersuai penuh seperti ProgrammeCard bila reka bentuk lebih khusus diperlukan. Widget kecil berformula begini ialah kes ideal untuk AI jana — asalkan kita semak sebelum guna pakai.

**Slaid 27 · TextStyle — Gaya Untuk Satu Text**  
Bina motivasi untuk slaid seterusnya: TextStyle inline bagus untuk kes tunggal, tetapi konsistensi seluruh aplikasi perlukan penyelesaian global — ThemeData.

**Slaid 28 · ThemeData — Kod Sebenar KptTheme**  
Fail sebenar lib/theme.dart (dipendekkan). ColorScheme.fromSeed menjana skema penuh dari satu warna benih; kita override primary/secondary supaya navy/gold. KptTheme._() = constructor private — kelas ini bekas pemalar, bukan untuk diinstankan.

**Slaid 29 · ThemeData — Perkara Penting**  
Tegaskan konsep satu tempat untuk semua gaya. Draf tema gelap ialah latihan lanjutan yang bagus untuk peserta pantas — struktur light sudah jadi templat, AI cuma isi variannya, dan kita semak seperti biasa.

**Slaid 30 · Ringkasan Hari 2 & Cabaran**  
Semak setiap peserta boleh skrol senarai 8 program dengan tema navy/gold sebelum bersurai. Cabaran ialah kerja rumah pilihan — galakkan cuba sekurang-kurangnya satu.
