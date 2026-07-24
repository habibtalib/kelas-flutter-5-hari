import 'package:flutter/material.dart';

import '../../theme.dart';

/// Demo: `Expanded` menentukan lebar/tinggi anak widget mengikut ruang baki
/// (dan nisbah `flex`), manakala widget TANPA `Expanded` mengekalkan lebar
/// sebenarnya walaupun jumlahnya melebihi ruang skrin — menyebabkan ralat
/// "RenderFlex overflowed" (jalur kuning-hitam).
class ExpandedFlexibleDemo extends StatefulWidget {
  const ExpandedFlexibleDemo({super.key});

  @override
  State<ExpandedFlexibleDemo> createState() => _ExpandedFlexibleDemoState();
}

class _ExpandedFlexibleDemoState extends State<ExpandedFlexibleDemo> {
  // Start WITHOUT Expanded so the overflow is visible immediately.
  // Mula dalam keadaan "berfungsi" (Expanded) — tekan toggle ke "Tanpa
  // Expanded" untuk melihat jalur overflow kuning-hitam.
  bool _useExpanded = true;

  // flex value doubles as "fixed width multiplier" in the without-Expanded
  // case, so the same sliders explain both scenarios.
  final List<double> _flexValues = [3, 3, 3];

  static const _labels = ['A', 'B', 'C'];
  static const _colors = [Colors.redAccent, Colors.teal, KptTheme.gold];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Expanded & Flexible'),
        backgroundColor: KptTheme.navy,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _ExplanationBanner(
              text: _useExpanded
                  ? 'Dengan Expanded, setiap kotak berkongsi ruang mengikut '
                      'nisbah flex — jumlah lebar kotak SENTIASA muat dalam Row, '
                      'walau apa pun nilai flex.'
                  : 'TANPA Expanded, setiap kotak diberi lebar TETAP (flex × 120px). '
                      'Apabila jumlah lebar melebihi lebar skrin, Flutter memaparkan '
                      'jalur kuning-hitam "RenderFlex overflowed" di hujung kanan.',
            ),
            const SizedBox(height: 12),
            SegmentedButton<bool>(
              segments: const [
                ButtonSegment(value: false, label: Text('Tanpa Expanded')),
                ButtonSegment(value: true, label: Text('Dengan Expanded')),
              ],
              selected: {_useExpanded},
              onSelectionChanged: (s) => setState(() => _useExpanded = s.first),
            ),
            const SizedBox(height: 16),
            for (var i = 0; i < 3; i++) ...[
              Text(
                'Kotak ${_labels[i]} — flex: ${_flexValues[i].round()}',
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
              Slider(
                value: _flexValues[i],
                min: 1,
                max: 5,
                divisions: 4,
                activeColor: KptTheme.navy,
                label: _flexValues[i].round().toString(),
                onChanged: (v) => setState(() => _flexValues[i] = v),
              ),
            ],
            const SizedBox(height: 12),
            const Text('Row demo', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            // ClipRect lets the overflow stripes render clearly inside a
            // bounded, visibly-outlined area instead of bleeding off-screen.
            Container(
              height: 100,
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade400),
                borderRadius: BorderRadius.circular(8),
              ),
              child: ClipRect(
                child: Row(
                  children: List.generate(3, (i) => _buildBox(i)),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              _useExpanded
                  ? 'Jumlah nisbah flex: ${_flexValues.map((v) => v.round()).reduce((a, b) => a + b)} '
                      '(dibahagi mengikut nisbah, bukan lebar tetap).'
                  : 'Jumlah lebar diminta: '
                      '${_flexValues.map((v) => (v * 120).round()).reduce((a, b) => a + b)}px '
                      '(lebar sebenar tetap, tidak kira ruang tersedia).',
              style: const TextStyle(fontSize: 12, color: Colors.black54),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBox(int i) {
    final box = Container(
      alignment: Alignment.center,
      margin: const EdgeInsets.symmetric(horizontal: 2),
      color: _colors[i],
      child: Text(
        _labels[i],
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
      ),
    );

    if (_useExpanded) {
      // Expanded forces the box to take a share of the Row's available
      // space proportional to `flex` — the Row can never overflow.
      return Expanded(flex: _flexValues[i].round(), child: box);
    }

    // No Expanded: the box keeps its own fixed width regardless of how
    // much space the Row actually has, which is what causes overflow.
    return SizedBox(width: _flexValues[i] * 120, child: box);
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
