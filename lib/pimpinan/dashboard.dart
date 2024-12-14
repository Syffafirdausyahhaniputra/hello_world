import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:hello_world/core/sharedPref.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:hello_world/config.dart'; // Impor Config
import 'package:hello_world/Model/UserModel.dart';
import 'package:hello_world/pimpinan/dosenbidang.dart';
import 'package:hello_world/Controller/Dashboard2Controller.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  UserModel? user;
  int jumlahSertifikasiPelatihan = 0;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadDashboardData();
  }

  Future<void> _loadDashboardData() async {
    try {
      // Mendapatkan token dari SharedPreferences
      final token = await Sharedpref.getToken();

      if (token == null) {
        throw Exception('Token tidak ditemukan');
      }

      // Panggil API menggunakan URL dari Config
      final response = await http.get(
        Uri.parse(Config.dashboar2dEndpoint),
        headers: {
          "Content-Type": "application/json; charset=utf-8",
          "Accept": "application/json",
          "Authorization": "Bearer $token",
        },
      );

      // Debugging status code dan body
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);

        if (jsonData['success'] == true) {
          final data = jsonData['data'];

          setState(() {
            user = data['user'] != null
                ? UserModel(
                    userId: 0,
                    roleId: data['user']['role_id'] ?? 0,
                    username: '',
                    nama: data['user']['nama'] ?? '-',
                    nip: '',
                    avatar: '',
                  )
                : null;

            jumlahSertifikasiPelatihan =
                data['jumlahSertifikasiPelatihan'] ?? 0;
            isLoading = false;
          });
        } else {
          throw Exception(
              jsonData['message'] ?? 'Terjadi kesalahan pada respon API');
        }
      } else if (response.statusCode == 404) {
        setState(() {
          isLoading = false;
        });
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text("Data Tidak Ditemukan"),
            content: const Text("Dosen tidak ditemukan untuk user ini."),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("OK"),
              ),
            ],
          ),
        );
      } else {
        throw Exception(
            'Failed to load dashboard: ${response.statusCode} - ${response.body}');
      }
    } catch (e) {
      print('Error loading dashboard data: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> _handleUnauthorized() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('token'); // Hapus token lama
    // Tampilkan dialog login ulang
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Session Expired'),
          content: const Text('Please log in again.'),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pushReplacementNamed('/login');
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              user?.nama ?? 'Loading...',
              style: const TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(width: 8),
            const Icon(
              Icons.account_circle,
              color: Colors.black,
            ),
          ],
        ),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  children: [
                    const SizedBox(height: 10),
                    const Text(
                      'Selamat Datang',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 20),
                    _buildInfoCard(
                      jumlahSertifikasiPelatihan.toString(),
                      'Sertifikasi dan Pelatihan',
                    ),
                    const SizedBox(height: 30),
                    _buildBidangSection(),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
    );
  }

  Widget _buildInfoCard(String value, String label) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: const Color(0xFF0D47A1),
          width: 5,
        ),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: const TextStyle(
              fontSize: 50,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          Text(
            label,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBidangSection() {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFF0D47A1),
            borderRadius: BorderRadius.circular(20),
          ),
          padding: const EdgeInsets.only(
              top: 30.0, left: 16.0, right: 16.0, bottom: 16.0),
          child: _buildGridCategories(),
        ),
        Positioned(
          top: -20,
          left: 16,
          right: 16,
          child: Center(
            child: Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 120.0, vertical: 8.0),
              decoration: BoxDecoration(
                color: const Color(0xFFEFB509),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Text(
                'Bidang',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCategoryCard(
      String title, String id, String iconPath, BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DosenBidangPage(id: id),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF0D47A1),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 200,
              height: 150,
              padding: const EdgeInsets.all(1.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    iconPath,
                    height: 70,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    title,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGridCategories() {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      mainAxisSpacing: 20,
      crossAxisSpacing: 20,
      children: [
        _buildCategoryCard(
            '1', 'Teknologi Informasi', 'lib/assets/progamming.png', context),
        _buildCategoryCard(
            '2', 'Cloud Computing', 'lib/assets/rpl.png', context),
        _buildCategoryCard(
            '6', 'Analisis Data', 'lib/assets/database.png', context),
        _buildCategoryCard('3', 'Data Mining',
            'lib/assets/information_management.png', context),
        _buildCategoryCard('4', 'Manajemen Pemasaran',
            'lib/assets/cyber_security.png', context),
        _buildCategoryCard('5', 'Algoritma Evolusioner',
            'lib/assets/data_mining.png', context),
      ],
    );
  }
}
