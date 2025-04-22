import 'package:flutter/material.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFF0073B1),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Notifikasi", style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold)),
            Text("Pemberitahuan", style: TextStyle(fontSize: 14, color: Colors.white)),
          ],
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: const [
              NotificationCard(
                color: Colors.orange,
                borderColor: Colors.orange,
                textColor: Colors.brown,
                messageLines: [
                  "Kadar Amonia",
                  "Melebihi Batas Normal",
                  "Segera Lakukan Pengursan",
                  "Kolam 1",
                  "Butuh Untuk Segera Dikuras",
                ],
              ),
              SizedBox(height: 20),
              NotificationCard(
                color: Colors.red,
                borderColor: Colors.red,
                textColor: Colors.red,
                messageLines: [
                  "Kadar Amonia",
                  "Melebihi Batas Normal",
                  "Segera Lakukan Pengursan",
                  "Kolam 1",
                  "Butuh Untuk Segera Dikuras",
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class NotificationCard extends StatelessWidget {
  final Color color;
  final Color borderColor;
  final Color textColor;
  final List<String> messageLines;

  const NotificationCard({
    super.key,
    required this.color,
    required this.borderColor,
    required this.textColor,
    required this.messageLines,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            border: Border.all(color: borderColor),
            borderRadius: BorderRadius.circular(12),
            boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(2, 2))],
            color: Colors.white,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: messageLines.map((line) {
              return Text(
                line,
                style: TextStyle(
                  color: textColor,
                  fontWeight: line == messageLines[2] || line == messageLines[4] ? FontWeight.bold : FontWeight.normal,
                  fontSize: 14,
                ),
              );
            }).toList(),
          ),
        ),
        Positioned(
          top: -10,
          right: -10,
          child: CircleAvatar(
            radius: 14,
            backgroundColor: color,
            child: const Icon(Icons.close, size: 16, color: Colors.white),
          ),
        ),
      ],
    );
  }
}
