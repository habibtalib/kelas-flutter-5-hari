import 'dart:async';

import 'package:flutter/material.dart';

import '../../data/sample_programmes.dart';
import '../../models/programme.dart';
import '../../theme.dart';

/// Tiga senario simulasi permintaan data — SEMUA disimulasikan tempatan
/// (tiada rangkaian sebenar) supaya demo boleh berjalan konsisten dalam
/// kelas walaupun tanpa internet.
enum _Scenario { success, timeout, badFormat }

/// Status paparan semasa demo ini.
enum _Status { idle, loading, success, error }

/// Demo: tiga butang (berjaya / timeout / format ralat) memicu satu
/// operasi async yang disimulasikan menerusi try/catch — setiap laluan
/// (path) ralat dikendalikan secara berasingan dengan mesej mesra pengguna.
class ErrorHandlingDemo extends StatefulWidget {
  const ErrorHandlingDemo({super.key});

  @override
  State<ErrorHandlingDemo> createState() => _ErrorHandlingDemoState();
}

class _ErrorHandlingDemoState extends State<ErrorHandlingDemo> {
  _Status _status = _Status.idle;
  String _message = 'Pilih satu senario di bawah untuk mula.';
  List<Programme> _programmes = [];
  _Scenario? _lastScenario;

  /// Simulasi permintaan data yang berjaya, timeout, atau JSON rosak.
  /// Tiada panggilan rangkaian sebenar — hanya Future.delayed + throw.
  Future<List<Programme>> _simulateFetch(_Scenario scenario) async {
    await Future.delayed(const Duration(seconds: 1));
    switch (scenario) {
      case _Scenario.success:
        return sampleProgrammes;
      case _Scenario.timeout:
        throw TimeoutException('Sambungan tamat masa.');
      case _Scenario.badFormat:
        throw const FormatException('Format JSON tidak sah / rosak.');
    }
  }

  Future<void> _run(_Scenario scenario) async {
    setState(() {
      _status = _Status.loading;
      _lastScenario = scenario;
      _message = 'Sedang cuba dapatkan data...';
    });

    try {
      final result = await _simulateFetch(scenario);
      if (!mounted) return;
      setState(() {
        _programmes = result;
        _status = _Status.success;
        _message = 'Berjaya! ${result.length} tawaran diterima.';
      });
    } on TimeoutException catch (e) {
      if (!mounted) return;
      setState(() {
        _status = _Status.error;
        _message = 'Sambungan tamat masa (${e.message}). Sila cuba lagi.';
      });
    } on FormatException catch (e) {
      if (!mounted) return;
      setState(() {
        _status = _Status.error;
        _message = 'Data yang diterima rosak (${e.message}).';
      });
    } catch (e) {
      // Penangkap umum (catch-all) untuk sebarang ralat lain yang tidak
      // dijangka — amalan baik supaya UI tidak terus crash.
      if (!mounted) return;
      setState(() {
        _status = _Status.error;
        _message = 'Ralat tidak dijangka: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pengendalian Ralat (try/catch)'),
        backgroundColor: KptTheme.navy,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const _ExplanationBanner(
              text:
                  'Setiap permintaan data dibalut dalam try/catch. Tekan '
                  'satu senario: "Berjaya" pulangkan data seperti biasa; '
                  '"Timeout" & "Format Ralat" simulasikan kegagalan yang '
                  'ditangkap oleh catch masing-masing (TimeoutException, '
                  'FormatException) supaya UI boleh tunjuk mesej mesra + '
                  'butang "Cuba Lagi", bukan crash.',
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                FilledButton.icon(
                  onPressed: _status == _Status.loading
                      ? null
                      : () => _run(_Scenario.success),
                  icon: const Icon(Icons.check_circle_outline),
                  label: const Text('Berjaya'),
                ),
                OutlinedButton.icon(
                  onPressed: _status == _Status.loading
                      ? null
                      : () => _run(_Scenario.timeout),
                  icon: const Icon(Icons.hourglass_disabled),
                  label: const Text('Timeout'),
                ),
                OutlinedButton.icon(
                  onPressed: _status == _Status.loading
                      ? null
                      : () => _run(_Scenario.badFormat),
                  icon: const Icon(Icons.data_object),
                  label: const Text('Format Ralat'),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Expanded(child: _buildBody()),
          ],
        ),
      ),
    );
  }

  Widget _buildBody() {
    return switch (_status) {
      _Status.idle => Center(child: Text(_message)),
      _Status.loading => const Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(),
              SizedBox(height: 12),
              Text('Sedang cuba...'),
            ],
          ),
        ),
      _Status.success => ListView(
          children: [
            Text(
              _message,
              style: const TextStyle(
                color: Colors.green,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            ..._programmes.map(
              (p) => ListTile(
                leading: Text(p.flagEmoji, style: const TextStyle(fontSize: 20)),
                title: Text(p.universityName),
                subtitle: Text(p.fieldOfStudy),
              ),
            ),
          ],
        ),
      _Status.error => Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.error_outline, color: Colors.red, size: 40),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Text(_message, textAlign: TextAlign.center),
              ),
              const SizedBox(height: 12),
              OutlinedButton.icon(
                onPressed: _lastScenario == null
                    ? null
                    : () => _run(_lastScenario!),
                icon: const Icon(Icons.refresh),
                label: const Text('Cuba Lagi'),
              ),
            ],
          ),
        ),
    };
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
