# Nota Konsep: Pengurusan Keadaan (State Management)

> "State" ialah **data yang boleh berubah** semasa aplikasi berjalan (cth. senarai pendaftaran, teks carian). Nota ini menerangkan pilihan pengurusan state dalam Flutter.

Kursus ini bermula dengan **`setState()`** (SESI 5, Hari 3 — lihat [`../JADUAL.md`](../JADUAL.md)), pendekatan paling asas dan mencukupi untuk projek mini 5 hari ini. Nota ini teruskan perjalanan itu: bagaimana pendekatan yang sama berkembang kepada `provider` apabila state perlu dikongsi antara banyak skrin, dan ke mana ia menuju seterusnya (Riverpod) apabila aplikasi membesar. Aplikasi rujukan [`projek/ett_mobile`](../projek/ett_mobile/) menggunakan `provider` sebagai contoh corak tersebut.

---

## Apa itu "state"?

- **State** = maklumat yang UI perlu tahu untuk melukis dirinya, dan yang boleh berubah.
- Contoh dalam projek eTT Mobile: senarai program yang dimuat, permohonan yang dihantar, teks carian, tapisan negara (Mesir/Maghribi).
- Bila state berubah → UI perlu **dibina semula (rebuild)** untuk cerminkan perubahan.

---

## 1. `setState` — state tempatan (built-in)

Cara paling asas. Sesuai untuk state **dalam satu widget** sahaja.

```dart
class Kaunter extends StatefulWidget {
  const Kaunter({super.key});
  @override
  State<Kaunter> createState() => _KaunterState();
}

class _KaunterState extends State<Kaunter> {
  int _nilai = 0;   // <-- state

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('$_nilai'),
        ElevatedButton(
          onPressed: () => setState(() => _nilai++),  // rebuild widget ini
          child: const Text('Tambah'),
        ),
      ],
    );
  }
}
```

**Had:** susah kongsi state antara **banyak** skrin (cth. permohonan perlu dilihat di tab "Permohonan Saya" **dan** dikira di "Profil").

---

## 2. `provider` + `ChangeNotifier` — state dikongsi

Bila banyak skrin perlu **state yang sama**, kita angkat state ke satu kelas `ChangeNotifier` dan sediakan melalui pokok widget.

**Langkah 1 — Kelas state:**

```dart
class ApplicationProvider extends ChangeNotifier {
  final List<Application> _items = [];
  List<Application> get applications => List.unmodifiable(_items);

  void add(Application application) {
    _items.insert(0, application);
    notifyListeners();   // <-- beritahu semua pendengar (UI) untuk rebuild
  }
}
```

**Langkah 2 — Sediakan di atas pokok widget:**

```dart
ChangeNotifierProvider(
  create: (_) => ApplicationProvider(),
  child: MyApp(),
)
```

**Langkah 3 — Guna dalam UI:**

```dart
// Baca + dengar perubahan (rebuild bila berubah)
final apps = context.watch<ApplicationProvider>().applications;

// Baca sekali sahaja tanpa dengar (cth. dalam onPressed)
context.read<ApplicationProvider>().add(app);
```

| Method | Guna bila |
|--------|-----------|
| `context.watch<T>()` | Dalam `build()` — dengar & rebuild bila state berubah |
| `context.read<T>()` | Dalam pengendali (onPressed, initState) — baca sekali |
| `Consumer<T>(builder: ...)` | Rebuild sebahagian kecil UI sahaja (optimum) |

---

## 3. Pilihan lain (sedar, tak wajib untuk pemula)

| Pilihan | Ringkasan |
|---------|-----------|
| **Riverpod** | "Provider generasi baharu" — lebih selamat jenis, tak perlu `BuildContext`. Popular untuk projek besar. |
| **Bloc / Cubit** | Corak berasaskan aliran peristiwa (event → state). Struktur ketat, sesuai pasukan besar. |
| **GetX** | Ringkas, banyak ciri (state + route + DI). Mudah tetapi kurang "idiomatik". |
| **InheritedWidget** | Mekanisme asas Flutter di sebalik provider. Jarang guna terus. |

> **Cadangan pembelajaran:** Mula dengan **`setState`** untuk state dalam satu widget → naik ke **`provider`** bila state perlu dikongsi antara banyak skrin → terokai **Riverpod** bila projek membesar.

---

## Peraturan mudah memilih

```
State hanya dalam 1 widget?            → setState
State dikongsi beberapa skrin?          → provider / Riverpod
Aplikasi besar, banyak logik & pasukan? → Bloc / Riverpod
```

---

Seterusnya: [`06-package-pub-dev.md`](./06-package-pub-dev.md) — cara guna pakej dari pub.dev.
