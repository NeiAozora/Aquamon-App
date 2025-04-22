import 'dart:ffi';

import 'package:aquamon/views/pages/history.dart';
import 'package:flutter/material.dart';
import 'package:aquamon/views/partials/navbar.dart';
import 'package:aquamon/views/pages/account/profile.dart';
import 'package:aquamon/views/pages/settings/settings.dart';

class AeratorPage extends StatefulWidget {
  const AeratorPage({super.key});

  @override
  State<AeratorPage> createState() => _AeratorPageState();
}

class _AeratorPageState extends State<AeratorPage> {
  String selectedKolam = '2';

  @override
  Widget build(BuildContext context) {

    

    return Scaffold(
      bottomNavigationBar: BottomNavBar(currentIndex: 0),
      body: SafeArea(
        child: Column(
          children: [
            _Header(),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    Image.asset('assets/images/fish_tank.png', height: 120),
                    const SizedBox(height: 20),
                    const NH3StatusRow(),
                    const SizedBox(height: 20),
                    const AutoToggle(),
                    const SizedBox(height: 20),
                    _KolamDropdown(
                      onChanged: (value) {
                        setState(() {
                          selectedKolam = value;
                        });
                      },
                    ),
                    const SizedBox(height: 30),
                    const Text(
                      'Hidupkan Penguras',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 10),
                    PowerButton(
                      angkakolam: selectedKolam,
                      onPressed: () {
                        debugPrint('Power toggled for kolam $selectedKolam');
                      },
                    ),
                    const SizedBox(height: 30),
                    OutlinedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => HistoryPage(kolam: int.tryParse(selectedKolam) ?? 0),
                          ),                        );
                      },
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Text(
                        'Buka Riwayat Pengecekan\nKolam $selectedKolam',
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          decoration: const BoxDecoration(
            color: Color(0xFF0288D1),
            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(40)),
          ),
          child: Row(
            children: const [
              SizedBox(width: 10),
              Text(
                'Aerator',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _NH3Card extends StatelessWidget {
  const _NH3Card();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.blue),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: const [
            Text('Nilai NH3', style: TextStyle(fontSize: 14)),
            SizedBox(height: 5),
            Text(
              '0.25',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text('PPM', style: TextStyle(fontSize: 12)),
          ],
        ),
      ),
    );
  }
}

class _StatusCard extends StatelessWidget {
  const _StatusCard();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.only(left: 10),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.blue),
          borderRadius: BorderRadius.circular(8),
        ),
        child: const Center(
          child: Text(
            'Aman',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}

class AutoToggle extends StatefulWidget {
  const AutoToggle({super.key});

  @override
  State<AutoToggle> createState() => _AutoToggleState();
}

class _AutoToggleState extends State<AutoToggle> {
  bool light = true;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Text('Pengurasan Otomatis', style: TextStyle(fontSize: 14)),
        const Spacer(),
        Switch(
          value: light,
          activeColor: Colors.blue,
          onChanged: (bool value) {
            setState(() {
              light = value;
            });
          },
        ),
      ],
    );
  }
}

class _KolamDropdown extends StatefulWidget {
  final ValueChanged<String> onChanged;

  const _KolamDropdown({required this.onChanged, Key? key}) : super(key: key);

  @override
  State<_KolamDropdown> createState() => _KolamDropdownState();
}

class _KolamDropdownState extends State<_KolamDropdown> {
  String selected = '2';

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Daftar Kolam',
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.blue),
            borderRadius: BorderRadius.circular(8),
          ),
          child: DropdownButton<String>(
            value: selected,
            isExpanded: true,
            underline: const SizedBox(),
            items: const [
              DropdownMenuItem(value: '1', child: Text('Kolam 1')),
              DropdownMenuItem(value: '2', child: Text('Kolam 2')),
            ],
            onChanged: (value) {
              if (value != null) {
                setState(() => selected = value);
                widget.onChanged(value);
              }
            },
          ),
        ),
      ],
    );
  }
}

class PowerButton extends StatefulWidget {
  final VoidCallback? onPressed;
  final String angkakolam;

  const PowerButton({
    required this.angkakolam,
    this.onPressed,
    super.key,
  });

  @override
  State<PowerButton> createState() => _PowerButtonState();
}

class _PowerButtonState extends State<PowerButton> {
  bool _isOn = false;

  void _handleTap() {
    if (!_isOn) {
      _showExitConfirmationDialog(context);
    } else {
      _togglePower();
    }
  }

  void _togglePower() {
    setState(() {
      _isOn = !_isOn;
    });
    widget.onPressed?.call();
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
                  Text(
                    'Apakah anda yakin\nuntuk Menguras Kolam ${widget.angkakolam}?',
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
                          backgroundColor: Colors.blue,
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                          _togglePower();
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

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _handleTap,
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: _isOn
              ? const Color.fromARGB(255, 1, 100, 35)
              : const Color(0xFF9EF4AE),
        ),
        padding: const EdgeInsets.all(25),
        child: const Icon(
          Icons.power_settings_new,
          size: 40,
          color: Colors.black,
        ),
      ),
    );
  }
}

class NH3StatusRow extends StatelessWidget {
  const NH3StatusRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // NH3
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Nilai NH3',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 5, width: 5),
              Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 16,
                ),
                decoration: BoxDecoration(
                  border: Border.all(color: Color(0xFF0D93D3)),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Text('0.25', style: TextStyle(fontSize: 16)),
                    SizedBox(width: 5),
                    Text('PPM', style: TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
            ],
          ),

          // Status
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Status',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 5),
              Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 16,
                ),
                decoration: BoxDecoration(
                  border: Border.all(color: Color(0xFF0D93D3)),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'Aman',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
