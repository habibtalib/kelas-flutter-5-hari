import 'package:flutter/material.dart';

import '../../data/sample_programmes.dart';
import '../../theme.dart';

/// Demo: `GridView.count` menyusun anak widget dalam grid dengan bilangan
/// lajur tetap (`crossAxisCount`) dan nisbah lebar:tinggi setiap sel
/// (`childAspectRatio`).
class GridViewDemo extends StatefulWidget {
  const GridViewDemo({super.key});

  @override
  State<GridViewDemo> createState() => _GridViewDemoState();
}

class _GridViewDemoState extends State<GridViewDemo> {
  int _crossAxisCount = 2;
  double _childAspectRatio = 1.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('GridView.count'),
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
                  'GridView.count menyusun tawaran pengajian dalam grid. '
                  'crossAxisCount menentukan BILANGAN LAJUR, manakala '
                  'childAspectRatio menentukan nisbah lebar:tinggi setiap sel '
                  '(nombor besar = sel lebih pendek/leper).',
            ),
            const SizedBox(height: 12),
            Text(
              'crossAxisCount: $_crossAxisCount',
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
            Slider(
              value: _crossAxisCount.toDouble(),
              min: 1,
              max: 4,
              divisions: 3,
              activeColor: KptTheme.navy,
              label: '$_crossAxisCount',
              onChanged: (v) => setState(() => _crossAxisCount = v.round()),
            ),
            Text(
              'childAspectRatio: ${_childAspectRatio.toStringAsFixed(2)}',
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
            Slider(
              value: _childAspectRatio,
              min: 0.5,
              max: 2.0,
              divisions: 15,
              activeColor: KptTheme.navy,
              label: _childAspectRatio.toStringAsFixed(2),
              onChanged: (v) => setState(() => _childAspectRatio = v),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: GridView.count(
                crossAxisCount: _crossAxisCount,
                childAspectRatio: _childAspectRatio,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                children: sampleProgrammes.map((p) {
                  return Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(p.flagEmoji, style: const TextStyle(fontSize: 22)),
                        const SizedBox(height: 4),
                        Text(
                          p.universityName,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                            color: KptTheme.navy,
                          ),
                        ),
                        Text(
                          p.fieldOfStudy,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 11,
                            color: Colors.grey[700],
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
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
