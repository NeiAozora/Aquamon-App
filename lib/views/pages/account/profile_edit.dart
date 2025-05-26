import 'dart:io';

import 'package:aquamon/views/partials/save_success_popup.dart';
import 'package:aquamon/views/partials/navbar.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:file_picker/file_picker.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  File? _imageFile;
  final _formKey = GlobalKey<FormState>();
  bool _isFormValid = false;
  bool _obscurePassword = true;

  void _validateForm() {
    setState(() {
      _isFormValid = _formKey.currentState?.validate() ?? false;
    });
  }

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
      bottomNavigationBar: const BottomNavBar(currentIndex: 1),
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
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: 30),
          child: Column(
            children: [
              _buildHeader(),
              const SizedBox(height: 20),
              _buildProfileImage(),
              const SizedBox(height: 20),
              _buildProfileEditForm(),
              const SizedBox(height: 20),
              _buildActionButtons(),
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
            backgroundImage: _imageFile != null
                ? FileImage(_imageFile!)
                : const AssetImage('assets/images/profile.png') as ImageProvider,
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

  Widget _buildProfileEditForm() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          ProfileEditField(
            label: 'Nama',
            initialValue: 'Fattah',
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Nama tidak boleh kosong';
              }
              if (!RegExp(r'^[a-zA-Z ]+$').hasMatch(value)) {
                return 'Hanya boleh mengandung huruf dan spasi';
              }
              return null;
            },
            onChanged: (_) => _validateForm(),
          ),
          ProfileEditField(
            label: 'Nomor Telepon',
            initialValue: '081876876987',
            keyboardType: TextInputType.phone,
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
            ],
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Nomor telepon tidak boleh kosong';
              }
              if (!RegExp(r'^[0-9]{10,13}$').hasMatch(value)) {
                return 'Harus 10-13 digit angka';
              }
              return null;
            },
            onChanged: (_) => _validateForm(),
          ),
          ProfileEditField(
            label: 'Username',
            initialValue: 'fattah',
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Username tidak boleh kosong';
              }
              if (!RegExp(r'^[a-zA-Z0-9_]+$').hasMatch(value)) {
                return 'Hanya boleh huruf, angka, dan underscore';
              }
              return null;
            },
            onChanged: (_) => _validateForm(),
          ),
          ProfileEditField(
            label: 'Password',
            initialValue: 'fattah123',
            obscureText: _obscurePassword,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Password tidak boleh kosong';
              }
              if (value.length < 8) {
                return 'Minimal 8 karakter';
              }
              if (!RegExp(r'[A-Za-z]').hasMatch(value)) {
                return 'Harus mengandung huruf';
              }
              if (!RegExp(r'[0-9]').hasMatch(value)) {
                return 'Harus mengandung angka';
              }
              return null;
            },
            onChanged: (_) => _validateForm(),
            helperText: 'Kriteria: Minimal 8 karakter, mengandung huruf dan angka',
            suffixIcon: IconButton(
              icon: Icon(
                _obscurePassword ? Icons.visibility_off : Icons.visibility,
                size: 20,
              ),
              onPressed: () {
                setState(() {
                  _obscurePassword = !_obscurePassword;
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
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
        OutlinedButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Kembali'),
        ),
      ],
    );
  }
}

class ProfileEditField extends StatelessWidget {
  final String label;
  final String initialValue;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String?)? validator;
  final bool obscureText;
  final Function(String?)? onChanged;
  final String? helperText;
  final Widget? suffixIcon;

  const ProfileEditField({
    super.key,
    required this.label,
    required this.initialValue,
    this.keyboardType,
    this.inputFormatters,
    this.validator,
    this.obscureText = false,
    this.onChanged,
    this.helperText,
    this.suffixIcon,
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
            initialValue: initialValue,
            keyboardType: keyboardType,
            inputFormatters: inputFormatters,
            obscureText: obscureText,
            validator: validator,
            onChanged: onChanged,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 10,
              ),
              border: const OutlineInputBorder(),
              suffixIcon: suffixIcon ?? const Icon(Icons.edit, size: 20),
              errorStyle: const TextStyle(color: Colors.red, fontSize: 12),
            ),
          ),
          if (helperText != null)
            Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Text(
                helperText!,
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                ),
              ),
            ),
        ],
      ),
    );
  }
}