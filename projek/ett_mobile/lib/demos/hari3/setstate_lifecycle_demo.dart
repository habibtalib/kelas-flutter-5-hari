import 'package:flutter/material.dart';

import '../../theme.dart';

/// Demo: kitaran hayat (lifecycle) `StatefulWidget` — `initState`, `build`,
/// `dispose` — dan kesan memanggil `setState()` berbanding TIDAK memanggil
/// `setState()` langsung. Satu suis "guna setState" membolehkan pelajar
/// LIHAT skrin membeku (freeze) apabila setState() tidak dipanggil, walaupun
/// nilai di sebalik tabir sebenarnya berubah.
class SetStateLifecycleDemo extends StatefulWidget {
  const SetStateLifecycleDemo({super.key});

  @override
  State<SetStateLifecycleDemo> createState() => _SetStateLifecycleDemoState();
}

class _SetStateLifecycleDemoState extends State<SetStateLifecycleDemo> {
  int _counter = 0;
  bool _useSetState = true;
  final List<String> _log = [];
  final ScrollController _logScrollCtrl = ScrollController();

  @override
  void initState() {
    super.initState();
    // initState() dipanggil SEKALI sahaja, apabila State dicipta buat kali
    // pertama — tempat sesuai untuk inisialisasi.
    _addLog('initState() dipanggil — State dicipta.');
  }

  @override
  void dispose() {
    // dispose() dipanggil SEKALI sahaja, apabila widget dibuang selama-lama
    // daripada pokok widget — tempat untuk bersihkan resource.
    // (Log ini tidak akan sempat dipaparkan kerana widget sudah dibuang,
    // tetapi guna debugPrint supaya kelihatan dalam konsol semasa demo.)
    debugPrint('SetStateLifecycleDemo: dispose() dipanggil.');
    _logScrollCtrl.dispose();
    super.dispose();
  }

  void _addLog(String message) {
    _log.add(message);
    // Auto-scroll ke bawah selepas frame seterusnya supaya entri terbaharu
    // sentiasa kelihatan.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_logScrollCtrl.hasClients) {
        _logScrollCtrl.jumpTo(_logScrollCtrl.position.maxScrollExtent);
      }
    });
  }

  void _increment() {
    if (_useSetState) {
      // setState() memberitahu Flutter: "data berubah, tolong build() semula".
      setState(() {
        _counter++;
        _addLog('setState() dipanggil — counter jadi $_counter, build() dijadualkan.');
      });
    } else {
      // Nilai BERUBAH di sebalik tabir, tetapi kerana setState() TIDAK
      // dipanggil, Flutter tidak tahu untuk build() semula — skrin "beku"
      // (paparan lama kekal) walaupun _counter sudah bertambah.
      _counter++;
      _addLog(
        'Tiada setState() — counter jadi $_counter dalam memori, tetapi '
        'skrin TIDAK dibina semula (paparan kekal lama).',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // build() dipanggil setiap kali widget perlu dilukis semula — selepas
    // setState(), atau apabila widget induk berubah. Baris ini sendiri
    // membuktikan bilangan kali build() berjalan (lihat log).
    _addLog('build() dijalankan — UI dilukis semula.');

    return Scaffold(
      appBar: AppBar(
        title: const Text('setState() & Lifecycle'),
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
                  'StatefulWidget ada kitaran hayat: initState() (sekali, '
                  'permulaan), build() (setiap kali dilukis semula), '
                  'dispose() (sekali, apabila dibuang). setState() ialah '
                  'isyarat kepada Flutter untuk panggil build() semula. Suis '
                  'di bawah tunjuk apa jadi bila setState() TIDAK dipanggil.',
            ),
            const SizedBox(height: 16),
            SegmentedButton<bool>(
              segments: const [
                ButtonSegment(value: true, label: Text('Guna setState')),
                ButtonSegment(value: false, label: Text('Tanpa setState')),
              ],
              selected: {_useSetState},
              onSelectionChanged: (selection) {
                setState(() {
                  _useSetState = selection.first;
                  _addLog(
                    'Suis ditukar kepada: '
                    '${_useSetState ? 'guna setState' : 'tanpa setState'}.',
                  );
                });
              },
            ),
            const SizedBox(height: 20),
            Center(
              child: Column(
                children: [
                  const Text('Counter (nilai sebenar dalam memori)'),
                  Text(
                    '$_counter',
                    style: const TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                      color: KptTheme.navy,
                    ),
                  ),
                  if (!_useSetState)
                    Text(
                      'Skrin ini TIDAK akan berubah walaupun anda tekan '
                      'butang — cuba tekan beberapa kali!',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.red.shade700, fontSize: 12),
                    ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            FilledButton.icon(
              onPressed: _increment,
              icon: const Icon(Icons.add),
              label: const Text('Tambah counter'),
            ),
            const SizedBox(height: 16),
            const Text('Log kitaran hayat', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 6),
            Expanded(
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.black87,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: ListView.builder(
                  controller: _logScrollCtrl,
                  itemCount: _log.length,
                  itemBuilder: (context, index) => Text(
                    '${index + 1}. ${_log[index]}',
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
