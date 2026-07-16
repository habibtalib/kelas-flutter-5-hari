# Nota Penceramah — Hari 1: Aliran Kawalan Dart & Widget Asas (SESI 1)

> Nota rujukan untuk **penceramah/jurulatih**. Setiap entri sepadan dengan satu slaid dalam [`../slides/flutter-training.html`](../slides/flutter-training.html). Nota ini asalnya *speaker notes* dalam deck — dikumpulkan di sini supaya bahan lengkap walaupun tanpa membuka slaid. Slaid tanpa nota penceramah tidak disenaraikan.

**Slaid 2 · Jadual Hari Ini**  
Tegaskan skop hari ini sempit tapi penting: asas Dart dan segelintir widget paling asas sahaja. Semua yang lain datang mengikut sesi rasmi.

**Slaid 3 · Projek Kursus: MyPelajar LN**  
Perkenalkan domain projek supaya semua contoh Dart hari ini terasa relevan. Ulang penafian: ini bahan latihan, bukan sistem rasmi.

**Slaid 4 · Persediaan — Sudah Sedia?**  
Persediaan sepatutnya siap sebelum kelas. Sesiapa yang bermasalah, bantu semasa rehat — jangan tahan seluruh kelas. DartPad ialah pelan B yang bagus.

**Slaid 5 · Operators (Pengendali)**  
Jalankan dalam DartPad secara langsung. Tunjukkan tajaan + sendiri memang sama dengan jumlah rasmi 54,903 — data sebenar buat contoh lebih bermakna.

**Slaid 6 · Kategori Operator Dart**  
Jangan hafal — tunjuk yang setiap kategori sudah muncul dalam contoh tadi. Rujukan rasmi: dart.dev/language/operators.

**Slaid 7 · Control Flow — if / else**  
Konsep pengiktirafan kelayakan ialah keputusan sebenar pelajar luar negara — if/else memodelkan keputusan itu. Minta peserta tukar nilai dan lihat output berubah.

**Slaid 8 · Control Flow — switch**  
Domain sebenar: setiap negara diselia pejabat Education Malaysia tertentu. Tunjuk fall-through UK/Ireland ke pejabat London — corak yang kerap berguna.

**Slaid 9 · Data Sebenar: Pelajar Mengikut Negara (2024)**  
Ini struktur Map — pasangan kunci-nilai. Tekankan senarai ini 12 negara utama sahaja, bukan semua destinasi; kita akan buktikan bezanya sebentar lagi dengan loop.

**Slaid 10 · Looping (for) & Function**  
Function ada nama, parameter dan nilai pulangan. Loop for-in melelar setiap entri Map tanpa urus indeks. Hasil 53,035 ≠ 54,903 — baki tersebar di negara lain yang tidak disenaraikan; contoh baik bahawa kod membantu kita semak data.

**Slaid 11 · Looping — while**  
Guna while bila bilangan lelaran tidak diketahui awal. Demokan infinite loop dalam DartPad sekali — pengalaman "tersangkut" lebih diingati daripada amaran lisan.

**Slaid 12 · Bonus: enum + switch Expression**  
Ini pratonton model sebenar yang kita guna penuh Hari 2. Bandingkan: switch statement untuk logik bercabang berbilang baris, switch expression untuk pulangkan satu nilai.

**Slaid 13 · Function — Tukar Yuran Asing ke RM**  
Gabungkan semua yang dipelajari: function, parameter, Map, operator. Tegaskan kadar tukaran hanya anggaran latihan, bukan kadar semasa.

**Slaid 14 · Slaid 14**  
Gantikan kandungan lib/main.dart dengan kod ini. Simpan = Hot Reload automatik. Scaffold/AppBar dibedah penuh esok — hari ini kita hanya perlukan rangka minimum untuk bereksperimen.

**Slaid 15 · Widget Asas 1/3 — Text**  
Tampal dalam body Scaffold dan Hot Reload. Cuba tukar fontSize dan lihat perubahan serta-merta — inilah keseronokan Hot Reload.

**Slaid 16 · Widget Asas 2/3 — Icon**  
Minta peserta cari 2-3 ikon lain di katalog dan cuba. Sebut awal: navy/gold ialah pilihan reka bentuk bahan kursus, bukan palet korporat rasmi KPT.

**Slaid 17 · Widget Asas 3/3 — Image**  
Projek tiada aset logo terbenam, jadi dua cara ini tak perlukan fail tempatan. Image.network perlukan internet pada emulator.

**Slaid 18 · Slaid 18**  
Selepas makan tengah hari, kita sambung SESI 1 dengan widget kotak dan jarak, kemudian tutup hari dengan konsep Stateless vs Stateful.

**Slaid 19 · Container — Kotak Serba Boleh**  
Container ialah widget kotak paling serba boleh. BoxDecoration mengawal rupa; borderRadius memberi sudut bulat moden.

**Slaid 20 · Padding vs Margin**  
Konsep paling mengelirukan pemula. Guna analogi bingkai gambar: padding di dalam bingkai, margin di luar bingkai.

**Slaid 21 · SizedBox — Jarak & Saiz Tepat**  
SizedBox ialah cara paling efisien untuk jarak kosong tetap. Column dibedah penuh esok — hari ini cukup faham ia menyusun anak menegak.

**Slaid 22 · Latihan Bengkel: Kad Info Universiti (Statik)**  
Latihan utama petang: gabungkan Container, Padding, SizedBox, Text dan Icon jadi satu kad universiti. Esok kad ini jadi widget UniversityCard yang boleh guna semula untuk 8 universiti.

**Slaid 23 · StatelessWidget vs StatefulWidget**  
Beza paling asas dalam Flutter — peserta akan tulis kedua-duanya setiap hari sepanjang kursus. Analogi gambar bercetak vs papan LED biasanya melekat.

**Slaid 24 · Teaser: setState() — Kaunter "Simpan Destinasi"**  
Tekan butang berulang kali — angka naik tanpa run semula. Tegaskan: tanpa setState(), nilai berubah di belakang tabir tetapi UI TIDAK dikemas kini.

**Slaid 25 · Ringkasan Hari 1 & Langkah Seterusnya**  
Pastikan flutter run setiap peserta masih berfungsi tanpa ralat sebelum bersurai. Galakkan commit git dari Hari 1 — tabiat baik.
