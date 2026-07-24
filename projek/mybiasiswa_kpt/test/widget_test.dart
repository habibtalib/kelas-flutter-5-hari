// Ujian widget asas untuk MyBiasiswa KPT.
//
// Mengesahkan skrin log masuk dipaparkan pada permulaan aplikasi.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

import 'package:mybiasiswa_kpt/providers/profile_provider.dart';
import 'package:mybiasiswa_kpt/screens/login_screen.dart';

void main() {
  testWidgets('Login screen shows app title', (WidgetTester tester) async {
    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (_) => ProfileProvider(),
        child: const MaterialApp(home: LoginScreen()),
      ),
    );

    expect(find.text('MyBiasiswa KPT'), findsOneWidget);
    expect(find.text('Log Masuk'), findsOneWidget);
  });
}
