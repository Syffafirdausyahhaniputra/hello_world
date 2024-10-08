import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'konfirmasiProfil.dart';

class EditProfilPage extends StatelessWidget {
  const EditProfilPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
          child: Column(
            children: [
              Row(
                children: [
                  // Tombol Kembali ke Halaman Profil
                  IconButton(
                    icon: const Icon(Icons.arrow_back),
                    color: Colors.white,
                    onPressed: () {
                      Navigator.pop(context); // Navigasi kembali ke halaman sebelumnya
                    },
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Text(
                'EDIT PROFIL',
                style: GoogleFonts.poppins(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 20),
              // Avatar Gambar Profil
              CircleAvatar(
                radius: 50,
                backgroundColor: Colors.white,
                child: Icon(
                  Icons.person,
                  size: 50,
                  color: const Color(0xFF0D47A1),
                ),
              ),
              const SizedBox(height: 30),
              // Form Edit Profil
              const EditProfileForm(),
            ],
          ),
        ),
      ),
      backgroundColor: const Color(0xFF0D47A1), // Latar belakang biru sesuai gambar
    );
  }
}

class EditProfileForm extends StatefulWidget {
  const EditProfileForm({super.key});

  @override
  _EditProfileFormState createState() => _EditProfileFormState();
}

class _EditProfileFormState extends State<EditProfileForm> {
  // Controller untuk input form
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _nipController = TextEditingController();
  final TextEditingController _fieldController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _nipController.dispose();
    _fieldController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Input Nama
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Nama',
            style: GoogleFonts.montserrat(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Container(
          width: screenWidth * 0.9,
          height: 50,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: TextField(
            controller: _nameController,
            decoration: const InputDecoration(
              contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              border: InputBorder.none,
            ),
          ),
        ),
        const SizedBox(height: 16),

        // Input NIP
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'NIP',
            style: GoogleFonts.montserrat(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Container(
          width: screenWidth * 0.9,
          height: 50,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: TextField(
            controller: _nipController,
            decoration: const InputDecoration(
              contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              border: InputBorder.none,
            ),
          ),
        ),
        const SizedBox(height: 16),

        // Input Bidang
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Bidang',
            style: GoogleFonts.montserrat(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Container(
          width: screenWidth * 0.9,
          height: 50,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: TextField(
            controller: _fieldController,
            decoration: const InputDecoration(
              contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              border: InputBorder.none,
            ),
          ),
        ),
        const SizedBox(height: 30),

        // Tombol Simpan
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFEFB509),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            minimumSize: Size(screenWidth * 0.5, 50), // Lebar tombol sesuai gambar
          ),
          onPressed: () {
            // Navigasi ke halaman konfirmasi setelah tombol simpan ditekan
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const SuccessPage(),
              ),
            );
          },
          child: Text(
            'SIMPAN',
            style: GoogleFonts.poppins(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}
