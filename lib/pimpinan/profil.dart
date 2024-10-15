import 'package:flutter/material.dart';
import '../login/login.dart'; // Pastikan mengimpor halaman login
import 'editprofil.dart';
import 'datasertif.dart'; 
import 'rekomendasi.dart';


class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key); // Menambahkan super.key
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
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
                      'Pimpinan Jurusan Teknologi Informasi',
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
              _buildProfileOption(context, Icons.note, 'Rekomendasi'),
              _buildProfileOption(context, Icons.file_copy, 'Data Sertifikasi/Pelatihan'),
              _buildProfileOption(context, Icons.logout, 'Keluar', isLogout: true),
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
              _showLogoutConfirmationDialog(context); // Menampilkan dialog konfirmasi
            } else if (title == 'Edit Profil') {
              // Navigasi ke halaman EditProfilPage
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const EditProfilPage()),
              );
            }
             else if (title == 'Rekomendasi') {
              // Navigasi ke halaman RekomendasiPage
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => RekomendasiPage()), // Navigasi ke RekomendasiPage
              );
             }
            else if (title == 'Data Sertifikasi/Pelatihan') {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const DataSertifPage()), // Mengarahkan ke halaman DataSertifPage
              );
            }

             else {
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
  
  void _logout(BuildContext context) {
    // Mengarahkan pengguna ke halaman login dan mencegah kembali ke profil
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
      (Route<dynamic> route) => false, // Menghapus semua rute sebelumnya
    );
  }
}
