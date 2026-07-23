// ============================================================================
// CONTOH REFACTORING — Widget Besar → Komponen Kecil
// ============================================================================
//
// Fail ini AUTONOM (self-contained) — boleh dijalankan terus. Salin fail ini
// ke `lib/main.dart` projek Flutter kosong (`flutter create pratonton` →
// `flutter run`) untuk lihat kad SEBELUM dan SELEPAS berdampingan, atau baca
// sahaja sebagai bahan rujukan semasa SESI 9 (Refactoring).
//
// SENARIO: kad ringkasan satu tawaran pengajian eTT (macam `ProgrammeCard`
// dalam `projek/ett_mobile/lib/widgets/programme_card.dart`) — bendera,
// universiti, bidang, kos anggaran, dan cip kategori kemasukan (SPM/STAM).
//
// BAHAGIAN 1 (SEBELUM) — semuanya ditulis terus dalam SATU kaedah build().
// BAHAGIAN 2 (SELEPAS) — dipecahkan kepada beberapa StatelessWidget kecil.
//
// Baca nota "KENAPA WIDGET, BUKAN KAEDAH?" di penghujung fail ini.
// ============================================================================

import 'package:flutter/material.dart';

/// Model data ringkas untuk contoh ini sahaja (bukan model sebenar projek —
/// rujuk `Programme` sebenar dalam `projek/ett_mobile/lib/models/programme.dart`).
class TawaranContoh {
  const TawaranContoh({
    required this.flagEmoji,
    required this.universityName,
    required this.fieldOfStudy,
    required this.city,
    required this.countryLabel,
    required this.costMyr,
    required this.categoryLabel,
  });

  final String flagEmoji;
  final String universityName;
  final String fieldOfStudy;
  final String city;
  final String countryLabel;
  final double costMyr;
  final String categoryLabel;
}

const _contohTawaran = TawaranContoh(
  flagEmoji: '🇪🇬',
  universityName: 'Universiti Al-Azhar',
  fieldOfStudy: 'Perubatan (Medicine)',
  city: 'Kaherah (Cairo)',
  countryLabel: 'Mesir',
  costMyr: 23000,
  categoryLabel: 'SPM',
);

// ============================================================================
// BAHAGIAN 1 — SEBELUM (widget besar, satu build() panjang)
// ============================================================================
//
// Masalah dengan corak ini:
// - `build()` sangat panjang — susah dibaca, susah cari bahagian yang mahu
//   diubah tanpa skrol berulang kali.
// - TIDAK boleh guna `const` pada bahagian yang sepatutnya tetap (statik),
//   kerana semuanya "terikat" dalam satu widget besar yang dibina semula
//   (rebuild) SEPENUHNYA setiap kali ibu bapanya (parent) berubah.
// - Tiada apa-apa boleh diguna semula (reuse) di skrin lain — cth. cip
//   kategori kemasukan tidak boleh dipakai semula dalam skrin butiran.

class ProgrammeCardBefore extends StatelessWidget {
  const ProgrammeCardBefore({super.key, required this.tawaran});

  final TawaranContoh tawaran;

  @override
  Widget build(BuildContext context) {
    // Bermula dari sini — SATU kaedah build() mengandungi SEMUA logik paparan.
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // -- bendera --
                Text(tawaran.flagEmoji, style: const TextStyle(fontSize: 30)),
                const SizedBox(width: 12),
                // -- universiti & bidang --
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        tawaran.universityName,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1A2B5C),
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        tawaran.fieldOfStudy,
                        style: TextStyle(
                          color: Colors.grey[800],
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        '${tawaran.city}, ${tawaran.countryLabel}',
                        style: TextStyle(color: Colors.grey[600], fontSize: 12),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                // -- kos anggaran --
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'RM ${tawaran.costMyr.toStringAsFixed(0)}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1A2B5C),
                      ),
                    ),
                    Text(
                      '/tahun',
                      style: TextStyle(color: Colors.grey[600], fontSize: 11),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 12),
            // -- cip kategori kemasukan (dibina inline juga) --
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                color: const Color(0xFFD4A017).withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                tawaran.categoryLabel,
                style: const TextStyle(
                  color: Color(0xFFD4A017),
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
    // ~70 baris untuk SATU kad. Bayangkan skrin dengan 8 tawaran macam ini.
  }
}

// ============================================================================
// BAHAGIAN 2 — SELEPAS (dipecahkan kepada widget kecil)
// ============================================================================
//
// `build()` utama sekarang HANYA menyusun (compose) widget-widget kecil —
// mudah dibaca sebagai "senarai kandungan": bendera+universiti+bidang, kos,
// kategori. Setiap bahagian kini widget berasingan yang boleh:
//   - diberi `const` bila datanya tetap → Flutter LANGKAU rebuild bahagian itu
//   - diuji berasingan (widget test kecil, fokus)
//   - diguna semula di skrin lain (cth. `CategoryPill` dalam skrin butiran)

class ProgrammeCardAfter extends StatelessWidget {
  const ProgrammeCardAfter({super.key, required this.tawaran});

  final TawaranContoh tawaran;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _UniversityInfo(tawaran: tawaran),
                const SizedBox(width: 8),
                _CostInfo(costMyr: tawaran.costMyr),
              ],
            ),
            const SizedBox(height: 12),
            CategoryPill(label: tawaran.categoryLabel),
          ],
        ),
      ),
    );
    // ~15 baris — build() utama kini mudah dibaca sebagai "peta" kad ini.
  }
}

/// Bendera + nama universiti + bidang + lokasi. Widget berasingan supaya
/// `Expanded` di sini tidak "mengganggu" struktur widget induk, dan mudah
/// diuji sendiri.
class _UniversityInfo extends StatelessWidget {
  const _UniversityInfo({required this.tawaran});

  final TawaranContoh tawaran;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(tawaran.flagEmoji, style: const TextStyle(fontSize: 30)),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  tawaran.universityName,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1A2B5C),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  tawaran.fieldOfStudy,
                  style: TextStyle(
                    color: Colors.grey[800],
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  '${tawaran.city}, ${tawaran.countryLabel}',
                  style: TextStyle(color: Colors.grey[600], fontSize: 12),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Paparan kos anggaran tahunan sahaja — kecil, jelas tujuannya, mudah diuji:
/// "diberi RM 23000, papar 'RM 23000' dan '/tahun'".
class _CostInfo extends StatelessWidget {
  const _CostInfo({required this.costMyr});

  final double costMyr;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          'RM ${costMyr.toStringAsFixed(0)}',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Color(0xFF1A2B5C),
          ),
        ),
        Text('/tahun', style: TextStyle(color: Colors.grey[600], fontSize: 11)),
      ],
    );
  }
}

/// Cip kategori kemasukan (SPM / STAM / kedua-duanya). Diekstrak sebagai
/// widget AWAM (bukan `_privat`) kerana ia boleh diguna semula di skrin lain
/// — cth. skrin butiran tawaran (lihat `CategoryPill` sebenar dalam
/// `projek/ett_mobile/lib/widgets/programme_card.dart`).
class CategoryPill extends StatelessWidget {
  const CategoryPill({super.key, required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    const color = Color(0xFFD4A017);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        label,
        style: const TextStyle(
          color: color,
          fontSize: 11,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

// ============================================================================
// PRATONTON BOLEH JALAN — bandingkan SEBELUM & SELEPAS berdampingan
// ============================================================================
//
// Uncomment `main()` di bawah (dan padam/namakan semula `main()` sedia ada
// projek anda, jika ada) untuk jalankan fail ini terus dengan `flutter run`.

void main() => runApp(const _PreviewApp());

class _PreviewApp extends StatelessWidget {
  const _PreviewApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(title: const Text('Refactor: Sebelum vs Selepas')),
        body: ListView(
          padding: const EdgeInsets.symmetric(vertical: 12),
          children: const [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'SEBELUM — satu build() panjang',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            ProgrammeCardBefore(tawaran: _contohTawaran),
            SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'SELEPAS — dipecahkan kepada widget kecil',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            ProgrammeCardAfter(tawaran: _contohTawaran),
          ],
        ),
      ),
    );
  }
}

// ============================================================================
// KENAPA WIDGET, BUKAN KAEDAH? (Extract Widget vs Extract Method)
// ============================================================================
//
// Sesetengah orang cuba "kemas kini" widget besar dengan menulis KAEDAH
// (method) yang memulangkan Widget, bukan KELAS widget berasingan:
//
//   Widget _buildCostInfo() { ... }   // ❌ kaedah, bukan widget
//
// Ini KELIHATAN lebih pendek untuk ditaip, tetapi ada 3 kelemahan besar
// berbanding widget kelas berasingan (`class _CostInfo extends
// StatelessWidget`):
//
// 1. SKOP REBUILD — kaedah `_buildX()` masih dijalankan semula SETIAP KALI
//    `build()` induk dipanggil (ia bukan elemen berasingan dalam pokok
//    widget Flutter). Widget KELAS pula boleh dilangkau (skipped) oleh
//    Flutter jika `const` dan input tidak berubah — prestasi lebih baik.
// 2. `const` — kaedah TIDAK BOLEH jadi `const`; kelas widget BOLEH. `const
//    CategoryPill(label: 'SPM')` memberitahu Flutter "widget ini tidak akan
//    berubah, jangan bina semula" — pengoptimuman percuma.
// 3. GUNA SEMULA — kaedah `_buildX()` terikat kepada kelas induknya sahaja;
//    ia tidak boleh dipanggil dari skrin lain. Kelas widget (`CategoryPill`)
//    boleh diimport dan digunakan di mana-mana sahaja dalam aplikasi —
//    contohnya dalam `ProgrammeDetailScreen` selain `ProgrammeListScreen`.
//
// Peraturan ringkas: jika sebahagian UI cukup kompleks untuk "diasingkan",
// jadikan ia KELAS widget, bukan sekadar kaedah pembantu.
