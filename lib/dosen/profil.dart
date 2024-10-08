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
                    backgroundColor: Color(0xFF0D47A1),
                    child: Icon(
                      Icons.person,
                      size: 40,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 16.0),
                  Text(
                    'Zulfa Ulinnuha',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '222222222',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                  Text(
                    'Dosen Jurusan Teknologi Informasi',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 40.0),
            ListTile(
              leading: Icon(Icons.edit, color: Colors.black),
              title: Text(
                'Edit Profil',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
              onTap: () {
                // Aksi ketika "Edit Profil" ditekan
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const EditProfilPage()),
                );
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.logout, color: Colors.black),
              title: Text(
                'Keluar',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
              onTap: () {
                // Aksi ketika "Keluar" ditekan
                _logout(context); // Memanggil fungsi _logout
              },
            ),
          ],
        ),
      ),
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
