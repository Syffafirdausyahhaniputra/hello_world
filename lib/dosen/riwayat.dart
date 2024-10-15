import 'package:flutter/material.dart';
import 'descRiwayat.dart'; // Make sure to import this file

class HistoryPage extends StatelessWidget {
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
              SizedBox(height: height * 0.01),
              Text(
                'Riwayat',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: height * 0.01),
              Text(
                'Sertifikasi dan Pelatihan',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: height * 0.03),
              _buildCertificationItem(
                context,
                title: 'AWS Certified Solutions Architect',
                subtitle: 'Cloud Computing',
                status: 'PROSES',
                description:
                    'Online proctoring allows you to take an exam from your private space with remote monitoring...',
                width: width * 0.9,
              ),
              SizedBox(height: height * 0.02),
              _buildCertificationItem(
                context,
                title: 'AWS Certified Solutions Architect',
                subtitle: 'Cloud Computing',
                status: 'SELESAI',
                description:
                    'This certification validates your ability to design distributed systems and apps on AWS...',
                width: width * 0.9,
              ),
              SizedBox(height: height * 0.02),
              // Add more items if necessary
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCertificationItem(
    BuildContext context, {
    required String title,
    required String subtitle,
    required String status,
    required String description,
    required double width,
  }) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DescRiwayat(
              title: title,
              subtitle: subtitle,
              description: description,
            ),
          ),
        );
      },
      child: Container(
        width: width,
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: Color(0xFF0D47A1),
            width: 5,
          ),
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
            Align(
              alignment: Alignment.bottomRight,
              child: Text(
                status,
                style: TextStyle(
                  color: status == 'SELESAI' ? Colors.green : Colors.orange,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
