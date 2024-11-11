
import 'package:flutter/material.dart';

class DescRiwayat extends StatelessWidget {
  const DescRiwayat({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              'Zulfa Ulinnuha',
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(width: 8),
            Icon(
              Icons.account_circle,
              color: Colors.black,
            ),
          ],
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: height * 0.02),
              const Text(
                'AWS Certified Solutions Architect',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Text(
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
                    const Text(
                      'Online proctoring:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: height * 0.01),
                    const Text(
                      'Online proctoring is a testing environment that allows you to take an exam from any private space, such as your home or office. You use your own computer for the exam, and converse with a proctor who remotely monitors your exam via both a screen-sharing application and your webcam. Most exam appointments are available 24 hours a day, seven days a week.',
                    ),
                    SizedBox(height: height * 0.01),
                    const Text(
                      'Online proctoring is available for all AWS Certification exams from our test delivery providers Pearson VUE.',
                    ),
                    SizedBox(height: height * 0.01),
                    const Text(
                      'Proctoring languages and availability:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: height * 0.01),
                    const Text('• English: 24/7'),
                    const Text('• Japanese: Monday – Saturday, 9 a.m. – 4 p.m. Local Time/JST'),
                    const Text('• Spanish (Latin America): Monday – Friday, 10:00 a.m. – 5:45 p.m. EST'),
                    const Text('• Mandarin (for customers in Mainland China): Monday – Friday, 8:00 a.m. – 5:00 p.m. Local Time/CST'),
                    SizedBox(height: height * 0.01),
                    GestureDetector(
                      onTap: () {
                        // Add link to schedule exam here
                      },
                      child: const Text(
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
                    // Add action for "PROGRES" button here
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.amber,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                  ),
                  child: const Text(
                    'PROGRES',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
              SizedBox(height: height * 0.02),
              _buildUserProfileList(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildUserProfileList() {
    return Column(
      children: [
        _buildUserProfileItem('Zulfa Ulinnuha', 'Dosen Jurusan Teknologi Informasi', 'aktif'),
        _buildUserProfileItem('User 2', 'Dosen Jurusan Komputer', 'non-aktif'),
        _buildUserProfileItem('User 3', 'Dosen Jurusan Matematika', 'aktif'),
        _buildUserProfileItem('User 4', 'Dosen Jurusan Fisika', 'non-aktif'),
      ],
    );
  }

  Widget _buildUserProfileItem(String name, String title, String status) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 25,
            backgroundColor: Colors.yellow,
            child: Icon(
              Icons.person,
              color: Colors.white,
              size: 30,
            ),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white70,
                ),
              ),
            ],
          ),
          const Spacer(),
          Chip(
            label: Text(
              status,
              style: const TextStyle(color: Colors.white),
            ),
            backgroundColor: status == 'aktif' ? Colors.green : Colors.red,
          ),
        ],
      ),
    );
  }
}