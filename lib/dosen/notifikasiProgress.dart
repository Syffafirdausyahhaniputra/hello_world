import 'package:flutter/material.dart';
// Import halaman tujuan (descRekom.dart)
import 'descRiwayat.dart';  // Ganti dengan path yang sesuai

class NotificationPage extends StatelessWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: 300,
          height: 400,
          decoration: BoxDecoration(
            color: const Color(0xFF0D47A1),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'PROGRES TELAH BERHASIL DIINPUT',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              const Icon(
                Icons.check_circle_outline_rounded,
                color: Colors.green,
                size: 100,
              ),
              const SizedBox(height: 40),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFEFB509),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  minimumSize: const Size(200, 50), // Lebar tombol
                ),
                onPressed: () {
                  // Menggunakan Navigator.push untuk berpindah ke halaman descRekom.dart
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DescRiwayat(), // Pastikan kelas ini ada di descRekom.dart
                    ),
                  );
                },
                child: const Text(
                  'Kembali',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
