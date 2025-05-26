import 'package:aquamon/views/login/login.dart';
import 'package:flutter/material.dart';
import 'package:aquamon/views/partials/navbar.dart';
import 'package:aquamon/views/pages/account/profile_edit.dart';

// Main ProfilePage widget
class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Bottom Navigation Bar
      bottomNavigationBar: const BottomNavBar(currentIndex: 1),

      // AppBar Configuration
      appBar: _buildAppBar(context),

      // Main body content of the page
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: 30),
          child: Column(
            children: [
              // Header Section
              _buildHeader(),

              const SizedBox(height: 20),

              // Profile Image Section
              const CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage('assets/images/profile.png'),
              ),

              const SizedBox(height: 20),

              // Profile Fields (Nama, Nomor Telepon, Username, Password)
              _buildProfileFields(),

              const SizedBox(height: 20),

              // Edit Profile Button
              _buildEditProfileButton(context),

              const SizedBox(height: 10),

              // Logout Button
              _buildLogoutButton(context),
            ],
          ),
        ),
      ),
    );
  }

  // AppBar with custom back button and title
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: const Color(0xFF0D93D3),
      title: const Text(
        'Profil',
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
    );
  }

  // Header with background color
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

  // Profile Fields (Read-only text fields)
  Widget _buildProfileFields() {
    return Column(
      children: const [
        ProfileField(label: 'Nama', value: 'Fattah'),
        ProfileField(label: 'Nomor Telepon', value: '081876876987'),
        ProfileField(label: 'Username', value: 'fattah'),
        ProfileField(label: 'Password', value: 'fattah123'),
      ],
    );
  }

  // Edit Profile Button that navigates to the EditProfilePage
  Widget _buildEditProfileButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const EditProfilePage()),
        );
      },
      child: const Text("Edit Profil"),
    );
  }

  // Logout Button
  Widget _buildLogoutButton(context) {
    return OutlinedButton(
      onPressed: () {
        _showExitConfirmationDialog(context);
      },
      child: const Text('Logout'),
    );
  }

  // Dialog confirmation when user tries to exit without saving
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
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Apakah anda yakin untuk logout?',
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
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const LoginPage(),
                            ),
                          );
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

// ProfileField widget for displaying editable text fields
class ProfileField extends StatelessWidget {
  final String label;
  final String value;

  const ProfileField({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Label for the field
          Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 5),

          // Read-only TextFormField for displaying profile information
          TextFormField(
            initialValue: value,
            readOnly: true,
            decoration: const InputDecoration(
              contentPadding: EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 10,
              ),
              border: OutlineInputBorder(),
            ),
          ),
        ],
      ),
    );
  }
}
