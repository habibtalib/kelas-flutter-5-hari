import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/application.dart';
import '../models/programme.dart';
import '../theme.dart';
import 'application_form_screen.dart';

/// Skrin butiran satu tawaran: kelayakan, kos, ambilan, kuota.
class ProgrammeDetailScreen extends StatelessWidget {
  const ProgrammeDetailScreen({
    super.key,
    required this.programme,
    required this.onSubmit,
  });

  final Programme programme;
  final void Function(Application) onSubmit;

  @override
  Widget build(BuildContext context) {
    final rm = NumberFormat.currency(
      locale: 'ms_MY',
      symbol: 'RM',
      decimalDigits: 0,
    );

    return Scaffold(
      appBar: AppBar(title: Text(programme.universityName)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            '${programme.flagEmoji} ${programme.city}, ${programme.countryLabel}',
            style: const TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 8),
          Text(
            programme.fieldOfStudy,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: KptTheme.navy,
            ),
          ),
          const Divider(height: 32),
          _DetailRow(
            icon: Icons.school,
            label: 'Kelayakan',
            value: '${programme.studyLevel.label} · ${programme.category.label}',
          ),
          _DetailRow(
            icon: Icons.payments,
            label: 'Anggaran Kos (setahun)',
            value: rm.format(programme.estimatedAnnualCostMyr),
          ),
          _DetailRow(
            icon: Icons.event,
            label: 'Ambilan',
            value: programme.intakeMonth,
          ),
          _DetailRow(
            icon: Icons.groups,
            label: 'Kuota',
            value: '${programme.quotaSeats} tempat',
          ),
          const SizedBox(height: 16),
          Text(
            programme.recognitionNote,
            style: TextStyle(color: Colors.grey[700], fontSize: 13),
          ),
          const SizedBox(height: 24),
          FilledButton.icon(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => ApplicationFormScreen(
                    programme: programme,
                    onSubmit: onSubmit,
                  ),
                ),
              );
            },
            icon: const Icon(Icons.edit_document),
            label: const Text('Mohon Sekarang'),
          ),
        ],
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  const _DetailRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: KptTheme.gold),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label,
                    style: TextStyle(color: Colors.grey[600], fontSize: 12)),
                Text(value,
                    style: const TextStyle(
                        fontSize: 15, fontWeight: FontWeight.w600)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
