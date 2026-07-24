import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../data/sample_programmes.dart';
import '../../theme.dart';

/// Demo: `Card` + `ListTile` (elevation, bucu bulat, kesan ink semasa tekan)
/// berbanding `Container` biasa yang menyusun maklumat sama tetapi TANPA
/// sebarang kesan visual bawaan Material.
class CardListTileDemo extends StatefulWidget {
  const CardListTileDemo({super.key});

  @override
  State<CardListTileDemo> createState() => _CardListTileDemoState();
}

class _CardListTileDemoState extends State<CardListTileDemo> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    final programme = sampleProgrammes[_index];
    final rm = NumberFormat.currency(
      locale: 'ms_MY',
      symbol: 'RM',
      decimalDigits: 0,
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Card & ListTile'),
        backgroundColor: KptTheme.navy,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const _ExplanationBanner(
              text:
                  'Programme yang SAMA dipaparkan dua cara. Card+ListTile '
                  'datang dengan elevation (bayang), bucu bulat & kesan ink '
                  'apabila ditekan — semuanya PERCUMA daripada Material. '
                  'Container biasa perlu anda bina semuanya sendiri (dan '
                  'tiada kesan tekan).',
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () => setState(
                    () => _index =
                        (_index - 1 + sampleProgrammes.length) %
                            sampleProgrammes.length,
                  ),
                  icon: const Icon(Icons.chevron_left),
                ),
                Text(
                  'Tawaran ${_index + 1} / ${sampleProgrammes.length}',
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                IconButton(
                  onPressed: () => setState(
                    () => _index = (_index + 1) % sampleProgrammes.length,
                  ),
                  icon: const Icon(Icons.chevron_right),
                ),
              ],
            ),
            const SizedBox(height: 12),
            const Text(
              'A — Card + ListTile',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Card(
              child: ListTile(
                onTap: () {}, // enables the InkWell ripple on tap
                leading: Text(
                  programme.flagEmoji,
                  style: const TextStyle(fontSize: 28),
                ),
                title: Text(
                  programme.universityName,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(programme.fieldOfStudy),
                trailing: Text(
                  rm.format(programme.estimatedAnnualCostMyr),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: KptTheme.navy,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'B — Container biasa',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: KptTheme.bgLight,
                border: Border.all(color: Colors.grey.shade400),
              ),
              child: Row(
                children: [
                  Text(
                    programme.flagEmoji,
                    style: const TextStyle(fontSize: 28),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          programme.universityName,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(programme.fieldOfStudy),
                      ],
                    ),
                  ),
                  Text(
                    rm.format(programme.estimatedAnnualCostMyr),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: KptTheme.navy,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'Cuba tekan kad A — nampak kesan ink (riak). Container B tiada '
              'sebarang kesan walaupun struktur maklumatnya sama.',
              style: TextStyle(fontSize: 12, color: Colors.grey[700]),
            ),
          ],
        ),
      ),
    );
  }
}

class _ExplanationBanner extends StatelessWidget {
  const _ExplanationBanner({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: KptTheme.gold.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: KptTheme.gold.withValues(alpha: 0.4)),
      ),
      child: Text(text, style: const TextStyle(fontSize: 13, height: 1.4)),
    );
  }
}
