import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mypinjaman/data/sample_programmes.dart';
import 'package:mypinjaman/models/application.dart';
import 'package:mypinjaman/screens/application_form_screen.dart';

void main() {
  testWidgets('valid submit calls onSubmit with a submitted application', (tester) async {
    Application? captured;
    final programme = sampleProgrammes.first;

    await tester.pumpWidget(MaterialApp(
      home: ApplicationFormScreen(
        programme: programme,
        onSubmit: (app) => captured = app,
      ),
    ));

    final fields = find.byType(TextFormField);
    await tester.enterText(fields.at(0), 'Ahmad bin Ali');
    await tester.enterText(fields.at(1), '051231-14-5678');
    await tester.enterText(fields.at(2), 'ahmad@example.com');
    await tester.enterText(fields.at(3), '0123456789');
    await tester.enterText(fields.at(4), 'SPM 2025 — 9A');

    await tester.ensureVisible(find.text('Hantar Permohonan'));
    await tester.tap(find.text('Hantar Permohonan'));
    await tester.pumpAndSettle();

    expect(captured, isNotNull);
    expect(captured!.fullName, 'Ahmad bin Ali');
    expect(captured!.icNumber, '051231145678'); // dashes stripped
    expect(captured!.status, ApplicationStatus.submitted);
    expect(captured!.universityChoiceIds, contains(programme.id));
  });

  testWidgets('invalid IC blocks submit', (tester) async {
    Application? captured;
    await tester.pumpWidget(MaterialApp(
      home: ApplicationFormScreen(
        programme: sampleProgrammes.first,
        onSubmit: (app) => captured = app,
      ),
    ));
    final fields = find.byType(TextFormField);
    await tester.enterText(fields.at(0), 'Ahmad');
    await tester.enterText(fields.at(1), '123'); // too short
    await tester.enterText(fields.at(2), 'ahmad@example.com');
    await tester.enterText(fields.at(3), '0123456789');
    await tester.enterText(fields.at(4), '9A');
    await tester.ensureVisible(find.text('Hantar Permohonan'));
    await tester.tap(find.text('Hantar Permohonan'));
    await tester.pumpAndSettle();
    expect(captured, isNull);
    expect(find.text('No. KP mesti 12 digit'), findsOneWidget);
  });
}
