// dart_asas.dart
//
// Contoh Dart asas SESI 1 (Hari 1) — BOLEH DIJALANKAN TERUS tanpa Flutter,
// menggunakan domain kursus "eTT Mobile" (companion latihan sistem
// e-Timur Tengah — permohonan pelajar Malaysia ke universiti di Mesir &
// Maghribi). Jalankan dengan:
//
//   dart run snippets/dart_asas.dart
//
// PENAFIAN: Bahan latihan — BUKAN sistem e-Timur Tengah rasmi. Permohonan
// sebenar hanya di dohe.mohe.gov.my/timurtengah. KPT tidak melantik ejen.
// Nama universiti & syarat adalah benar; kos/kuota adalah ilustrasi.
//
// Topik ditutup (ikut aturcara rasmi SESI 1 — lihat JADUAL.md):
//   1. Operators (pengendali)
//   2. Control flow — if/else
//   3. Control flow — switch
//   4. Looping (for) & Function
//   5. Looping (while)
//   6. Enum dengan getter (pratonton model sebenar projek)
//   7. Function — format/tukar kos anggaran kepada RM
//
// Rujukan model SEBENAR (Hari 2 seterusnya guna ini penuh):
//   projek/ett_mobile/lib/models/programme.dart
//   projek/ett_mobile/lib/data/sample_programmes.dart

void main() {
  print('=== 1. Operators (Pengendali) ===');
  operatorsDemo();

  print('\n=== 2. Control Flow — if/else ===');
  ifElseDemo();

  print('\n=== 3. Control Flow — switch ===');
  switchDemo();

  print('\n=== 4. Looping (for) & Function — Kuota Program eTT ===');
  loopingAndFunctionDemo();

  print('\n=== 5. Looping (while) ===');
  whileDemo();

  print('\n=== 6. Enum dengan getter (pratonton model sebenar) ===');
  enumDemo();

  print('\n=== 7. Function — Format/Tukar Kos Anggaran kepada RM ===');
  costFormattingDemo();
}

// ---------------------------------------------------------------------------
// Data contoh — versi RINGKAS (Map) 8 tawaran program eTT, sepadan dengan
// projek/ett_mobile/lib/data/sample_programmes.dart. Guna Map di sini (bukan
// class Programme penuh) supaya fail ini kekal Dart tulen, boleh jalan tanpa
// Flutter. Kita bina class Programme SEBENAR di Hari 2.
// ---------------------------------------------------------------------------
const List<Map<String, Object>> sampleProgrammes = [
  {
    'id': 'ETT-001',
    'universityName': 'Universiti Al-Azhar',
    'country': 'Egypt',
    'fieldOfStudy': 'Perubatan (Medicine)',
    'costMyr': 23000.0,
    'quotaSeats': 40,
  },
  {
    'id': 'ETT-002',
    'universityName': 'Universiti Al-Azhar',
    'country': 'Egypt',
    'fieldOfStudy': 'Syariah dan Undang-undang',
    'costMyr': 5000.0,
    'quotaSeats': 120,
  },
  {
    'id': 'ETT-003',
    'universityName': 'Universiti Al-Azhar',
    'country': 'Egypt',
    'fieldOfStudy': 'Ulum Islamiah',
    'costMyr': 4500.0,
    'quotaSeats': 80,
  },
  {
    'id': 'ETT-004',
    'universityName': 'Universiti Alexandria',
    'country': 'Egypt',
    'fieldOfStudy': 'Farmasi (Pharmacy)',
    'costMyr': 36000.0,
    'quotaSeats': 30,
  },
  {
    'id': 'ETT-005',
    'universityName': 'Universiti Ain Shams',
    'country': 'Egypt',
    'fieldOfStudy': 'Perubatan (Medicine)',
    'costMyr': 34000.0,
    'quotaSeats': 25,
  },
  {
    'id': 'ETT-006',
    'universityName': 'Universiti Tanta',
    'country': 'Egypt',
    'fieldOfStudy': 'Pergigian (Dentistry)',
    'costMyr': 27000.0,
    'quotaSeats': 20,
  },
  {
    'id': 'ETT-007',
    'universityName': 'Universite Al Quaraouiyine',
    'country': 'Morocco',
    'fieldOfStudy': 'Usuluddin',
    'costMyr': 6000.0,
    'quotaSeats': 15,
  },
  {
    'id': 'ETT-008',
    'universityName': 'Universiti Mohammed V',
    'country': 'Morocco',
    'fieldOfStudy': 'Bahasa Arab (Arabic Language)',
    'costMyr': 7000.0,
    'quotaSeats': 10,
  },
];

// ---------------------------------------------------------------------------
// 1. Operators — aritmetik, bandingan, logik, tugasan gabungan (compound)
// ---------------------------------------------------------------------------
void operatorsDemo() {
  // Kuota program eTT-001 (Al-Azhar, Perubatan) & ETT-003 (Al-Azhar, Ulum
  // Islamiah) — angka ILUSTRASI untuk tujuan latihan.
  const int kuotaEtt001 = 40;
  const int kuotaEtt003 = 80;

  // Operator aritmetik: +
  print('Kuota ETT-001 + ETT-003 = ${kuotaEtt001 + kuotaEtt003}');
  // Operator bandingan: >
  print('ETT-003 ada kuota lebih besar? ${kuotaEtt003 > kuotaEtt001}');

  // Kos anggaran Farmasi Universiti Alexandria (ETT-004) — operator *
  const double kosFarmasiSetahun = 36000; // RM, ilustrasi
  const int tempohPengajianTahun = 5;
  final double anggaranKosKeseluruhan = kosFarmasiSetahun * tempohPengajianTahun;
  print('Anggaran kos keseluruhan Farmasi (5 tahun): '
      'RM${anggaranKosKeseluruhan.toStringAsFixed(0)}');

  // Operator logik: && (dan)
  const bool sijilLengkap = true;
  final bool dalamBajet = anggaranKosKeseluruhan <= 200000; // operator <=
  print('Layak dipertimbang (dalam bajet DAN sijil lengkap)? '
      '${dalamBajet && sijilLengkap}');

  // Operator tugasan gabungan: +=, *=
  int kiraanProgramDisemak = 0;
  kiraanProgramDisemak += 1;
  kiraanProgramDisemak += 1;
  kiraanProgramDisemak *= 3;
  print('kiraanProgramDisemak selepas += dan *=: $kiraanProgramDisemak');
}

// ---------------------------------------------------------------------------
// 2. Control Flow — if / else if / else
// ---------------------------------------------------------------------------
void ifElseDemo() {
  // Contoh 1: kelayakan sijil — SPM lwn STAM (pratonton EntryCategory
  // sebenar dalam projek/ett_mobile/lib/models/programme.dart). Realiti eTT:
  // SATU negara + SATU bidang setiap permohonan.
  const String keperluanProgram = 'stam'; // ETT-002: Syariah dan Undang-undang
  const String sijilPemohon = 'spm';

  if (keperluanProgram == 'both') {
    print('Program ini terima kedua-dua SPM & STAM.');
  } else if (keperluanProgram == sijilPemohon) {
    print('Layak memohon — sijil ${sijilPemohon.toUpperCase()} sepadan '
        'keperluan program.');
  } else {
    print('Tidak layak — program ini hanya terima '
        '${keperluanProgram.toUpperCase()}, pemohon ada '
        '${sijilPemohon.toUpperCase()}.');
  }

  // Contoh 2: semak bajet pelajar berbanding anggaran kos tahunan (RM)
  const double kosAnggaranTahunanEtt004 = 36000; // Farmasi, Alexandria
  const double bajetPelajar = 30000;

  if (kosAnggaranTahunanEtt004 <= bajetPelajar) {
    print('Dalam bajet (RM${kosAnggaranTahunanEtt004.toStringAsFixed(0)}).');
  } else {
    print('Melebihi bajet pelajar '
        '(RM${kosAnggaranTahunanEtt004.toStringAsFixed(0)} > '
        'RM${bajetPelajar.toStringAsFixed(0)}).');
  }
}

// ---------------------------------------------------------------------------
// 3. Control Flow — switch (statement klasik dengan case/fall-through/default)
// ---------------------------------------------------------------------------
/// Memetakan nama universiti kepada label negara Bahasa Melayu. Beberapa
/// `case` "jatuh melalui" (fall-through) ke `return` yang sama kerana
/// berkongsi negara.
String countryLabelForUniversity(String universityName) {
  switch (universityName) {
    case 'Universiti Al-Azhar':
    case 'Universiti Alexandria':
    case 'Universiti Ain Shams':
    case 'Universiti Tanta':
      return 'Mesir';
    case 'Universite Al Quaraouiyine':
    case 'Universiti Mohammed V':
      return 'Maghribi';
    default:
      return 'Negara tidak diketahui';
  }
}

void switchDemo() {
  const universitiUjian = [
    'Universiti Al-Azhar',
    'Universiti Alexandria',
    'Universite Al Quaraouiyine',
    'Universiti Mohammed V',
    'Universiti Kaherah', // sengaja bukan dalam senarai eTT -> default
  ];

  for (final universiti in universitiUjian) {
    print('$universiti -> ${countryLabelForUniversity(universiti)}');
  }
}

// ---------------------------------------------------------------------------
// 4. Looping (for) & Function — jumlahkan kuota tempat 8 program eTT
// ---------------------------------------------------------------------------
/// Function — jumlahkan `quotaSeats` semua program dalam senarai [data].
/// Kuota ILUSTRASI (kecuali laluan Maghribi — 15 tempat, angka rasmi).
int jumlahkanKuota(List<Map<String, Object>> data) {
  int jumlah = 0;
  for (final programme in data) {
    jumlah += programme['quotaSeats'] as int;
  }
  return jumlah;
}

void loopingAndFunctionDemo() {
  // for (... in ...) — loop merentasi setiap program dalam senarai
  for (final programme in sampleProgrammes) {
    final nama = programme['universityName'] as String;
    final bidang = programme['fieldOfStudy'] as String;
    final kuota = programme['quotaSeats'] as int;
    print('${nama.padRight(28)}: $bidang (kuota: $kuota)');
  }

  final jumlahKuota = jumlahkanKuota(sampleProgrammes);
  print('---');
  print('Jumlah kuota keseluruhan (8 program): $jumlahKuota tempat');
}

// ---------------------------------------------------------------------------
// 5. Looping (while)
// ---------------------------------------------------------------------------
void whileDemo() {
  const senaraiBidangPopular = [
    'Perubatan (Medicine)',
    'Farmasi (Pharmacy)',
    'Pergigian (Dentistry)',
  ];

  int i = 0;
  while (i < senaraiBidangPopular.length) {
    print('Bidang popular #${i + 1}: ${senaraiBidangPopular[i]}');
    i++; // PENTING: jangan lupa naikkan i, jika tidak -> infinite loop
  }
}

// ---------------------------------------------------------------------------
// 6. Enum dengan getter — pratonton corak SEBENAR yang dipakai dalam
//    projek/ett_mobile/lib/models/programme.dart
// ---------------------------------------------------------------------------
enum StudyLevel {
  foundation,
  diploma,
  bachelor;

  String get label => switch (this) {
        StudyLevel.foundation => 'Asasi',
        StudyLevel.diploma => 'Diploma',
        StudyLevel.bachelor => 'Ijazah Sarjana Muda',
      };
}

/// Kategori kemasukan — sijil yang boleh memohon (SPM / STAM / kedua-dua).
enum EntryCategory {
  spm,
  stam,
  both;

  String get label => switch (this) {
        EntryCategory.spm => 'SPM',
        EntryCategory.stam => 'STAM',
        EntryCategory.both => 'SPM atau STAM',
      };

  /// Adakah kategori sijil pemohon [applicant] layak untuk program ini?
  bool accepts(EntryCategory applicant) =>
      this == EntryCategory.both || this == applicant;
}

void enumDemo() {
  print('Semua peringkat pengajian (StudyLevel):');
  for (final level in StudyLevel.values) {
    print('  - ${level.name} => ${level.label}');
  }

  const keperluanEtt002 = EntryCategory.stam; // Syariah dan Undang-undang
  const keperluanEtt007 = EntryCategory.both; // Usuluddin, Al Quaraouiyine
  print('ETT-002 (Syariah): ${keperluanEtt002.label}');
  print('ETT-007 (Usuluddin): ${keperluanEtt007.label}');
  print('ETT-007 terima pemohon SPM? ${keperluanEtt007.accepts(EntryCategory.spm)}');
  print('ETT-002 terima pemohon SPM? ${keperluanEtt002.accepts(EntryCategory.spm)}');
}

// ---------------------------------------------------------------------------
// 7. Function — format/tukar kos anggaran kepada RM
// ---------------------------------------------------------------------------
/// Format kos anggaran tahunan (RM) dengan pemisah ribuan mudah,
/// cth. 23000.0 -> "RM23,000". Kos ILUSTRASI sahaja, bukan sebut harga rasmi.
String formatCostMyr(double amount) {
  final wholeNumber = amount.toStringAsFixed(0);
  final buffer = StringBuffer();
  for (var i = 0; i < wholeNumber.length; i++) {
    final posFromRight = wholeNumber.length - i;
    buffer.write(wholeNumber[i]);
    if (posFromRight > 1 && posFromRight % 3 == 1) {
      buffer.write(',');
    }
  }
  return 'RM${buffer.toString()}';
}

/// Kadar tukaran ANGGARAN USD->MYR untuk tujuan latihan sahaja — diselaras
/// secara kasar dengan jadual USD rasmi 2021/22 (bukan kadar semasa/rasmi).
const double kadarUsdMyrAnggaran = 4.6;

double convertUsdToMyrEstimate(double usd) => usd * kadarUsdMyrAnggaran;

void costFormattingDemo() {
  for (final programme in sampleProgrammes) {
    final nama = programme['universityName'] as String;
    final bidang = programme['fieldOfStudy'] as String;
    final kos = programme['costMyr'] as double;
    print('$nama ($bidang): ${formatCostMyr(kos)}/tahun (ilustrasi)');
  }

  print('---');
  // Anchor USD rasmi 2021/22 (ilustrasi): Perubatan Al-Azhar ~USD5,000.
  const double kosPerubatanUsd = 5000;
  final anggaranMyr = convertUsdToMyrEstimate(kosPerubatanUsd);
  print('Anggaran USD$kosPerubatanUsd -> ${formatCostMyr(anggaranMyr)} '
      '(kadar tukaran anggaran, bukan rasmi)');
}
