import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/application.dart';
import '../providers/application_provider.dart';
import '../providers/profile_provider.dart';
import '../theme.dart';

/// Skrin Profil + Dashboard (Hari 5) — ringkasan permohonan ikut status.
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final profile = context.watch<ProfileProvider>();
    final appProvider = context.watch<ApplicationProvider>();
    final counts = appProvider.countByStatus;

    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        // Kad profil
        Card(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: KptTheme.navy,
                  child: Text(
                    (profile.name ?? '?').substring(0, 1).toUpperCase(),
                    style: const TextStyle(color: Colors.white, fontSize: 24),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        profile.name ?? 'Pelajar',
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 2),
                      Text(profile.icNumber ?? '-',
                          style: TextStyle(color: Colors.grey[700])),
                      Text(profile.institution ?? '-',
                          style: TextStyle(color: Colors.grey[700])),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 20),
        const Text('Ringkasan Permohonan',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: KptTheme.navy)),
        const SizedBox(height: 12),
        // Jumlah keseluruhan
        _StatTile(
          label: 'Jumlah Permohonan',
          value: appProvider.total.toString(),
          color: KptTheme.navy,
        ),
        const SizedBox(height: 10),
        // Kiraan setiap status
        GridView.count(
          crossAxisCount: 2,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          childAspectRatio: 2.4,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          children: [
            for (final status in ApplicationStatus.values)
              _StatTile(
                label: status.label,
                value: (counts[status] ?? 0).toString(),
                color: status.color,
              ),
          ],
        ),
        const SizedBox(height: 24),
        OutlinedButton.icon(
          onPressed: () => context.read<ProfileProvider>().logout(),
          icon: const Icon(Icons.logout),
          label: const Text('Log Keluar'),
        ),
      ],
    );
  }
}

class _StatTile extends StatelessWidget {
  const _StatTile({required this.label, required this.value, required this.color});

  final String label;
  final String value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withValues(alpha: 0.4)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(child: Text(label, style: TextStyle(color: color, fontWeight: FontWeight.w600))),
          Text(value, style: TextStyle(color: color, fontSize: 22, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
