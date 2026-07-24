import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/programme.dart';
import '../providers/programme_provider.dart';
import '../widgets/programme_card.dart';
import 'programme_detail_screen.dart';

/// Skrin senarai tawaran pengajian eTT.
///
/// Menggabungkan topik: ListView.builder & Card (SESI 3), carian dengan
/// TextField (SESI 4), serta keadaan memuat/ralat daripada API (SESI 7).
class ProgrammeListScreen extends StatelessWidget {
  const ProgrammeListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ProgrammeProvider>();

    return Column(
      children: [
        // Bar carian
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
          child: TextField(
            onChanged: provider.search,
            decoration: const InputDecoration(
              hintText: 'Cari universiti, bidang atau negara…',
              prefixIcon: Icon(Icons.search),
            ),
          ),
        ),
        // Cip tapisan negara
        SizedBox(
          height: 44,
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            children: [
              _FilterChip(
                label: 'Semua Negara',
                selected: provider.countryFilter == null,
                onTap: () => provider.filterByCountry(null),
              ),
              _FilterChip(
                label: '🇪🇬 Mesir',
                selected: provider.countryFilter == 'Egypt',
                onTap: () => provider.filterByCountry('Egypt'),
              ),
              _FilterChip(
                label: '🇲🇦 Maghribi',
                selected: provider.countryFilter == 'Morocco',
                onTap: () => provider.filterByCountry('Morocco'),
              ),
            ],
          ),
        ),
        // Cip tapisan kategori (SPM / STAM)
        SizedBox(
          height: 44,
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            children: [
              _FilterChip(
                label: 'Semua Kategori',
                selected: provider.categoryFilter == null,
                onTap: () => provider.filterByCategory(null),
              ),
              _FilterChip(
                label: 'SPM',
                selected: provider.categoryFilter == EntryCategory.spm,
                onTap: () => provider.filterByCategory(EntryCategory.spm),
              ),
              _FilterChip(
                label: 'STAM',
                selected: provider.categoryFilter == EntryCategory.stam,
                onTap: () => provider.filterByCategory(EntryCategory.stam),
              ),
            ],
          ),
        ),
        Expanded(child: _buildBody(context, provider)),
      ],
    );
  }

  Widget _buildBody(BuildContext context, ProgrammeProvider provider) {
    switch (provider.state) {
      case LoadState.idle:
      case LoadState.loading:
        return const Center(child: CircularProgressIndicator());
      case LoadState.error:
        return _ErrorView(onRetry: provider.load);
      case LoadState.loaded:
        final items = provider.programmes;
        if (items.isEmpty) {
          return const Center(child: Text('Tiada program dijumpai.'));
        }
        return RefreshIndicator(
          onRefresh: provider.load, // tarik-untuk-muat-semula
          child: ListView.builder(
            padding: const EdgeInsets.only(bottom: 16),
            itemCount: items.length,
            itemBuilder: (context, index) {
              final p = items[index];
              return ProgrammeCard(
                programme: p,
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => ProgrammeDetailScreen(programme: p),
                  ),
                ),
              );
            },
          ),
        );
    }
  }
}

class _FilterChip extends StatelessWidget {
  const _FilterChip({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: ChoiceChip(
        label: Text(label),
        selected: selected,
        onSelected: (_) => onTap(),
      ),
    );
  }
}

class _ErrorView extends StatelessWidget {
  const _ErrorView({required this.onRetry});

  final Future<void> Function() onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.wifi_off, size: 48, color: Colors.grey),
          const SizedBox(height: 12),
          const Text('Gagal memuat data program.'),
          const SizedBox(height: 12),
          FilledButton(onPressed: onRetry, child: const Text('Cuba Lagi')),
        ],
      ),
    );
  }
}
