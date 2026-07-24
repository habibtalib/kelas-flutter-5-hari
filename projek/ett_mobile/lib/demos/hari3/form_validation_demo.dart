import 'package:flutter/material.dart';

import '../../theme.dart';

/// Demo: `Form` + `GlobalKey<FormState>` dengan validator No. KP (12 digit)
/// dan emel. Butang "Sahkan" memanggil `validate()` yang menjalankan SETIAP
/// validator dan memaparkan mesej ralat inline secara langsung.
class FormValidationDemo extends StatefulWidget {
  const FormValidationDemo({super.key});

  @override
  State<FormValidationDemo> createState() => _FormValidationDemoState();
}

class _FormValidationDemoState extends State<FormValidationDemo> {
  final _formKey = GlobalKey<FormState>();
  final _icCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();

  // Menyimpan hasil pengesahan terakhir untuk paparan status ringkas.
  bool? _lastResult;

  @override
  void dispose() {
    _icCtrl.dispose();
    _emailCtrl.dispose();
    super.dispose();
  }

  String? _validateIc(String? value) {
    if (value == null || value.trim().isEmpty) return 'No. KP diperlukan';
    final digits = value.replaceAll('-', '');
    if (digits.length != 12 || int.tryParse(digits) == null) {
      return 'No. KP mesti tepat 12 digit (cth: 051231145678)';
    }
    return null;
  }

  String? _validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) return 'Emel diperlukan';
    final regex = RegExp(r'^[\w.+-]+@[\w-]+\.[\w.-]+$');
    if (!regex.hasMatch(value.trim())) return 'Format emel tidak sah';
    return null;
  }

  void _sahkan() {
    // Form.validate() menjalankan SEMUA validator sekali gus. Setiap medan
    // yang gagal akan memaparkan mesej ralatnya sendiri secara automatik.
    final ok = _formKey.currentState!.validate();
    setState(() => _lastResult = ok);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Form Validation'),
        backgroundColor: KptTheme.navy,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            const _ExplanationBanner(
              text:
                  'GlobalKey<FormState> membolehkan kita panggil validate() '
                  'dari luar widget. Setiap TextFormField ada fungsi '
                  'validator sendiri — Form.validate() menjalankan '
                  'kesemuanya sekali gus dan papar ralat terus di bawah '
                  'medan yang gagal.',
            ),
            const SizedBox(height: 20),
            Form(
              key: _formKey,
              // autovalidateMode default (disabled): ralat hanya dipapar
              // selepas validate() dipanggil buat kali pertama — sama seperti
              // dalam ApplicationFormScreen sebenar.
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextFormField(
                    controller: _icCtrl,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'No. Kad Pengenalan',
                      hintText: '051231145678',
                    ),
                    validator: _validateIc,
                  ),
                  const SizedBox(height: 14),
                  TextFormField(
                    controller: _emailCtrl,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      labelText: 'Emel',
                      hintText: 'nama@contoh.com',
                    ),
                    validator: _validateEmail,
                  ),
                  const SizedBox(height: 20),
                  FilledButton.icon(
                    onPressed: _sahkan,
                    icon: const Icon(Icons.check_circle_outline),
                    label: const Text('Sahkan'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            if (_lastResult != null)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: (_lastResult!
                          ? Colors.green
                          : Colors.red.shade700)
                      .withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: _lastResult! ? Colors.green : Colors.red.shade700,
                  ),
                ),
                child: Text(
                  _lastResult!
                      ? 'Semua medan SAH. validate() pulangkan true.'
                      : 'Ada medan TIDAK SAH. validate() pulangkan false — '
                          'lihat mesej ralat merah di atas.',
                  style: TextStyle(
                    color: _lastResult! ? Colors.green.shade800 : Colors.red.shade800,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _ExplanationBanner extends StatelessWidget {
  const _ExplanationBanner({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: KptTheme.gold.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: KptTheme.gold.withValues(alpha: 0.4)),
      ),
      child: Text(text, style: const TextStyle(fontSize: 13, height: 1.4)),
    );
  }
}
