# Nota Konsep: Asas Bahasa Dart

> Flutter ditulis dalam **Dart**. Nota ini merangkumi asas Dart yang cukup untuk mula membina widget pada Hari 1. Kekalkan **istilah teknikal** & nama pembolehubah dalam **Bahasa Inggeris**.

---

## Kenapa Dart?

- Direka Google, **mudah dipelajari** jika anda pernah guna JavaScript, Java, C#, atau Kotlin.
- **Ditaip kuat (strongly typed)** tetapi ada `var` untuk inferens jenis.
- Kompil ke **kod mesin asli (AOT)** untuk keluaran → pantas; dan **JIT** semasa pembangunan → membolehkan **Hot Reload**.
- **Null safety** — mengelakkan ralat *null* yang biasa.

Cuba di pelayar tanpa pasang apa-apa: [dartpad.dev](https://dartpad.dev)

---

## 1. Pembolehubah & Jenis (Variables & Types)

```dart
// Jenis eksplisit
String nama = 'Ali';
int umur = 21;
double cgpa = 3.75;
bool aktif = true;

// Inferens jenis dengan var
var negeri = 'Selangor';       // String
var jumlah = 1500;             // int

// Pemalar (constants)
const double kadarZakat = 0.025;   // pemalar masa kompil
final tarikh = DateTime.now();     // pemalar masa larian (runtime)
```

- `const` — nilai diketahui semasa **kompil** (tak boleh berubah).
- `final` — ditetapkan **sekali** semasa larian, kemudian tak boleh berubah.

---

## 2. Null Safety

Secara lalai pembolehubah **tidak boleh** `null`. Tambah `?` untuk benarkan `null`:

```dart
String nama = 'Ali';       // tak boleh null
String? gelaran;           // boleh null (lalai: null)

// Operator berguna
gelaran ??= 'Encik';                 // tetapkan jika null
String papar = gelaran ?? 'Tiada';   // guna nilai lalai jika null
int panjang = gelaran?.length ?? 0;  // akses selamat + lalai
```

---

## 3. String & Interpolasi

```dart
String nama = 'Aminah';
int mata = 90;

print('Pelajar $nama mendapat $mata markah');
print('Peratus: ${mata / 100 * 100}%');   // guna ${} untuk ungkapan

// String pelbagai baris
String alamat = '''
No 12, Jalan Universiti
50603 Kuala Lumpur
''';
```

---

## 4. Koleksi: List & Map

```dart
// List (senarai)
List<String> universitiMesir = ['Al-Azhar', 'Alexandria', 'Ain Shams', 'Tanta'];
universitiMesir.add('Mansoura');
print(universitiMesir[0]);          // Al-Azhar
print(universitiMesir.length);      // 5

// Map (pasangan kunci-nilai) — seperti objek JSON
Map<String, dynamic> pelajar = {
  'nama': 'Ali',
  'cgpa': 3.75,
  'aktif': true,
};
print(pelajar['nama']);  // Ali
```

---

## 5. Fungsi (Functions)

```dart
// Fungsi biasa
int tambah(int a, int b) {
  return a + b;
}

// Arrow function (satu baris)
int darab(int a, int b) => a * b;

// Parameter bernama (banyak digunakan dalam Flutter!)
String salam({required String nama, String gelaran = 'Encik'}) {
  return 'Selamat datang, $gelaran $nama';
}

void main() {
  print(salam(nama: 'Ali'));                 // Selamat datang, Encik Ali
  print(salam(nama: 'Siti', gelaran: 'Puan')); // Selamat datang, Puan Siti
}
```

> **Penting:** Corak `{required ... , ... = default}` inilah yang anda akan nampak di **setiap widget Flutter** (cth. `Text(..., style: ...)`).

---

## 6. Kawalan Aliran (Control Flow)

```dart
// if / else
if (cgpa >= 3.5) {
  print('Dekan');
} else if (cgpa >= 2.0) {
  print('Lulus');
} else {
  print('Percubaan');
}

// for
for (var i = 0; i < universitiMesir.length; i++) { print(universitiMesir[i]); }
for (final u in universitiMesir) { print(u); }          // for-in

// switch
switch (status) {
  case 'Baharu': print('Permohonan baharu'); break;
  default: print('Status lain');
}

// Ungkapan bersyarat
String label = aktif ? 'Aktif' : 'Tidak aktif';
```

---

## 7. Kelas & Objek (Classes) — asas model data

```dart
class Programme {
  final String universityName;
  final String fieldOfStudy;
  final double estimatedAnnualCostMyr;

  // Constructor dengan parameter bernama
  Programme({
    required this.universityName,
    required this.fieldOfStudy,
    this.estimatedAnnualCostMyr = 0,
  });

  // Method
  String summary() =>
      '$universityName, $fieldOfStudy (RM${estimatedAnnualCostMyr.toStringAsFixed(2)}/tahun)';

  // Factory dari JSON (banyak digunakan bila sambung API — Hari 4)
  factory Programme.fromJson(Map<String, dynamic> json) {
    return Programme(
      universityName: json['universityName'] as String,
      fieldOfStudy: json['fieldOfStudy'] as String,
      estimatedAnnualCostMyr:
          (json['estimatedAnnualCostMyr'] as num?)?.toDouble() ?? 0,
    );
  }
}

void main() {
  final p = Programme(
    universityName: 'Universiti Al-Azhar',
    fieldOfStudy: 'Perubatan (Medicine)',
    estimatedAnnualCostMyr: 23000,
  );
  print(p.summary());
  // Universiti Al-Azhar, Perubatan (Medicine) (RM23000.00/tahun)
}
```

> Ini versi ringkas untuk belajar. Model **sebenar** projek (`Programme`) ada lebih banyak medan & enum — lihat [`../projek/ett_mobile/lib/models/programme.dart`](../projek/ett_mobile/lib/models/programme.dart).

---

## 8. Async / Await (untuk API & fail — didalami Hari 4)

```dart
Future<String> ambilData() async {
  await Future.delayed(Duration(seconds: 2));   // simulasi rangkaian
  return 'Data siap';
}

void main() async {
  print('Mula...');
  String hasil = await ambilData();   // tunggu tanpa sekat UI
  print(hasil);
}
```

- `Future<T>` — nilai yang **akan** sedia kemudian.
- `async` menanda fungsi tak segerak; `await` menunggu `Future` selesai.

---

## Ringkasan cepat

| Konsep | Kata kunci |
|--------|-----------|
| Pembolehubah | `var`, `final`, `const` |
| Boleh null | `String?`, `??`, `?.` |
| Fungsi bernama | `{required ..., ... = lalai}` |
| Koleksi | `List<T>`, `Map<K,V>` |
| Kelas | `class`, `factory`, `this` |
| Tak segerak | `Future`, `async`, `await` |

Seterusnya: mula tulis widget pertama di [`../hari-1/README.md`](../hari-1/). Untuk pembezaan dengan rangka kerja lain: [`03-flutter-vs-lain.md`](./03-flutter-vs-lain.md).

---

## Sumber Rasmi

- **[dart.dev](https://dart.dev)** — laman **dokumentasi rasmi** bahasa Dart (panduan, rujukan pustaka, tutorial).
- **[dartpad.dev](https://dartpad.dev)** — cuba Dart/Flutter dalam pelayar tanpa pemasangan.
- **Flutter di YouTube** — siri **"Widget of the Week"** & ceramah rasmi pasukan Flutter.
