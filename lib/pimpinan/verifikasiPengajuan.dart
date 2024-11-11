
import 'package:flutter/material.dart';

class VerifikasiPengajuanPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              'Zulfa Ulinnuha',
              style: TextStyle(color: Colors.black),
            ),
            SizedBox(width: 8),
            Icon(Icons.account_circle, color: Colors.blue),
          ],
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Pengajuan Dosen',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Color(0xFF0D47A1), width: 3),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Nama : Zulfa Ulinnuha', style: TextStyle(fontSize: 16)),
                  Text('NIP : 2241760119', style: TextStyle(fontSize: 16)),
                  Text('Jenis : Sertifikasi', style: TextStyle(fontSize: 16)),
                  SizedBox(height: 16),
                  Text('Bidang : Cloud Computing', style: TextStyle(fontSize: 16)),
                  Text('Mata Kuliah :', style: TextStyle(fontSize: 16)),
                  Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('- Jaringan Komputer', style: TextStyle(fontSize: 16)),
                        Text('- Konsep Teknologi Informasi', style: TextStyle(fontSize: 16)),
                      ],
                    ),
                  ),
                  SizedBox(height: 8),
                  Text('Tanggal Acara : 20 Januari 2021', style: TextStyle(fontSize: 16)),
                  Text('Berlaku Hingga : 19 September 2025', style: TextStyle(fontSize: 16)),
                  Text('Vendor : Kemendikbud', style: TextStyle(fontSize: 16)),
                  Text('Jenis : Profesi', style: TextStyle(fontSize: 16)),
                  Text('Periode : 2024 – ganjil', style: TextStyle(fontSize: 16)),
                ],
              ),
            ),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Logic untuk menolak
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                  ),
                  child: Text('Tolak', style: TextStyle(fontSize: 16)),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Logic untuk menyetujui
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                  ),
                  child: Text('Setuju', style: TextStyle(fontSize: 16)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}