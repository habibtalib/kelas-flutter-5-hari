import 'dart:convert';

import 'package:http/http.dart' as http;

import '../data/sample_programmes.dart';
import '../models/programme.dart';

/// Status muat turun data untuk memandu UI (SESI 6–7).
enum LoadState { loading, loaded, error }

/// Punca data tawaran: cuba REST API, jatuh balik ke senarai tempatan.
class ProgrammeService {
  ProgrammeService({http.Client? client}) : _client = client ?? http.Client();

  final http.Client _client;

  // Semasa Hari 4, tukar ke server tempatan anda, contohnya:
  //   Android emulator : http://10.0.2.2:8000/programmes.json
  //   Web / desktop     : http://localhost:8000/programmes.json
  // (jalankan `python3 -m http.server 8000` dalam projek/mock-api/).
  static const _endpoint =
      'https://raw.githubusercontent.com/kpt-kursus/mock/main/programmes.json';

  Future<List<Programme>> fetchProgrammes() async {
    try {
      final response = await _client
          .get(Uri.parse(_endpoint))
          .timeout(const Duration(seconds: 8));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body) as List<dynamic>;
        return data
            .map((e) => Programme.fromJson(e as Map<String, dynamic>))
            .toList();
      }
      return _fallback();
    } catch (_) {
      return _fallback();
    }
  }

  Future<List<Programme>> _fallback() async {
    await Future.delayed(const Duration(milliseconds: 600));
    return sampleProgrammes;
  }

  void dispose() => _client.close();
}
