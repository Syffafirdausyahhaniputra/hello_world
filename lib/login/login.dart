import 'package:flutter/material.dart';
import '../dosen.dart'; // Impor halaman dosen
import '../pimpinan.dart'; // Impor halaman pimpinan

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ListView(
            shrinkWrap: true,
            children: [
              const LoginForm(),
            ],
          ),
        ),
      ),
    );
  }
}

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  // Controller untuk input username dan password
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // Fungsi untuk melakukan login
  void _login(BuildContext context) {
    String username = _usernameController.text;
    String password = _passwordController.text;

    // Cek apakah username dan password sesuai untuk dosen atau pimpinan
    if (username == 'dosen' && password == '12345') {
      // Jika sesuai, navigasi ke halaman dosen
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const DosenPage()),
      );
    } else if (username == 'pimpinan' && password == '54321') {
      // Jika sesuai, navigasi ke halaman pimpinan
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const PimpinanPage()),
      );
    } else {
      // Jika tidak sesuai, tampilkan pesan error
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Username atau password salah')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text(
          'LOGIN',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.black,
            fontSize: 40,
            fontFamily: 'Hammersmith One',
            fontWeight: FontWeight.w400,
            letterSpacing: -0.90,
          ),
        ),
        SizedBox(height: screenHeight * 0.05),
        Container(
          width: screenWidth * 0.85,
          padding: const EdgeInsets.all(20.0),
          decoration: ShapeDecoration(
            color: const Color(0xFF0D47A1),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: const Text(
                  'USERNAME',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 19,
                    fontFamily: 'Hammersmith One',
                    fontWeight: FontWeight.w400,
                    letterSpacing: -0.38,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Container(
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: TextField(
                  controller: _usernameController,
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.symmetric(horizontal: 20),
                    border: InputBorder.none,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Align(
                alignment: Alignment.centerLeft,
                child: const Text(
                  'PASSWORD',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 19,
                    fontFamily: 'Hammersmith One',
                    fontWeight: FontWeight.w400,
                    letterSpacing: -0.38,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Container(
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: TextField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.symmetric(horizontal: 20),
                    border: InputBorder.none,
                  ),
                ),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFEFB509),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  minimumSize: const Size(100, 40),
                ),
                onPressed: () {
                  _login(context); // Panggil fungsi login saat tombol ditekan
                },
                child: const Text(
                  'KIRIM',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontFamily: 'Hammersmith One',
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
