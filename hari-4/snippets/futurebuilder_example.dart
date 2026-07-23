// Contoh pendekatan ALTERNATIF menggunakan FutureBuilder — Hari 4 (SESI 6/7).
//
// Ini BUKAN pendekatan yang digunakan dalam ProgrammeListScreen sebenar
// (yang guna ChangeNotifier + LoadState sebagai lapisan BONUS — silibus rasmi
// kekal `setState()`). FutureBuilder ditunjukkan di sini kerana ia contoh
// PALING RINGKAS untuk paparkan hasil satu `Future` tanpa memerlukan pakej
// `provider` langsung — sesuai untuk skrin yang hanya fetch SEKALI tanpa
// keperluan carian/tapisan/muat semula manual di atasnya.
//
// Rujuk README Hari 4, bahagian "Pendekatan alternatif: FutureBuilder" untuk
// penjelasan penuh kelebihan & batasannya.
//
// Fail ini ditulis SEOLAH-OLAH diletak di dalam projek sebenar
// (projek/ett_mobile/lib/screens/simple_programme_list.dart) — salin
// kandungan di bawah ke lokasi tersebut jika mahu benar-benar jalankannya;
// import di bawah mengikut lokasi itu.

import 'package:flutter/material.dart';

import '../models/programme.dart';
import '../services/programme_service.dart';
import '../widgets/programme_card.dart';

class SimpleProgrammeList extends StatefulWidget {
  const SimpleProgrammeList({super.key});

  @override
  State<SimpleProgrammeList> createState() => _SimpleProgrammeListState();
}

class _SimpleProgrammeListState extends State<SimpleProgrammeList> {
  // PENTING: simpan Future dalam medan State, JANGAN panggil
  // ProgrammeService().fetchProgrammes() terus di dalam `build()`.
  // Jika dipanggil dalam build(), setiap kali widget dibina semula
  // (contohnya bila parent rebuild atas sebab lain), API akan dipanggil
  // BERULANG KALI tanpa disengajakan.
  late Future<List<Programme>> _futureProgrammes;

  @override
  void initState() {
    super.initState();
    _futureProgrammes = ProgrammeService().fetchProgrammes();
  }

  // Untuk sokong "refresh" dengan FutureBuilder, anda perlu setState() untuk
  // cetuskan semula Future — ini contoh manual berbanding RefreshIndicator
  // yang terus panggil provider.load() dalam pendekatan sebenar aplikasi.
  void _refresh() {
    setState(() {
      _futureProgrammes = ProgrammeService().fetchProgrammes();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tawaran Pengajian eTT (contoh FutureBuilder)'),
        actions: [
          IconButton(onPressed: _refresh, icon: const Icon(Icons.refresh)),
        ],
      ),
      body: FutureBuilder<List<Programme>>(
        future: _futureProgrammes,
        builder: (context, snapshot) {
          // 1) Masih menunggu Future selesai.
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          // 2) Future selesai dengan ralat (Future melontar exception).
          if (snapshot.hasError) {
            return Center(child: Text('Ralat: ${snapshot.error}'));
          }

          // 3) Future selesai dengan jayanya — snapshot.data tersedia.
          final items = snapshot.data ?? const <Programme>[];
          if (items.isEmpty) {
            return const Center(child: Text('Tiada tawaran dijumpai.'));
          }

          return ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              return ProgrammeCard(programme: items[index]);
            },
          );
        },
      ),
    );
  }
}
