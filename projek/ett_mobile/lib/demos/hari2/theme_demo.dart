import 'package:flutter/material.dart';

import '../../theme.dart';

/// Demo: gaya (style) yang HARDCODE (ditulis terus dalam widget) berbanding
/// gaya yang diambil daripada `Theme.of(context)`. Menukar `Theme` tempatan
/// mengubah bahagian "guna Theme" secara automatik (cascading), tetapi
/// bahagian hardcode LANGSUNG TIDAK berubah.
class ThemeDemo extends StatefulWidget {
  const ThemeDemo({super.key});

  @override
  State<ThemeDemo> createState() => _ThemeDemoState();
}

class _ThemeDemoState extends State<ThemeDemo> {
  bool _altSeed = false;

  static const Color _altColor = Colors.deepPurple;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ThemeData'),
        backgroundColor: KptTheme.navy,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _ExplanationBanner(
              text: _altSeed
                  ? 'Theme tempatan kini ditukar kepada warna UNGU. Lihat: '
                      'bahagian "B — guna Theme.of(context)" turut bertukar '
                      'ungu secara automatik, tetapi bahagian "A — hardcode" '
                      'KEKAL navy/emas kerana warnanya ditulis terus dalam kod.'
                  : 'Bandingkan dua UI SAMA di bawah: A menulis warna terus '
                      '(hardcode), B mengambil warna daripada Theme.of(context). '
                      'Tekan suis di bawah untuk tukar Theme tempatan & lihat '
                      'kesan "cascading" — hanya B yang terjejas.',
            ),
            const SizedBox(height: 12),
            SwitchListTile(
              value: _altSeed,
              activeThumbColor: KptTheme.navy,
              title: const Text('Tukar Theme tempatan (navy → ungu)'),
              onChanged: (v) => setState(() => _altSeed = v),
            ),
            const SizedBox(height: 12),
            const Text(
              'A — hardcode (tidak terjejas oleh Theme)',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            _PreviewCard(
              background: KptTheme.navy,
              accent: KptTheme.gold,
              label: 'Warna ditulis terus dalam kod',
            ),
            const SizedBox(height: 20),
            const Text(
              'B — guna Theme.of(context)',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            // Wrapping in a local Theme changes what Theme.of(context)
            // returns for every descendant below this point — this is
            // "cascading": the change flows down the widget tree.
            Theme(
              data: ThemeData(
                useMaterial3: true,
                colorScheme: ColorScheme.fromSeed(
                  seedColor: _altSeed ? _altColor : KptTheme.navy,
                  brightness: Brightness.light,
                ),
              ),
              child: Builder(
                builder: (themedContext) {
                  final scheme = Theme.of(themedContext).colorScheme;
                  return _PreviewCard(
                    background: scheme.primary,
                    accent: scheme.secondary,
                    label: 'Warna daripada Theme.of(context)',
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PreviewCard extends StatelessWidget {
  const _PreviewCard({
    required this.background,
    required this.accent,
    required this.label,
  });

  final Color background;
  final Color accent;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: accent,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.school, color: Colors.white, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
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
