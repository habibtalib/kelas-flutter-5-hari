import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../models/application.dart';
import '../providers/application_provider.dart';
import '../theme.dart';
import '../widgets/status_badge.dart';

/// Skrin "Permohonan Saya" (Hari 3) — senarai permohonan dengan badge status.
class MyApplicationsScreen extends StatelessWidget {
  const MyApplicationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final apps = context.watch<ApplicationProvider>().applications;

    if (apps.isEmpty) {
      return const Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.inbox_outlined, size: 56, color: Colors.grey),
            SizedBox(height: 12),
            Text('Belum ada permohonan.'),
            SizedBox(height: 4),
            Text(
              'Pilih biasiswa dan tekan "Mohon Sekarang".',
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: apps.length,
      separatorBuilder: (_, __) => const SizedBox(height: 10),
      itemBuilder: (context, index) => _AppTile(app: apps[index]),
    );
  }
}

class _AppTile extends StatelessWidget {
  const _AppTile({required this.app});
  final ScholarshipApplication app;

  @override
  Widget build(BuildContext context) {
    final tarikh = app.submittedAt == null
        ? '-'
        : DateFormat('d MMM yyyy, h:mm a', 'ms').format(app.submittedAt!);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    app.scholarshipName,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: KptTheme.navy,
                    ),
                  ),
                ),
                StatusBadge(status: app.status),
              ],
            ),
            const SizedBox(height: 6),
            Text('No. Rujukan: ${app.id}', style: TextStyle(color: Colors.grey[700], fontSize: 13)),
            Text('Dihantar: $tarikh', style: TextStyle(color: Colors.grey[700], fontSize: 13)),
            const Divider(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Simulasi kemas kini status (Hari 4) — dalam sistem sebenar
                // status dikawal oleh pihak penilai.
                TextButton.icon(
                  onPressed: () => _showStatusPicker(context),
                  icon: const Icon(Icons.update, size: 18),
                  label: const Text('Kemas Kini Status'),
                ),
                IconButton(
                  onPressed: () => context
                      .read<ApplicationProvider>()
                      .remove(app.id),
                  icon: const Icon(Icons.delete_outline, color: Colors.red),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showStatusPicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (sheetContext) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Padding(
              padding: EdgeInsets.all(16),
              child: Text('Pilih Status', style: TextStyle(fontWeight: FontWeight.bold)),
            ),
            for (final status in ApplicationStatus.values)
              ListTile(
                leading: Icon(Icons.circle, color: status.color, size: 14),
                title: Text(status.label),
                onTap: () {
                  context.read<ApplicationProvider>().updateStatus(app.id, status);
                  Navigator.of(sheetContext).pop();
                },
              ),
          ],
        ),
      ),
    );
  }
}
