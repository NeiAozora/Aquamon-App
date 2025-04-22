import 'package:aquamon/views/partials/save_success_popup.dart';
import 'package:flutter/material.dart';
import 'package:aquamon/views/partials/navbar.dart';
import 'package:flutter/services.dart';


class AmoniaSettingsPage extends StatelessWidget {
  const AmoniaSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Default values for form fields
    String selectedPpm = '0.2';
    String selectedInterval = '6';

    return Scaffold(
      // Bottom Navigation Bar
      bottomNavigationBar: const BottomNavBar(currentIndex: 1),

      // AppBar
      appBar: AppBar(
        backgroundColor: const Color(0xFF0D93D3),
        title: const Text(
          'Pengaturan Amonia',
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),

      // Page Background
      backgroundColor: Colors.white,

      // Scrollable Body
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 20),
        child: Column(
          children: [
            // Header with curved bottom left
            Container(
              height: 16,
              decoration: const BoxDecoration(
                color: Color(0xFF0D93D3),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(40),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Circular NH3 Indicator
            Center(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    width: 150,
                    height: 150,
                    child: CircularProgressIndicator(
                      value: 0.2,
                      strokeWidth: 8,
                      backgroundColor: Colors.blue.shade100,
                      valueColor: const AlwaysStoppedAnimation(
                        Color(0xFF0D93D3),
                      ),
                    ),
                  ),
                  const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '0.2',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text('ppm'),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),
            const Text(
              'Batas Kadar Amonia',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),

            // Input field for PPM value
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextFormField(
              initialValue: selectedPpm,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
              ],
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 12,
                ),
                suffix: const Text(
                  'ppm',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),

            ),

            const SizedBox(height: 20),
            const Text(
              'Jeda Waktu Penyimpanan Riwayat',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),

            // Input field for interval value
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextFormField(
              initialValue: selectedInterval,
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
              ],
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 12,
                ),
                suffix: const Text(
                  'jam',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),

            ),

            const SizedBox(height: 30),

            // Save and Cancel Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.blue,
                    side: const BorderSide(color: Colors.blue),
                  ),
                  onPressed: () {
                    SaveSuccessPopUp.show(context);
                  },
                  child: const Text('Simpan'),
                ),
                const SizedBox(width: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.red,
                    side: const BorderSide(color: Colors.red),
                  ),
                  onPressed: () {
                    _showExitConfirmationDialog(context);
                  },
                  child: const Text('Batal'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showExitConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Center(
          child: FractionallySizedBox(
            child: AlertDialog(
              backgroundColor: Colors.grey[300],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Apakah anda yakin\nuntuk keluar dan membuang perubahan?',
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      OutlinedButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: const Text('Tidak'),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                          Navigator.pop(context);
                        },
                        child: const Text('Iya'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
