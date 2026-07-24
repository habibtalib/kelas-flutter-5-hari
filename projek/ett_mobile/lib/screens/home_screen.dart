import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/programme_provider.dart';
import '../theme.dart';
import 'my_applications_screen.dart';
import 'profile_screen.dart';
import 'programme_list_screen.dart';

/// Rangka utama: BottomNavigationBar (3 tab) + Drawer negara (SESI 3).
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _index = 0;

  static const _titles = ['Program', 'Permohonan Saya', 'Profil'];
  static const _screens = [
    ProgrammeListScreen(),
    MyApplicationsScreen(),
    ProfileScreen(),
  ];

  /// Tapis mengikut negara daripada Drawer, kemudian kembali ke tab Program.
  void _selectCountry(String? country) {
    context.read<ProgrammeProvider>().filterByCountry(country);
    setState(() => _index = 0);
    Navigator.of(context).pop(); // tutup Drawer
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('eTT Mobile · ${_titles[_index]}')),
      drawer: _CountryDrawer(onSelect: _selectCountry),
      body: _screens[_index],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _index,
        onTap: (i) => setState(() => _index = i),
        selectedItemColor: KptTheme.navy,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.school_outlined),
            activeIcon: Icon(Icons.school),
            label: 'Program',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.assignment_outlined),
            activeIcon: Icon(Icons.assignment),
            label: 'Permohonan Saya',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person),
            label: 'Profil',
          ),
        ],
      ),
    );
  }
}

/// Item drawer negara: nilai `null` = semua, "Egypt" = Mesir, "Morocco" = Maghribi.
class _CountryOption {
  const _CountryOption(this.value, this.label, this.flag);
  final String? value;
  final String label;
  final String flag;
}

/// Drawer tapisan negara eTT (Mesir / Maghribi).
class _CountryDrawer extends StatelessWidget {
  const _CountryDrawer({required this.onSelect});

  final void Function(String?) onSelect;

  static const _options = [
    _CountryOption(null, 'Semua Negara', '🌍'),
    _CountryOption('Egypt', 'Mesir', '🇪🇬'),
    _CountryOption('Morocco', 'Maghribi', '🇲🇦'),
  ];

  @override
  Widget build(BuildContext context) {
    final selected = context.watch<ProgrammeProvider>().countryFilter;

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(color: KptTheme.navy),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'eTT Mobile',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Program pengajian Timur Tengah',
                  style: TextStyle(color: Colors.white70, fontSize: 13),
                ),
              ],
            ),
          ),
          for (final option in _options)
            ListTile(
              leading: Text(option.flag, style: const TextStyle(fontSize: 22)),
              title: Text(option.label),
              selected: selected == option.value,
              onTap: () => onSelect(option.value),
            ),
        ],
      ),
    );
  }
}
