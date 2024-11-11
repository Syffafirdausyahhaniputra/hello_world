import 'package:flutter/material.dart';
import 'inputData.dart';
import '../header.dart';
import 'dataSertif.dart';
import 'sertif.dart';

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
            _buildInfoCard(
              title: 'Sertifikasi dan Pelatihan',
              value: '4',
              width: width * 1,
              borderColor: const Color(0xFF0D47A1),
              context: context,
            ),
            SizedBox(height: height * 0.05),
            _buildSection('Sertifikasi', context, width, height),
            SizedBox(height: height * 0.02),
            _buildSection('Pelatihan', context, width, height),
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

  Widget _buildSection(
      String title, BuildContext context, double width, double height) {
    return Center(
      child: Stack(
        children: [
          Container(
            width: width * 0.9,
            margin: const EdgeInsets.only(top: 30),
            padding:
                const EdgeInsets.symmetric(vertical: 24.0, horizontal: 16.0),
            decoration: BoxDecoration(
              color: const Color(0xFF0D47A1),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              children: [
                _buildRecommendationItem(
                  title: 'AWS Certified Solutions Architect',
                  subtitle: 'Cloud Computing',
                  date: 'Berlaku hingga 19 September 2025',
                  width: width * 0.8,
                  context: context,
                ),
                _buildRecommendationItem(
                  title: 'AWS Certified Solutions Architect',
                  subtitle: 'Cloud Computing',
                  date: 'Berlaku hingga 19 September 2025',
                  width: width * 0.8,
                  context: context,
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
          Positioned(
            top: 0,
            left: width * 0.1,
            right: width * 0.1,
            child: Align(
              alignment: Alignment.center,
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 8),
                decoration: BoxDecoration(
                  color: Color(0xFFEFB509),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Center(
                  child: Text(
                    title,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 10,
            right: width * 0.05,
            child: GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => InputDataPage()));
              },
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Color(0xFFEFB509),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.add,
                  color: Colors.black,
                  size: 24,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecommendationItem({
    String title = '',
    String subtitle = '',
    String date = '',
    double? width,
    required BuildContext context,
  }) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => SertifPage()));
      },
      child: Container(
        width: width,
        padding: const EdgeInsets.all(16.0),
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: Colors.white,
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
            Text(
              subtitle,
              style: TextStyle(
                color: Colors.black54,
                fontSize: 14,
              ),
            ),
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
