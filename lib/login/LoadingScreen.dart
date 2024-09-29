import 'dart:async';
import 'package:flutter/material.dart';
import 'login.dart';  // Import halaman login

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    // Timer untuk pindah ke halaman login setelah 3 detik
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginPage()),  // Pindah ke halaman login
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 122.97,
              height: 130,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("lib/login/img/jti_polinema.png"),  // Ganti dengan path gambar yang benar
                  fit: BoxFit.fill,
                ),
              ),
            ),
            const SizedBox(height: 5),
            const SizedBox(
              width: 194,
              height: 26,
              child: Text(
                'Sertifikasi & Pelatihan',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 19,
                  fontFamily: 'Hammersmith One',
                  fontWeight: FontWeight.w400,
                  letterSpacing: -0.38,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
