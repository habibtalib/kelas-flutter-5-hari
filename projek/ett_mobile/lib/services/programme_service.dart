import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

import '../data/sample_programmes.dart';
import '../models/programme.dart';

/// Servis pengambilan data tawaran pengajian eTT (SESI 6 & 7).
///
/// Cuba ambil daripada API JSON (mock). Jika gagal — tiada internet, pelayan
/// tak dapat dicapai, masa tamat, JSON rosak — ia berpatah balik (fallback)
/// kepada data contoh tempatan supaya aplikasi tetap berfungsi semasa kelas.
class ProgrammeService {
  ProgrammeService({http.Client? client}) : _client = client ?? http.Client();

  final http.Client _client;

  /// Ganti dengan endpoint sebenar/mock anda.
  /// Fail contoh: `projek/mock-api/programmes.json` — hos di GitHub Pages /
  /// json-server / mocki.io, kemudian letak URL di sini.
  static const String _endpoint =
      'https://raw.githubusercontent.com/kpt-kursus/mock/main/programmes.json';

  Future<List<Programme>> fetchProgrammes() async {
    try {
      final response = await _client
          .get(Uri.parse(_endpoint))
          .timeout(const Duration(seconds: 8));

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body) as List<dynamic>;
        return data
            .map((e) => Programme.fromJson(e as Map<String, dynamic>))
            .toList();
      }
      // Kod status bukan 200 → guna data tempatan.
      return _fallback();
    } catch (_) {
      // Ralat rangkaian / masa tamat / JSON rosak → guna data tempatan.
      return _fallback();
    }
  }

  /// Simulasi kelewatan rangkaian supaya penunjuk memuat (loading) kelihatan.
  Future<List<Programme>> _fallback() async {
    await Future.delayed(const Duration(milliseconds: 600));
    return sampleProgrammes;
  }

  void dispose() => _client.close();
}
