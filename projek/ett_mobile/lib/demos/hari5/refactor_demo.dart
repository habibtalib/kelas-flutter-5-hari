import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../data/sample_programmes.dart';
import '../../models/programme.dart';
import '../../theme.dart';

/// Demo: refactoring — memecahkan SATU kaedah `build()` yang besar kepada
/// beberapa widget kecil, tanpa mengubah paparan akhir.
///
/// "Sebelum" dan "Selepas" mesti kelihatan SAMA di skrin — refactoring
/// mengubah STRUKTUR kod, bukan output visualnya.
class RefactorDemo extends StatefulWidget {
  const RefactorDemo({super.key});

  @override
  State<RefactorDemo> createState() => _RefactorDemoState();
}

enum _ViewMode { before, after }

class _RefactorDemoState extends State<RefactorDemo> {
  _ViewMode _mode = _ViewMode.before;

  @override
  Widget build(BuildContext context) {
    final programme = sampleProgrammes.first;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Refactoring: Sebelum vs Selepas'),
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
                  'Kad tawaran di bawah dipaparkan dua cara: "Sebelum" — SATU '
                  'kaedah build() panjang dengan semua widget bersarang '
                  '(nested) terus di dalamnya; "Selepas" — kad yang SAMA '
                  'disusun daripada beberapa widget kecil (_Flag, '
                  '_TitleBlock, _CostRow). Tukar togol di bawah — perhatikan '
                  'output kekal SAMA.',
            ),
            const SizedBox(height: 16),
            SegmentedButton<_ViewMode>(
              segments: const [
                ButtonSegment(
                  value: _ViewMode.before,
                  label: Text('Sebelum'),
                  icon: Icon(Icons.code),
                ),
                ButtonSegment(
                  value: _ViewMode.after,
                  label: Text('Selepas'),
                  icon: Icon(Icons.widgets_outlined),
                ),
              ],
              selected: {_mode},
              onSelectionChanged: (selection) {
                setState(() => _mode = selection.first);
              },
            ),
            const SizedBox(height: 16),
            if (_mode == _ViewMode.before)
              _CardBefore(programme: programme)
            else
              _CardAfter(programme: programme),
            const SizedBox(height: 16),
            _ModeNote(mode: _mode),
          ],
        ),
      ),
    );
  }
}

/// Nota kecil di bawah kad, berubah ikut mod yang dipilih.
class _ModeNote extends StatelessWidget {
  const _ModeNote({required this.mode});

  final _ViewMode mode;

  @override
  Widget build(BuildContext context) {
    final text = mode == _ViewMode.before
        ? 'Kod "Sebelum": semua widget ditulis terus dalam build() — susah '
            'dibaca, tiada bahagian boleh diguna semula, dan SEMUANYA dibina '
            'semula (rebuild) setiap kali induk berubah.'
        : 'Kod "Selepas": build() utama kini pendek — hanya menyusun '
            '_Flag, _TitleBlock & _CostRow. Sub-widget dengan const '
            'constructor boleh DILANGKAU (skipped) oleh Flutter bila input '
            'tidak berubah — output SAMA, prestasi lebih baik.';

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: KptTheme.navy.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: KptTheme.navy.withValues(alpha: 0.25)),
      ),
      child: Text(text, style: const TextStyle(fontSize: 12, height: 1.4)),
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

// ============================================================================
// SEBELUM — satu build() panjang, semua widget bersarang terus di dalamnya.
// ============================================================================
//
// Guna [Programme] yang sama dengan "Selepas" supaya output boleh dibanding
// terus. Perhatikan betapa panjang & bersarang build() ini berbanding
// _CardAfter di bawah — tiada bahagian boleh diguna semula atau dijadikan
// const secara berasingan.
class _CardBefore extends StatelessWidget {
  const _CardBefore({required this.programme});

  final Programme programme;

  @override
  Widget build(BuildContext context) {
    final rm = NumberFormat.currency(
      locale: 'ms_MY',
      symbol: 'RM',
      decimalDigits: 0,
    );

    return Card(
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // -- bendera, ditulis terus di sini --
                Text(
                  programme.flagEmoji,
                  style: const TextStyle(fontSize: 30),
                ),
                const SizedBox(width: 12),
                // -- universiti, bidang & lokasi, ditulis terus di sini --
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        programme.universityName,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: KptTheme.navy,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        programme.fieldOfStudy,
                        style: TextStyle(
                          color: Colors.grey[800],
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        '${programme.city}, ${programme.countryLabel}',
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                // -- kos anggaran, ditulis terus di sini --
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      rm.format(programme.estimatedAnnualCostMyr),
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: KptTheme.navy,
                      ),
                    ),
                    Text(
                      '/tahun',
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 12),
            // -- cip kategori & negara, ditulis terus di sini juga --
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 3,
                  ),
                  decoration: BoxDecoration(
                    color: KptTheme.gold.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    programme.category.label,
                    style: const TextStyle(
                      color: KptTheme.gold,
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 3,
                  ),
                  decoration: BoxDecoration(
                    color: KptTheme.navy.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    programme.countryLabel,
                    style: const TextStyle(
                      color: KptTheme.navy,
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      // ~150 baris untuk SATU kad — semuanya dalam satu build().
    );
  }
}

// ============================================================================
// SELEPAS — build() utama pendek, disusun daripada widget kecil.
// ============================================================================
//
// Output SAMA seperti _CardBefore, tetapi build() di sini hanya "menyusun"
// (compose) beberapa widget kecil: _Flag, _TitleBlock, _CostRow & _Pill.
// Setiap satu boleh diuji berasingan, diguna semula di skrin lain, dan
// mempunyai const constructor supaya Flutter boleh melangkau (skip)
// rebuild bila data tidak berubah.
class _CardAfter extends StatelessWidget {
  const _CardAfter({required this.programme});

  final Programme programme;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _Flag(emoji: programme.flagEmoji),
                const SizedBox(width: 12),
                Expanded(
                  child: _TitleBlock(
                    universityName: programme.universityName,
                    fieldOfStudy: programme.fieldOfStudy,
                    locationLabel:
                        '${programme.city}, ${programme.countryLabel}',
                  ),
                ),
                const SizedBox(width: 8),
                _CostRow(costMyr: programme.estimatedAnnualCostMyr),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                _Pill(text: programme.category.label, color: KptTheme.gold),
                const SizedBox(width: 8),
                _Pill(text: programme.countryLabel, color: KptTheme.navy),
              ],
            ),
          ],
        ),
      ),
      // ~30 baris — build() utama kini mudah dibaca sebagai "peta" kad ini.
    );
  }
}

/// Bendera negara sahaja. Kecil, jelas tujuannya, boleh diuji secara berasingan.
class _Flag extends StatelessWidget {
  const _Flag({required this.emoji});

  final String emoji;

  @override
  Widget build(BuildContext context) {
    return Text(emoji, style: const TextStyle(fontSize: 30));
  }
}

/// Nama universiti + bidang + lokasi. Diekstrak berasingan daripada bendera
/// & kos supaya setiap bahagian boleh berubah bebas tanpa menjejaskan yang
/// lain — dan boleh diguna semula, cth. dalam skrin butiran tawaran.
class _TitleBlock extends StatelessWidget {
  const _TitleBlock({
    required this.universityName,
    required this.fieldOfStudy,
    required this.locationLabel,
  });

  final String universityName;
  final String fieldOfStudy;
  final String locationLabel;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          universityName,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: KptTheme.navy,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          fieldOfStudy,
          style: TextStyle(
            color: Colors.grey[800],
            fontSize: 13,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          locationLabel,
          style: TextStyle(color: Colors.grey[600], fontSize: 12),
        ),
      ],
    );
  }
}

/// Anggaran kos tahunan sahaja — kecil, mudah diuji: "diberi RM 23000, papar
/// 'RM 23,000' dan '/tahun'". Formatting (NumberFormat) dikendalikan di sini
/// supaya widget induk tidak perlu tahu tentang locale/currency.
class _CostRow extends StatelessWidget {
  const _CostRow({required this.costMyr});

  final double costMyr;

  @override
  Widget build(BuildContext context) {
    final rm = NumberFormat.currency(
      locale: 'ms_MY',
      symbol: 'RM',
      decimalDigits: 0,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          rm.format(costMyr),
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: KptTheme.navy,
          ),
        ),
        Text('/tahun', style: TextStyle(color: Colors.grey[600], fontSize: 11)),
      ],
    );
  }
}

/// Cip label kecil (kategori kemasukan / negara) — diguna dua kali, jadi
/// diekstrak sebagai widget berasingan supaya warna & bentuk konsisten.
class _Pill extends StatelessWidget {
  const _Pill({required this.text, required this.color});

  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: color,
          fontSize: 11,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
