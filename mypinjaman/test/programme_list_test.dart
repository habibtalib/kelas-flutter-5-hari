import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:mypinjaman/screens/programme_list_screen.dart';
import 'package:mypinjaman/widgets/programme_card.dart';

void main() {
  setUpAll(() async => initializeDateFormatting('ms', null));

  testWidgets('loads (via fallback) then filters by search', (tester) async {
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(body: ProgrammeListScreen(onSubmitApplication: (_) {})),
    ));
    // Initial frame shows a spinner.
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    // Let the fetch/fallback complete (600ms fallback delay).
    await tester.pump(const Duration(seconds: 1));
    await tester.pumpAndSettle();

    expect(find.byType(ProgrammeCard), findsWidgets);
    final initial = tester.widgetList(find.byType(ProgrammeCard)).length;

    await tester.enterText(find.byType(TextField), 'Tanta');
    await tester.pumpAndSettle();
    final filtered = tester.widgetList(find.byType(ProgrammeCard)).length;
    expect(filtered, lessThan(initial));
    expect(filtered, greaterThan(0));
  });
}
