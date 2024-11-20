import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:hello_world/config.dart'; // Impor Config
import 'package:hello_world/Model/UserModel.dart';
import 'package:hello_world/pimpinan/dosenbidang.dart';
import 'package:hello_world/Controller/DashboardController.dart';



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
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    if (token == null) {
      throw Exception('Token tidak ditemukan');
    }

    // Panggil API menggunakan URL dari Config
    final response = await http.get(
      Uri.parse(Config.dashboardEndpoint), // Menggunakan Config
      headers: {
        "Content-Type": "application/json; charset=utf-8",
        "Accept": "application/json",
        "Authorization": "Bearer $token",
      },
    );

    // Debugging status code
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);

      if (jsonData['success'] == true) {
        final data = jsonData['data'];

        // Pastikan data bidang di-handle dengan aman
        final bidangList = data['bidang'] ?? [];
        if (bidangList is! List) {
          throw Exception('Invalid bidang format');
        }

        // Update state dengan data yang diterima
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

          jumlahSertifikasiPelatihan = data['jumlahSertifikasiPelatihan'] ?? 0;
          isLoading = false;
        });
      } else {
        throw Exception('Response success is false');
      }
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
          padding: const EdgeInsets.only(top: 30.0, left: 16.0, right: 16.0, bottom: 16.0),
          child: _buildGridCategories(),
        ),
        Positioned(
          top: -20,
          left: 16,
          right: 16,
          child: Center(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 120.0, vertical: 8.0),
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

  Widget _buildCategoryCard(String title, String iconPath, BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const DosenBidangPage(),
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
        _buildCategoryCard('Pemrograman', 'lib/assets/progamming.png', context),
        _buildCategoryCard('RPL', 'lib/assets/rpl.png', context),
        _buildCategoryCard('Database', 'lib/assets/database.png', context),
        _buildCategoryCard('Manajemen SI', 'lib/assets/information_management.png', context),
        _buildCategoryCard('Cyber Security', 'lib/assets/cyber_security.png', context),
        _buildCategoryCard('Data Mining', 'lib/assets/data_mining.png', context),
      ],
    );
  }
}
