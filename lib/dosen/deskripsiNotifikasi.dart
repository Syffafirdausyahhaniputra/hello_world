import 'package:flutter/material.dart';

class DeskripsiNotifikasiPage extends StatelessWidget {
  final String status;

  DeskripsiNotifikasiPage({required this.status});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    Color statusColor;
    String statusText;
    bool showDownloadButton = false;

    // Menentukan warna dan teks berdasarkan status
    if (status == 'Diterima') {
      statusColor = Colors.green;
      statusText = 'Pengajuan Diterima';
      showDownloadButton = true;
    } else if (status == 'Proses') {
      statusColor = Colors.grey;
      statusText = 'Pengajuan masih dalam proses';
    } else {
      statusColor = Colors.red;
      statusText = 'Pengajuan ditolak';
    }

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Back button and Username
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  Row(
                    children: [
                      Text(
                        'Zulfa Ulinnuha',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(width: 8),
                      Icon(Icons.account_circle),
                    ],
                  ),
                ],
              ),
              SizedBox(height: height * 0.02),

              // Status Box
              Container(
                width: width,
                padding: EdgeInsets.symmetric(vertical: 12.0),
                decoration: BoxDecoration(
                  color: statusColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: Text(
                    statusText,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              SizedBox(height: height * 0.02),

              // Certification Title and Category
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'AWS Certified Solutions',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Architect',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 4),
              Text(
                'Cloud Computing',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
              SizedBox(height: height * 0.02),

              // Information Table
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildTableRow('Bidang', ':Cloud Computing'),
                    _buildTableRow('Mata Kuliah', ':- Jaringan Komputer\n- Konsep Teknologi Informasi'),
                    _buildTableRow('Tanggal Acara', ':20 Januari 2021'),
                    _buildTableRow('Berlaku Hingga', ':19 September 2025'),
                    _buildTableRow('Vendor', ':Kemendikbud'),
                    _buildTableRow('Jenis', ':Profesi'),
                    _buildTableRow('Periode', ':2024 – ganjil'),
                  ],
                ),
              ),
              SizedBox(height: height * 0.03),

              // Row with text and download button
              if (showDownloadButton)
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Silahkan unduh surat tugas'),
                      SizedBox(width: 12),
                      ElevatedButton(
                        onPressed: () {
                          // Handle download action
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.yellow[700],
                          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                        ),
                        child: Text(
                          'UNDUH',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTableRow(String title, String content) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 3,
            child: Text(
              '$title',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            flex: 7,
            child: Text('$content'),
          ),
        ],
      ),
    );
  }
}
