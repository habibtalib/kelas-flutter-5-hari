import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../models/application.dart';
import '../providers/application_provider.dart';
import '../providers/programme_provider.dart';
import '../theme.dart';
import '../widgets/status_badge.dart';

/// Skrin "Permohonan Saya" — senarai permohonan dengan badge status.
class MyApplicationsScreen extends StatelessWidget {
  const MyApplicationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final applications = context.watch<ApplicationProvider>().applications;

    if (applications.isEmpty) {
      return const Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.inbox_outlined, size: 56, color: Colors.grey),
            SizedBox(height: 12),
            Text('Belum ada permohonan.'),
            SizedBox(height: 4),
            Text(
              'Pilih program dan tekan "Mohon".',
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: applications.length,
      separatorBuilder: (_, __) => const SizedBox(height: 10),
      itemBuilder: (context, index) =>
          _ApplicationTile(application: applications[index]),
    );
  }
}

class _ApplicationTile extends StatelessWidget {
  const _ApplicationTile({required this.application});

  final Application application;

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ProgrammeProvider>();

    // Selesaikan nama universiti pilihan daripada id (data ada di
    // ProgrammeProvider — permohonan hanya menyimpan universityChoiceIds).
    final choices = application.universityChoiceIds
        .map((id) => provider.byId(id)?.universityName ?? id)
        .toList();

    final tarikh = application.submittedAt == null
        ? '-'
        : DateFormat('d MMM yyyy, h:mm a', 'ms')
            .format(application.submittedAt!);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    '${application.countryLabel} · ${application.fieldOfStudy}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: KptTheme.navy,
                    ),
                  ),
                ),
                StatusBadge(status: application.status),
              ],
            ),
            const SizedBox(height: 6),
            _line('No. Rujukan: ${application.id}'),
            _line('Pemohon: ${application.fullName} '
                '(${application.academicCategory.label})'),
            for (var i = 0; i < choices.length; i++)
              _line('Pilihan ${i + 1}: ${choices[i]}'),
            _line('Dihantar: $tarikh'),
            const Divider(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Simulasi kemas kini status — dalam sistem sebenar status
                // dikawal oleh pihak BPPT/eTT (LAYAK/TIDAK LAYAK dsb.).
                TextButton.icon(
                  onPressed: () => _showStatusPicker(context),
                  icon: const Icon(Icons.update, size: 18),
                  label: const Text('Kemas Kini Status'),
                ),
                IconButton(
                  onPressed: () => context
                      .read<ApplicationProvider>()
                      .remove(application.id),
                  icon: const Icon(Icons.delete_outline, color: Colors.red),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _line(String text) => Padding(
        padding: const EdgeInsets.only(top: 2),
        child: Text(
          text,
          style: const TextStyle(color: Colors.black54, fontSize: 13),
        ),
      );

  void _showStatusPicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (sheetContext) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                'Pilih Status',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            for (final status in ApplicationStatus.values)
              ListTile(
                leading: Icon(Icons.circle, color: status.color, size: 14),
                title: Text(status.label),
                onTap: () {
                  context
                      .read<ApplicationProvider>()
                      .updateStatus(application.id, status);
                  Navigator.of(sheetContext).pop();
                },
              ),
          ],
        ),
      ),
    );
  }
}
