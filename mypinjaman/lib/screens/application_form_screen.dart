import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../data/document_checklist.dart';
import '../data/sample_programmes.dart';
import '../models/application.dart';
import '../models/programme.dart';
import '../utils/programme_filter.dart';
import '../utils/validators.dart';

/// Borang permohonan eTT dengan pengesahan.
/// Peraturan sebenar: 1 negara + 1 bidang, sehingga 3 pilihan universiti.
class ApplicationFormScreen extends StatefulWidget {
  const ApplicationFormScreen({
    super.key,
    required this.programme,
    required this.onSubmit,
  });

  final Programme programme;
  final void Function(Application) onSubmit;

  @override
  State<ApplicationFormScreen> createState() => _ApplicationFormScreenState();
}

class _ApplicationFormScreenState extends State<ApplicationFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _icController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _summaryController = TextEditingController();

  late String _country;
  late String _field;
  EntryCategory _category = EntryCategory.spm;
  String? _choice1;
  String? _choice2;
  String? _choice3;
  final Set<String> _checkedDocs = {};

  @override
  void initState() {
    super.initState();
    _country = widget.programme.country;
    _field = widget.programme.fieldOfStudy;
    _choice1 = widget.programme.id;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _icController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _summaryController.dispose();
    super.dispose();
  }

  List<Programme> get _choiceOptions =>
      byCountryAndField(sampleProgrammes, _country, _field);

  String _countryLabel(String c) =>
      c == 'Egypt' ? 'Mesir' : (c == 'Morocco' ? 'Maghribi' : c);

  void _onCountryChanged(String? value) {
    if (value == null) return;
    setState(() {
      _country = value;
      _field = fieldsInCountry(sampleProgrammes, value).first;
      _resetChoices();
    });
  }

  void _onFieldChanged(String? value) {
    if (value == null) return;
    setState(() {
      _field = value;
      _resetChoices();
    });
  }

  void _resetChoices() {
    _choice1 = null;
    _choice2 = null;
    _choice3 = null;
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    // Kutip pilihan: buang kosong & pendua, kekalkan susunan.
    final choices = <String>[];
    for (final id in [_choice1, _choice2, _choice3]) {
      if (id != null && id.isNotEmpty && !choices.contains(id)) choices.add(id);
    }
    final application = Application(
      id: '', // id rujukan sebenar diberi oleh HomeScreen
      fullName: _nameController.text.trim(),
      icNumber: _icController.text.replaceAll('-', ''),
      email: _emailController.text.trim(),
      phoneNumber: _phoneController.text.replaceAll(RegExp(r'[\s-]'), ''),
      academicCategory: _category,
      academicSummary: _summaryController.text.trim(),
      country: _country,
      fieldOfStudy: _field,
      universityChoiceIds: choices,
      uploadedDocuments: _checkedDocs.toList(),
      status: ApplicationStatus.submitted,
      submittedAt: DateTime.now(),
    );
    widget.onSubmit(application);
    // Borang dibuka 2 tolak dalam (senarai → butiran → borang); balik terus
    // ke home shell supaya tab "Permohonan Saya" kelihatan selepas hantar.
    Navigator.of(context).popUntil((route) => route.isFirst);
  }

  @override
  Widget build(BuildContext context) {
    final countries = uniqueCountries(sampleProgrammes);
    final fields = fieldsInCountry(sampleProgrammes, _country);
    final options = _choiceOptions;

    return Scaffold(
      appBar: AppBar(title: const Text('Borang Permohonan')),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
            TextFormField(
              controller: _nameController,
              textCapitalization: TextCapitalization.words,
              decoration: const InputDecoration(labelText: 'Nama Penuh'),
              validator: (v) => validateRequired(v, field: 'Nama'),
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _icController,
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'[0-9-]')),
              ],
              decoration: const InputDecoration(
                labelText: 'No. Kad Pengenalan',
                hintText: '051231-14-5678',
              ),
              validator: validateIc,
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(labelText: 'Emel'),
              validator: validateEmail,
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _phoneController,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                labelText: 'No. Telefon',
                hintText: '0123456789',
              ),
              validator: validatePhone,
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<EntryCategory>(
              initialValue: _category,
              decoration: const InputDecoration(labelText: 'Kategori Sijil'),
              items: const [
                DropdownMenuItem(value: EntryCategory.spm, child: Text('SPM')),
                DropdownMenuItem(value: EntryCategory.stam, child: Text('STAM')),
              ],
              onChanged: (v) =>
                  setState(() => _category = v ?? EntryCategory.spm),
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _summaryController,
              decoration: const InputDecoration(
                labelText: 'Ringkasan Keputusan',
                hintText: 'Cth: SPM 2025 — 9A',
              ),
              validator: (v) => validateRequired(v, field: 'Ringkasan keputusan'),
            ),
            const Divider(height: 32),
            const Text(
              'Pilihan Pengajian (1 negara + 1 bidang, sehingga 3 universiti)',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<String>(
              initialValue: _country,
              decoration: const InputDecoration(labelText: 'Negara (satu sahaja)'),
              items: [
                for (final c in countries)
                  DropdownMenuItem(value: c, child: Text(_countryLabel(c))),
              ],
              onChanged: _onCountryChanged,
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<String>(
              initialValue: fields.contains(_field) ? _field : null,
              decoration: const InputDecoration(labelText: 'Bidang (satu sahaja)'),
              items: [
                for (final f in fields)
                  DropdownMenuItem(value: f, child: Text(f)),
              ],
              onChanged: _onFieldChanged,
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<String>(
              initialValue: options.any((p) => p.id == _choice1) ? _choice1 : null,
              decoration: const InputDecoration(labelText: 'Pilihan 1 (wajib)'),
              items: [
                for (final p in options)
                  DropdownMenuItem(value: p.id, child: Text(p.universityName)),
              ],
              validator: (v) =>
                  v == null ? 'Sila pilih sekurang-kurangnya satu universiti' : null,
              onChanged: (v) => setState(() => _choice1 = v),
            ),
            const SizedBox(height: 12),
            _optionalChoice(
              'Pilihan 2 (pilihan)',
              _choice2,
              (v) => setState(() => _choice2 = v),
              options,
            ),
            const SizedBox(height: 12),
            _optionalChoice(
              'Pilihan 3 (pilihan)',
              _choice3,
              (v) => setState(() => _choice3 = v),
              options,
            ),
            const Divider(height: 32),
            const Text('Senarai Semak Dokumen',
                style: TextStyle(fontWeight: FontWeight.bold)),
            for (final doc in ettDocumentChecklist)
              CheckboxListTile(
                title: Text(doc),
                value: _checkedDocs.contains(doc),
                onChanged: (checked) => setState(() {
                  if (checked == true) {
                    _checkedDocs.add(doc);
                  } else {
                    _checkedDocs.remove(doc);
                  }
                }),
              ),
            const SizedBox(height: 24),
            FilledButton(
              onPressed: _submit,
              child: const Text('Hantar Permohonan'),
            ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _optionalChoice(
    String label,
    String? value,
    ValueChanged<String?> onChanged,
    List<Programme> options,
  ) {
    return DropdownButtonFormField<String>(
      initialValue: options.any((p) => p.id == value) ? value : null,
      decoration: InputDecoration(labelText: label),
      items: [
        const DropdownMenuItem<String>(value: null, child: Text('Tiada')),
        for (final p in options)
          DropdownMenuItem(value: p.id, child: Text(p.universityName)),
      ],
      onChanged: onChanged,
    );
  }
}
