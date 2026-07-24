/// Penapis tawaran (filters) untuk carian dan penyaringan.
library;

import '../models/programme.dart';

/// Tapis senarai tawaran ikut teks carian + negara.
/// [country] null bermaksud semua negara.
List<Programme> filterProgrammes(
  List<Programme> all, {
  String query = '',
  String? country,
}) {
  final q = query.trim().toLowerCase();
  return all.where((p) {
    if (country != null && p.country != country) return false;
    if (q.isEmpty) return true;
    return p.universityName.toLowerCase().contains(q) ||
        p.city.toLowerCase().contains(q) ||
        p.fieldOfStudy.toLowerCase().contains(q) ||
        p.country.toLowerCase().contains(q) ||
        p.countryLabel.toLowerCase().contains(q);
  }).toList();
}

/// Senarai negara unik (untuk dropdown borang).
List<String> uniqueCountries(List<Programme> all) =>
    all.map((p) => p.country).toSet().toList();

/// Bidang unik dalam satu negara.
List<String> fieldsInCountry(List<Programme> all, String country) => all
    .where((p) => p.country == country)
    .map((p) => p.fieldOfStudy)
    .toSet()
    .toList();

/// Tawaran yang sepadan negara + bidang (untuk pilihan universiti).
List<Programme> byCountryAndField(
  List<Programme> all,
  String country,
  String field,
) =>
    all.where((p) => p.country == country && p.fieldOfStudy == field).toList();
