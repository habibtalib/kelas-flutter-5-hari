// ============================================================================
// ApplicationProvider — menguruskan senarai permohonan eTT + kegigihan
// tempatan melalui `shared_preferences`.
// ============================================================================

import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/application.dart';

/// Menguruskan senarai permohonan eTT + kegigihan tempatan.
///
/// Guna [ChangeNotifier] daripada pakej `provider`. Setiap kali senarai
/// berubah, `notifyListeners()` dipanggil supaya UI membina semula.
/// Senarai disimpan ke peranti melalui `shared_preferences` (JSON string)
/// supaya kekal selepas aplikasi ditutup.
class ApplicationProvider extends ChangeNotifier {
  static const _storageKey = 'my_applications';

  final List<Application> _applications = [];
  int _counter = 0;

  List<Application> get applications => List.unmodifiable(_applications);

  int get total => _applications.length;

  /// Kiraan permohonan mengikut status (untuk dashboard profil).
  Map<ApplicationStatus, int> get countByStatus {
    final map = <ApplicationStatus, int>{};
    for (final status in ApplicationStatus.values) {
      map[status] = _applications.where((a) => a.status == status).length;
    }
    return map;
  }

  /// Muat semula permohonan tersimpan dari peranti.
  Future<void> loadFromStorage() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_storageKey);
    if (raw == null) return;

    final List<dynamic> list = jsonDecode(raw) as List<dynamic>;
    _applications
      ..clear()
      ..addAll(
          list.map((e) => Application.fromJson(e as Map<String, dynamic>)));
    _counter = _applications.length;
    notifyListeners();
  }

  Future<void> _persist() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = jsonEncode(_applications.map((a) => a.toJson()).toList());
    await prefs.setString(_storageKey, raw);
  }

  Future<void> add(Application application) async {
    _applications.insert(0, application);
    notifyListeners();
    await _persist();
  }

  Future<void> updateStatus(String id, ApplicationStatus status) async {
    final index = _applications.indexWhere((a) => a.id == id);
    if (index == -1) return;
    _applications[index] = _applications[index].copyWith(status: status);
    notifyListeners();
    await _persist();
  }

  Future<void> remove(String id) async {
    _applications.removeWhere((a) => a.id == id);
    notifyListeners();
    await _persist();
  }

  /// Jana ID permohonan baharu, cth: ETT-2026-0001.
  String nextId() {
    _counter++;
    final year = DateTime.now().year;
    return 'ETT-$year-${_counter.toString().padLeft(4, '0')}';
  }
}
