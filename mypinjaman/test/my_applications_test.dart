import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mypinjaman/models/application.dart';
import 'package:mypinjaman/models/programme.dart';
import 'package:mypinjaman/screens/my_applications_screen.dart';
import 'package:mypinjaman/widgets/status_badge.dart';

Application _sample() => Application(
      id: 'ETT-2026-0001',
      fullName: 'Siti Aminah',
      icNumber: '051231145678',
      email: 'siti@example.com',
      phoneNumber: '0123456789',
      academicCategory: EntryCategory.spm,
      academicSummary: 'SPM 2025 — 9A',
      country: 'Egypt',
      fieldOfStudy: 'Perubatan (Medicine)',
      universityChoiceIds: const ['ETT-001'],
      status: ApplicationStatus.submitted,
      submittedAt: DateTime(2026, 7, 24),
    );

void main() {
  testWidgets('empty state shown when no applications', (tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: Scaffold(body: MyApplicationsScreen(applications: [])),
    ));
    expect(find.textContaining('Belum ada permohonan'), findsOneWidget);
  });

  testWidgets('renders a record with its status badge', (tester) async {
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(body: MyApplicationsScreen(applications: [_sample()])),
    ));
    expect(find.text('Siti Aminah'), findsOneWidget);
    expect(find.byType(StatusBadge), findsOneWidget);
    expect(find.textContaining('ETT-2026-0001'), findsOneWidget);
  });
}
