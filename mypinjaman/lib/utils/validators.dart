/// Pengesahan borang (fungsi tulen supaya mudah diuji).
library;

/// Medan teks wajib diisi.
String? validateRequired(String? value, {String field = 'Medan ini'}) {
  if (value == null || value.trim().isEmpty) return '$field wajib diisi';
  return null;
}

/// No. Kad Pengenalan mesti 12 digit selepas membuang '-'.
String? validateIc(String? value) {
  if (value == null || value.trim().isEmpty) return 'No. KP wajib diisi';
  final digits = value.replaceAll('-', '');
  if (digits.length != 12 || int.tryParse(digits) == null) {
    return 'No. KP mesti 12 digit';
  }
  return null;
}

/// Emel dalam format yang sah.
String? validateEmail(String? value) {
  if (value == null || value.trim().isEmpty) return 'Emel wajib diisi';
  final re = RegExp(r'^[\w.+-]+@[\w-]+\.[\w.-]+$');
  if (!re.hasMatch(value.trim())) return 'Format emel tidak sah';
  return null;
}

/// No. telefon 9–15 digit (boleh ada '+', ruang, atau '-').
String? validatePhone(String? value) {
  if (value == null || value.trim().isEmpty) return 'No. telefon wajib diisi';
  final cleaned = value.replaceAll(RegExp(r'[\s-]'), '');
  final re = RegExp(r'^\+?\d{9,15}$');
  if (!re.hasMatch(cleaned)) return 'No. telefon tidak sah';
  return null;
}
