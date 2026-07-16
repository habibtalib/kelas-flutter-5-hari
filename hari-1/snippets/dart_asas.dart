// dart_asas.dart
//
// Contoh Dart asas SESI 1 (Hari 1) — BOLEH DIJALANKAN TERUS tanpa Flutter,
// menggunakan domain kursus "MyPelajar LN" (pendaftaran pelajar Malaysia
// di luar negara). Jalankan dengan:
//
//   dart run snippets/dart_asas.dart
//
// Topik ditutup (ikut aturcara rasmi SESI 1 — lihat JADUAL.md):
//   1. Operators (pengendali)
//   2. Control flow — if/else
//   3. Control flow — switch
//   4. Looping (for) & Function
//   5. Looping (while)
//   6. Enum dengan getter (pratonton model sebenar projek)
//   7. Function — tukar yuran mata wang asing kepada RM
//
// Rujukan model SEBENAR (Hari 2 seterusnya guna ini penuh):
//   projek/mypelajar_ln/lib/models/overseas_university.dart
//   projek/mypelajar_ln/lib/data/sample_universities.dart

void main() {
  print('=== 1. Operators (Pengendali) ===');
  operatorsDemo();

  print('\n=== 2. Control Flow — if/else ===');
  ifElseDemo();

  print('\n=== 3. Control Flow — switch ===');
  switchDemo();

  print('\n=== 4. Looping (for) & Function — Statistik Pelajar Mengikut Negara ===');
  loopingAndFunctionDemo();

  print('\n=== 5. Looping (while) ===');
  whileDemo();

  print('\n=== 6. Enum dengan getter (pratonton model sebenar) ===');
  enumDemo();

  print('\n=== 7. Function — Tukar Yuran Asing kepada RM ===');
  tuitionConversionDemo();
}

// ---------------------------------------------------------------------------
// 1. Operators — aritmetik, bandingan, logik, tugasan gabungan (compound)
// ---------------------------------------------------------------------------
void operatorsDemo() {
  // Statistik rasmi: Statistik Pendidikan Tinggi 2024, Bab 6.
  const int totalPelajarLN = 54903;
  const int pelajarTajaan = 14697;
  const int pelajarSendiri = 40206;

  // Operator aritmetik: +
  print('Tajaan + Sendiri = ${pelajarTajaan + pelajarSendiri}');
  // Operator bandingan: ==
  print('Sepadan jumlah rasmi? ${pelajarTajaan + pelajarSendiri == totalPelajarLN}');

  // Yuran University of Melbourne (ilustrasi) — operator *
  const double yuranMelbourneAud = 52000;
  const double kadarTukaranAudMyr = 3.0; // anggaran, bukan rasmi
  final double yuranMelbourneMyr = yuranMelbourneAud * kadarTukaranAudMyr;
  print('Anggaran yuran Melbourne dalam RM: $yuranMelbourneMyr');

  // Operator logik: && (dan)
  const bool statusDiiktiraf = true;
  final bool dalamBajet = yuranMelbourneMyr <= 200000; // operator <=
  print('Layak dipertimbang (dalam bajet DAN diiktiraf)? '
      '${dalamBajet && statusDiiktiraf}');

  // Operator tugasan gabungan: +=, *=
  int kiraanNegaraDilawati = 0;
  kiraanNegaraDilawati += 1;
  kiraanNegaraDilawati += 1;
  kiraanNegaraDilawati *= 3;
  print('kiraanNegaraDilawati selepas += dan *=: $kiraanNegaraDilawati');
}

// ---------------------------------------------------------------------------
// 2. Control Flow — if / else if / else
// ---------------------------------------------------------------------------
void ifElseDemo() {
  // Contoh 1: status pengiktirafan (rujuk eSisraf MQA jika perlu semak)
  const String recognitionStatusAuckland = 'checkWithMqa';

  if (recognitionStatusAuckland == 'recognised') {
    print('University of Auckland: diiktiraf terus.');
  } else if (recognitionStatusAuckland == 'checkWithMqa') {
    print('University of Auckland: perlu semak eSisraf (MQA) dahulu.');
  } else {
    print('Status tidak dikenali.');
  }

  // Contoh 2: semak bajet pelajar berbanding anggaran yuran tahunan (RM)
  const double annualTuitionMyrAuckland = 121000;
  const double bajetPelajar = 100000;

  if (annualTuitionMyrAuckland <= bajetPelajar) {
    print('Dalam bajet (RM${annualTuitionMyrAuckland.toStringAsFixed(0)}).');
  } else {
    print('Melebihi bajet pelajar '
        '(RM${annualTuitionMyrAuckland.toStringAsFixed(0)} > '
        'RM${bajetPelajar.toStringAsFixed(0)}).');
  }
}

// ---------------------------------------------------------------------------
// 3. Control Flow — switch (statement klasik dengan case/break/default)
// ---------------------------------------------------------------------------
String emOfficeForCountry(String country) {
  switch (country) {
    case 'Australia':
      return 'Education Malaysia Australia';
    case 'New Zealand':
      return 'Education Malaysia New Zealand';
    case 'United Kingdom':
    case 'Ireland':
      // dua case "jatuh melalui" (fall-through) ke return yang sama
      return 'Education Malaysia London';
    case 'Egypt':
      return 'Education Malaysia Egypt';
    case 'China':
    case 'Japan':
      return 'Education Malaysia Beijing';
    case 'Jordan':
      return 'Education Malaysia Jordan';
    default:
      return 'Tiada pejabat EM khusus direkodkan untuk negara ini';
  }
}

void switchDemo() {
  const negaraUjian = [
    'Australia',
    'Ireland',
    'Japan',
    'Jordan',
    'Brazil', // sengaja bukan dalam senarai 12 negara utama -> default
  ];

  for (final negara in negaraUjian) {
    print('$negara -> ${emOfficeForCountry(negara)}');
  }
}

// ---------------------------------------------------------------------------
// 4. Looping (for) & Function — statistik pelajar mengikut negara 2024
// ---------------------------------------------------------------------------
/// Statistik Pendidikan Tinggi 2024, Bab 6 — bilangan pelajar Malaysia di
/// luar negara mengikut 12 negara utama. Jumlah rasmi KESELURUHAN (semua
/// destinasi) ialah 54,903; baki selain 12 negara ini tersebar di destinasi
/// lain yang tidak disenaraikan secara individu dalam bahan latihan ini.
const Map<String, int> pelajarMengikutNegara = {
  'Australia': 18348,
  'United Kingdom': 13005,
  'Egypt': 5445,
  'United States': 4980,
  'China': 4357,
  'Jordan': 2003,
  'Indonesia': 1110,
  'Japan': 1039,
  'Ireland': 856,
  'South Korea': 695,
  'Russia': 622,
  'New Zealand': 575,
};

/// Function — jumlahkan semua nilai dalam peta statistik negara.
int jumlahkanPelajar(Map<String, int> data) {
  int jumlah = 0;
  for (final entry in data.entries) {
    jumlah += entry.value;
  }
  return jumlah;
}

void loopingAndFunctionDemo() {
  // for (... in ...) — loop merentasi setiap pasangan negara/bilangan
  for (final entry in pelajarMengikutNegara.entries) {
    print('${entry.key.padRight(16)}: ${entry.value} pelajar');
  }

  final jumlah12Negara = jumlahkanPelajar(pelajarMengikutNegara);
  const jumlahRasmiKeseluruhan = 54903;

  print('---');
  print('Jumlah 12 negara utama: $jumlah12Negara');
  print('Jumlah rasmi keseluruhan (semua destinasi): $jumlahRasmiKeseluruhan');
  print('Baki di destinasi lain: '
      '${jumlahRasmiKeseluruhan - jumlah12Negara}');
}

// ---------------------------------------------------------------------------
// 5. Looping (while)
// ---------------------------------------------------------------------------
void whileDemo() {
  const senaraiDestinasiPopular = ['Australia', 'United Kingdom', 'Egypt'];

  int i = 0;
  while (i < senaraiDestinasiPopular.length) {
    print('Destinasi popular #${i + 1}: ${senaraiDestinasiPopular[i]}');
    i++; // PENTING: jangan lupa naikkan i, jika tidak -> infinite loop
  }
}

// ---------------------------------------------------------------------------
// 6. Enum dengan getter — pratonton corak SEBENAR yang dipakai dalam
//    projek/mypelajar_ln/lib/models/overseas_university.dart
// ---------------------------------------------------------------------------
enum StudyLevel {
  diploma,
  bachelor,
  master,
  doctorate;

  String get label => switch (this) {
        StudyLevel.diploma => 'Diploma',
        StudyLevel.bachelor => 'Ijazah Sarjana Muda',
        StudyLevel.master => 'Sarjana',
        StudyLevel.doctorate => 'Kedoktoran (PhD)',
      };
}

/// Status pengiktirafan kelayakan. Semakan sebenar melalui eSisraf (MQA).
enum RecognitionStatus {
  recognised,
  checkWithMqa;

  String get label => switch (this) {
        RecognitionStatus.recognised => 'Diiktiraf',
        RecognitionStatus.checkWithMqa => 'Semak dengan MQA',
      };
}

void enumDemo() {
  print('Semua peringkat pengajian (StudyLevel):');
  for (final level in StudyLevel.values) {
    print('  - ${level.name} => ${level.label}');
  }

  const statusAuckland = RecognitionStatus.checkWithMqa;
  const statusMelbourne = RecognitionStatus.recognised;
  print('University of Auckland: ${statusAuckland.label}');
  print('University of Melbourne: ${statusMelbourne.label}');
}

// ---------------------------------------------------------------------------
// 7. Function — tukar yuran mata wang asing kepada anggaran RM
// ---------------------------------------------------------------------------
/// Fungsi biasa dengan parameter positional — kadar tukaran ANGGARAN sahaja
/// untuk tujuan latihan, bukan kadar rasmi/semasa.
double convertTuitionToMyr(double amount, String currency) {
  const Map<String, double> kadarTukaranAnggaran = {
    'AUD': 3.0,
    'GBP': 6.0,
    'EGP': 0.093,
    'JOD': 6.55,
  };

  final double kadar = kadarTukaranAnggaran[currency] ?? 1.0;
  return amount * kadar;
}

void tuitionConversionDemo() {
  final List<Map<String, Object>> destinasi = [
    {'name': 'University of Melbourne', 'tuition': 52000.0, 'currency': 'AUD'},
    {'name': 'Imperial College London', 'tuition': 40700.0, 'currency': 'GBP'},
    {'name': 'Universiti Al-Azhar', 'tuition': 45000.0, 'currency': 'EGP'},
    {'name': 'University of Jordan', 'tuition': 4500.0, 'currency': 'JOD'},
  ];

  for (final uni in destinasi) {
    final name = uni['name'] as String;
    final tuition = uni['tuition'] as double;
    final currency = uni['currency'] as String;
    final rm = convertTuitionToMyr(tuition, currency);
    print('$name: $tuition $currency ≈ RM${rm.toStringAsFixed(0)}/tahun '
        '(anggaran)');
  }
}
