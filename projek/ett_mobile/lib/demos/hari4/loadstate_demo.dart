import 'package:flutter/material.dart';

import '../../data/sample_programmes.dart';
import '../../theme.dart';

/// Empat keadaan pemuatan data yang biasa dalam aplikasi sebenar.
enum _DemoLoadState { idle, loading, loaded, error }

/// Demo: empat butang (Idle / Loading / Loaded / Error) menukar satu enum
/// tempatan yang serupa dengan `LoadState` sebenar (`ProgrammeProvider`),
/// supaya pelajar nampak UI mana yang sepadan dengan keadaan mana.
class LoadStateDemo extends StatefulWidget {
  const LoadStateDemo({super.key});

  @override
  State<LoadStateDemo> createState() => _LoadStateDemoState();
}

class _LoadStateDemoState extends State<LoadStateDemo> {
  _DemoLoadState _state = _DemoLoadState.idle;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('LoadState'),
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
                  'Aplikasi sebenar (lihat ProgrammeProvider) menyimpan satu '
                  'enum LoadState (idle / loading / loaded / error) dan UI '
                  'membina paparan berbeza ikut nilai semasa. Tekan setiap '
                  'butang di bawah untuk lihat paparan yang sepadan dengan '
                  'setiap keadaan.',
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: _DemoLoadState.values.map((value) {
                final selected = value == _state;
                return ChoiceChip(
                  label: Text(_label(value)),
                  selected: selected,
                  selectedColor: KptTheme.gold.withValues(alpha: 0.3),
                  onSelected: (_) => setState(() => _state = value),
                );
              }).toList(),
            ),
            const SizedBox(height: 20),
            const Text(
              'Paparan semasa:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: _buildForState(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _label(_DemoLoadState state) => switch (state) {
        _DemoLoadState.idle => 'Idle',
        _DemoLoadState.loading => 'Loading',
        _DemoLoadState.loaded => 'Loaded',
        _DemoLoadState.error => 'Error',
      };

  Widget _buildForState() {
    return switch (_state) {
      _DemoLoadState.idle => const Center(
          child: Text('Idle — belum ada permintaan data dibuat lagi.'),
        ),
      _DemoLoadState.loading => const Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(),
              SizedBox(height: 12),
              Text('Loading — sedang memuatkan data...'),
            ],
          ),
        ),
      _DemoLoadState.loaded => ListView.builder(
          padding: const EdgeInsets.all(8),
          itemCount: sampleProgrammes.length,
          itemBuilder: (context, index) {
            final p = sampleProgrammes[index];
            return ListTile(
              leading: Text(p.flagEmoji, style: const TextStyle(fontSize: 20)),
              title: Text(p.universityName),
              subtitle: Text(p.fieldOfStudy),
            );
          },
        ),
      _DemoLoadState.error => Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.error_outline, color: Colors.red, size: 40),
              const SizedBox(height: 8),
              const Text('Ralat — data gagal dimuatkan.'),
              const SizedBox(height: 12),
              OutlinedButton.icon(
                onPressed: () => setState(() => _state = _DemoLoadState.loading),
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
