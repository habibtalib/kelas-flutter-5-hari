import 'dart:async';

import 'package:flutter/material.dart';

import '../../theme.dart';

/// Demo: `async` / `await` tidak menyekat (block) UI.
///
/// Semasa `Future.delayed` sedang menunggu, penunjuk berputar & pembilang
/// "tick" terus berjalan — bukti thread UI utama masih responsif walaupun
/// satu tugasan async sedang berlangsung.
class AsyncAwaitDemo extends StatefulWidget {
  const AsyncAwaitDemo({super.key});

  @override
  State<AsyncAwaitDemo> createState() => _AsyncAwaitDemoState();
}

class _AsyncAwaitDemoState extends State<AsyncAwaitDemo> {
  Timer? _ticker;
  int _tick = 0;
  bool _isRunning = false;
  String _resultText = 'Belum dimulakan. Tekan butang di bawah.';

  @override
  void initState() {
    super.initState();
    // Berdetik setiap 100ms selagi skrin ini terbuka — bukti thread UI
    // utama terus berjalan walaupun kita "await" satu Future yang lambat.
    _ticker = Timer.periodic(const Duration(milliseconds: 100), (_) {
      setState(() => _tick++);
    });
  }

  @override
  void dispose() {
    _ticker?.cancel();
    super.dispose();
  }

  Future<void> _runAsyncTask() async {
    setState(() {
      _isRunning = true;
      _resultText = 'Menunggu Future.delayed(2 saat)...';
    });

    // `await` hanya menjeda FUNGSI ini sahaja. Ia TIDAK menyekat thread UI
    // utama — itulah sebabnya Timer di atas terus berdetik semasa menunggu.
    await Future.delayed(const Duration(seconds: 2));

    if (!mounted) return;
    setState(() {
      _isRunning = false;
      _resultText = 'Tugasan async selesai selepas 2 saat!';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('async & await'),
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
                  'Kod SEGERAK (sync) menyekat (block) UI sehingga selesai — '
                  'skrin "beku" sepanjang tempoh itu. Kod TAK SEGERAK (async) '
                  'dengan await hanya menjeda fungsi berkenaan; thread UI '
                  'utama terus bebas melukis animasi & mengemas kini widget '
                  'lain. Pembilang "Tick" & penunjuk berputar di bawah terus '
                  'berjalan semasa Future.delayed(2 saat) sedang menunggu.',
            ),
            const SizedBox(height: 20),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    const Text(
                      'Bukti UI masih hidup',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(
                          width: 28,
                          height: 28,
                          child: CircularProgressIndicator(strokeWidth: 3),
                        ),
                        const SizedBox(width: 16),
                        Text(
                          'Tick: $_tick',
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            FilledButton.icon(
              onPressed: _isRunning ? null : _runAsyncTask,
              icon: _isRunning
                  ? const SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    )
                  : const Icon(Icons.play_arrow),
              label: Text(
                _isRunning ? 'Sedang menunggu (2 saat)...' : 'Mula Tugasan Async',
              ),
            ),
            const SizedBox(height: 12),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Text(_resultText, style: const TextStyle(fontSize: 13)),
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
