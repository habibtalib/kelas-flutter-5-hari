// dart_asas.dart
//
// Contoh Dart asas yang BOLEH DIJALANKAN TERUS tanpa Flutter — berguna untuk
// berlatih sintaks Dart sebelum masuk ke widget. Jalankan dengan:
//
//   dart run snippets/dart_asas.dart
//
// Nota konsep penuh (null safety, koleksi, fungsi, class) ada di
// ../../nota/02-dart-asas.md — fail ini contoh RINGKAS & RUNNABLE sahaja,
// menggunakan domain "biasiswa" yang sama seperti projek kursus.

void main() {
  print('=== 1. Pembolehubah & Jenis ===');
  variablesDemo();

  print('\n=== 2. Enum dengan getter (Dart 3) ===');
  enumDemo();

  print('\n=== 3. Class & Named Constructor ===');
  classDemo();

  print('\n=== 4. List, Map & Koleksi ===');
  collectionsDemo();

  print('\n=== 5. Fungsi & Arrow Function ===');
  functionsDemo();

  print('\n=== 6. Null Safety ===');
  nullSafetyDemo();
}

// ---------------------------------------------------------------------------
// 1. Pembolehubah & Jenis
// ---------------------------------------------------------------------------
void variablesDemo() {
  String nama = 'Ali';
  int umur = 21;
  double cgpa = 3.75;
  bool layak = cgpa >= 3.50;

  // Inferens jenis dengan var — Dart teka jenis daripada nilai
  var negeri = 'Selangor';

  // const — nilai diketahui semasa KOMPIL, tak boleh berubah
  const double kadarMinimumCgpa = 3.50;

  print('Nama: $nama, Umur: $umur, CGPA: $cgpa, Layak MyBrainSc: $layak');
  print('Negeri: $negeri, CGPA minimum ditetapkan: $kadarMinimumCgpa');
}

// ---------------------------------------------------------------------------
// 2. Enum dengan getter — corak sama seperti ScholarshipCategory/StudyLevel
// ---------------------------------------------------------------------------
enum StatusPermohonan {
  belumHantar,
  sedangDiproses,
  diluluskan,
  ditolak;

  String get label => switch (this) {
        StatusPermohonan.belumHantar => 'Belum Hantar',
        StatusPermohonan.sedangDiproses => 'Sedang Diproses',
        StatusPermohonan.diluluskan => 'Diluluskan',
        StatusPermohonan.ditolak => 'Ditolak',
      };
}

void enumDemo() {
  final status = StatusPermohonan.diluluskan;
  print('Status permohonan: ${status.label}');

  for (final s in StatusPermohonan.values) {
    print('  - ${s.name} => ${s.label}');
  }
}

// ---------------------------------------------------------------------------
// 3. Class & Named Constructor — corak sama seperti model Scholarship
// ---------------------------------------------------------------------------
class Pelajar {
  final String nama;
  final double cgpa;
  final int umur;

  const Pelajar({
    required this.nama,
    required this.cgpa,
    required this.umur,
  });

  // Method — kaedah dalam class
  bool layakMohon({required double minCgpa, required int maxAge}) {
    return cgpa >= minCgpa && umur <= maxAge;
  }

  @override
  String toString() => 'Pelajar($nama, CGPA: $cgpa, Umur: $umur)';
}

void classDemo() {
  const pelajar = Pelajar(nama: 'Aminah', cgpa: 3.80, umur: 22);
  print(pelajar);
  print('Layak mohon MyBrainSc (min 3.50, max umur 24)? '
      '${pelajar.layakMohon(minCgpa: 3.50, maxAge: 24)}');
}

// ---------------------------------------------------------------------------
// 4. List, Map & Koleksi
// ---------------------------------------------------------------------------
void collectionsDemo() {
  // List — senarai tersusun
  final List<String> iptaContoh = ['UM', 'USM', 'UKM', 'UPM', 'UTM'];
  print('Senarai IPTA: $iptaContoh');
  print('Jumlah IPTA: ${iptaContoh.length}');
  print('IPTA pertama: ${iptaContoh.first}, terakhir: ${iptaContoh.last}');

  // map() — ubah setiap elemen
  final iptaHuruBesar = iptaContoh.map((nama) => nama.toUpperCase()).toList();
  print('Huruf besar: $iptaHuruBesar');

  // where() — tapis mengikut syarat
  final iptaMula5Huruf = iptaContoh.where((nama) => nama.length <= 3).toList();
  print('Nama pendek (<=3 huruf): $iptaMula5Huruf');

  // Map — struktur kunci-nilai
  final Map<String, double> elaunMengikutKategori = {
    'Pra Perkhidmatan': 1500,
    'Dalam Perkhidmatan': 2500,
    'Bantuan Kewangan': 800,
  };
  elaunMengikutKategori.forEach((kategori, elaun) {
    print('$kategori: RM$elaun/bulan');
  });
}

// ---------------------------------------------------------------------------
// 5. Fungsi & Arrow Function
// ---------------------------------------------------------------------------
// Fungsi biasa
double kiraElaunTahunan(double elaunBulanan) {
  return elaunBulanan * 12;
}

// Arrow function — bentuk ringkas untuk fungsi satu ungkapan (sama konsep
// dengan getter `label` dalam enum di atas)
String formatRinggit(double jumlah) => 'RM${jumlah.toStringAsFixed(2)}';

void functionsDemo() {
  final tahunan = kiraElaunTahunan(1500);
  print('Elaun tahunan: ${formatRinggit(tahunan)}');

  // Fungsi tanpa nama (anonymous function) — lazim digunakan dalam
  // itemBuilder, onTap, dsb. dalam Flutter
  final gandaDua = (int n) => n * 2;
  print('Gandaan 8: ${gandaDua(8)}');
}

// ---------------------------------------------------------------------------
// 6. Null Safety — konsep PENTING dalam Dart
// ---------------------------------------------------------------------------
void nullSafetyDemo() {
  String nama = 'Ali'; // tidak boleh null
  String? gelaran; // BOLEH null (nilai lalai: null)

  print('Gelaran sebelum: $gelaran');

  gelaran ??= 'Encik'; // tetapkan nilai HANYA jika null
  print('Gelaran selepas ??=: $gelaran');

  // Nilai boleh jadi null bergantung keadaan (analyzer tak boleh andaikan)
  String? alamatEmail = nama.isEmpty ? 'ali@example.com' : null;
  String paparan = alamatEmail ?? 'Tiada emel didaftarkan';
  print('Paparan emel: $paparan');

  // Akses selamat (?.) — elak ralat jika objek null
  int? panjangEmail = alamatEmail?.length;
  print('Panjang alamat emel (null jika tiada): $panjangEmail');

  print('Nama (tidak boleh null): $nama');
}
