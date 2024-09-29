import 'package:flutter/material.dart';

class DosenPage extends StatelessWidget {
  const DosenPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light(),
      home: Scaffold(
        body: SafeArea(
          child: Dashboard(),
        ),
        bottomNavigationBar: _buildBottomNavigationBar(),
      ),
    );
  }

Widget _buildBottomNavigationBar() {
  return Padding(
    padding: const EdgeInsets.only(bottom: 5, right: 10, left: 10, top: 5), // Memberi jarak ke atas dari bagian bawah layar
    child: Container(
      decoration: BoxDecoration(
        color: const Color(0xFF002366), // Warna latar belakang biru
        borderRadius: BorderRadius.circular(20), // Border radius 20 di semua sisi
      ),
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavItem(Icons.home, isSelected: true), // Home
          _buildNavItem(Icons.assignment), // Assignment
          _buildNavItem(Icons.notifications), // Notifications
          _buildNavItem(Icons.person), // Person
        ],
      ),
    ),
  );
}



Widget _buildNavItem(IconData icon, {bool isSelected = false}) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isSelected ? Colors.amber[200] : Colors.amber,
        ),
        child: Icon(
          icon,
          size: 24,
          color: isSelected ? const Color(0xFF002366) : Colors.black,
        ),
      ),
    ],
  );
}

}

class Dashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(width),
            SizedBox(height: height * 0.05),
            Text(
              'Selamat Datang',
              style: TextStyle(
                color: Colors.black,
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: height * 0.03),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildInfoCard(
                  title: 'Sertifikasi',
                  value: '4',
                  width: width * 0.4,
                  borderColor: Colors.blue,
                )
              ],
            ),
            SizedBox(height: height * 0.05),
            _buildRecommendationSection(width, height),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(double width) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(width: width * 0.05), // Space to match the layout
          Text(
            'Zulfa Ulinnuha',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
          ),
          Icon(
            Icons.account_circle,
            size: 24,
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard({
    required String title,
    required String value,
    required double width,
    required Color borderColor,
  }) {
    return Container(
      width: width,
      height: 120,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(width: 3, color: borderColor),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            value,
            style: TextStyle(
              color: Colors.black,
              fontSize: 40,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8),
          Text(
            title,
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecommendationSection(double width, double height) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF002366),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 12),
              width: width,
              decoration: BoxDecoration(
                color: Color(0xFFEFB509),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Text(
                  'Rekomendasi',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            SizedBox(height: height * 0.02),
            _buildRecommendationItem(
              title: 'AWS Certified Solutions Architect',
              subtitle: 'Cloud Computing',
              date: '20 Oktober 2024',
            ),
            SizedBox(height: height * 0.02),
            _buildRecommendationItem(
              title: 'AWS Certified Solutions Architect',
              subtitle: 'Cloud Computing',
              date: '20 Oktober 2024',
            ),
            SizedBox(height: height * 0.02),
            _buildMoreButton(width),
          ],
        ),
      ),
    );
  }

  Widget _buildRecommendationItem({
    String title = '',
    String subtitle = '',
    String date = '',
  }) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title.isNotEmpty)
            Text(
              title,
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          if (subtitle.isNotEmpty)
            Text(
              subtitle,
              style: TextStyle(
                color: Colors.black54,
                fontSize: 14,
              ),
            ),
          if (date.isNotEmpty)
            Text(
              date,
              style: TextStyle(
                color: Colors.black38,
                fontSize: 12,
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildMoreButton(double width) {
    return GestureDetector(
      onTap: () {
        // Action for more button
      },
      child: Container(
        width: width * 0.4,
        padding: EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: Color(0xFFEFB509),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(
            'More',
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}
