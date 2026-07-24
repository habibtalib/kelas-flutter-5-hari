import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:mypinjaman/screens/home_screen.dart';
import 'package:mypinjaman/widgets/programme_card.dart';
import 'package:mypinjaman/widgets/status_badge.dart';

void main() {
  setUpAll(() async => initializeDateFormatting('ms', null));

  testWidgets('offer → detail → form → submit lands on Permohonan Saya', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: HomeScreen()));
    await tester.pump(const Duration(seconds: 1));
    await tester.pumpAndSettle();

    // Empty tab 2 initially.
    // Open first offer.
    await tester.tap(find.byType(ProgrammeCard).first);
    await tester.pumpAndSettle();

    // Detail → apply.
    await tester.tap(find.text('Mohon Sekarang'));
    await tester.pumpAndSettle();

    // Fill the form.
    final fields = find.byType(TextFormField);
    await tester.enterText(fields.at(0), 'Ahmad bin Ali');
    await tester.enterText(fields.at(1), '051231-14-5678');
    await tester.enterText(fields.at(2), 'ahmad@example.com');
    await tester.enterText(fields.at(3), '0123456789');
    await tester.enterText(fields.at(4), 'SPM 2025 — 9A');
    await tester.ensureVisible(find.text('Hantar Permohonan'));
    await tester.tap(find.text('Hantar Permohonan'));
    await tester.pumpAndSettle();

    // We should now be on tab 2 with the new record.
    expect(find.text('Ahmad bin Ali'), findsOneWidget);
    expect(find.byType(StatusBadge), findsOneWidget);
    expect(find.textContaining('ETT-'), findsOneWidget);
  });
}
