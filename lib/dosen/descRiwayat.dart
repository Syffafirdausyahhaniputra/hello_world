import 'package:flutter/material.dart';

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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
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
                      Row(
                        children: [
                          Text(
                            'Zulfa Ulinnuha',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(width: 8),
                          Icon(Icons.account_circle, size: 32),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: height * 0.04),
              Text(
                'AWS Certified Solutions Architect',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Cloud Computing',
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 16,
                ),
              ),
              SizedBox(height: height * 0.02),
              _buildDescriptionBox(width),
              SizedBox(height: height * 0.02),
              Align(
                alignment: Alignment.centerRight,
                child: _buildProgresButton(context, width),
              ),
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
        border: Border.all(color: Colors.grey.shade300, width: 1),
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
          _buildBulletPoint('English: 24/7'),
          _buildBulletPoint('Japanese: Monday - Saturday, 9 a.m. - 4 p.m. Local Time/JST'),
          _buildBulletPoint('Spanish (Latin America): Monday - Friday, 10:00 a.m. - 5:45 p.m. EST'),
          _buildBulletPoint('Mandarin (for customers in Mainland China): Monday - Friday, 8:00 a.m. - 5:00 p.m. Local Time/CST'),
          SizedBox(height: 8),
          GestureDetector(
            onTap: () {
              // Handle link tap
            },
            child: Text(
              'Schedule an AWS Certification Exam (amazon.com)',
              style: TextStyle(
                color: Colors.blue,
                fontSize: 14,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBulletPoint(String text) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, bottom: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('• ', style: TextStyle(fontSize: 14)),
          Expanded(
            child: Text(text, style: TextStyle(fontSize: 14)),
          ),
        ],
      ),
    );
  }

  Widget _buildProgresButton(BuildContext context, double width) {
    return GestureDetector(
      onTap: () {
        // Navigasi ke halaman berikutnya
      },
      child: Container(
        width: width * 0.3,
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        decoration: BoxDecoration(
          color: const Color(0xFFEFB509),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Center(
          child: Text(
            'PROGRES',
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
