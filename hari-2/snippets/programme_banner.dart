// ProgrammeBanner — rujukan Latihan 2 (README Bahagian 3.2).
//
// Contoh widget Stack + Positioned: banner navy satu tawaran pengajian eTT
// dengan pill kategori kemasukan (CategoryPill, daripada
// widgets/programme_card.dart) ditindan di sudut kanan atas.
//
// Salin fail ini ke lib/widgets/programme_banner.dart semasa mengikuti
// Latihan 2 di lab.md, atau guna sebagai rujukan selepas mencuba sendiri.

import 'package:flutter/material.dart';

import '../models/programme.dart';
import '../theme.dart';
import 'programme_card.dart'; // guna semula CategoryPill (fail sama direktori lib/widgets/)

/// Banner satu tawaran pengajian eTT — lapisan warna navy dengan nama
/// universiti & bidang di bawah kiri, dan pill kategori kemasukan
/// (SPM/STAM) ditindan di sudut kanan atas.
class ProgrammeBanner extends StatelessWidget {
  const ProgrammeBanner({super.key, required this.programme});

  final Programme programme;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Lapisan bawah: "gambar" destinasi (guna warna sebagai placeholder).
        Container(
          height: 160,
          width: double.infinity,
          decoration: BoxDecoration(
            color: KptTheme.navy,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Center(
            child: Text(
              programme.flagEmoji,
              style: const TextStyle(fontSize: 56),
            ),
          ),
        ),
        // Lapisan atas: universiti & bidang, dilabuhkan ke bawah kiri.
        Positioned(
          left: 16,
          bottom: 14,
          right: 90, // elak bertindih dengan pill kanan atas pada nama panjang
          child: Text(
            '${programme.universityName}\n${programme.fieldOfStudy}',
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
        // Pill kategori kemasukan (SPM/STAM), ditindan di sudut kanan atas.
        Positioned(
          top: 12,
          right: 12,
          child: CategoryPill(category: programme.category),
        ),
      ],
    );
  }
}
