import 'package:flutter/material.dart';
import 'package:hello_world/pimpinan/dosenbidang.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
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
    );
  }

  // Info Card to display certification details
  Widget _buildInfoCard(String value, String label) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white, // Set background color to white
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: const Color(0xFF0D47A1), // Border color to match the theme
          width: 5,
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

  // Build section for "Bidang"
  Widget _buildBidangSection() {
    return Stack(
      clipBehavior: Clip.none, // To allow text to overflow outside container
      children: [
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFF0D47A1), // Blue color for container
            borderRadius: BorderRadius.circular(20),
          ),
          padding: const EdgeInsets.only(top: 30.0, left: 16.0, right: 16.0, bottom: 16.0),
          child: _buildGridCategories(), // Fill with grid categories
        ),
        Positioned(
          top: -20, // Place text partially outside container
          left: 16, // Align to left with padding
          right: 16, // Maintain same padding for right side
          child: Center(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 120.0, vertical: 8.0),
              decoration: BoxDecoration(
                color: const Color(0xFFEFB509), // Yellow color for "Bidang" text background
                borderRadius: BorderRadius.circular(20), // Round corners
              ),
              child: const Text(
                'Bidang',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black, // Text color set to black
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  // Grid categories for different areas of expertise
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

  // Card for individual category
  Widget _buildCategoryCard(String title, String iconPath) {
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
          color: const Color(0xFF0D47A1), // Blue color for card
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 200, // Fixed width for image and text
              height: 150, // Fixed height for image and text
              padding: const EdgeInsets.all(1.0), // Padding around image
              decoration: BoxDecoration(
                color: Colors.white, // White background for image and text
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    iconPath,
                    height: 70, // Fixed size for image
                  ),
                  const SizedBox(height: 10),
                  Text(
                    title,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 14, // Fixed font size
                      fontWeight: FontWeight.bold,
                      color: Colors.black, // Text color set to black
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
}
