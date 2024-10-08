import 'package:flutter/material.dart';
import '../header.dart'; // Pastikan sudah mengimpor file header.dart
import 'dataSertif.dart';
import 'rekomendasi.dart';
import 'descRekom.dart'; // Tambahkan import untuk descRekom.dart

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
            Header(userName: 'Zulfa Ulinnuha'),
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
                  borderColor: const Color(0xFF0D47A1),
                  context: context, 
                )
              ],
            ),
            SizedBox(height: height * 0.05),
            _buildRecommendationSection(width, height, context),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard({
    required String title,
    required String value,
    required double width,
    required Color borderColor,
    required BuildContext context, 
  }) {
    return GestureDetector(
      onTap: () {
        // Navigasi ke halaman DataSertif
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => DataSertifPage()), 
        );
      },
      child: Container(
        width: width,
        height: 120,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(width: 5, color: borderColor),
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
      ),
    );
  }

  Widget _buildRecommendationSection(double width, double height, BuildContext context) {
    return Stack(
      clipBehavior: Clip.none, 
      children: [
        Container(
          margin: const EdgeInsets.only(top: 20),
          decoration: BoxDecoration(
            color: const Color(0xFF0D47A1),
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
                  width: width * 0.9,
                  context: context, // Tambahkan context untuk navigasi
                ),
                SizedBox(height: height * 0.02),
                _buildRecommendationItem(
                  title: 'AWS Certified Solutions Architect',
                  subtitle: 'Cloud Computing',
                  date: '20 Oktober 2024',
                  width: width * 0.9,
                  context: context, // Tambahkan context untuk navigasi
                ),
                SizedBox(height: height * 0.02),
                Align(
                  alignment: Alignment.bottomRight,
                  child: _buildMoreButton(width, context),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          top: 0,
          left: 2,
          right: 2,
          child: Align(
            alignment: Alignment.center,
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
                textAlign: TextAlign.center,
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
    double? width,
    required BuildContext context, // Tambahkan context untuk navigasi
  }) {
    return GestureDetector( // Bungkus dengan GestureDetector
      onTap: () {
        // Navigasi ke halaman descRekom
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => DescRekomPage()), // Panggil halaman DescRekomPage
        );
      },
      child: Container(
        width: width,
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
      ),
    );
  }

  Widget _buildMoreButton(double width, BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigasi ke halaman rekomendasi
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => RekomendasiPage()),
        );
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
