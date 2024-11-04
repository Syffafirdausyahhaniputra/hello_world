
import 'package:flutter/material.dart';
import '../header.dart'; // Import file header.dart
import 'verifikasiPengajuan.dart'; // Import halaman verifikasiPengajuan.dart

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

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
              const Header(userName: 'Zulfa Ulinnuha'), // Menggunakan header dari header.dart
              SizedBox(height: height * 0.01),
              const Text(
                'Notifikasi',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: height * 0.03),
              // Membuat Tabel
              Table(
                border: TableBorder.all(color: Colors.grey),
                columnWidths: const {
                  0: FlexColumnWidth(3),
                  1: FlexColumnWidth(2),
                  2: FlexColumnWidth(2),
                },
                children: [
                  _buildTableHeader(), // Header Tabel
                  _buildTableRow(
                    context,
                    title: 'AWS Certified Solutions Architect',
                    category: 'Pengajuan',
                    status: 'Diterima',
                    statusColor: Colors.green,
                  ),
                  _buildTableRow(
                    context,
                    title: 'AWS Certified Solutions Architect',
                    category: 'Verifikasi',
                    status: 'Proses',
                    statusColor: Colors.grey,
                  ),
                  _buildTableRow(
                    context,
                    title: 'AWS Certified Solutions Architect',
                    category: 'Penunjukan',
                    status: 'Ditolak',
                    statusColor: Colors.red,
                  ),
                  // Tambahkan lebih banyak baris jika perlu
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  TableRow _buildTableHeader() {
    return TableRow(
      decoration: BoxDecoration(
        color: Colors.grey.shade200, // Warna latar belakang header
      ),
      children: const [
        Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            'Nama',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            'Keterangan',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            'Status',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }

  TableRow _buildTableRow(
    BuildContext context, {
    required String title,
    required String category,
    required String status,
    required Color statusColor,
  }) {
    return TableRow(
      children: [
        // Buat teks bisa diklik menggunakan GestureDetector
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => VerifikasiPengajuanPage()), // Periksa apakah kelas sudah sesuai
              );
            },
            child: Text(
              title,
              style: const TextStyle(
                color: Colors.blue, // Warna teks biru sebagai indikasi bisa diklik
                decoration: TextDecoration.underline, // Garis bawah sebagai indikasi bisa diklik
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(category),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: statusColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              status,
              style: const TextStyle(
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ],
    );
  }
}