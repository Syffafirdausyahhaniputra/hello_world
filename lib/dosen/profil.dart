import 'package:flutter/material.dart';
import '../login/login.dart'; // Pastikan mengimpor halaman login
import 'editProfil.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 50.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundColor: const Color(0xFF0D47A1),
                    child: const Icon(
                      Icons.person,
                      size: 40,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  const Text(
                    'Zulfa Ulinnuha',
                    style: TextStyle(
                      fontSize: 20,
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
                    'Dosen Jurusan Teknologi Informasi',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40.0),
            ListTile(
              leading: const Icon(Icons.edit, color: Colors.black),
              title: const Text(
                'Edit Profil',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
              onTap: () {
                // Aksi ketika "Edit Profil" ditekan
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const EditProfilPage()),
                );
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.logout, color: Colors.black),
              title: const Text(
                'Keluar',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
              onTap: () {
                // Aksi ketika "Keluar" ditekan
                _showLogoutConfirmationDialog(context); // Menampilkan dialog konfirmasi
              },
            ),
          ],
        ),
      ),
    );
  }

  // Fungsi untuk menampilkan dialog konfirmasi
  void _showLogoutConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color(0xFF0D47A1), // Warna latar biru sesuai gambar
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 20),
              const Text(
                'Apakah anda ingin keluar?',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(); // Menutup dialog
                      _logout(context); // Panggil fungsi logout jika "Ya" ditekan
                    },
                    child: const Text(
                      'Ya',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(); // Menutup dialog jika "Tidak" ditekan
                    },
                    child: const Text(
                      'Tidak',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  // Fungsi logout yang mengarahkan ke halaman login
  void _logout(BuildContext context) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
      (Route<dynamic> route) => false, // Menghapus semua rute sebelumnya
    );
  }
}
