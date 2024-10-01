import 'package:flutter/material.dart';

class DosenBidangPage extends StatelessWidget {
  const DosenBidangPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
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
                'Dosen Bidang (..)',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 20),
              _buildSearchBox(),
              const SizedBox(height: 20),
              _buildDosenList(),
            ],
          ),
        ),
      ),
    );
  }

  // Widget untuk kotak pencarian
  Widget _buildSearchBox() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(
          color: const Color(0xFF002366), // Warna biru untuk border kotak pencarian
          width: 2,
        ),
      ),
      child: Row(
        children: const [
          Icon(Icons.search, color: Colors.grey),
          SizedBox(width: 10),
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: "CARI",
                border: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Widget untuk daftar dosen
  Widget _buildDosenList() {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF002366), // Warna biru untuk container background
        borderRadius: BorderRadius.circular(20),
      ),
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          _buildDosenItem(
            name: "Zulfa Ulinnuha",
            description: "Dosen Jurusan Teknologi Informasi",
            isMain: true,
          ),
          const SizedBox(height: 16),
          _buildDosenItem(name: "Nama Dosen Lain", description: "Bidang A"),
          const SizedBox(height: 16),
          _buildDosenItem(name: "Nama Dosen Lain", description: "Bidang B"),
          const SizedBox(height: 16),
          _buildDosenItem(name: "Nama Dosen Lain", description: "Bidang C"),
        ],
      ),
    );
  }

  // Widget untuk item dosen individual
  Widget _buildDosenItem({
    required String name,
    required String description,
    bool isMain = false,
  }) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: const Color(0xFFEFB509), // Warna kuning untuk avatar
            radius: 30,
            child: Icon(
              Icons.person,
              color: isMain ? Colors.white : Colors.black, // Warna ikon
              size: 30,
            ),
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              Text(
                description,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
