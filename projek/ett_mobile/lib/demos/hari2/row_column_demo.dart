import 'package:flutter/material.dart';

import '../../data/sample_programmes.dart';
import '../../theme.dart';

/// Demo: `Row` (paksi mendatar) vs `Column` (paksi menegak) dan bagaimana
/// `mainAxisAlignment` (paksi utama) & `crossAxisAlignment` (paksi silang)
/// mengawal susunan anak-anak widget di dalamnya.
class RowColumnDemo extends StatefulWidget {
  const RowColumnDemo({super.key});

  @override
  State<RowColumnDemo> createState() => _RowColumnDemoState();
}

class _RowColumnDemoState extends State<RowColumnDemo> {
  MainAxisAlignment _mainAxis = MainAxisAlignment.start;
  CrossAxisAlignment _crossAxis = CrossAxisAlignment.center;

  // Small chips built from the first 3 sample programmes (short labels).
  List<Widget> _chips() {
    return sampleProgrammes.take(3).map((p) {
      return Container(
        margin: const EdgeInsets.all(4),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 14),
        decoration: BoxDecoration(
          color: KptTheme.navy.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: KptTheme.navy.withValues(alpha: 0.3)),
        ),
        child: Text(
          '${p.flagEmoji} ${p.universityName}',
          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
        ),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Row & Column'),
        backgroundColor: KptTheme.navy,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _ExplanationBanner(
              text:
                  'Row menyusun anak widget secara MENDATAR, Column secara '
                  'MENEGAK. Tukar mainAxisAlignment (susunan sepanjang paksi '
                  'utama) & crossAxisAlignment (susunan merentas paksi utama) '
                  'di bawah untuk lihat kesannya secara langsung.',
            ),
            const SizedBox(height: 16),
            const Text(
              'mainAxisAlignment',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: MainAxisAlignment.values.map((value) {
                final selected = value == _mainAxis;
                return ChoiceChip(
                  label: Text(value.name),
                  selected: selected,
                  selectedColor: KptTheme.gold.withValues(alpha: 0.3),
                  onSelected: (_) => setState(() => _mainAxis = value),
                );
              }).toList(),
            ),
            const SizedBox(height: 16),
            const Text(
              'crossAxisAlignment',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: CrossAxisAlignment.values
                  // stretch on the demo row would fill unhelpfully tall; keep all options though.
                  .map((value) {
                final selected = value == _crossAxis;
                return ChoiceChip(
                  label: Text(value.name),
                  selected: selected,
                  selectedColor: KptTheme.gold.withValues(alpha: 0.3),
                  onSelected: (_) => setState(() => _crossAxis = value),
                );
              }).toList(),
            ),
            const SizedBox(height: 20),
            const Text('Demo Row', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Container(
              height: 160,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade400),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisAlignment: _mainAxis,
                crossAxisAlignment: _crossAxis,
                children: _chips(),
              ),
            ),
            const SizedBox(height: 20),
            const Text('Demo Column', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade400),
                  borderRadius: BorderRadius.circular(8),
                ),
                // Bounded height (from Expanded) lets mainAxisAlignment show
                // real spacing between the 3 chips, unlike an unbounded
                // scroll view where the Column just shrinks to fit content.
                child: Column(
                  mainAxisAlignment: _mainAxis,
                  crossAxisAlignment: _crossAxis,
                  children: _chips(),
                ),
              ),
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
