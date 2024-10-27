import 'package:flutter/material.dart';
import 'package:hello_world/dosen/inputRiwayat.dart';
import '../header.dart'; // Import file header.dart

class DescRiwayat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
              SizedBox(height: height * 0.01),
              Text(
                'AWS Certified Solutions Architect',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Cloud Computing',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
              SizedBox(height: height * 0.02),
              Container(
                padding: const EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.blue),
                  borderRadius: BorderRadius.circular(8.0),
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
                    SizedBox(height: height * 0.01),
                    Text(
                      'Online proctoring is a testing environment that allows you to take an exam from any private space, such as your home or office. You use your own computer for the exam, and converse with a proctor who remotely monitors your exam via both a screen-sharing application and your webcam. Most exam appointments are available 24 hours a day, seven days a week.',
                    ),
                    SizedBox(height: height * 0.01),
                    Text(
                      'Online proctoring is available for all AWS Certification exams from our test delivery providers Pearson VUE.',
                    ),
                    SizedBox(height: height * 0.01),
                    Text(
                      'Proctoring languages and availability:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: height * 0.01),
                    Text('• English: 24/7'),
                    Text(
                        '• Japanese: Monday – Saturday, 9 a.m. – 4 p.m. Local Time/JST'),
                    Text(
                        '• Spanish (Latin America): Monday – Friday, 10:00 a.m. – 5:45 p.m. EST'),
                    Text(
                        '• Mandarin (for customers in Mainland China): Monday – Friday, 8:00 a.m. – 5:00 p.m. Local Time/CST'),
                    SizedBox(height: height * 0.01),
                    GestureDetector(
                      onTap: () {
                        // Buka link jadwal ujian di sini
                      },
                      child: Text(
                        'Schedule an AWS Certification Exam (amazon.com)',
                        style: TextStyle(
                          color: Colors.blue,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: height * 0.02),
              Align(
                alignment: Alignment.bottomRight,
                child: ElevatedButton(
                  onPressed: () {
                    // Navigasi ke halaman notifikasiProgress.dart saat tombol PROGRES ditekan
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const InputHasilPage(), // Pastikan kelas ini ada di notifikasiProgress.dart
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.amber,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                  ),
                  child: Text(
                    'PROGRES',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
              SizedBox(height: height * 0.02),
            ],
          ),
        ),
      ),
    );
  }
}
