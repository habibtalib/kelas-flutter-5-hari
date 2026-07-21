// ══════════════════════════════════════════════════════════════════
// DEMO SNIPPET — Bahagian 8.2  `ListTile` (+ Card + ListTile)
//
// Fail BERDIRI SENDIRI. Tiada model / pakej luar diperlukan.
// Cara jalankan:
//   1. Salin fail ini ke  lib/listtile_demo.dart  dalam projek Flutter anda
//   2. flutter run -t lib/listtile_demo.dart
//
// Tujuan: lihat SETIAP parameter ListTile (leading/title/subtitle/trailing/
// onTap) hidup, dan corak `Card + ListTile` yang biasa dalam eTT Mobile.
// ══════════════════════════════════════════════════════════════════
import 'package:flutter/material.dart';

const Color kNavy = Color(0xFF1A2B5C); // KptTheme.navy
const Color kGold = Color(0xFFD4A017); // KptTheme.gold

void main() => runApp(const ListTileDemoApp());

class ListTileDemoApp extends StatelessWidget {
  const ListTileDemoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Demo ListTile',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: kNavy, primary: kNavy),
        appBarTheme: const AppBarTheme(
          backgroundColor: kNavy,
          foregroundColor: Colors.white,
        ),
      ),
      home: const ListTileDemoScreen(),
    );
  }
}

class ListTileDemoScreen extends StatefulWidget {
  const ListTileDemoScreen({super.key});

  @override
  State<ListTileDemoScreen> createState() => _ListTileDemoScreenState();
}

class _ListTileDemoScreenState extends State<ListTileDemoScreen> {
  // Untuk demo `trailing` interaktif (Switch) — Bahagian 8.2.
  bool _terimaMakluman = true;

  // Data ringkas untuk corak collection-for (sama seperti _CountryDrawer).
  static const _universiti = [
    ('🇪🇬', 'Universiti Al-Azhar', 'Kaherah, Mesir'),
    ('🇪🇬', 'Universiti Alexandria', 'Iskandariah, Mesir'),
    ('🇲🇦', 'Universite Al Quaraouiyine', 'Fes, Maghribi'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Demo · ListTile')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _banner(
            'ListTile = baris siap pakai: leading | title + subtitle | trailing. '
            'Semua jarak & saiz fon ikut garis panduan Material secara automatik.',
          ),
          const SizedBox(height: 16),

          // ── 1. ListTile ASAS — setiap parameter ──────────────────
          _tajuk('1. ListTile asas (4 parameter + onTap)'),
          Card(
            child: ListTile(
              leading: const Icon(Icons.school_outlined, color: kNavy),
              title: const Text('Universiti Al-Azhar'),
              subtitle: const Text('Kaherah (Cairo), Mesir'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => _snack('Baris ditekan (onTap) — navigasi sebenar Hari 3'),
            ),
          ),
          const SizedBox(height: 20),

          // ── 2. Variasi leading & trailing ────────────────────────
          _tajuk('2. Variasi leading (CircleAvatar) & trailing (Switch)'),
          Card(
            child: Column(
              children: [
                ListTile(
                  leading: const CircleAvatar(
                    backgroundColor: kNavy,
                    child: Text('AA', style: TextStyle(color: Colors.white)),
                  ),
                  title: const Text('Universiti Ain Shams'),
                  subtitle: const Text('Perubatan · Ambilan Oktober'),
                  trailing: const Text('40 tempat'),
                ),
                const Divider(height: 1),
                // `trailing` boleh widget interaktif — Switch dengan setState.
                SwitchListTile(
                  secondary: const Icon(Icons.notifications_outlined,
                      color: kNavy),
                  title: const Text('Terima makluman status'),
                  subtitle: const Text('Beritahu bila keputusan LAYAK keluar'),
                  activeTrackColor: kGold,
                  value: _terimaMakluman,
                  onChanged: (v) => setState(() => _terimaMakluman = v),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // ── 3. Card + ListTile (corak eTT Mobile) ────────────────
          _tajuk('3. Senarai: satu Card + ListTile bagi setiap rekod'),
          // Corak collection-for — sama seperti _CountryDrawer (Bahagian 5.2).
          for (final (bendera, nama, lokasi) in _universiti)
            Card(
              margin: const EdgeInsets.symmetric(vertical: 6),
              child: ListTile(
                leading: Text(bendera, style: const TextStyle(fontSize: 28)),
                title: Text(nama, overflow: TextOverflow.ellipsis),
                subtitle: Text(lokasi),
                trailing: const Icon(Icons.chevron_right),
                onTap: () => _snack('$nama ditekan'),
              ),
            ),

          const SizedBox(height: 20),

          // ── 4. Banding: bina baris yang SAMA secara manual (Row) ──
          _tajuk('4. Tanpa ListTile — Row manual (lebih banyak kod)'),
          Card(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                children: [
                  const Icon(Icons.school_outlined, color: kNavy),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text('Universiti Mansoura'),
                        SizedBox(height: 4),
                        Text(
                          'Farmasi · Ambilan September',
                          style: TextStyle(fontSize: 12, color: Colors.black54),
                        ),
                      ],
                    ),
                  ),
                  const Icon(Icons.chevron_right),
                ],
              ),
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Bandingkan blok 3 (ListTile) vs 4 (Row manual): hasil hampir sama, '
            'tetapi ListTile jauh lebih ringkas dan konsisten.',
            style: TextStyle(fontSize: 12, color: Colors.black54),
          ),
        ],
      ),
    );
  }

  void _snack(String msg) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(msg)));
  }

  Widget _tajuk(String text) => Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Text(
          text,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: kNavy,
            fontSize: 15,
          ),
        ),
      );

  Widget _banner(String text) => Container(
        width: double.infinity,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: kGold.withValues(alpha: 0.12),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: kGold.withValues(alpha: 0.4)),
        ),
        child: Text(text, style: const TextStyle(fontSize: 13, height: 1.4)),
      );
}
