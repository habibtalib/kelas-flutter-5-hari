import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/scholarship.dart';
import '../providers/scholarship_provider.dart';
import '../widgets/scholarship_card.dart';
import 'scholarship_detail_screen.dart';

/// Skrin senarai biasiswa — dibina berperingkat sepanjang Hari 1, 3 & 4:
/// Hari 1 = ListView + Card, Hari 3 = carian + tapisan, Hari 4 = FutureBuilder/API.
class ScholarshipListScreen extends StatelessWidget {
  const ScholarshipListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ScholarshipProvider>();

    return Column(
      children: [
        // Bar carian (Hari 3)
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
          child: TextField(
            onChanged: provider.search,
            decoration: const InputDecoration(
              hintText: 'Cari biasiswa atau bidang…',
              prefixIcon: Icon(Icons.search),
            ),
          ),
        ),
        // Cip tapisan kategori (Hari 3)
        SizedBox(
          height: 44,
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            children: [
              _CategoryChip(
                label: 'Semua',
                selected: provider.categoryFilter == null,
                onTap: () => provider.filterByCategory(null),
              ),
              for (final c in ScholarshipCategory.values)
                _CategoryChip(
                  label: c.label,
                  selected: provider.categoryFilter == c,
                  onTap: () => provider.filterByCategory(c),
                ),
            ],
          ),
        ),
        Expanded(child: _buildBody(context, provider)),
      ],
    );
  }

  Widget _buildBody(BuildContext context, ScholarshipProvider provider) {
    switch (provider.state) {
      case LoadState.loading:
      case LoadState.idle:
        return const Center(child: CircularProgressIndicator());
      case LoadState.error:
        return _ErrorView(onRetry: provider.load);
      case LoadState.loaded:
        final items = provider.scholarships;
        if (items.isEmpty) {
          return const Center(child: Text('Tiada biasiswa dijumpai.'));
        }
        return RefreshIndicator(
          onRefresh: provider.load, // pull-to-refresh (Hari 4)
          child: ListView.builder(
            padding: const EdgeInsets.only(bottom: 16),
            itemCount: items.length,
            itemBuilder: (context, index) {
              final s = items[index];
              return ScholarshipCard(
                scholarship: s,
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => ScholarshipDetailScreen(scholarship: s),
                  ),
                ),
              );
            },
          ),
        );
    }
  }
}

class _CategoryChip extends StatelessWidget {
  const _CategoryChip({
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
          const Text('Gagal memuat data biasiswa.'),
          const SizedBox(height: 12),
          FilledButton(onPressed: onRetry, child: const Text('Cuba Lagi')),
        ],
      ),
    );
  }
}
