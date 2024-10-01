import 'package:flutter/material.dart';
import '../login/login.dart'; // Pastikan mengimpor halaman login
import '../bottombar.dart'; // Impor BottomNavBar dari file bottombar.dart

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  int _selectedIndex = 3; // Index untuk halaman Profil

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView( // Menambahkan SingleChildScrollView untuk kemampuan scroll
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 50.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 50, // Memperbesar ukuran avatar
                      backgroundColor: const Color(0xFF002366),
                      child: const Icon(
                        Icons.person,
                        size: 50,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    const Text(
                      'Zulfa Ulinnuha',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Text(
                      '222222222',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                    const Text(
                      'Pimpinan Jurusan Teknologi Informasi', // Menyesuaikan deskripsi sesuai gambar
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40.0),
              _buildProfileOption(context, Icons.person, 'Edit Profil'),
              _buildProfileOption(context, Icons.note, 'Rekomendasi'), // Opsi Rekomendasi
              _buildProfileOption(context, Icons.file_copy, 'Data Sertifikasi/Pelatihan'), // Opsi Data Sertifikasi/Pelatihan
              _buildProfileOption(context, Icons.logout, 'Keluar', isLogout: true), // Opsi Keluar
            ],
          ),
        ),
      ),
    );
  }

  // Fungsi untuk membuat item ListTile
  Widget _buildProfileOption(BuildContext context, IconData icon, String title, {bool isLogout = false}) {
    return Column(
      children: [
        ListTile(
          leading: Icon(icon, color: Colors.black),
          title: Text(
            title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
          ),
          onTap: () {
            if (isLogout) {
              _logout(context);
            } else {
              // Tambahkan aksi yang relevan untuk opsi lainnya di sini
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Navigasi ke: $title')),
              );
            }
          },
        ),
        const Divider(),
      ],
    );
  }

  void _logout(BuildContext context) {
    // Mengarahkan pengguna ke halaman login dan mencegah kembali ke profil
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
      (Route<dynamic> route) => false, // Menghapus semua rute sebelumnya
    );
  }
}
