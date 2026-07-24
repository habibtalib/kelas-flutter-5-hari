import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/scholarship.dart';
import '../theme.dart';

/// Kad yang memaparkan ringkasan satu biasiswa dalam senarai (Hari 1).
class ScholarshipCard extends StatelessWidget {
  const ScholarshipCard({
    super.key,
    required this.scholarship,
    this.onTap,
  });

  final Scholarship scholarship;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final rm = NumberFormat.currency(locale: 'ms_MY', symbol: 'RM', decimalDigits: 0);
    final tarikh = DateFormat('d MMM yyyy', 'ms').format(scholarship.applicationDeadline);

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      scholarship.name,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: KptTheme.navy,
                      ),
                    ),
                  ),
                  if (!scholarship.isOpen)
                    const _Pill(text: 'Tutup', color: Colors.red)
                  else
                    const _Pill(text: 'Dibuka', color: Colors.green),
                ],
              ),
              const SizedBox(height: 6),
              Text(
                scholarship.fieldOfStudy,
                style: TextStyle(color: Colors.grey[700], fontSize: 13),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  _Pill(text: scholarship.category.label, color: KptTheme.navy),
                  const SizedBox(width: 8),
                  _Pill(text: scholarship.studyLevel.label, color: KptTheme.gold),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.payments_outlined,
                          size: 16, color: KptTheme.navy),
                      const SizedBox(width: 4),
                      Text(
                        '${rm.format(scholarship.monthlyAllowance)}/bulan',
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.event_outlined, size: 16, color: Colors.grey[600]),
                      const SizedBox(width: 4),
                      Text(tarikh, style: TextStyle(color: Colors.grey[700], fontSize: 12)),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Pill extends StatelessWidget {
  const _Pill({required this.text, required this.color});

  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        text,
        style: TextStyle(color: color, fontSize: 11, fontWeight: FontWeight.w600),
      ),
    );
  }
}
