import 'package:flutter/material.dart';

import '../data/sample_programmes.dart';
import '../models/application.dart';
import '../models/programme.dart';
import '../utils/programme_filter.dart';
import '../widgets/programme_card.dart';
import 'programme_detail_screen.dart';

/// Tab 1: senarai tawaran pengajian + carian + tapis negara.
class ProgrammeListScreen extends StatefulWidget {
  const ProgrammeListScreen({super.key, required this.onSubmitApplication});

  /// Dipanggil bila borang dihantar (state sebenar dipegang HomeScreen).
  final void Function(Application) onSubmitApplication;

  @override
  State<ProgrammeListScreen> createState() => _ProgrammeListScreenState();
}

class _ProgrammeListScreenState extends State<ProgrammeListScreen> {
  final _searchController = TextEditingController();
  String _query = '';
  String? _country; // null = semua negara

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _openDetail(Programme p) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => ProgrammeDetailScreen(
          programme: p,
          onSubmit: widget.onSubmitApplication,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final results = filterProgrammes(
      sampleProgrammes,
      query: _query,
      country: _country,
    );

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
          child: TextField(
            controller: _searchController,
            decoration: const InputDecoration(
              hintText: 'Cari universiti, bidang, bandar…',
              prefixIcon: Icon(Icons.search),
            ),
            onChanged: (v) => setState(() => _query = v),
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Row(
            children: [
              _filterChip('Semua', null),
              _filterChip('Mesir', 'Egypt'),
              _filterChip('Maghribi', 'Morocco'),
            ],
          ),
        ),
        const SizedBox(height: 4),
        Expanded(
          child: results.isEmpty
              ? const Center(child: Text('Tiada tawaran sepadan.'))
              : ListView.builder(
                  itemCount: results.length,
                  itemBuilder: (_, i) => ProgrammeCard(
                    programme: results[i],
                    onTap: () => _openDetail(results[i]),
                  ),
                ),
        ),
      ],
    );
  }

  Widget _filterChip(String label, String? country) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: ChoiceChip(
        label: Text(label),
        selected: _country == country,
        onSelected: (_) => setState(() => _country = country),
      ),
    );
  }
}
