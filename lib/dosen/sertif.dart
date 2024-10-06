import 'package:flutter/material.dart';
import '../header.dart'; // Import the Header component

class SertifPage extends StatelessWidget {
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
                  Header(userName: 'Zulfa Ulinnuha'),
                  Positioned(
                    left: 0,
                    top: 16,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.black, width: 2),
                        ),
                        child: Icon(
                          Icons.arrow_back_ios_new,
                          color: Colors.black,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: height * 0.02),
              Text(
                'AWS Certified Solutions Architect',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 27,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: height * 0.01),
              Center(
                child: Image.asset(
                  'lib/assets/sertif.png', // Mengambil gambar dari folder assets
                  width: width * 0.7,
                ),
              ),
              SizedBox(height: height * 0.02),
              _buildCertificateDetails(width), // Menggabungkan InfoBox dan DescriptionBox
              SizedBox(height: height * 0.02),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCertificateDetails(double width) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      width: width,
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFF0D47A1), width: 3),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Informasi Sertifikasi
          Text(
            'Bidang\t\t: Cloud Computing',
            style: TextStyle(
              fontSize: 16,
            ),
          ),
          Text(
            'Tanggal Acara\t: 20 Januari 2021',
            style: TextStyle(
              fontSize: 16,
            ),
          ),
          Text(
            'Berlaku Hingga\t: 19 September 2025',
            style: TextStyle(
              fontSize: 16,
            ),
          ),
          SizedBox(height: 16), // Spacer

          // Deskripsi Sertifikasi
          Text(
            'Online proctoring is a testing environment that allows you to take an exam from any private space, such as your home or office. You use your own computer for the exam, and converse with a proctor who remotely monitors your exam via both a screen-sharing application and your webcam. Most exam appointments are available 24 hours a day, seven days a week.',
            style: TextStyle(fontSize: 14),
          ),
          SizedBox(height: 8),
        ],
      ),
    );
  }
}
