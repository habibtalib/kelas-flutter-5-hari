# Nota Penceramah — Hari 1: Aliran Kawalan Dart & Widget Asas (SESI 1)

> Nota rujukan untuk **penceramah/jurulatih**. Setiap entri sepadan dengan satu slaid dalam [`../slides/flutter-training.html`](../slides/flutter-training.html). Nota ini asalnya *speaker notes* dalam deck — dikumpulkan di sini supaya bahan lengkap walaupun tanpa membuka slaid. Slaid tanpa nota penceramah tidak disenaraikan.

**Slaid 2 · Jadual Hari Ini**  
Tegaskan skop hari ini sempit tapi penting: asas Dart dan segelintir widget paling asas sahaja. Semua yang lain datang mengikut sesi rasmi.

**Slaid 3 · Projek Kursus: eTT Mobile**  
Perkenalkan domain projek supaya semua contoh Dart hari ini terasa relevan. Ulang penafian: ini bahan latihan, bukan sistem rasmi.

**Slaid 4 · Persediaan — Sudah Sedia?**  
Persediaan sepatutnya siap sebelum kelas. Sesiapa yang bermasalah, bantu semasa rehat — jangan tahan seluruh kelas. DartPad ialah pelan B yang bagus.

**Slaid 5 · Operators (Pengendali)**  
Jalankan dalam DartPad secara langsung. Data daripada 8 program eTT kursus — kuota dan kos ilustrasi, tetapi struktur domain sebenar. Farmasi Alexandria 5 tahun = anggaran RM180,000 keseluruhan.

**Slaid 6 · Kategori Operator Dart**  
Jangan hafal — tunjuk yang setiap kategori sudah muncul dalam contoh tadi. Rujukan rasmi: dart.dev/language/operators.

**Slaid 7 · Control Flow — if / else**  
Domain sebenar: kelayakan sijil SPM lwn STAM ialah keputusan pertama setiap pemohon eTT. Minta peserta tukar nilai sijilPemohon kepada stam dan lihat output berubah.

**Slaid 8 · Nota Realiti eTT — Satu Negara, Satu Bidang**  
Selitkan fakta domain awal supaya bila borang dibina Hari 3, peraturan 1 negara + 1 bidang + 3 pilihan universiti sudah biasa didengari.

**Slaid 9 · Control Flow — switch**  
Domain sebenar: memetakan universiti eTT ke label negara BM. Tunjuk fall-through — empat universiti Mesir berkongsi satu return. Cuba 'Universiti Kaherah' untuk lihat default.

**Slaid 10 · Data Kursus: 8 Program eTT**  
Ini struktur List of Map — versi ringkas Dart tulen. Kita bina class Programme sebenar mulai Hari 2. Tekankan: nama universiti benar, kuota ilustrasi kecuali Maghribi 15.

**Slaid 11 · Looping (for) & Function**  
Function ada nama, parameter bertaip dan nilai pulangan. Loop for-in melelar setiap program tanpa urus indeks. Jumlah 340 tempat — angka latihan yang boleh peserta sahkan sendiri di DartPad.

**Slaid 12 · Looping — while**  
Guna while bila bilangan lelaran tidak diketahui awal. Demokan infinite loop dalam DartPad sekali — pengalaman "tersangkut" lebih diingati daripada amaran lisan.

**Slaid 13 · Bonus: enum + switch Expression**  
Ini pratonton model sebenar yang kita guna penuh Hari 2. Bandingkan: switch statement untuk logik bercabang berbilang baris, switch expression untuk pulangkan satu nilai. Method accepts() menjawab: adakah sijil pemohon layak untuk program ini?

**Slaid 14 · Function — Format Kos Anggaran ke RM**  
Latihan penutup pagi: format 23000.0 jadi RM23,000. Snippet penuh boleh dijalankan: hari-1/snippets/dart_asas.dart. Tegaskan kos ilustrasi — diselaras kasar dengan jadual USD rasmi 2021/22.

**Slaid 15 · Slaid 15**  
Gantikan kandungan lib/main.dart dengan kod ini. Simpan = Hot Reload automatik. Scaffold/AppBar dibedah penuh esok — hari ini kita hanya perlukan rangka minimum untuk bereksperimen.

**Slaid 16 · Widget Asas 1/3 — Text**  
Tampal dalam body Scaffold dan Hot Reload. Cuba tukar fontSize dan lihat perubahan serta-merta — inilah keseronokan Hot Reload.

**Slaid 17 · Widget Asas 2/3 — Icon**  
Minta peserta cari 2-3 ikon lain di katalog dan cuba. Sebut awal: navy/gold ialah pilihan reka bentuk bahan kursus, bukan palet korporat rasmi.

**Slaid 18 · Widget Asas 3/3 — Image**  
Projek tiada aset logo terbenam, jadi dua cara ini tak perlukan fail tempatan. Image.network perlukan internet pada emulator.

**Slaid 19 · Slaid 19**  
Selepas makan tengah hari, kita sambung SESI 1 dengan widget kotak dan jarak, kemudian tutup hari dengan konsep Stateless vs Stateful.

**Slaid 20 · Container — Kotak Serba Boleh**  
Container ialah widget kotak paling serba boleh. BoxDecoration mengawal rupa; borderRadius memberi sudut bulat moden.

**Slaid 21 · Padding vs Margin**  
Konsep paling mengelirukan pemula. Guna analogi bingkai gambar: padding di dalam bingkai, margin di luar bingkai.

**Slaid 22 · SizedBox — Jarak & Saiz Tepat**  
SizedBox ialah cara paling efisien untuk jarak kosong tetap. Column dibedah penuh esok — hari ini cukup faham ia menyusun anak menegak.

**Slaid 23 · Latihan Bengkel: Kad Info Program (Statik)**  
Latihan utama petang: gabungkan Container, Padding, SizedBox dan Text jadi satu kad program — data ETT-001 (Al-Azhar, Perubatan). Esok kad ini jadi widget ProgrammeCard yang boleh guna semula untuk 8 program.

**Slaid 24 · StatelessWidget vs StatefulWidget**  
Beza paling asas dalam Flutter — peserta akan tulis kedua-duanya setiap hari sepanjang kursus. Analogi gambar bercetak vs papan LED biasanya melekat.

**Slaid 25 · Teaser: setState() — Kaunter "Simpan Program"**  
Tekan butang berulang kali — angka naik tanpa run semula. Tegaskan: tanpa setState(), nilai berubah di belakang tabir tetapi UI TIDAK dikemas kini.

**Slaid 26 · Ringkasan Hari 1 & Langkah Seterusnya**  
Pastikan flutter run setiap peserta masih berfungsi tanpa ralat sebelum bersurai. Galakkan commit git dari Hari 1 — tabiat baik.
