import 'package:flutter/material.dart';
import 'package:aquamon/views/partials/navbar.dart';

class HistoryPage extends StatelessWidget {
  final int kolam;

  const HistoryPage({super.key, this.kolam = 0});

  @override
  Widget build(BuildContext context) {
    String header = 'Riwayat Pengecekan';
    if (kolam > 0) {
      header = "$header Kolam $kolam";
    }

    return Scaffold(
      bottomNavigationBar: const BottomNavBar(currentIndex: 2),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              decoration: const BoxDecoration(
                color: Color(0xFF0288D1),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(40),
                ),
              ),
              child: Row(
                children: [
                  const SizedBox(width: 10),
                  Text(
                    header,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                children: const [
                  HistoryCard(ppm: '0.25', date: '23 Maret 2025 12.00.00'),
                  SizedBox(height: 12),
                  HistoryCard(ppm: '1.2', date: '25 Maret 2025 12.00.00'),
                  SizedBox(height: 12),
                  HistoryCard(ppm: '1', date: '29 Maret 2025 12.00.00'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class HistoryCard extends StatelessWidget {
  final String ppm;
  final String date;

  const HistoryCard({super.key, required this.ppm, required this.date});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.blue.shade300),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          // Left
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Kolam 1',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const Text(
                  'Pembaruan Terakhir',
                  style: TextStyle(fontSize: 12),
                ),
                Text(date, style: const TextStyle(fontSize: 12)),
              ],
            ),
          ),
          // Right
          Column(
            children: [
              Text(
                ppm,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Text('ppm'),
            ],
          ),
        ],
      ),
    );
  }
}
