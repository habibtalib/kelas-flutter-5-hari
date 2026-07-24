import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/application.dart';
import '../models/programme.dart';
import '../providers/application_provider.dart';
import '../providers/profile_provider.dart';
import '../theme.dart';

/// Skrin Profil + ringkasan permohonan mengikut status.
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final profile = context.watch<ProfileProvider>();
    final applicationProvider = context.watch<ApplicationProvider>();
    final counts = applicationProvider.countByStatus;

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
                    profile.hasProfile
                        ? profile.name!.substring(0, 1).toUpperCase()
                        : '?',
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
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'No. KP: ${profile.icNumber ?? "-"}',
                        style: TextStyle(color: Colors.grey[700]),
                      ),
                      Text(
                        'Kategori: ${profile.academicCategory?.label ?? "-"}',
                        style: TextStyle(color: Colors.grey[700]),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () => _showProfileEditor(context),
                  icon: const Icon(Icons.edit_outlined),
                  tooltip: 'Kemas Kini Profil',
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 20),
        const Text(
          'Ringkasan Permohonan',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: KptTheme.navy,
          ),
        ),
        const SizedBox(height: 12),
        _StatTile(
          label: 'Jumlah Permohonan',
          value: applicationProvider.total.toString(),
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
        if (profile.hasProfile)
          OutlinedButton.icon(
            onPressed: () => context.read<ProfileProvider>().clear(),
            icon: const Icon(Icons.delete_outline),
            label: const Text('Kosongkan Profil'),
          ),
      ],
    );
  }

  void _showProfileEditor(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (_) => const _ProfileDialog(),
    );
  }
}

/// Dialog ringkas untuk mengisi/kemaskini profil pelajar.
class _ProfileDialog extends StatefulWidget {
  const _ProfileDialog();

  @override
  State<_ProfileDialog> createState() => _ProfileDialogState();
}

class _ProfileDialogState extends State<_ProfileDialog> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameCtrl;
  late final TextEditingController _icCtrl;
  EntryCategory? _category;

  @override
  void initState() {
    super.initState();
    final profile = context.read<ProfileProvider>();
    _nameCtrl = TextEditingController(text: profile.name ?? '');
    _icCtrl = TextEditingController(text: profile.icNumber ?? '');
    _category = profile.academicCategory;
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _icCtrl.dispose();
    super.dispose();
  }

  void _save() {
    if (!_formKey.currentState!.validate()) return;
    context.read<ProfileProvider>().save(
          name: _nameCtrl.text.trim(),
          icNumber: _icCtrl.text.trim(),
          academicCategory: _category!,
        );
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Profil Pelajar'),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: _nameCtrl,
              textCapitalization: TextCapitalization.words,
              decoration: const InputDecoration(labelText: 'Nama Penuh'),
              validator: (v) =>
                  (v == null || v.trim().isEmpty) ? 'Nama diperlukan' : null,
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _icCtrl,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'No. Kad Pengenalan',
                hintText: '051231-14-5678',
              ),
              validator: (v) {
                if (v == null || v.trim().isEmpty) return 'No. KP diperlukan';
                if (v.replaceAll('-', '').length != 12) {
                  return 'No. KP mesti 12 digit';
                }
                return null;
              },
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<EntryCategory>(
              initialValue: _category,
              decoration: const InputDecoration(labelText: 'Kategori Akademik'),
              items: const [
                DropdownMenuItem(
                  value: EntryCategory.spm,
                  child: Text('SPM'),
                ),
                DropdownMenuItem(
                  value: EntryCategory.stam,
                  child: Text('STAM'),
                ),
              ],
              onChanged: (v) => setState(() => _category = v),
              validator: (v) => v == null ? 'Sila pilih kategori' : null,
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Batal'),
        ),
        FilledButton(onPressed: _save, child: const Text('Simpan')),
      ],
    );
  }
}

class _StatTile extends StatelessWidget {
  const _StatTile({
    required this.label,
    required this.value,
    required this.color,
  });

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
          Flexible(
            child: Text(
              label,
              style: TextStyle(color: color, fontWeight: FontWeight.w600),
            ),
          ),
          Text(
            value,
            style: TextStyle(
              color: color,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
