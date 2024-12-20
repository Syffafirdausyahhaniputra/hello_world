import 'dart:async';
import 'package:flutter/material.dart';
import 'package:hello_world/Controller/BidangController.dart';
import 'package:hello_world/Controller/LoginController.dart';
import 'package:hello_world/dosen.dart';
import 'package:hello_world/pimpinan.dart';
import 'package:hello_world/sessionManager.dart';
import 'login.dart'; // Import halaman login

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Future<void> checkSession() async {
      await SessionManager.clearSession();
      Map<String, String?> userData = await SessionManager.getUserData();

      print("user data $userData");
      String level = userData['level'] ?? "09";
      print("user data $level");
      if (level == "2") {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const PimpinanPage()),
          (Route<dynamic> route) => false,
        );
      } else if (level == "3") {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  DosenPage(token: userData['token'] ?? "null")),
          (Route<dynamic> route) => false,
        );
      } else {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const LoginPage()),
          (Route<dynamic> route) => false,
        );
      }
    }

    return Builder(builder: (context) {
      Future.delayed(const Duration(seconds: 3), () => checkSession());
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 270,
                height: 270,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                        "lib/assets/logo_jti_certify.png"), // Ganti dengan path gambar yang benar
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              const SizedBox(height: 5),
              const SizedBox(
                width: 194,
                height: 26,
                child: Text(
                  '',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color.fromARGB(255, 13, 71, 161),
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
    });
  }
}
