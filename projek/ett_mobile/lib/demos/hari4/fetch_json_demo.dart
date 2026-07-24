import 'dart:convert';

import 'package:flutter/material.dart';

import '../../models/programme.dart';
import '../../services/programme_service.dart';
import '../../theme.dart';

/// Status pengambilan data tempatan untuk demo ini sahaja (bukan
/// `LoadState` sebenar provider — dibuat ringkas untuk tujuan pengajaran).
enum _FetchStatus { idle, loading, loaded }

/// Demo: panggil `ProgrammeService().fetchProgrammes()`, tunjukkan penunjuk
/// memuat, kemudian senarai yang telah di-"parse" daripada JSON kepada
/// objek `Programme`. Bentuk JSON mentah dipaparkan bersebelahan supaya
/// idea "JSON → Dart model" (`Programme.fromJson`) kelihatan jelas.
class FetchJsonDemo extends StatefulWidget {
  const FetchJsonDemo({super.key});

  @override
  State<FetchJsonDemo> createState() => _FetchJsonDemoState();
}

class _FetchJsonDemoState extends State<FetchJsonDemo> {
  final _service = ProgrammeService();
  _FetchStatus _status = _FetchStatus.idle;
  List<Programme> _programmes = [];

  @override
  void dispose() {
    _service.dispose();
    super.dispose();
  }

  Future<void> _fetch() async {
    setState(() => _status = _FetchStatus.loading);

    // ProgrammeService cuba GET dari API (http package) & tukar JSON kepada
    // List<Programme>; jika rangkaian gagal ia berpatah balik ke data
    // tempatan supaya demo tetap berfungsi luar talian.
    final result = await _service.fetchProgrammes();

    if (!mounted) return;
    setState(() {
      _programmes = result;
      _status = _FetchStatus.loaded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fetch & Parse JSON'),
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
                  'Tekan butang untuk panggil ProgrammeService().fetchProgrammes() '
                  '— ia cuba GET dari API (pakej http), tukar respons JSON '
                  'kepada senarai objek Programme melalui Programme.fromJson(). '
                  'Jika rangkaian tidak dapat dicapai, ia berpatah balik '
                  '(fallback) kepada data tempatan supaya demo tetap '
                  'berfungsi luar talian.',
            ),
            const SizedBox(height: 16),
            FilledButton.icon(
              onPressed: _status == _FetchStatus.loading ? null : _fetch,
              icon: const Icon(Icons.cloud_download),
              label: const Text('Ambil dari API'),
            ),
            const SizedBox(height: 16),
            Expanded(child: _buildBody()),
          ],
        ),
      ),
    );
  }

  Widget _buildBody() {
    return switch (_status) {
      _FetchStatus.idle =>
        const Center(child: Text('Belum diambil lagi. Tekan butang di atas.')),
      _FetchStatus.loading => const Center(child: CircularProgressIndicator()),
      _FetchStatus.loaded => ListView(
          children: [
            _JsonShapeCard(programme: _programmes.first),
            const SizedBox(height: 16),
            const Text(
              'Senarai selepas parse (List<Programme>):',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            ..._programmes.map(
              (p) => Card(
                child: ListTile(
                  leading:
                      Text(p.flagEmoji, style: const TextStyle(fontSize: 22)),
                  title: Text(p.universityName),
                  subtitle: Text('${p.fieldOfStudy} · ${p.countryLabel}'),
                ),
              ),
            ),
          ],
        ),
    };
  }
}

/// Tunjuk bentuk JSON mentah bagi SATU rekod, bersebelahan idea bahawa
/// `Programme.fromJson` mengubahnya menjadi objek Dart bertaip kukuh.
class _JsonShapeCard extends StatelessWidget {
  const _JsonShapeCard({required this.programme});

  final Programme programme;

  @override
  Widget build(BuildContext context) {
    const encoder = JsonEncoder.withIndent('  ');
    final rawJson = encoder.convert(programme.toJson());
    return Card(
      color: KptTheme.navy.withValues(alpha: 0.04),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Bentuk JSON mentah → Programme.fromJson()',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              rawJson,
              style: const TextStyle(fontFamily: 'monospace', fontSize: 11),
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
