import 'package:flutter/material.dart';

import '../data/sample_programmes.dart';
import '../models/application.dart';
import '../widgets/status_badge.dart';

/// Tab 2: rekod permohonan yang telah dihantar + statusnya.
class MyApplicationsScreen extends StatelessWidget {
  const MyApplicationsScreen({super.key, required this.applications});

  final List<Application> applications;

  @override
  Widget build(BuildContext context) {
    if (applications.isEmpty) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(32),
          child: Text(
            'Belum ada permohonan.\n'
            'Pilih satu tawaran dan tekan "Mohon Sekarang".',
            textAlign: TextAlign.center,
          ),
        ),
      );
    }
    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 8),
      itemCount: applications.length,
      itemBuilder: (_, i) {
        final app = applications[i];
        final choices =
            app.universityChoiceIds.map(_universityName).join(', ');
        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
          child: ListTile(
            title: Text(app.fullName,
                style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('${app.fieldOfStudy} · ${app.countryLabel}'),
                Text('Pilihan: $choices',
                    style: const TextStyle(fontSize: 12)),
                Text('No. Rujukan: ${app.id}',
                    style: const TextStyle(fontSize: 12)),
              ],
            ),
            trailing: StatusBadge(status: app.status),
            isThreeLine: true,
          ),
        );
      },
    );
  }

  String _universityName(String id) {
    final match = sampleProgrammes.where((p) => p.id == id);
    return match.isEmpty ? id : match.first.universityName;
  }
}
