import 'package:aquamon/views/partials/save_success_popup.dart';
import 'package:flutter/material.dart';
import 'package:aquamon/views/partials/navbar.dart';
import 'package:flutter/services.dart';

class AmoniaSettingsPage extends StatefulWidget {
  const AmoniaSettingsPage({super.key});

  @override
  State<AmoniaSettingsPage> createState() => _AmoniaSettingsPageState();
}

class _AmoniaSettingsPageState extends State<AmoniaSettingsPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController ppmController;
  late TextEditingController intervalController;
  bool _isFormValid = false;

  @override
  void initState() {
    super.initState();
    ppmController = TextEditingController(text: '0');
    intervalController = TextEditingController(text: '6');
    _isFormValid = true; // Nilai awal valid
    
    // Tambahkan listener untuk memantau perubahan input
    ppmController.addListener(_validateForm);
    intervalController.addListener(_validateForm);
  }

  @override
  void dispose() {
    ppmController.dispose();
    intervalController.dispose();
    super.dispose();
  }

  void _validateForm() {
    final isValid = _formKey.currentState?.validate() ?? false;
    if (isValid != _isFormValid) {
      setState(() {
        _isFormValid = isValid;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const BottomNavBar(currentIndex: 1),
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
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 20),
        child: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            children: [
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
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          ppmController.text,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Text('ppm'),
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
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextFormField(
                  controller: ppmController,
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
                      'ppm',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    errorMaxLines: 2,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Harap masukkan angka';
                    }
                    if (int.tryParse(value) == null) {
                      return 'Harus berisi angka bulat';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Jeda Waktu Penyimpanan Riwayat',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextFormField(
                  controller: intervalController,
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
                    errorMaxLines: 2,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Harap masukkan angka';
                    }
                    if (int.tryParse(value) == null) {
                      return 'Harus berisi angka bulat';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: 
                          _isFormValid ? Colors.white : Colors.grey[300],
                      foregroundColor: 
                          _isFormValid ? Colors.blue : Colors.grey,
                      side: BorderSide(
                        color: _isFormValid ? Colors.blue : Colors.grey,
                      ),
                    ),
                    onPressed: _isFormValid
                        ? () {
                            if (_formKey.currentState!.validate()) {
                              SaveSuccessPopUp.show(context);
                            }
                          }
                        : null,
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