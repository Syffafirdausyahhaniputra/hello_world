import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:hello_world/core/sharedPref.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:hello_world/config.dart';
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

  // Previous _loadDashboardData method remains the same
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
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F9FF), // Light blue background
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 2,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Dashboard',
              style: TextStyle(
                color: Color(0xFF0D47A1),
                fontWeight: FontWeight.bold,
              ),
            ),
            Row(
              children: [
                Text(
                  user?.nama ?? 'Loading...',
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: screenWidth > 600 ? 18 : 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE3F2FD),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Icon(
                    Icons.account_circle,
                    color: const Color(0xFF0D47A1),
                    size: screenWidth > 600 ? 30 : 24,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.04,
                  vertical: screenHeight * 0.02,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Welcome Section with enhanced design
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 24),
                      child: Column(
                        children: [
                          Text(
                            'Selamat Datang',
                            style: TextStyle(
                              fontSize: screenWidth > 600 ? 36 : 28,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFF0D47A1),
                            ),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            'Sistem Informasi Sertifikasi dan Pelatihan',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black54,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Enhanced Stats Card
                    Container(
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [Colors.white, Color(0xFFE3F2FD)],
                        ),
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.blue.withOpacity(0.1),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                        border: Border.all(
                          color: const Color(0xFF0D47A1),
                          width: 2,
                        ),
                      ),
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        children: [
                          Text(
                            jumlahSertifikasiPelatihan.toString(),
                            style: TextStyle(
                              fontSize: screenWidth > 600 ? 60 : 48,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFF0D47A1),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Sertifikasi dan Pelatihan',
                            style: TextStyle(
                              fontSize: screenWidth > 600 ? 20 : 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.black87,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 32),

                    // Original Bidang Section (maintained as before)
                    _buildBidangSection(screenWidth, screenHeight),
                  ],
                ),
              ),
            ),
    );
  }

  // Original methods for Bidang section remain the same
  Widget _buildBidangSection(double screenWidth, double screenHeight) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFF0D47A1),
            borderRadius: BorderRadius.circular(20),
          ),
          padding: EdgeInsets.only(
            top: screenHeight * 0.04,
            left: screenWidth * 0.04,
            right: screenWidth * 0.04,
            bottom: screenWidth * 0.04,
          ),
          child: _buildGridCategories(screenWidth),
        ),
        Positioned(
          top: -20,
          left: screenWidth * 0.04,
          right: screenWidth * 0.04,
          child: Center(
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.3,
                vertical: 8.0,
              ),
              decoration: BoxDecoration(
                color: const Color(0xFFEFB509),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                'Bidang',
                style: TextStyle(
                  fontSize: screenWidth > 600 ? 20 : 16,
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

  Widget _buildCategoryCard(String title, String id, String iconPath, BuildContext context, double screenWidth) {
    return LayoutBuilder(
      builder: (context, constraints) {
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
                  width: constraints.maxWidth,
                  height: constraints.maxWidth * 0.75,
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
                        height: constraints.maxWidth * 0.4,
                        fit: BoxFit.contain,
                      ),
                      SizedBox(height: constraints.maxWidth * 0.05),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          title,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: screenWidth > 600 ? 16 : 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildGridCategories(double screenWidth) {
    int crossAxisCount = screenWidth > 600 ? 3 : 2;
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: crossAxisCount,
      mainAxisSpacing: screenWidth * 0.05,
      crossAxisSpacing: screenWidth * 0.05,
      childAspectRatio: 1,
      children: [
        _buildCategoryCard('Teknologi Informasi', '1', 'lib/assets/progamming.png', context, screenWidth),
        _buildCategoryCard('Cloud Computing', '2', 'lib/assets/rpl.png', context, screenWidth),
        _buildCategoryCard('Analisis Data', '6', 'lib/assets/database.png', context, screenWidth),
        _buildCategoryCard('Data Mining', '3', 'lib/assets/information_management.png', context, screenWidth),
        _buildCategoryCard('Manajemen Pemasaran', '4', 'lib/assets/cyber_security.png', context, screenWidth),
        _buildCategoryCard('Algoritma Evolusioner', '5', 'lib/assets/data_mining.png', context, screenWidth),
      ],
    );
  }
}