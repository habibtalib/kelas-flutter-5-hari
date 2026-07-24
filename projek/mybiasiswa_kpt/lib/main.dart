import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';

import 'providers/application_provider.dart';
import 'providers/profile_provider.dart';
import 'providers/scholarship_provider.dart';
import 'screens/home_screen.dart';
import 'screens/login_screen.dart';
import 'theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Muatkan data locale untuk format tarikh/nombor Bahasa Melayu.
  await initializeDateFormatting('ms', null);
  runApp(const MyBiasiswaApp());
}

class MyBiasiswaApp extends StatelessWidget {
  const MyBiasiswaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ScholarshipProvider()..load(),
        ),
        ChangeNotifierProvider(
          create: (_) => ApplicationProvider()..loadFromStorage(),
        ),
        ChangeNotifierProvider(
          create: (_) => ProfileProvider()..loadFromStorage(),
        ),
      ],
      child: MaterialApp(
        title: 'MyBiasiswa KPT',
        debugShowCheckedModeBanner: false,
        theme: KptTheme.light,
        home: const _Gate(),
      ),
    );
  }
}

/// Menentukan skrin permulaan: login jika belum log masuk, jika tidak Home.
class _Gate extends StatelessWidget {
  const _Gate();

  @override
  Widget build(BuildContext context) {
    final loggedIn = context.watch<ProfileProvider>().isLoggedIn;
    return loggedIn ? const HomeScreen() : const LoginScreen();
  }
}
