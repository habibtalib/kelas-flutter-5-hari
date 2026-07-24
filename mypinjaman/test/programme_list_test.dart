import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:mypinjaman/screens/programme_list_screen.dart';
import 'package:mypinjaman/widgets/programme_card.dart';

void main() {
  setUpAll(() async => initializeDateFormatting('ms', null));

  testWidgets('shows all offers, then filters by search', (tester) async {
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: ProgrammeListScreen(onSubmitApplication: (_) {}),
      ),
    ));
    expect(find.byType(ProgrammeCard), findsWidgets);
    final initial = tester.widgetList(find.byType(ProgrammeCard)).length;

    await tester.enterText(find.byType(TextField), 'Tanta');
    await tester.pumpAndSettle();
    final filtered = tester.widgetList(find.byType(ProgrammeCard)).length;
    expect(filtered, lessThan(initial));
    expect(filtered, greaterThan(0));
  });

  testWidgets('Maghribi chip filters to Morocco offers', (tester) async {
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: ProgrammeListScreen(onSubmitApplication: (_) {}),
      ),
    ));
    await tester.tap(find.text('Maghribi'));
    await tester.pumpAndSettle();
    expect(find.byType(ProgrammeCard), findsWidgets);
  });
}
