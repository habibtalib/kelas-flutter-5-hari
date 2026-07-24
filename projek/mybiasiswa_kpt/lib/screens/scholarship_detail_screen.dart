import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../models/scholarship.dart';
import '../providers/application_provider.dart';
import '../theme.dart';
import 'application_form_screen.dart';

/// Skrin butiran biasiswa (Hari 2) — syarat, deadline, butang "Mohon".
class ScholarshipDetailScreen extends StatelessWidget {
  const ScholarshipDetailScreen({super.key, required this.scholarship});

  final Scholarship scholarship;

  @override
  Widget build(BuildContext context) {
    final rm = NumberFormat.currency(locale: 'ms_MY', symbol: 'RM', decimalDigits: 0);
    final tarikh = DateFormat('d MMMM yyyy', 'ms').format(scholarship.applicationDeadline);
    final sudahMohon =
        context.watch<ApplicationProvider>().hasAppliedFor(scholarship.id);

    return Scaffold(
      appBar: AppBar(title: Text(scholarship.code)),
      body: ListView(
        children: [
          Container(
            width: double.infinity,
            color: KptTheme.navy,
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  scholarship.name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  scholarship.provider,
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
                _InfoRow(icon: Icons.school_outlined, label: 'Peringkat', value: scholarship.studyLevel.label),
                _InfoRow(icon: Icons.category_outlined, label: 'Kategori', value: scholarship.category.label),
                _InfoRow(icon: Icons.menu_book_outlined, label: 'Bidang', value: scholarship.fieldOfStudy),
                _InfoRow(icon: Icons.payments_outlined, label: 'Elaun Bulanan', value: '${rm.format(scholarship.monthlyAllowance)}/bulan'),
                _InfoRow(icon: Icons.receipt_long_outlined, label: 'Yuran Pengajian', value: scholarship.tuitionCoverage ? 'Ditanggung penuh' : 'Tidak ditanggung'),
                _InfoRow(icon: Icons.trending_up_outlined, label: 'CGPA Minimum', value: scholarship.minCgpa.toStringAsFixed(2)),
                _InfoRow(icon: Icons.cake_outlined, label: 'Had Umur', value: '${scholarship.maxAge} tahun'),
                _InfoRow(icon: Icons.event_outlined, label: 'Tarikh Tutup', value: tarikh),
                const SizedBox(height: 16),
                const Text('Keterangan', style: _sectionStyle),
                const SizedBox(height: 6),
                Text(scholarship.description, style: const TextStyle(height: 1.5)),
                const SizedBox(height: 16),
                const Text('Syarat Kelayakan', style: _sectionStyle),
                const SizedBox(height: 6),
                ...scholarship.requirements.map(
                  (r) => Padding(
                    padding: const EdgeInsets.only(bottom: 6),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(Icons.check_circle, size: 18, color: KptTheme.gold),
                        const SizedBox(width: 8),
                        Expanded(child: Text(r)),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton.icon(
                    onPressed: (!scholarship.isOpen || sudahMohon)
                        ? null
                        : () => Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) =>
                                    ApplicationFormScreen(scholarship: scholarship),
                              ),
                            ),
                    icon: Icon(sudahMohon ? Icons.check : Icons.edit_document),
                    label: Text(
                      !scholarship.isOpen
                          ? 'Permohonan Ditutup'
                          : sudahMohon
                              ? 'Anda Telah Memohon'
                              : 'Mohon Sekarang',
                    ),
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
  const _InfoRow({required this.icon, required this.label, required this.value});

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
          SizedBox(width: 110, child: Text(label, style: TextStyle(color: Colors.grey[600]))),
          Expanded(child: Text(value, style: const TextStyle(fontWeight: FontWeight.w500))),
        ],
      ),
    );
  }
}
