import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Profil pelajar yang log masuk (Hari 5). Ringkas — disimpan tempatan.
class ProfileProvider extends ChangeNotifier {
  static const _kName = 'profile_name';
  static const _kIc = 'profile_ic';
  static const _kInstitution = 'profile_institution';

  String? _name;
  String? _icNumber;
  String? _institution;

  String? get name => _name;
  String? get icNumber => _icNumber;
  String? get institution => _institution;
  bool get isLoggedIn => _name != null && _name!.isNotEmpty;

  Future<void> loadFromStorage() async {
    final prefs = await SharedPreferences.getInstance();
    _name = prefs.getString(_kName);
    _icNumber = prefs.getString(_kIc);
    _institution = prefs.getString(_kInstitution);
    notifyListeners();
  }

  Future<void> login({
    required String name,
    required String icNumber,
    required String institution,
  }) async {
    _name = name;
    _icNumber = icNumber;
    _institution = institution;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_kName, name);
    await prefs.setString(_kIc, icNumber);
    await prefs.setString(_kInstitution, institution);
    notifyListeners();
  }

  Future<void> logout() async {
    _name = null;
    _icNumber = null;
    _institution = null;
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_kName);
    await prefs.remove(_kIc);
    await prefs.remove(_kInstitution);
    notifyListeners();
  }
}
