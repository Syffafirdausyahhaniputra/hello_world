import 'package:flutter/material.dart';
import 'bottombar.dart'; // Import file bottombar.dart
import 'dosen/riwayat.dart'; // Import file riwayat.dart (AssignmentPage)
import 'dosen/notifikasi.dart'; // Import file notifikasi.dart (NotificationPage)
import 'dosen/profil.dart'; // Import file profil.dart (ProfilePage)

class DosenPage extends StatefulWidget {
  const DosenPage({super.key});

  @override
  _DosenPageState createState() => _DosenPageState();
}

class _DosenPageState extends State<DosenPage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    Dashboard(), // Halaman Dashboard
    HistoryPage(), // Halaman Assignment dari riwayat.dart
    NotificationPage(), // Halaman Notifikasi dari notifikasi.dart
    ProfilePage(), // Halaman Profil dari profil.dart
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index; // Update halaman aktif
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light(),
      home: Scaffold(
        body: SafeArea(
          child: _pages[_selectedIndex], // Menampilkan halaman yang dipilih
        ),
        bottomNavigationBar: BottomNavBar(
          selectedIndex: _selectedIndex,
          onItemTapped: _onItemTapped, // Pass the callback function
        ),
      ),
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
            SizedBox(height: height * 0.01),
            Text(
              'Selamat Datang',
              style: TextStyle(
                color: Colors.black,
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: height * 0.05),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildInfoCard(
                  title: 'Sertifikasi dan Pelatihan',
                  value: '4',
                  width: width * 0.8,
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
          SizedBox(width: width * 0.55), // Space to match the layout
          Text(
            'Zulfa Ulinnuha',
            style: TextStyle(
              fontSize: 14,
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
    return Stack(
      clipBehavior: Clip.none, // Membiarkan title keluar dari batas container
      children: [
        // Container untuk daftar rekomendasi
        Container(
          margin: const EdgeInsets.only(
              top: 20), // Beri margin agar title punya ruang di atas
          decoration: BoxDecoration(
            color: const Color(0xFF002366),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: height * 0.02),
                _buildRecommendationItem(
                  title: 'AWS Certified Solutions Architect',
                  subtitle: 'Cloud Computing',
                  date: '20 Oktober 2024',
                  width: width * 0.9, // Mengatur lebar container
                ),
                SizedBox(height: height * 0.02),
                _buildRecommendationItem(
                  title: 'AWS Certified Solutions Architect',
                  subtitle: 'Cloud Computing',
                  date: '20 Oktober 2024',
                  width: width * 0.9, // Mengatur lebar container
                ),
                SizedBox(height: height * 0.02),
                Align(
                  alignment: Alignment.bottomRight,
                  child: _buildMoreButton(width),
                ),
              ],
            ),
          ),
        ),

        // Title "Rekomendasi" yang setengah di dalam dan setengah di luar container
        Positioned(
          top:
              0, // Mengatur posisi vertikal agar setengah di dalam dan setengah di luar container
          left: 2,
          right: 2,
          child: Align(
            alignment: Alignment
                .center, // Menempatkan teks di tengah secara horizontal
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 7, horizontal: 84),
              decoration: BoxDecoration(
                color: Color(0xFFEFB509),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                'Rekomendasi',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign
                    .center, // Memastikan teks juga berada di tengah secara horizontal
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRecommendationItem({
    String title = '',
    String subtitle = '',
    String date = '',
    double? width, // Tambahkan parameter optional untuk mengatur lebar
  }) {
    return Container(
      width: width, // Set lebar container menggunakan parameter width
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
        width: width * 0.3,
        padding: EdgeInsets.symmetric(vertical: 3),
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
