import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../data/institutions.dart';
import '../models/application.dart';
import '../models/institution.dart';
import '../models/scholarship.dart';
import '../providers/application_provider.dart';
import '../providers/profile_provider.dart';

/// Borang permohonan biasiswa (Hari 2) — Form + TextFormField + validation +
/// dropdown institusi. Hantar → simpan ke ApplicationProvider (Hari 3).
class ApplicationFormScreen extends StatefulWidget {
  const ApplicationFormScreen({super.key, required this.scholarship});

  final Scholarship scholarship;

  @override
  State<ApplicationFormScreen> createState() => _ApplicationFormScreenState();
}

class _ApplicationFormScreenState extends State<ApplicationFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();
  final _icCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _phoneCtrl = TextEditingController();
  final _cgpaCtrl = TextEditingController();
  Institution? _institution;

  @override
  void initState() {
    super.initState();
    // Isi awal daripada profil jika pengguna telah log masuk (Hari 5).
    final profile = context.read<ProfileProvider>();
    if (profile.isLoggedIn) {
      _nameCtrl.text = profile.name ?? '';
      _icCtrl.text = profile.icNumber ?? '';
      _institution = institutions.firstWhere(
        (i) => i.name == profile.institution,
        orElse: () => institutions.first,
      );
    }
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _icCtrl.dispose();
    _emailCtrl.dispose();
    _phoneCtrl.dispose();
    _cgpaCtrl.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    if (_institution == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Sila pilih institusi.')),
      );
      return;
    }

    final provider = context.read<ApplicationProvider>();
    final app = ScholarshipApplication(
      id: provider.nextId(),
      scholarshipId: widget.scholarship.id,
      scholarshipName: widget.scholarship.name,
      applicantName: _nameCtrl.text.trim(),
      icNumber: _icCtrl.text.trim(),
      email: _emailCtrl.text.trim(),
      phone: _phoneCtrl.text.trim(),
      institution: _institution!.name,
      currentCgpa: double.parse(_cgpaCtrl.text.trim()),
      status: ApplicationStatus.submitted,
      submittedAt: DateTime.now(),
    );
    provider.add(app);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Permohonan ${app.id} berjaya dihantar!')),
    );
    Navigator.of(context).pop(); // tutup borang
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Borang Permohonan')),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            Text(
              widget.scholarship.name,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
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
                hintText: '020315-14-5678',
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
              validator: (v) => (v == null || v.trim().length < 9)
                  ? 'No. telefon tidak sah'
                  : null,
            ),
            const SizedBox(height: 14),
            DropdownButtonFormField<Institution>(
              initialValue: _institution,
              decoration: const InputDecoration(labelText: 'Institusi'),
              items: institutions
                  .map((i) => DropdownMenuItem(
                        value: i,
                        child: Text('${i.shortName} — ${i.name}',
                            overflow: TextOverflow.ellipsis),
                      ))
                  .toList(),
              onChanged: (v) => setState(() => _institution = v),
              validator: (v) => v == null ? 'Sila pilih institusi' : null,
            ),
            const SizedBox(height: 14),
            TextFormField(
              controller: _cgpaCtrl,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              decoration: InputDecoration(
                labelText: 'CGPA Semasa',
                helperText:
                    'Minimum untuk biasiswa ini: ${widget.scholarship.minCgpa.toStringAsFixed(2)}',
              ),
              validator: _validateCgpa,
            ),
            const SizedBox(height: 28),
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

  String? _validateCgpa(String? v) {
    if (v == null || v.trim().isEmpty) return 'CGPA diperlukan';
    final cgpa = double.tryParse(v.trim());
    if (cgpa == null || cgpa < 0 || cgpa > 4.0) return 'CGPA antara 0.00 – 4.00';
    if (cgpa < widget.scholarship.minCgpa) {
      return 'CGPA di bawah syarat minimum (${widget.scholarship.minCgpa.toStringAsFixed(2)})';
    }
    return null;
  }
}
