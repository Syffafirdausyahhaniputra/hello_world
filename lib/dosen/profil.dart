import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart'; // Tambahkan ini
import '../login/login.dart'; // Pastikan mengimpor halaman login
import 'editProfil.dart';
import '../Controller/ProfileDosenController.dart'; // Mengimpor controller

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Map<String, dynamic>? profileData;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchProfile();
  }

  Future<void> _fetchProfile() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString('token');

      if (token == null) {
        _showError('Token tidak ditemukan. Harap login kembali.');
        setState(() {
          isLoading = false;
        });
        _logout(context);
        return;
      }

      final response = await ProfileDosenController.fetchDosenProfile(token);

      if (response['success']) {
        setState(() {
          profileData = response['data']; // Gunakan data mentah dari API
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
        });
        _showError(
            response['message'] ?? 'Terjadi kesalahan saat memuat profil.');
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      _showError('Terjadi kesalahan: $e');
    }
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
      backgroundColor: Colors.red,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : profileData == null
              ? const Center(child: Text('Data tidak tersedia'))
              : Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ListView(
                    children: [
                      Center(
                        child: Column(
                          children: [
                            CircleAvatar(
                              radius: 50,
                              backgroundImage: profileData?['avatar'] != null
                                  ? NetworkImage(profileData!['avatar'])
                                      as ImageProvider
                                  : null,
                              child: profileData?['avatar'] == null
                                  ? const Icon(Icons.person,
                                      size: 50, color: Colors.white)
                                  : null,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              profileData?['nama'] ?? 'Nama tidak tersedia',
                              style: const TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              profileData?['nip'] ?? 'NIP tidak tersedia',
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      ListTile(
                        leading: const Icon(Icons.edit, color: Colors.black),
                        title: const Text(
                          'Edit Profil',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w500),
                        ),
                        onTap: () async {
                          // Ambil token dari SharedPreferences dan kirim ke EditProfilPage
                          final SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                          final String? token = prefs.getString('token');
                          if (token != null) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    EditProfilPage(token: token), // Kirim token
                              ),
                            );
                          } else {
                            _showError(
                                'Token tidak ditemukan. Harap login kembali.');
                          }
                        },
                      ),
                      const Divider(),
                      ListTile(
                        leading: const Icon(Icons.logout, color: Colors.black),
                        title: const Text(
                          'Keluar',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w500),
                        ),
                        onTap: () => _showLogoutConfirmationDialog(context),
                      ),
                    ],
                  ),
                ),
    );
  }

  void _showLogoutConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color(0xFF0D47A1),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
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
                      Navigator.of(context).pop();
                      _logout(context);
                    },
                    child: const Text('Ya',
                        style: TextStyle(color: Colors.white, fontSize: 16)),
                  ),
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('Tidak',
                        style: TextStyle(color: Colors.white, fontSize: 16)),
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
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
      (Route<dynamic> route) => false,
    );
  }
}
