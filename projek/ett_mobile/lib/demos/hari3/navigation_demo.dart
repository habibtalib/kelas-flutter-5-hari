import 'package:flutter/material.dart';

import '../../theme.dart';

/// Demo: `Navigator.push` / `Navigator.pop` sebagai satu STACK skrin.
///
/// Setiap "Tolak skrin baharu" menolak (push) satu skrin baharu ke atas
/// stack — kedalaman bertambah. "Pop" menanggalkan skrin teratas — kembali
/// ke skrin sebelumnya. Ini adalah asas navigasi dalam Flutter.
class NavigationDemo extends StatelessWidget {
  const NavigationDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return const _NavStackScreen(depth: 1);
  }
}

/// Satu "aras" dalam stack navigasi. `depth` menunjukkan berapa banyak
/// skrin telah ditolak (push) setakat ini, termasuk skrin ini sendiri.
class _NavStackScreen extends StatelessWidget {
  const _NavStackScreen({required this.depth});

  final int depth;

  void _push(BuildContext context) {
    // Navigator.push menolak skrin baharu ke ATAS stack — depth bertambah 1.
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => _NavStackScreen(depth: depth + 1),
      ),
    );
  }

  void _pop(BuildContext context) {
    // Navigator.pop menanggalkan skrin teratas — kembali ke skrin sebelum ini.
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    // Skrin pertama (depth == 1) memaparkan tajuk & penjelasan penuh; skrin
    // seterusnya dalam stack tetap ringkas supaya tumpuan pada visual depth.
    return Scaffold(
      appBar: AppBar(
        title: const Text('Navigator push & pop'),
        backgroundColor: KptTheme.navy,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (depth == 1)
              const _ExplanationBanner(
                text:
                    'Navigasi Flutter berfungsi seperti TIMBUNAN (stack) '
                    'kertas. "Tolak skrin baharu" letak kertas baharu di '
                    'atas (push); "Pop" cabut kertas teratas dan kembali ke '
                    'kertas di bawahnya. Cuba tolak beberapa kali, perhatikan '
                    'kedalaman bertambah, kemudian pop untuk turun semula.',
              ),
            const SizedBox(height: 20),
            Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Visualise the stack as stacked cards.
                    SizedBox(
                      height: 180,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          for (var i = 1; i <= depth; i++)
                            Positioned(
                              top: (depth - i) * 12.0,
                              child: Container(
                                width: 140 - (depth - i) * 6,
                                height: 90,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: i == depth
                                      ? KptTheme.gold.withValues(alpha: 0.85)
                                      : KptTheme.navy.withValues(alpha: 0.15),
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(color: KptTheme.navy),
                                ),
                                child: Text(
                                  'Skrin $i',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      'Kedalaman stack sekarang: $depth',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            FilledButton.icon(
              onPressed: () => _push(context),
              icon: const Icon(Icons.add_box_outlined),
              label: const Text('Tolak skrin baharu (push)'),
            ),
            const SizedBox(height: 10),
            OutlinedButton.icon(
              onPressed: depth > 1 ? () => _pop(context) : null,
              icon: const Icon(Icons.arrow_back),
              label: Text(
                depth > 1
                    ? 'Pop (kembali ke Skrin ${depth - 1})'
                    : 'Pop (skrin pertama, tiada tempat kembali)',
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
