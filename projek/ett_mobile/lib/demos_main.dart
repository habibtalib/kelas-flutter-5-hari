// ============================================================================
// Galeri Demo eTT Mobile — titik masuk BERASINGAN untuk demo interaktif.
//
// Ini BUKAN aplikasi eTT Mobile sebenar (itu lib/main.dart). Fail ini
// melancarkan "Galeri Demo": satu menu demo interaktif untuk setiap konsep
// Hari 2–5, supaya jurulatih/pelajar boleh tunjuk & lihat konsep berfungsi
// secara langsung pada telefon.
//
// Jalankan:
//   flutter run -t lib/demos_main.dart
// ============================================================================

import 'package:flutter/material.dart';

import 'demos/demo_gallery.dart';
import 'theme.dart';

void main() {
  runApp(const DemoGalleryApp());
}

class DemoGalleryApp extends StatelessWidget {
  const DemoGalleryApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Galeri Demo — eTT Mobile',
      debugShowCheckedModeBanner: false,
      theme: KptTheme.light,
      home: const DemoGallery(),
    );
  }
}
