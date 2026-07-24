// ============================================================================
// eTT Mobile — Companion Latihan Sistem e-Timur Tengah (KPT)
//
// e-Timur Tengah (eTT) ialah sistem Bahagian Pengantarabangsaan Pendidikan
// Tinggi (BPPT), Jabatan Pendidikan Tinggi (JPT), Kementerian Pendidikan
// Tinggi (KPT) — untuk pelajar Malaysia memohon ke universiti di Mesir &
// Maghribi (Morocco).
// ============================================================================

import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';

import 'providers/application_provider.dart';
import 'providers/profile_provider.dart';
import 'providers/programme_provider.dart';
import 'screens/home_screen.dart';
import 'theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Muatkan data locale untuk format tarikh/nombor Bahasa Melayu.
  await initializeDateFormatting('ms', null);
  runApp(const EttMobileApp());
}

class EttMobileApp extends StatelessWidget {
  const EttMobileApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ProgrammeProvider()..load(),
        ),
        ChangeNotifierProvider(
          create: (_) => ApplicationProvider()..loadFromStorage(),
        ),
        ChangeNotifierProvider(
          create: (_) => ProfileProvider()..loadFromStorage(),
        ),
      ],
      child: MaterialApp(
        title: 'eTT Mobile — Latihan',
        debugShowCheckedModeBanner: false,
        theme: KptTheme.light,
        home: const HomeScreen(),
      ),
    );
  }
}
