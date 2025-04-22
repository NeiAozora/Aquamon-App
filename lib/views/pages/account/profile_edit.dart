import 'dart:io';

import 'package:aquamon/views/partials/save_success_popup.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:aquamon/views/partials/navbar.dart';

import 'package:file_picker/file_picker.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  File? _imageFile;

  Future<void> _pickImage() async {
    final result = await FilePicker.platform.pickFiles(type: FileType.image);

    if (result != null && result.files.single.path != null) {
      setState(() {
        _imageFile = File(result.files.single.path!);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Bottom Navigation Bar
      bottomNavigationBar: const BottomNavBar(currentIndex: 1),

      // AppBar Section
      appBar: AppBar(
        backgroundColor: const Color(0xFF0D93D3),
        title: const Text(
          'Edit Profil',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),

      // Main Body of the Page
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: 30),
          child: Column(
            children: [
              // Header section with background
              _buildHeader(),

              const SizedBox(height: 20),

              // Profile picture section with camera icon to change the image
              _buildProfileImage(),

              const SizedBox(height: 20),

              // Profile edit fields
              _buildProfileEditFields(),

              const SizedBox(height: 20),

              // Save/Back Buttons
              _buildActionButtons(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(16),
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Color(0xFF0D93D3),
        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(40)),
      ),
    );
  }

  Widget _buildProfileImage() {
    return GestureDetector(
      onTap: _pickImage,
      child: Stack(
        alignment: Alignment.bottomRight,
        children: [
          CircleAvatar(
            radius: 50,
            backgroundImage:
                _imageFile != null
                    ? FileImage(_imageFile!)
                    : const AssetImage('assets/images/profile.png')
                        as ImageProvider,
          ),
          const CircleAvatar(
            radius: 15,
            backgroundColor: Colors.white,
            child: Icon(Icons.camera_alt, size: 18, color: Colors.black),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileEditFields() {
    return Column(
      children: [
        ProfileEditField(label: 'Nama', value: 'Fattah'),
        ProfileEditField(
          label: 'Nomor Telepon',
          value: '081876876987',
          keyboardType: TextInputType.phone,
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'[+\d]')),
          ],
        ),
        ProfileEditField(label: 'Username', value: 'fattah'),
        ProfileEditField(
          label: 'Password',
          value: 'fattah123',
          keyboardType: TextInputType.visiblePassword,
        ),
      ],
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: () {
            SaveSuccessPopUp.show(context);
          },
          child: const Text('Simpan'),
        ),
        const SizedBox(width: 20),
        OutlinedButton(
          onPressed: () {
            _showExitConfirmationDialog(context);
          },
          child: const Text('Kembali'),
        ),
      ],
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

class ProfileEditField extends StatelessWidget {
  final String label;
  final String value;
  final TextInputType keyboardType;
  final List<TextInputFormatter>? inputFormatters;

  const ProfileEditField({
    super.key,
    required this.label,
    required this.value,
    this.keyboardType = TextInputType.text,
    this.inputFormatters,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 5),
          TextFormField(
            initialValue: value,
            keyboardType: keyboardType,
            inputFormatters: inputFormatters,
            decoration: const InputDecoration(
              contentPadding: EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 10,
              ),
              border: OutlineInputBorder(),
              suffixIcon: Icon(Icons.edit, size: 20),
            ),
          ),
        ],
      ),
    );
  }
}
