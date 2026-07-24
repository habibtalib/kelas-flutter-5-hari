import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/programme.dart';
import '../theme.dart';
import '../widgets/programme_card.dart';
import 'application_form_screen.dart';

/// Skrin butiran tawaran (SESI 4 — Navigator + passing data).
class ProgrammeDetailScreen extends StatelessWidget {
  const ProgrammeDetailScreen({super.key, required this.programme});

  final Programme programme;

  @override
  Widget build(BuildContext context) {
    final rm = NumberFormat.currency(
      locale: 'ms_MY',
      symbol: 'RM',
      decimalDigits: 0,
    );

    return Scaffold(
      appBar: AppBar(title: Text(programme.id)),
      body: ListView(
        children: [
          // Header
          Container(
            width: double.infinity,
            color: KptTheme.navy,
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  programme.flagEmoji,
                  style: const TextStyle(fontSize: 40),
                ),
                const SizedBox(height: 8),
                Text(
                  programme.universityName,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  programme.fieldOfStudy,
                  style: const TextStyle(
                    color: KptTheme.gold,
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '${programme.city}, ${programme.countryLabel}',
                  style: const TextStyle(color: Colors.white70),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CategoryPill(category: programme.category),
                  ],
                ),
                const SizedBox(height: 16),
                _InfoRow(
                  icon: Icons.badge_outlined,
                  label: 'Kategori',
                  value: '${programme.category.label} '
                      '(kelayakan kemasukan)',
                ),
                _InfoRow(
                  icon: Icons.payments_outlined,
                  label: 'Kos Anggaran',
                  value: '${rm.format(programme.estimatedAnnualCostMyr)} / tahun '
                      '(ilustrasi)',
                ),
                _InfoRow(
                  icon: Icons.school_outlined,
                  label: 'Peringkat',
                  value: programme.studyLevel.label,
                ),
                _InfoRow(
                  icon: Icons.event_available_outlined,
                  label: 'Ambilan',
                  value: programme.intakeMonth,
                ),
                _InfoRow(
                  icon: Icons.event_seat_outlined,
                  label: 'Kuota',
                  value: '${programme.quotaSeats} tempat (ilustrasi)',
                ),
                const SizedBox(height: 16),
                const Text('Nota Pengiktirafan', style: _sectionStyle),
                const SizedBox(height: 8),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: KptTheme.navy.withValues(alpha: 0.05),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: KptTheme.navy.withValues(alpha: 0.15),
                    ),
                  ),
                  child: Text(
                    programme.recognitionNote,
                    style: const TextStyle(fontSize: 13, height: 1.4),
                  ),
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton.icon(
                    onPressed: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) =>
                            ApplicationFormScreen(programme: programme),
                      ),
                    ),
                    icon: const Icon(Icons.app_registration),
                    label: const Text('Mohon'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

const _sectionStyle = TextStyle(
  fontSize: 16,
  fontWeight: FontWeight.bold,
  color: KptTheme.navy,
);

class _InfoRow extends StatelessWidget {
  const _InfoRow({
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
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 20, color: KptTheme.navy),
          const SizedBox(width: 12),
          SizedBox(
            width: 110,
            child: Text(label, style: TextStyle(color: Colors.grey[600])),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }
}
