import 'package:flutter/material.dart';

import '../../theme.dart';

/// Demo: pelbagai jenis butang (`ElevatedButton`, `TextButton`,
/// `OutlinedButton`, `FilledButton`) berbanding pengesan gerak isyarat
/// mentah (`GestureDetector`, `InkWell`). Setiap tap/long-press/double-tap
/// ditambah ke log peristiwa pada skrin.
class GestureButtonDemo extends StatefulWidget {
  const GestureButtonDemo({super.key});

  @override
  State<GestureButtonDemo> createState() => _GestureButtonDemoState();
}

class _GestureButtonDemoState extends State<GestureButtonDemo> {
  final List<String> _events = [];

  void _log(String message) {
    setState(() {
      _events.insert(0, message); // terbaharu di atas
      if (_events.length > 30) _events.removeLast();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Buttons & Gestures'),
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
                  'Widget butang (ElevatedButton, TextButton, OutlinedButton, '
                  'FilledButton) ialah pembungkus siap-guna dengan gaya '
                  'Material. GestureDetector & InkWell pula mengesan gerak '
                  'isyarat mentah (tap, long-press, double-tap) pada mana-mana '
                  'widget. Cuba setiap satu — perhatikan log di bawah.',
            ),
            const SizedBox(height: 16),
            const Text('Widget Butang', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [
                ElevatedButton(
                  onPressed: () => _log('ElevatedButton ditekan'),
                  child: const Text('ElevatedButton'),
                ),
                TextButton(
                  onPressed: () => _log('TextButton ditekan'),
                  child: const Text('TextButton'),
                ),
                OutlinedButton(
                  onPressed: () => _log('OutlinedButton ditekan'),
                  child: const Text('OutlinedButton'),
                ),
                FilledButton(
                  onPressed: () => _log('FilledButton ditekan'),
                  child: const Text('FilledButton'),
                ),
              ],
            ),
            const SizedBox(height: 24),
            const Text('Gesture mentah', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () => _log('GestureDetector: tap'),
                    onLongPress: () => _log('GestureDetector: long-press'),
                    onDoubleTap: () => _log('GestureDetector: double-tap'),
                    child: Container(
                      height: 90,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: KptTheme.navy.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: KptTheme.navy.withValues(alpha: 0.4)),
                      ),
                      child: const Text(
                        'GestureDetector\n(tap / long-press / double-tap)',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Material(
                    // InkWell needs a Material ancestor to draw its ripple.
                    color: KptTheme.gold.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(10),
                    child: InkWell(
                      onTap: () => _log('InkWell: tap (dengan riak/ripple)'),
                      onLongPress: () => _log('InkWell: long-press'),
                      onDoubleTap: () => _log('InkWell: double-tap'),
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        height: 90,
                        alignment: Alignment.center,
                        padding: const EdgeInsets.all(8),
                        child: const Text(
                          'InkWell\n(sama, tapi ada kesan riak/ripple)',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Log peristiwa', style: TextStyle(fontWeight: FontWeight.bold)),
                TextButton(
                  onPressed: _events.isEmpty ? null : () => setState(_events.clear),
                  child: const Text('Kosongkan'),
                ),
              ],
            ),
            const SizedBox(height: 6),
            Expanded(
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.black87,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: _events.isEmpty
                    ? const Center(
                        child: Text(
                          'Belum ada peristiwa. Cuba tekan butang di atas.',
                          style: TextStyle(color: Colors.white54, fontSize: 12),
                        ),
                      )
                    : ListView.builder(
                        itemCount: _events.length,
                        itemBuilder: (context, index) => Text(
                          '${_events.length - index}. ${_events[index]}',
                          style: const TextStyle(
                            color: Colors.greenAccent,
                            fontSize: 11,
                            fontFamily: 'monospace',
                          ),
                        ),
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
