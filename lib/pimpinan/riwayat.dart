import 'package:flutter/material.dart';

class RiwayatPage extends StatefulWidget {
  const RiwayatPage({Key? key}) : super(key: key);

  @override
  _RiwayatPageState createState() => _RiwayatPageState();
}

class _RiwayatPageState extends State<RiwayatPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: const [
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
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              const Text(
                'Riwayat',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const Text(
                'Sertifikasi dan Pelatihan',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black54,
                ),
              ),
              const SizedBox(height: 20),
              _buildRiwayatList(),
            ],
          ),
        ),
      ),
    );
  }

  // Widget untuk daftar riwayat sertifikasi
  Widget _buildRiwayatList() {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF0D47A1), // Warna biru untuk container background
        borderRadius: BorderRadius.circular(20),
      ),
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          _buildRiwayatItem(
            title: "AWS Certified Solutions Architect",
            category: "Cloud Computing",
            status: "PROSES",
          ),
          const SizedBox(height: 16),
          _buildRiwayatItem(
            title: "AWS Certified Solutions Architect",
            category: "Cloud Computing",
            status: "SELESAI",
          ),
          const SizedBox(height: 16),
          _buildRiwayatItem(
            title: "",
            category: "",
            status: "", // Item kosong untuk layout tampilan
          ),
          const SizedBox(height: 16),
          _buildRiwayatItem(
            title: "",
            category: "",
            status: "", // Item kosong untuk layout tampilan
          ),
          const SizedBox(height: 16),
          _buildRiwayatItem(
            title: "",
            category: "",
            status: "", // Item kosong untuk layout tampilan
          ),
        ],
      ),
    );
  }

  // Widget untuk item riwayat individual
  Widget _buildRiwayatItem({
    required String title,
    required String category,
    required String status,
  }) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
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
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
          Text(
            status,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: status == "SELESAI" ? Colors.green : Colors.orange,
            ),
          ),
        ],
      ),
    );
  }
}
