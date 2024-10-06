import 'package:flutter/material.dart';
import '../header.dart'; // Import the Header component
import 'descRekom.dart'; // Pastikan file ini sudah ada di path yang benar

class RekomendasiPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: height * 0.04),
              Stack(
                children: [
                  Header(
                      userName: 'Zulfa Ulinnuha'), // Reuse the Header component
                  Positioned(
                    left: 0,
                    top: 16,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        width: 40, // Adjust the size as per your design
                        height: 40,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.black, width: 2),
                        ),
                        child: Icon(
                          Icons.arrow_back_ios_new,
                          color: Colors.black,
                          size: 20, // Adjust icon size to fit inside the circle
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: height * 0.02),
              Text(
                'Rekomendasi',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Sertifikasi dan Pelatihan',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: height * 0.02),
              _buildRecommendationList(
                  width, height, context), // Kirim context di sini
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRecommendationList(
      double width, double height, BuildContext context) {
    // Example data, you can replace with dynamic data or a list
    List<Map<String, String>> recommendations = [
      {
        'title': 'AWS Certified Solutions Architect',
        'subtitle': 'Cloud Computing',
        'date': '20 Oktober 2024',
      },
    ];

    return Column(
      children: recommendations.map((item) {
        return Column(
          children: [
            _buildRecommendationItem(
              context: context, // Kirim context ke dalam item
              title: item['title'] ?? '',
              subtitle: item['subtitle'] ?? '',
              date: item['date'] ?? '',
              width: width * 0.9,
            ),
            SizedBox(height: height * 0.02),
            _buildRecommendationItem(
              context: context, // Kirim context ke dalam item
              title: item['title'] ?? '',
              subtitle: item['subtitle'] ?? '',
              date: item['date'] ?? '',
              width: width * 0.9,
            ),
            SizedBox(height: height * 0.02),
          ],
        );
      }).toList(),
    );
  }

  Widget _buildRecommendationItem({
    required BuildContext context, // Tambahkan context sebagai parameter
    String title = '',
    String subtitle = '',
    String date = '',
    double? width,
  }) {
    return GestureDetector(
      onTap: () {
        // Navigasi ke halaman descRekom.dart
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  DescRekomPage()), // Pastikan DescRekomPage diimpor
        );
      },
      child: Container(
        width: width,
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: const Color(0xFF0D47A1), width: 5),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 4),
            Text(
              subtitle,
              style: TextStyle(
                color: Colors.black54,
                fontSize: 14,
              ),
            ),
            SizedBox(height: 4),
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
}
