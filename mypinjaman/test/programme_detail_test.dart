import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mypinjaman/data/sample_programmes.dart';
import 'package:mypinjaman/screens/programme_detail_screen.dart';

void main() {
  testWidgets('detail shows kelayakan/kos/ambilan/kuota and apply button', (tester) async {
    final p = sampleProgrammes.first;
    await tester.pumpWidget(MaterialApp(
      home: ProgrammeDetailScreen(programme: p, onSubmit: (_) {}),
    ));
    expect(find.text(p.universityName), findsWidgets);
    expect(find.text('Kelayakan'), findsOneWidget);
    expect(find.text('Kuota'), findsOneWidget);
    expect(find.text('Ambilan'), findsOneWidget);
    expect(find.text('Mohon Sekarang'), findsOneWidget);
  });
}
