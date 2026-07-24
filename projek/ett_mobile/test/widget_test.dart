// Ujian untuk eTT Mobile.
//
// Mengesahkan (1) senarai program memaparkan data daripada API (mock) dan
// carian menapis senarai, (2) badge status memaparkan label BM, dan (3) data
// `mock-api/programmes.json` berjaya dihurai menerusi Programme.fromJson.

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';

import 'package:ett_mobile/data/sample_programmes.dart';
import 'package:ett_mobile/models/application.dart';
import 'package:ett_mobile/models/programme.dart';
import 'package:ett_mobile/providers/application_provider.dart';
import 'package:ett_mobile/providers/programme_provider.dart';
import 'package:ett_mobile/screens/programme_list_screen.dart';
import 'package:ett_mobile/services/programme_service.dart';
import 'package:ett_mobile/widgets/programme_card.dart';
import 'package:ett_mobile/widgets/status_badge.dart';

/// Klien HTTP palsu yang memulangkan data contoh sebagai respons JSON 200.
/// Ini menguji laluan sebenar: HTTP → jsonDecode → Programme.fromJson.
http.Client _fakeClient() {
  return MockClient((request) async {
    final body = jsonEncode(sampleProgrammes.map((p) => p.toJson()).toList());
    return http.Response(
      body,
      200,
      headers: {'content-type': 'application/json'},
    );
  });
}

ProgrammeProvider _providerWithFakeApi() => ProgrammeProvider(
      service: ProgrammeService(client: _fakeClient()),
    );

Widget _wrap(Widget child, ProgrammeProvider provider) {
  return MultiProvider(
    providers: [
      ChangeNotifierProvider<ProgrammeProvider>.value(value: provider),
      ChangeNotifierProvider(create: (_) => ApplicationProvider()),
    ],
    child: MaterialApp(home: Scaffold(body: child)),
  );
}

void main() {
  setUpAll(() async {
    await initializeDateFormatting('ms', null);
  });

  testWidgets('Senarai program memaparkan tawaran daripada API',
      (WidgetTester tester) async {
    final provider = _providerWithFakeApi();

    await tester.pumpWidget(_wrap(const ProgrammeListScreen(), provider));

    // Sebelum data dimuat: penunjuk memuat (loading) dipaparkan.
    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    await provider.load();
    await tester.pumpAndSettle();

    // Kesemua 8 tawaran berjaya dihurai daripada JSON API.
    expect(provider.programmes.length, 8);
    // ListView.builder membina kad secara malas (lazy) — hanya kad yang
    // kelihatan (di bahagian atas) wujud dalam pokok widget.
    expect(find.byType(ProgrammeCard), findsWidgets);
    expect(find.text('Syariah dan Undang-undang'), findsOneWidget);
    expect(find.byType(CircularProgressIndicator), findsNothing);
  });

  testWidgets('Carian menapis senarai program', (WidgetTester tester) async {
    final provider = _providerWithFakeApi();

    await tester.pumpWidget(_wrap(const ProgrammeListScreen(), provider));
    await provider.load();
    await tester.pumpAndSettle();

    expect(find.text('Syariah dan Undang-undang'), findsOneWidget);

    await tester.enterText(find.byType(TextField), 'Tanta');
    await tester.pumpAndSettle();

    expect(find.text('Universiti Tanta'), findsOneWidget);
    expect(find.text('Syariah dan Undang-undang'), findsNothing);
    expect(find.byType(ProgrammeCard), findsOneWidget);
  });

  testWidgets('StatusBadge memaparkan label Bahasa Melayu',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(body: StatusBadge(status: ApplicationStatus.eligible)),
      ),
    );

    expect(find.text('Layak'), findsOneWidget);
  });

  test('mock-api/programmes.json dihurai menerusi Programme.fromJson', () {
    // Fail JSON dijana daripada toJson model — uji ia berjaya dibaca semula
    // supaya kod hari-4 (JSON → model) sepadan dengan data sebenar.
    final file = File('../mock-api/programmes.json');
    expect(file.existsSync(), isTrue,
        reason: 'programmes.json sepatutnya wujud di projek/mock-api/');

    final data = jsonDecode(file.readAsStringSync()) as List<dynamic>;
    final programmes = data
        .map((e) => Programme.fromJson(e as Map<String, dynamic>))
        .toList();

    expect(programmes.length, 8);
    // Round-trip: JSON fail sepadan dengan data contoh dalam aplikasi.
    expect(programmes.first.id, 'ETT-001');
    expect(programmes.first.universityName, 'Universiti Al-Azhar');
    expect(programmes.first.category, EntryCategory.spm);
    for (var i = 0; i < programmes.length; i++) {
      expect(programmes[i].toJson(), sampleProgrammes[i].toJson());
    }
  });
}
