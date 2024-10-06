import 'package:flutter/material.dart';

class SertifikasiPage extends StatelessWidget {
  final String dosenName;
  final List<Map<String, String>> sertifikasiList = [
    {
      'title': 'AWS Certified Solutions Architect',
      'category': 'Cloud Computing',
      'date': '20 Oktober 2024',
    },
    {
      'title': 'Google Cloud Engineer',
      'category': 'Cloud Computing',
      'date': '10 November 2023',
    },
    {
      'title': 'Azure Fundamentals',
      'category': 'Cloud Computing',
      'date': '15 September 2023',
    },
    {
      'title': 'Certified Kubernetes Administrator',
      'category': 'DevOps',
      'date': '22 Agustus 2023',
    },
    {
      'title': 'Cisco Certified Network Associate (CCNA)',
      'category': 'Networking',
      'date': '30 Juli 2023',
    },
  ];

  // Hapus kata kunci const dari konstruktor
  SertifikasiPage({Key? key, required this.dosenName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Bagian Atas: Informasi dosen
              _buildHeader(),
              const SizedBox(height: 20),
              // Garis Pembatas
              const Divider(
                color: Color(0xFF0D47A1), // Warna biru tua
                thickness: 2,
              ),
              const SizedBox(height: 20),
              // Bagian Bawah: Sertifikasi
              const Text(
                'Sertifikasi Dan Pelatihan',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              // Menggunakan ListView.builder untuk daftar sertifikasi
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(), // Agar tidak berbenturan dengan scroll parent
                itemCount: sertifikasiList.length,
                itemBuilder: (context, index) {
                  final sertifikasi = sertifikasiList[index];
                  return _buildSertifikasiItem(
                    sertifikasi['title']!,
                    sertifikasi['category']!,
                    sertifikasi['date']!,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Membuat bagian atas yang menampilkan informasi dosen dan jumlah sertifikasi
  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            CircleAvatar(
              radius: 40,
              backgroundColor: const Color(0xFF0D47A1), // Warna biru tua
              child: const Icon(
                Icons.person,
                size: 40,
                color: Colors.white,
              ),
            ),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  dosenName,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black, // Warna teks hitam
                  ),
                ),
                const Text(
                  '222222222',
                  style: TextStyle(fontSize: 18, color: Colors.grey),
                ),
                const Text(
                  'Dosen Jurusan Teknologi Informasi',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 20),
        // Jumlah sertifikasi
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border.all(color: const Color(0xFF0D47A1), width: 2),
            borderRadius: BorderRadius.circular(10),
          ),
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Text(
                sertifikasiList.length.toString(),
                style: const TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF0D47A1), // Warna biru
                ),
              ),
              const Text(
                'Sertifikasi dan Pelatihan',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // Membuat item sertifikasi
  Widget _buildSertifikasiItem(String title, String category, String date) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFF0D47A1), width: 2),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          Text(
            category,
            style: const TextStyle(fontSize: 14, color: Colors.grey),
          ),
          Text(
            date,
            style: const TextStyle(fontSize: 14, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
