// ============================================================================
// ProfileProvider — menguruskan profil pelajar (nama, No. KP, kategori
// akademik) dengan kegigihan tempatan melalui `shared_preferences`.
// ============================================================================

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/programme.dart';

/// Profil pelajar yang menggunakan aplikasi. Ringkas — disimpan tempatan.
class ProfileProvider extends ChangeNotifier {
  static const _kName = 'profile_name';
  static const _kIc = 'profile_ic';
  static const _kCategory = 'profile_category';

  String? _name;
  String? _icNumber;

  /// Kategori akademik pelajar (SPM / STAM).
  EntryCategory? _academicCategory;

  String? get name => _name;
  String? get icNumber => _icNumber;
  EntryCategory? get academicCategory => _academicCategory;
  bool get hasProfile => _name != null && _name!.isNotEmpty;

  Future<void> loadFromStorage() async {
    final prefs = await SharedPreferences.getInstance();
    _name = prefs.getString(_kName);
    _icNumber = prefs.getString(_kIc);
    final cat = prefs.getString(_kCategory);
    _academicCategory = cat == null ? null : EntryCategory.fromString(cat);
    notifyListeners();
  }

  Future<void> save({
    required String name,
    required String icNumber,
    required EntryCategory academicCategory,
  }) async {
    _name = name;
    _icNumber = icNumber;
    _academicCategory = academicCategory;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_kName, name);
    await prefs.setString(_kIc, icNumber);
    await prefs.setString(_kCategory, academicCategory.name);
    notifyListeners();
  }

  Future<void> clear() async {
    _name = null;
    _icNumber = null;
    _academicCategory = null;
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_kName);
    await prefs.remove(_kIc);
    await prefs.remove(_kCategory);
    notifyListeners();
  }
}
