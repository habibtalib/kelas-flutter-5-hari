import 'package:flutter/material.dart';

import '../theme.dart';
import 'hari2/card_listtile_demo.dart';
import 'hari2/expanded_flexible_demo.dart';
import 'hari2/gridview_demo.dart';
import 'hari2/listview_builder_demo.dart';
import 'hari2/row_column_demo.dart';
import 'hari2/stack_positioned_demo.dart';
import 'hari2/theme_demo.dart';
import 'hari3/form_validation_demo.dart';
import 'hari3/gesture_button_demo.dart';
import 'hari3/navigation_demo.dart';
import 'hari3/setstate_lifecycle_demo.dart';
import 'hari3/textfield_demo.dart';
import 'hari4/async_await_demo.dart';
import 'hari4/error_handling_demo.dart';
import 'hari4/fetch_json_demo.dart';
import 'hari4/loadstate_demo.dart';
import 'hari5/refactor_demo.dart';

/// Satu entri demo: tajuk, penerangan ringkas, dan pembina skrin demo.
class _Demo {
  const _Demo(this.title, this.subtitle, this.builder);
  final String title;
  final String subtitle;
  final WidgetBuilder builder;
}

/// Satu kumpulan demo untuk satu hari.
class _DemoGroup {
  const _DemoGroup(this.day, this.sessions, this.demos);
  final String day;
  final String sessions;
  final List<_Demo> demos;
}

/// Semua demo, dikumpulkan mengikut hari.
final List<_DemoGroup> _groups = [
  _DemoGroup('Hari 2', 'SESI 2–3 · Layout & Senarai', [
    _Demo('Row & Column',
        'Ubah MainAxisAlignment & CrossAxisAlignment secara langsung',
        (_) => const RowColumnDemo()),
    _Demo('Expanded vs Flexible',
        'Lihat RenderFlex overflow, dan bagaimana Expanded membaikinya',
        (_) => const ExpandedFlexibleDemo()),
    _Demo('Stack & Positioned',
        'Tindih lencana "Diiktiraf" atas banner; gerakkannya',
        (_) => const StackPositionedDemo()),
    _Demo('ListView vs ListView.builder',
        'Bina 1000 item — lihat builder bina secara malas (lazy)',
        (_) => const ListViewBuilderDemo()),
    _Demo('GridView', 'Ubah crossAxisCount & childAspectRatio',
        (_) => const GridViewDemo()),
    _Demo('Card & ListTile', 'Banding Card+ListTile dengan Container biasa',
        (_) => const CardListTileDemo()),
    _Demo('ThemeData', 'Gaya hardcoded vs Theme.of(context)',
        (_) => const ThemeDemo()),
  ]),
  _DemoGroup('Hari 3', 'SESI 4–5 · Navigasi, Borang & setState()', [
    _Demo('Navigator push/pop', 'Visualkan timbunan (stack) skrin',
        (_) => const NavigationDemo()),
    _Demo('TextField vs TextFormField', 'Controller & echo nilai secara langsung',
        (_) => const TextFieldDemo()),
    _Demo('Form & Validation', 'Validator No. KP + emel, ralat inline',
        (_) => const FormValidationDemo()),
    _Demo('setState() & Lifecycle',
        'Log initState/build/dispose; lihat skrin beku tanpa setState',
        (_) => const SetStateLifecycleDemo()),
    _Demo('Button & GestureDetector', 'Log setiap tap / long-press / double-tap',
        (_) => const GestureButtonDemo()),
  ]),
  _DemoGroup('Hari 4', 'SESI 6–7 · REST API & Ralat', [
    _Demo('async / await', 'UI kekal responsif semasa Future berjalan',
        (_) => const AsyncAwaitDemo()),
    _Demo('Fetch JSON dari API', 'ProgrammeService → senarai Programme',
        (_) => const FetchJsonDemo()),
    _Demo('LoadState', 'Idle / Loading / Loaded / Error — setiap satu UI-nya',
        (_) => const LoadStateDemo()),
    _Demo('Pengendalian Ralat', 'try/catch: berjaya / timeout / format ralat',
        (_) => const ErrorHandlingDemo()),
  ]),
  _DemoGroup('Hari 5', 'SESI 8–9 · Kod Moden', [
    _Demo('Refactoring', 'Sebelum (satu build besar) vs Selepas (widget kecil)',
        (_) => const RefactorDemo()),
  ]),
];

/// Skrin menu utama — senarai semua demo interaktif, dikumpulkan ikut hari.
///
/// Jalankan dengan:  flutter run -t lib/demos_main.dart
class DemoGallery extends StatelessWidget {
  const DemoGallery({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Galeri Demo — eTT Mobile')),
      body: ListView(
        children: [
          Container(
            width: double.infinity,
            color: KptTheme.navy.withValues(alpha: 0.06),
            padding: const EdgeInsets.all(16),
            child: const Text(
              'Setiap demo di bawah menunjukkan SATU konsep secara langsung & '
              'interaktif — ubah kawalan pada skrin dan lihat kesannya. '
              'Guna semasa mengajar untuk tunjuk "bagaimana ia berfungsi".',
              style: TextStyle(height: 1.4),
            ),
          ),
          for (final group in _groups) _GroupSection(group: group),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}

class _GroupSection extends StatelessWidget {
  const _GroupSection({required this.group});
  final _DemoGroup group;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 20, 16, 4),
          child: Row(
            children: [
              Text(
                group.day,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: KptTheme.navy,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  group.sessions,
                  style: TextStyle(color: Colors.grey[600], fontSize: 12),
                ),
              ),
            ],
          ),
        ),
        for (var d = 0; d < group.demos.length; d++)
          ListTile(
            leading: CircleAvatar(
              backgroundColor: KptTheme.gold.withValues(alpha: 0.18),
              child: Text('${d + 1}',
                  style: const TextStyle(
                      color: KptTheme.navy, fontWeight: FontWeight.bold)),
            ),
            title: Text(group.demos[d].title),
            subtitle: Text(group.demos[d].subtitle),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(builder: group.demos[d].builder),
            ),
          ),
      ],
    );
  }
}
