import 'package:flutter/material.dart';
import '../header.dart'; // Import file header.dart

class NotificationPage extends StatelessWidget {
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
              Header(userName: 'Zulfa Ulinnuha'), // Menggunakan header dari header.dart
              SizedBox(height: height * 0.01),
              Text(
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
                columnWidths: {
                  0: FlexColumnWidth(3),
                  1: FlexColumnWidth(2),
                  2: FlexColumnWidth(2),
                },
                children: [
                  _buildTableHeader(), // Header Tabel
                  _buildTableRow(
                    title: 'AWS Certified Solutions Architect',
                    category: 'Cloud Computing',
                    status: 'Diterima',
                    statusColor: Colors.green,
                  ),
                  _buildTableRow(
                    title: 'AWS Certified Solutions Architect',
                    category: 'Cloud Computing',
                    status: 'Proses',
                    statusColor: Colors.grey,
                  ),
                  _buildTableRow(
                    title: 'AWS Certified Solutions Architect',
                    category: 'Cloud Computing',
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
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'Nama',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'Kategori',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'Status',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }

  TableRow _buildTableRow({
    required String title,
    required String category,
    required String status,
    required Color statusColor,
  }) {
    return TableRow(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(title),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(category),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: statusColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              status,
              style: TextStyle(
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
