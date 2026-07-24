import 'package:flutter/foundation.dart';

import '../models/scholarship.dart';
import '../services/scholarship_service.dart';

/// Keadaan pemuatan senarai biasiswa.
enum LoadState { idle, loading, loaded, error }

/// Menguruskan senarai biasiswa + carian/tapisan (Hari 3 & 4).
class ScholarshipProvider extends ChangeNotifier {
  ScholarshipProvider({ScholarshipService? service})
      : _service = service ?? ScholarshipService();

  final ScholarshipService _service;

  List<Scholarship> _all = [];
  LoadState _state = LoadState.idle;
  String _query = '';
  ScholarshipCategory? _categoryFilter;

  LoadState get state => _state;
  String get query => _query;
  ScholarshipCategory? get categoryFilter => _categoryFilter;

  /// Senarai selepas ditapis mengikut carian & kategori.
  List<Scholarship> get scholarships {
    return _all.where((s) {
      final matchQuery = _query.isEmpty ||
          s.name.toLowerCase().contains(_query.toLowerCase()) ||
          s.fieldOfStudy.toLowerCase().contains(_query.toLowerCase());
      final matchCategory =
          _categoryFilter == null || s.category == _categoryFilter;
      return matchQuery && matchCategory;
    }).toList();
  }

  Future<void> load() async {
    _state = LoadState.loading;
    notifyListeners();
    try {
      _all = await _service.fetchScholarships();
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

  void filterByCategory(ScholarshipCategory? category) {
    _categoryFilter = category;
    notifyListeners();
  }

  Scholarship? byId(String id) {
    for (final s in _all) {
      if (s.id == id) return s;
    }
    return null;
  }
}
