import 'package:flutter/material.dart';
import '../header.dart'; // Import the Header component
import 'sertif.dart'; // Pastikan nama file dan path benar

class DataSertifPage extends StatelessWidget {
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
                'Data',
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
              _buildSertifList(context, width, height), // Pass context here
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSertifList(BuildContext context, double width, double height) {
    // Example data, you can replace with dynamic data or a list
    List<Map<String, String>> recommendations = [
      {
        'title': 'AWS Certified Solutions Architect',
        'subtitle': 'Cloud Computing',
        'date': 'Berlaku hingga 19 Oktober 2025',
      },
    ];

    return Column(
      children: recommendations.map((item) {
        return Column(
          children: [
            _buildSertifItem(
              context: context, // Pass context here
              title: item['title'] ?? '',
              subtitle: item['subtitle'] ?? '',
              date: item['date'] ?? '',
              width: width * 0.9,
            ),
            SizedBox(height: height * 0.02),
            _buildSertifItem(
              context: context, // Pass context here
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

  Widget _buildSertifItem({
    required BuildContext context, // Add context as a parameter
    required String title,
    required String subtitle,
    required String date,
    required double width,
  }) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context, // Use the passed context here
          MaterialPageRoute(
            builder: (context) => SertifPage(), // Halaman sertif.dart
          ),
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
