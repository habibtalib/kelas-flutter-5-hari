import 'package:flutter/material.dart';

import '../../theme.dart';

enum _BadgeMode { positioned, align }

/// Demo: `Stack` menindankan (overlap) anak widget. `Positioned` meletakkan
/// anak pada koordinat piksel tepat (top/left/right/bottom) berbanding
/// `Align`, yang meletakkan anak berdasarkan pecahan (fraction) alignment
/// (-1.0 hingga 1.0) di dalam Stack.
class StackPositionedDemo extends StatefulWidget {
  const StackPositionedDemo({super.key});

  @override
  State<StackPositionedDemo> createState() => _StackPositionedDemoState();
}

class _StackPositionedDemoState extends State<StackPositionedDemo> {
  _BadgeMode _mode = _BadgeMode.positioned;

  // 0.0..1.0 fraction of the banner's height/width — reused for both
  // Positioned (converted to px) and Align (converted to -1..1).
  double _topFraction = 0.05;
  double _leftFraction = 0.60;

  static const double _bannerHeight = 220;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Stack & Positioned'),
        backgroundColor: KptTheme.navy,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _ExplanationBanner(
              text: _mode == _BadgeMode.positioned
                  ? 'Positioned letak lencana "Diiktiraf" pada jarak PIKSEL '
                      'tepat (top/left) dari tepi Stack — kawalan halus, sesuai '
                      'untuk lencana/label di atas gambar.'
                  : 'Align letak lencana berdasarkan PECAHAN alignment (-1.0 '
                      'hingga 1.0) merentasi Stack — mudah untuk kedudukan '
                      'relatif seperti tengah/penjuru, tanpa kira saiz sebenar.',
            ),
            const SizedBox(height: 12),
            SegmentedButton<_BadgeMode>(
              segments: const [
                ButtonSegment(
                  value: _BadgeMode.positioned,
                  label: Text('Positioned'),
                ),
                ButtonSegment(
                  value: _BadgeMode.align,
                  label: Text('Align'),
                ),
              ],
              selected: {_mode},
              onSelectionChanged: (s) => setState(() => _mode = s.first),
            ),
            const SizedBox(height: 16),
            Text('top: ${(_topFraction * 100).round()}%',
                style: const TextStyle(fontWeight: FontWeight.w600)),
            Slider(
              value: _topFraction,
              activeColor: KptTheme.navy,
              onChanged: (v) => setState(() => _topFraction = v),
            ),
            Text('left: ${(_leftFraction * 100).round()}%',
                style: const TextStyle(fontWeight: FontWeight.w600)),
            Slider(
              value: _leftFraction,
              activeColor: KptTheme.navy,
              onChanged: (v) => setState(() => _leftFraction = v),
            ),
            const SizedBox(height: 16),
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: SizedBox(
                height: _bannerHeight,
                width: double.infinity,
                child: Stack(
                  children: [
                    // Base banner: gradient background representing an eTT
                    // university programme banner.
                    Container(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: [KptTheme.navy, Color(0xFF33447A)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(16),
                        child: Align(
                          alignment: Alignment.bottomLeft,
                          child: Text(
                            'Universiti Al-Azhar\nPerubatan (Medicine)',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                    _buildBadge(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBadge() {
    const badge = _RecognisedBadge();

    if (_mode == _BadgeMode.positioned) {
      // Positioned requires a Stack ancestor and places the child at an
      // exact pixel offset from the given edges.
      return Positioned(
        top: _topFraction * _bannerHeight,
        left: _leftFraction * 300, // approx banner width for demo purposes
        child: badge,
      );
    }

    // Align places the child using a fractional alignment (-1..1 on each
    // axis) relative to the Stack's own size, not raw pixels.
    return Align(
      alignment: Alignment(
        _leftFraction * 2 - 1,
        _topFraction * 2 - 1,
      ),
      child: badge,
    );
  }
}

class _RecognisedBadge extends StatelessWidget {
  const _RecognisedBadge();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: KptTheme.gold,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.25),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: const Text(
        'Diiktiraf',
        style: TextStyle(
          color: KptTheme.navy,
          fontWeight: FontWeight.bold,
          fontSize: 12,
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
