import 'package:flutter/material.dart';
import 'package:aquamon/views/partials/navbar.dart';
import 'package:aquamon/views/login/login.dart';
import 'package:aquamon/views/pages/aerator.dart';
import 'package:aquamon/views/pages/home.dart';
import 'package:aquamon/views/pages/history.dart';

void main() {
  runApp(const MonitoringAmoniaApp());
}

class MonitoringAmoniaApp extends StatelessWidget {
  const MonitoringAmoniaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Monitoring Amonia',
      initialRoute: '/login',
      debugShowCheckedModeBanner: false,
      routes: {
        '/login': (context) => const LoginPage(),
        '/home': (context) => const HomePage(),
        '/aerator': (context) => const AeratorPage(),
        '/history': (context) => const HistoryPage(),
      },
    );
  }
}
