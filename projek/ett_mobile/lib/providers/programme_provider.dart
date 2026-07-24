// ============================================================================
// ProgrammeProvider — menguruskan senarai tawaran pengajian eTT: pemuatan
// daripada API/fallback tempatan, carian teks bebas, dan tapisan mengikut
// negara/kategori kemasukan.
// ============================================================================

import 'package:flutter/foundation.dart';

import '../models/programme.dart';
import '../services/programme_service.dart';

/// Keadaan pemuatan senarai tawaran.
enum LoadState { idle, loading, loaded, error }

/// Menguruskan senarai tawaran pengajian eTT + carian/tapisan.
class ProgrammeProvider extends ChangeNotifier {
  ProgrammeProvider({ProgrammeService? service})
      : _service = service ?? ProgrammeService();

  final ProgrammeService _service;

  List<Programme> _all = [];
  LoadState _state = LoadState.idle;
  String _query = '';
  String? _countryFilter; // "Egypt" | "Morocco"
  EntryCategory? _categoryFilter;

  LoadState get state => _state;
  String get query => _query;
  String? get countryFilter => _countryFilter;
  EntryCategory? get categoryFilter => _categoryFilter;

  /// Senarai penuh tanpa tapisan.
  List<Programme> get all => List.unmodifiable(_all);

  /// Senarai selepas ditapis mengikut carian, negara & kategori.
  List<Programme> get programmes {
    final q = _query.toLowerCase();
    return _all.where((p) {
      final matchQuery = q.isEmpty ||
          p.universityName.toLowerCase().contains(q) ||
          p.country.toLowerCase().contains(q) ||
          p.countryLabel.toLowerCase().contains(q) ||
          p.city.toLowerCase().contains(q) ||
          p.fieldOfStudy.toLowerCase().contains(q);
      final matchCountry =
          _countryFilter == null || p.country == _countryFilter;
      // Tawaran "both" muncul untuk tapisan SPM mahupun STAM.
      final matchCategory = _categoryFilter == null ||
          p.category == _categoryFilter ||
          p.category == EntryCategory.both;
      return matchQuery && matchCountry && matchCategory;
    }).toList();
  }

  Future<void> load() async {
    _state = LoadState.loading;
    notifyListeners();
    try {
      _all = await _service.fetchProgrammes();
      _state = LoadState.loaded;
    } catch (_) {
      _state = LoadState.error;
    }
    notifyListeners();
  }

  void search(String value) {
    _query = value;
    notifyListeners();
  }

  void filterByCountry(String? country) {
    _countryFilter = country;
    notifyListeners();
  }

  void filterByCategory(EntryCategory? category) {
    _categoryFilter = category;
    notifyListeners();
  }

  Programme? byId(String id) {
    for (final p in _all) {
      if (p.id == id) return p;
    }
    return null;
  }

  /// Tawaran dalam bidang & negara tertentu (untuk pilihan universiti borang).
  List<Programme> byCountryAndField(String country, String fieldOfStudy) {
    return _all
        .where((p) => p.country == country && p.fieldOfStudy == fieldOfStudy)
        .toList();
  }
}
