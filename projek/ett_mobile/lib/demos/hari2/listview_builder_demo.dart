import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../data/sample_programmes.dart';
import '../../models/programme.dart';
import '../../theme.dart';
import '../../widgets/programme_card.dart';

const int _kGeneratedCount = 1000;

/// Demo BINTANG: `ListView(children: [...])` membina SEMUA widget serta-merta
/// (eager) apabila skrin dibuka, manakala `ListView.builder` hanya membina
/// widget yang KELIHATAN (dan sedikit lagi untuk buffer) — lazy building.
///
/// Untuk 8 item (senarai kecil), perbezaan tidak ketara. Tetapi untuk 1000
/// item, ListView biasa membina 1000 widget serentak (lambat, boros memori)
/// manakala ListView.builder hanya membina ~10-15 widget pada satu masa,
/// dan membina lagi HANYA apabila anda skrol.
class ListViewBuilderDemo extends StatefulWidget {
  const ListViewBuilderDemo({super.key});

  @override
  State<ListViewBuilderDemo> createState() => _ListViewBuilderDemoState();
}

class _ListViewBuilderDemoState extends State<ListViewBuilderDemo> {
  bool _useBuilder = true;

  // Tracks which item indices have actually had their widget built by
  // ListView.builder's itemBuilder — this is what proves laziness.
  final Set<int> _builtIndices = {};

  late final List<Programme> _manyProgrammes = _generateMany(_kGeneratedCount);

  static List<Programme> _generateMany(int count) {
    return List.generate(count, (i) {
      final base = sampleProgrammes[i % sampleProgrammes.length];
      return Programme(
        id: '${base.id}-$i',
        universityName: '${base.universityName} #$i',
        country: base.country,
        city: base.city,
        fieldOfStudy: base.fieldOfStudy,
        studyLevel: base.studyLevel,
        category: base.category,
        estimatedAnnualCostMyr: base.estimatedAnnualCostMyr,
        intakeMonth: base.intakeMonth,
        recognitionNote: base.recognitionNote,
        quotaSeats: base.quotaSeats,
      );
    });
  }

  // Called from itemBuilder. Records a newly-built index, then schedules a
  // rebuild AFTER the current frame (never call setState synchronously
  // while another build is in progress).
  void _markBuilt(int index) {
    if (_builtIndices.add(index)) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) setState(() {});
      });
    }
  }

  void _reset() {
    setState(() => _builtIndices.clear());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ListView vs ListView.builder'),
        backgroundColor: KptTheme.navy,
        foregroundColor: Colors.white,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _ExplanationBanner(
                  text: _useBuilder
                      ? 'ListView.builder dengan $_kGeneratedCount tawaran '
                          '(dijana). Kaunter "widget dibina" di bawah hanya '
                          'bertambah apabila anda SKROL — buktinya widget '
                          'dibina secara MALAS (lazy), bukan semua sekaligus.'
                      : 'ListView biasa (children: [...]) daripada 8 tawaran '
                          'sampel — SEMUA widget dibina serta-merta walaupun '
                          'belum kelihatan di skrin. Untuk senarai panjang/tidak '
                          'diketahui saiznya, ini membazir memori & masa.',
                ),
                const SizedBox(height: 12),
                SegmentedButton<bool>(
                  segments: const [
                    ButtonSegment(
                      value: false,
                      label: Text('A: ListView (8 item)'),
                    ),
                    ButtonSegment(
                      value: true,
                      label: Text('B: ListView.builder (1000 item)'),
                    ),
                  ],
                  selected: {_useBuilder},
                  onSelectionChanged: (s) {
                    setState(() => _useBuilder = s.first);
                    _reset();
                  },
                ),
                const SizedBox(height: 12),
                if (_useBuilder)
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: KptTheme.navy.withValues(alpha: 0.08),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      'widget dibina: ${_builtIndices.length} / $_kGeneratedCount '
                      '(skrol untuk tambah)',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: KptTheme.navy,
                      ),
                    ),
                  )
                else
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: KptTheme.navy.withValues(alpha: 0.08),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Text(
                      'widget dibina: 8 / 8 (semua dibina serta-merta, tidak '
                      'berubah walau anda skrol)',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: KptTheme.navy,
                      ),
                    ),
                  ),
              ],
            ),
          ),
          Expanded(
            child: _useBuilder ? _buildLazyList() : _buildEagerList(),
          ),
        ],
      ),
    );
  }

  Widget _buildEagerList() {
    // Eager: the `children` list is fully evaluated up-front — all 8
    // ProgrammeCard widgets exist before the first frame is even drawn.
    return ListView(
      children: sampleProgrammes
          .map((p) => ProgrammeCard(programme: p))
          .toList(),
    );
  }

  Widget _buildLazyList() {
    final rm = NumberFormat.currency(
      locale: 'ms_MY',
      symbol: 'RM',
      decimalDigits: 0,
    );

    // Lazy: itemBuilder only runs for the item indices Flutter currently
    // needs to render (visible items + a small cache extent).
    return ListView.builder(
      itemCount: _manyProgrammes.length,
      itemBuilder: (context, index) {
        _markBuilt(index);
        final p = _manyProgrammes[index];
        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          child: ListTile(
            leading: Text(p.flagEmoji, style: const TextStyle(fontSize: 22)),
            title: Text(
              p.universityName,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text('#$index · ${p.fieldOfStudy}'),
            trailing: Text(
              rm.format(p.estimatedAnnualCostMyr),
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: KptTheme.navy,
              ),
            ),
          ),
        );
      },
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
