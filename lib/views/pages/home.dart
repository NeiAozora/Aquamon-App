import 'package:aquamon/views/pages/notification/notification.dart';
import 'package:flutter/material.dart';
import 'package:aquamon/views/partials/navbar.dart';
import 'package:aquamon/views/pages/account/profile.dart';
import 'package:aquamon/views/pages/settings/settings.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavBar(currentIndex: 1),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Header Section
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                decoration: const BoxDecoration(
                  color: Color(0xFF0D93D3),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(40),
                  ),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Selamat Datang ,\nPak Fattah',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const NotificationPage()),
                        );
                      },
                      child: const Icon(Icons.notifications, color: Colors.white),
                    ),
                    const SizedBox(width: 10),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const AmoniaSettingsPage()),
                        );
                      },
                      child: const Icon(Icons.settings, color: Colors.white),
                    ),
                    const SizedBox(width: 10),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const ProfilePage()),
                        );
                      },
                      child: const Icon(Icons.account_circle, color: Colors.white),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              // Fish Tank Image
              SizedBox(
                height: 120,
                child: Image.asset(
                  'assets/images/fish_tank.png',
                  fit: BoxFit.contain,
                ),
              ),

              const SizedBox(height: 30),

              // NH3 Card
              Card(
                margin: const EdgeInsets.symmetric(horizontal: 60),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 25),
                  child: Column(
                    children: const [
                      Text('Level NH3 Tertinggi', style: TextStyle(fontSize: 14)),
                      SizedBox(height: 5),
                      Text('0.25',
                          style: TextStyle(
                              fontSize: 32, fontWeight: FontWeight.bold)),
                      Text('ppm'),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Status Card
              Card(
                margin: const EdgeInsets.symmetric(horizontal: 90),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
                  child: Column(
                    children: const [
                      Text('Aman',
                          style: TextStyle(
                              fontSize: 28, fontWeight: FontWeight.bold)),
                      SizedBox(height: 5),
                      Text('Status Semua Kolam', style: TextStyle(fontSize: 14)),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 30), // Padding at the bottom
            ],
          ),
        ),
      ),
    );
  }
}
