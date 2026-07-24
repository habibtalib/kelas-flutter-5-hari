import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data/institutions.dart';
import '../models/institution.dart';
import '../providers/profile_provider.dart';
import '../theme.dart';

/// Skrin log masuk pelajar yang ringkas (Hari 5).
///
/// Ini BUKAN pengesahan sebenar — hanya menyimpan profil pelajar secara
/// tempatan untuk mengisi borang secara automatik & memaparkan dashboard.
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();
  final _icCtrl = TextEditingController();
  Institution? _institution;

  @override
  void dispose() {
    _nameCtrl.dispose();
    _icCtrl.dispose();
    super.dispose();
  }

  void _login() {
    if (!_formKey.currentState!.validate() || _institution == null) {
      if (_institution == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Sila pilih institusi.')),
        );
      }
      return;
    }
    context.read<ProfileProvider>().login(
          name: _nameCtrl.text.trim(),
          icNumber: _icCtrl.text.trim(),
          institution: _institution!.name,
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: KptTheme.navy,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                const Icon(Icons.school, color: KptTheme.gold, size: 64),
                const SizedBox(height: 12),
                const Text(
                  'MyBiasiswa KPT',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Text(
                  'Kementerian Pendidikan Tinggi',
                  style: TextStyle(color: Colors.white70),
                ),
                const SizedBox(height: 32),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            controller: _nameCtrl,
                            textCapitalization: TextCapitalization.words,
                            decoration: const InputDecoration(labelText: 'Nama Penuh'),
                            validator: (v) => (v == null || v.trim().isEmpty)
                                ? 'Nama diperlukan'
                                : null,
                          ),
                          const SizedBox(height: 14),
                          TextFormField(
                            controller: _icCtrl,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              labelText: 'No. Kad Pengenalan',
                              hintText: '020315-14-5678',
                            ),
                            validator: (v) {
                              if (v == null || v.trim().isEmpty) {
                                return 'No. KP diperlukan';
                              }
                              if (v.replaceAll('-', '').length != 12) {
                                return 'No. KP mesti 12 digit';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 14),
                          DropdownButtonFormField<Institution>(
                            initialValue: _institution,
                            isExpanded: true,
                            decoration: const InputDecoration(labelText: 'Institusi'),
                            items: institutions
                                .map((i) => DropdownMenuItem(
                                      value: i,
                                      child: Text('${i.shortName} — ${i.name}',
                                          overflow: TextOverflow.ellipsis),
                                    ))
                                .toList(),
                            onChanged: (v) => setState(() => _institution = v),
                          ),
                          const SizedBox(height: 24),
                          SizedBox(
                            width: double.infinity,
                            child: FilledButton(
                              onPressed: _login,
                              child: const Text('Log Masuk'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
