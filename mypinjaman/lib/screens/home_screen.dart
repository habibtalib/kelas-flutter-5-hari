import 'package:flutter/material.dart';

import '../models/application.dart';
import 'my_applications_screen.dart';
import 'programme_list_screen.dart';

/// Root aplikasi. Memegang senarai permohonan (single source of truth) dan
/// BottomNavigationBar 2 tab. State diangkat ke sini — corak "lifting state
/// up" yang diajar dalam SESI 5.
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Application> _applications = [];
  int _currentIndex = 0;

  String _nextId() =>
      'ETT-${DateTime.now().year}-'
      '${(_applications.length + 1).toString().padLeft(4, '0')}';

  void _addApplication(Application application) {
    setState(() {
      _applications.add(application.copyWith(id: _nextId()));
      _currentIndex = 1; // tunjuk tab "Permohonan Saya"
    });
  }

  @override
  Widget build(BuildContext context) {
    const titles = ['Tawaran Pengajian', 'Permohonan Saya'];
    return Scaffold(
      appBar: AppBar(title: Text(titles[_currentIndex])),
      body: Column(
        children: [
          _disclaimerBar(),
          Expanded(
            child: IndexedStack(
              index: _currentIndex,
              children: [
                ProgrammeListScreen(onSubmitApplication: _addApplication),
                MyApplicationsScreen(applications: _applications),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (i) => setState(() => _currentIndex = i),
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.school), label: 'Tawaran'),
          BottomNavigationBarItem(
              icon: Icon(Icons.assignment), label: 'Permohonan Saya'),
        ],
      ),
    );
  }

  Widget _disclaimerBar() {
    return Container(
      width: double.infinity,
      color: Colors.amber.shade100,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: const Text(
        'Bahan latihan — BUKAN sistem rasmi e-Timur Tengah. '
        'Permohonan sebenar di dohe.mohe.gov.my/timurtengah.',
        style: TextStyle(fontSize: 11),
        textAlign: TextAlign.center,
      ),
    );
  }
}
