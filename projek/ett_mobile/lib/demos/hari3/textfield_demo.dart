import 'package:flutter/material.dart';

import '../../theme.dart';

/// Demo: `TextField` (tanpa Form) vs `TextFormField` (dalam Form), kedua-dua
/// disambungkan kepada `TextEditingController` untuk membaca nilai semasa
/// pengguna menaip — inilah cara UI "gema" (echo) nilai secara langsung.
class TextFieldDemo extends StatefulWidget {
  const TextFieldDemo({super.key});

  @override
  State<TextFieldDemo> createState() => _TextFieldDemoState();
}

class _TextFieldDemoState extends State<TextFieldDemo> {
  // TextEditingController menyimpan & mengawal teks dalam medan input.
  final _plainCtrl = TextEditingController();
  final _formCtrl = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    // addListener memaksa build semula setiap kali teks berubah, supaya
    // paparan "gema" di bawah sentiasa terkini.
    _plainCtrl.addListener(() => setState(() {}));
    _formCtrl.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    // Controller MESTI dilupuskan (dispose) untuk elak kebocoran memori.
    _plainCtrl.dispose();
    _formCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TextField vs TextFormField'),
        backgroundColor: KptTheme.navy,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            const _ExplanationBanner(
              text:
                  'TextField ialah medan input asas. TextFormField sama, '
                  'tetapi direka untuk digunakan di dalam Form — ia menerima '
                  'validator dan bekerjasama dengan GlobalKey<FormState>. '
                  'Kedua-duanya disambungkan kepada TextEditingController '
                  'yang membaca nilai semasa pengguna menaip.',
            ),
            const SizedBox(height: 20),
            const Text(
              'TextField (di luar Form)',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _plainCtrl,
              decoration: const InputDecoration(
                labelText: 'Nama (TextField)',
                hintText: 'Taip di sini...',
              ),
            ),
            const SizedBox(height: 8),
            _EchoBox(label: 'Nilai TextField sekarang', value: _plainCtrl.text),
            const SizedBox(height: 24),
            const Text(
              'TextFormField (di dalam Form)',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Form(
              key: _formKey,
              child: TextFormField(
                controller: _formCtrl,
                decoration: const InputDecoration(
                  labelText: 'Emel (TextFormField)',
                  hintText: 'Taip di sini...',
                ),
                validator: (v) => (v == null || v.trim().isEmpty)
                    ? 'Medan ini diperlukan'
                    : null,
              ),
            ),
            const SizedBox(height: 8),
            _EchoBox(label: 'Nilai TextFormField sekarang', value: _formCtrl.text),
          ],
        ),
      ),
    );
  }
}

class _EchoBox extends StatelessWidget {
  const _EchoBox({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: KptTheme.navy.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        '$label: ${value.isEmpty ? '(kosong)' : value}',
        style: const TextStyle(fontSize: 13),
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
