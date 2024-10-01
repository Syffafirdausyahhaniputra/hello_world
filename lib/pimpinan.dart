import 'package:flutter/material.dart';
import 'bottombar.dart'; // Import your custom bottom nav bar

class PimpinanPage extends StatefulWidget {
  const PimpinanPage({super.key});

  @override
  State<PimpinanPage> createState() => _PimpinanPageState();
}

class _PimpinanPageState extends State<PimpinanPage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: const [
            Text(
              'Zulfa Ulinnuha',
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(width: 8),
            Icon(
              Icons.account_circle,
              color: Colors.black,
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
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
              _buildInfoCard('110', 'Sertifikasi dan Pelatihan'), // Merged single card
              const SizedBox(height: 30),
              _buildBidangSection(), // Call the updated "Bidang" section
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }

  Widget _buildInfoCard(String value, String label) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white, // Set background color to white
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: const Color(0xFF002366), // Border color to match the theme
          width: 2,
        ),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: const TextStyle(
              fontSize: 50, // Larger font size
              fontWeight: FontWeight.bold,
              color: Colors.black, // Black color for value
            ),
          ),
          Text(
            label,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black, // Black color for label
            ),
          ),
        ],
      ),
    );
  }

Widget _buildBidangSection() {
  return Stack(
    clipBehavior: Clip.none, // Agar teks bisa keluar dari container biru
    children: [
      Container(
        decoration: BoxDecoration(
          color: const Color(0xFF002366), // Warna biru untuk container
          borderRadius: BorderRadius.circular(20),
        ),
        padding: const EdgeInsets.only(top: 30.0, left: 16.0, right: 16.0, bottom: 16.0),
        child: _buildGridCategories(), // Isi dengan grid categories
      ),
      Positioned(
        top: -20, // Agar setengah teks berada di luar container
        left: 16, // Posisi teks di bagian kiri container
        right: 16, // Tambahkan jarak pada kanan agar center
        child: Center(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 120.0, vertical: 8.0),
            decoration: BoxDecoration(
              color: const Color(0xFFEFB509), // Warna kuning untuk teks "Bidang"
              borderRadius: BorderRadius.circular(20), // Membuat sudut membulat
            ),
            child: const Text(
              'Bidang',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black, // Warna teks hitam
              ),
            ),
          ),
        ),
      ),
    ],
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
        _buildCategoryCard('Pemrograman', 'lib/assets/progamming.png'),
        _buildCategoryCard('RPL', 'lib/assets/rpl.png'),
        _buildCategoryCard('Database', 'lib/assets/database.png'),
        _buildCategoryCard('Manajemen SI', 'lib/assets/information_management.png'),
        _buildCategoryCard('Cyber Security', 'lib/assets/cyber_security.png'),
        _buildCategoryCard('Data Mining', 'lib/assets/data_mining.png'),
      ],
    );
  }

    Widget _buildCategoryCard(String title, String iconPath) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF002366), // Warna biru untuk kartu
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 200, // Lebar tetap untuk gambar dan teks
            height: 150, // Tinggi tetap untuk gambar dan teks
            padding: const EdgeInsets.all(1.0), // Padding sekitar gambar
            decoration: BoxDecoration(
              color: Colors.white, // Latar belakang putih untuk gambar dan teks
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  iconPath,
                  height: 70, // Ukuran tetap untuk gambar
                ),
                const SizedBox(height: 10),
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 14, // Font size tetap
                    fontWeight: FontWeight.bold,
                    color: Colors.black, // Warna teks hitam
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
