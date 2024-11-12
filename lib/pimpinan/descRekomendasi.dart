import 'package:flutter/material.dart';
import '../header.dart'; // Import the Header component
import 'inputPengajuan.dart'; // Import halaman InputPengajuan

class DescRekomPage extends StatelessWidget {
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
                'AWS Certified Solutions Architect',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 27,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Cloud Computing',
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 18,
                ),
              ),
              SizedBox(height: height * 0.02),
              _buildDescriptionBox(width), // Description section
              SizedBox(height: height * 0.02),
              _buildButtonsRow(context, width), // Buttons row
              SizedBox(height: height * 0.02),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDescriptionBox(double width) {
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
          Text(
            'Online proctoring:',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Online proctoring is a testing environment that allows you to take an exam from any private space, such as your home or office. You use your own computer for the exam, and converse with a proctor who remotely monitors your exam via both a screen-sharing application and your webcam. Most exam appointments are available 24 hours a day, seven days a week.',
            style: TextStyle(fontSize: 14),
          ),
          SizedBox(height: 8),
          Text(
            'Online proctoring is available for all AWS Certification exams from our test delivery providers Pearson VUE.',
            style: TextStyle(fontSize: 14),
          ),
          SizedBox(height: 8),
          Text(
            'Proctoring languages and availability:',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          SizedBox(height: 8),
          Text(
            '• English: 24/7\n'
            '• Japanese: Monday – Saturday, 9 a.m. – 4 p.m. Local Time/JST\n'
            '• Spanish (Latin America): Monday – Friday, 10:00 a.m. – 5:45 p.m. EST\n'
            '• Mandarin (for customers in Mainland China): Monday – Friday, 8:00 a.m. – 5:00 p.m. Local Time/CST',
            style: TextStyle(fontSize: 14),
          ),
          SizedBox(height: 8),
          GestureDetector(
            onTap: () {
              // Handle link tap (open browser or another action)
            },
            child: Text(
              'link: Schedule an AWS Certification Exam (amazon.com)',
              style: TextStyle(
                color: const Color(0xFF0D47A1),
                fontSize: 14,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Widget for the two buttons: "List Pengajuan" and "Ajukan"
  Widget _buildButtonsRow(BuildContext context, double width) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildListPengajuanButton(context, width), // List Pengajuan button
        _buildAjukanButton(context, width), // Ajukan button
      ],
    );
  }

  // Widget for "List Pengajuan" button
  Widget _buildListPengajuanButton(BuildContext context, double width) {
    return GestureDetector(
      onTap: () {
        // Handle "List Pengajuan" button press
      },
      
      child: Container(
        width: width * 0.4, // Set the width to 40% of the screen width
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: const Color(0xFFEFB509), width: 2),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(
            'List Pengajuan',
            style: TextStyle(
              color: const Color(0xFFEFB509),
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  // Widget for "Ajukan" button
  Widget _buildAjukanButton(BuildContext context, double width) {
    return GestureDetector(
      onTap: () {
        // Navigasi ke halaman inputPengajuan.dart saat tombol ditekan
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PengajuanPage(), // Pastikan halaman InputPengajuanPage diimpor
          ),
        );
      },
      child: Container(
        width: width * 0.4, // Set the width to 40% of the screen width
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        decoration: BoxDecoration(
          color: const Color(0xFFEFB509),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(
            'AJUKAN',
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
