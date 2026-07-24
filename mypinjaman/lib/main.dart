// ============================================================================
// eTT Mobile — companion latihan Sistem e-Timur Tengah (KPT).
// Bahan latihan sahaja — BUKAN sistem rasmi.
// ============================================================================

import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'screens/home_screen.dart';
import 'theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Muatkan data locale Bahasa Melayu untuk format nombor/tarikh.
  await initializeDateFormatting('ms', null);
  runApp(const EttMobileApp());
}

class EttMobileApp extends StatelessWidget {
  const EttMobileApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'eTT Mobile',
      debugShowCheckedModeBanner: false,
      theme: KptTheme.light,
      home: const HomeScreen(),
    );
  }
}
