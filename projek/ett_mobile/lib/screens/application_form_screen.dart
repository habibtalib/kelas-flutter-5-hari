import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../data/document_checklist.dart';
import '../models/application.dart';
import '../models/programme.dart';
import '../providers/application_provider.dart';
import '../providers/profile_provider.dart';
import '../providers/programme_provider.dart';

/// Borang permohonan eTT (SESI 4 & 5).
///
/// PERATURAN SEBENAR eTT: satu permohonan = **SATU negara + SATU bidang**.
/// Panduan awam menekankan **1 negara / 1 bidang**. Dalam bidang itu, pelajar
/// menyusun sehingga **3 pilihan universiti**. Borang ini menguatkuasakan
/// pilihan negara+bidang tunggal, kemudian membenarkan 1–3 pilihan universiti
/// (pilihan 1 wajib; pilihan 2 & 3 pilihan).
///
/// Menggabungkan: Form + TextFormField + validation,
/// DropdownButtonFormField, CheckboxListTile, dan `setState()` untuk state.
class ApplicationFormScreen extends StatefulWidget {
  const ApplicationFormScreen({super.key, required this.programme});

  /// Tawaran yang dipilih daripada skrin butiran — menetapkan negara & bidang
  /// awal serta pilihan universiti pertama.
  final Programme programme;

  @override
  State<ApplicationFormScreen> createState() => _ApplicationFormScreenState();
}

class _ApplicationFormScreenState extends State<ApplicationFormScreen> {
  final _formKey = GlobalKey<FormState>();

  final _nameCtrl = TextEditingController();
  final _icCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _phoneCtrl = TextEditingController();
  final _academicCtrl = TextEditingController();

  EntryCategory? _academicCategory;
  late String _country; // 1 negara (peraturan eTT)
  late String _fieldOfStudy; // 1 bidang (peraturan eTT)

  // 1–3 pilihan universiti dalam bidang tersebut. Pilihan 1 wajib.
  String? _choice1;
  String? _choice2;
  String? _choice3;

  // Senarai semak dokumen — kunci: label dokumen, nilai: dimuat naik?
  final Map<String, bool> _documents = {
    for (final doc in ettDocumentChecklist) doc: false,
  };

  @override
  void initState() {
    super.initState();
    _country = widget.programme.country;
    _fieldOfStudy = widget.programme.fieldOfStudy;
    _choice1 = widget.programme.id;

    // Isi awal daripada profil jika pengguna telah menyimpan profil.
    final profile = context.read<ProfileProvider>();
    if (profile.hasProfile) {
      _nameCtrl.text = profile.name ?? '';
      _icCtrl.text = profile.icNumber ?? '';
      _academicCategory = profile.academicCategory;
    }
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _icCtrl.dispose();
    _emailCtrl.dispose();
    _phoneCtrl.dispose();
    _academicCtrl.dispose();
    super.dispose();
  }

  /// Negara unik yang ada dalam data tawaran.
  List<String> get _countries {
    final all = context.read<ProgrammeProvider>().all;
    return {for (final p in all) p.country}.toList();
  }

  String _countryLabel(String country) => switch (country) {
        'Egypt' => '🇪🇬 Mesir',
        'Morocco' => '🇲🇦 Maghribi',
        _ => country,
      };

  /// Bidang unik dalam negara terpilih.
  List<String> get _fields {
    final all = context.read<ProgrammeProvider>().all;
    return {
      for (final p in all)
        if (p.country == _country) p.fieldOfStudy,
    }.toList();
  }

  /// Tawaran universiti dalam negara + bidang terpilih (untuk pilihan 1–3).
  List<Programme> get _choiceProgrammes =>
      context.read<ProgrammeProvider>().byCountryAndField(_country, _fieldOfStudy);

  /// Apabila negara bertukar: set semula bidang & pilihan universiti.
  void _onCountryChanged(String? value) {
    if (value == null) return;
    setState(() {
      _country = value;
      final fields = _fields;
      _fieldOfStudy = fields.isNotEmpty ? fields.first : '';
      _resetChoices();
    });
  }

  /// Apabila bidang bertukar: set semula pilihan universiti.
  void _onFieldChanged(String? value) {
    if (value == null) return;
    setState(() {
      _fieldOfStudy = value;
      _resetChoices();
    });
  }

  void _resetChoices() {
    final programmes = _choiceProgrammes;
    _choice1 = programmes.isNotEmpty ? programmes.first.id : null;
    _choice2 = null;
    _choice3 = null;
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;

    if (_choice1 == null) {
      _snack('Sila pilih sekurang-kurangnya satu universiti (Pilihan 1).');
      return;
    }
    // Buang nilai kosong & pendua daripada senarai pilihan.
    final choices = <String>[];
    for (final id in [_choice1, _choice2, _choice3]) {
      if (id != null && !choices.contains(id)) choices.add(id);
    }

    final provider = context.read<ApplicationProvider>();
    final application = Application(
      id: provider.nextId(),
      fullName: _nameCtrl.text.trim(),
      icNumber: _icCtrl.text.trim(),
      email: _emailCtrl.text.trim(),
      phoneNumber: _phoneCtrl.text.trim(),
      academicCategory: _academicCategory!,
      academicSummary: _academicCtrl.text.trim(),
      country: _country,
      fieldOfStudy: _fieldOfStudy,
      universityChoiceIds: choices,
      uploadedDocuments: _documents.entries
          .where((e) => e.value)
          .map((e) => e.key)
          .toList(),
      status: ApplicationStatus.submitted,
      submittedAt: DateTime.now(),
    );
    provider.add(application);

    _snack('Permohonan ${application.id} berjaya dihantar!');
    Navigator.of(context).pop(); // tutup borang
  }

  void _snack(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final choiceProgrammes = _choiceProgrammes;

    return Scaffold(
      appBar: AppBar(title: const Text('Borang Permohonan eTT')),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            const Text(
              'Maklumat Pemohon',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _nameCtrl,
              textCapitalization: TextCapitalization.words,
              decoration: const InputDecoration(labelText: 'Nama Penuh'),
              validator: (v) =>
                  (v == null || v.trim().isEmpty) ? 'Nama diperlukan' : null,
            ),
            const SizedBox(height: 14),
            TextFormField(
              controller: _icCtrl,
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'[0-9-]')),
              ],
              decoration: const InputDecoration(
                labelText: 'No. Kad Pengenalan',
                hintText: '051231-14-5678',
              ),
              validator: _validateIc,
            ),
            const SizedBox(height: 14),
            TextFormField(
              controller: _emailCtrl,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(labelText: 'Emel'),
              validator: _validateEmail,
            ),
            const SizedBox(height: 14),
            TextFormField(
              controller: _phoneCtrl,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                labelText: 'No. Telefon',
                hintText: '0123456789',
              ),
              validator: _validatePhone,
            ),
            const SizedBox(height: 24),
            const Text(
              'Kelayakan Akademik',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<EntryCategory>(
              initialValue: _academicCategory,
              decoration: const InputDecoration(
                labelText: 'Kategori Sijil',
                helperText: 'eTT terbuka kepada lepasan SPM & STAM.',
              ),
              items: const [
                DropdownMenuItem(
                  value: EntryCategory.spm,
                  child: Text('SPM'),
                ),
                DropdownMenuItem(
                  value: EntryCategory.stam,
                  child: Text('STAM'),
                ),
              ],
              onChanged: (v) => setState(() => _academicCategory = v),
              validator: (v) => v == null ? 'Sila pilih kategori sijil' : null,
            ),
            const SizedBox(height: 14),
            TextFormField(
              controller: _academicCtrl,
              decoration: const InputDecoration(
                labelText: 'Ringkasan Keputusan',
                hintText: 'Cth: SPM 2025 — 9A',
              ),
              validator: (v) => (v == null || v.trim().isEmpty)
                  ? 'Ringkasan keputusan diperlukan'
                  : null,
            ),
            const SizedBox(height: 24),
            const Text(
              'Pilihan Pengajian',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            // Nota peraturan sebenar eTT.
            Text(
              'Peraturan eTT: 1 negara + 1 bidang setiap permohonan. Anda '
              'boleh menyusun sehingga 3 pilihan universiti dalam bidang itu.',
              style: TextStyle(fontSize: 12, color: Colors.grey[700]),
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              initialValue: _country,
              isExpanded: true,
              decoration: const InputDecoration(labelText: 'Negara (satu sahaja)'),
              items: [
                for (final c in _countries)
                  DropdownMenuItem(value: c, child: Text(_countryLabel(c))),
              ],
              onChanged: _onCountryChanged,
              validator: (v) => v == null ? 'Sila pilih negara' : null,
            ),
            const SizedBox(height: 14),
            DropdownButtonFormField<String>(
              initialValue: _fields.contains(_fieldOfStudy) ? _fieldOfStudy : null,
              isExpanded: true,
              decoration: const InputDecoration(labelText: 'Bidang (satu sahaja)'),
              items: [
                for (final f in _fields)
                  DropdownMenuItem(
                    value: f,
                    child: Text(f, overflow: TextOverflow.ellipsis),
                  ),
              ],
              onChanged: _onFieldChanged,
              validator: (v) => v == null ? 'Sila pilih bidang' : null,
            ),
            const SizedBox(height: 16),
            // Pilihan universiti 1 (wajib) → 3 (pilihan).
            _ChoiceDropdown(
              label: 'Pilihan 1 (wajib)',
              value: _choice1,
              programmes: choiceProgrammes,
              onChanged: (v) => setState(() => _choice1 = v),
              validator: (v) => v == null ? 'Pilihan 1 diperlukan' : null,
            ),
            const SizedBox(height: 14),
            _ChoiceDropdown(
              label: 'Pilihan 2 (pilihan)',
              value: _choice2,
              programmes: choiceProgrammes,
              includeNone: true,
              onChanged: (v) => setState(() => _choice2 = v),
            ),
            const SizedBox(height: 14),
            _ChoiceDropdown(
              label: 'Pilihan 3 (pilihan)',
              value: _choice3,
              programmes: choiceProgrammes,
              includeNone: true,
              onChanged: (v) => setState(() => _choice3 = v),
            ),
            const SizedBox(height: 24),
            const Text(
              'Senarai Semak Dokumen',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text(
              'Dalam sistem sebenar, dokumen dimuat naik selepas status LAYAK.',
              style: TextStyle(fontSize: 12, color: Colors.grey[700]),
            ),
            const SizedBox(height: 8),
            for (final doc in ettDocumentChecklist)
              CheckboxListTile(
                dense: true,
                contentPadding: EdgeInsets.zero,
                controlAffinity: ListTileControlAffinity.leading,
                title: Text(doc),
                value: _documents[doc],
                onChanged: (v) =>
                    setState(() => _documents[doc] = v ?? false),
              ),
            const SizedBox(height: 24),
            FilledButton.icon(
              onPressed: _submit,
              icon: const Icon(Icons.send),
              label: const Text('Hantar Permohonan'),
            ),
          ],
        ),
      ),
    );
  }

  String? _validateIc(String? v) {
    if (v == null || v.trim().isEmpty) return 'No. KP diperlukan';
    final digits = v.replaceAll('-', '');
    if (digits.length != 12) return 'No. KP mesti 12 digit';
    return null;
  }

  String? _validateEmail(String? v) {
    if (v == null || v.trim().isEmpty) return 'Emel diperlukan';
    final regex = RegExp(r'^[\w.+-]+@[\w-]+\.[\w.-]+$');
    return regex.hasMatch(v.trim()) ? null : 'Format emel tidak sah';
  }

  String? _validatePhone(String? v) {
    if (v == null || v.trim().isEmpty) return 'No. telefon diperlukan';
    final digits = v.replaceAll(RegExp(r'[\s-]'), '');
    if (!RegExp(r'^\+?\d{9,15}$').hasMatch(digits)) {
      return 'No. telefon tidak sah';
    }
    return null;
  }
}

/// Dropdown pilihan universiti dalam bidang terpilih.
class _ChoiceDropdown extends StatelessWidget {
  const _ChoiceDropdown({
    required this.label,
    required this.value,
    required this.programmes,
    required this.onChanged,
    this.validator,
    this.includeNone = false,
  });

  final String label;
  final String? value;
  final List<Programme> programmes;
  final ValueChanged<String?> onChanged;
  final String? Function(String?)? validator;

  /// Jika benar, tambah item "Tiada" bernilai null (untuk pilihan opsional).
  final bool includeNone;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      initialValue: value,
      isExpanded: true,
      decoration: InputDecoration(labelText: label),
      items: [
        if (includeNone)
          const DropdownMenuItem<String>(
            value: null,
            child: Text('Tiada'),
          ),
        for (final p in programmes)
          DropdownMenuItem(
            value: p.id,
            child: Text(
              '${p.universityName} (${p.city})',
              overflow: TextOverflow.ellipsis,
            ),
          ),
      ],
      onChanged: onChanged,
      validator: validator,
    );
  }
}
