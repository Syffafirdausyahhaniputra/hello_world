import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import '../Controller/ProfileController.dart';

class EditProfilPage extends StatelessWidget {
  final String token; // Tambahkan token untuk autentikasi
  const EditProfilPage({super.key, required this.token});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(  // Menambahkan SingleChildScrollView untuk scrollable
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
                        Navigator.pop(context);
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
                EditProfileForm(token: token),
              ],
            ),
          ),
        ),
      ),
      backgroundColor: const Color(0xFF0D47A1),
    );
  }
}

class EditProfileForm extends StatefulWidget {
  final String token; // Tambahkan token untuk autentikasi
  const EditProfileForm({super.key, required this.token});

  @override
  _EditProfileFormState createState() => _EditProfileFormState();
}

class _EditProfileFormState extends State<EditProfileForm> {
  // Controller untuk input form
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _nipController = TextEditingController();
  final TextEditingController _fieldController = TextEditingController();
  final TextEditingController _courseController = TextEditingController();
  final TextEditingController _oldPasswordController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  File? _avatar; // File untuk avatar

  final ImagePicker _picker = ImagePicker();

  @override
  void dispose() {
    _usernameController.dispose();
    _nameController.dispose();
    _nipController.dispose();
    _fieldController.dispose();
    _courseController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _pickAvatar() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _avatar = File(pickedFile.path);
      });
    }
  }

  Future<void> _updateProfile() async {
    final response = await ProfileController().updateProfile(
      token: widget.token,
      username: _usernameController.text.trim(),
      nama: _nameController.text.trim(),
      nip: _nipController.text.trim(),
      oldPassword: _oldPasswordController.text.trim(),
      password: _passwordController.text.trim(),
      avatar: _avatar,
    );

    if (response['success']) {
      // Tampilkan dialog sukses
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Berhasil'),
          content: Text(response['message']),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    } else {
      // Tampilkan dialog error
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Gagal'),
          content: Text(response['message']),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Input Username
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Username',
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
            controller: _usernameController,
            decoration: const InputDecoration(
              contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              border: InputBorder.none,
            ),
          ),
        ),
        const SizedBox(height: 16),

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

        // // Input Bidang
        // Align(
        //   alignment: Alignment.centerLeft,
        //   child: Text(
        //     'Bidang',
        //     style: GoogleFonts.montserrat(
        //       color: Colors.white,
        //       fontSize: 16,
        //     ),
        //   ),
        // ),
        // const SizedBox(height: 8),
        // Container(
        //   width: screenWidth * 0.9,
        //   height: 50,
        //   decoration: BoxDecoration(
        //     color: Colors.white,
        //     borderRadius: BorderRadius.circular(20),
        //   ),
        //   child: TextField(
        //     controller: _fieldController,
        //     decoration: const InputDecoration(
        //       contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        //       border: InputBorder.none,
        //     ),
        //   ),
        // ),
        // const SizedBox(height: 16),

        // // Input Mata Kuliah
        // Align(
        //   alignment: Alignment.centerLeft,
        //   child: Text(
        //     'Mata Kuliah',
        //     style: GoogleFonts.montserrat(
        //       color: Colors.white,
        //       fontSize: 16,
        //     ),
        //   ),
        // ),
        // const SizedBox(height: 8),
        // Container(
        //   width: screenWidth * 0.9,
        //   height: 50,
        //   decoration: BoxDecoration(
        //     color: Colors.white,
        //     borderRadius: BorderRadius.circular(20),
        //   ),
        //   child: TextField(
        //     controller: _courseController,
        //     decoration: const InputDecoration(
        //       contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        //       border: InputBorder.none,
        //     ),
        //   ),
        // ),
        // const SizedBox(height: 16),

        // Input Password
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Password Lama',
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
            controller: _oldPasswordController,
            obscureText: true,  // Menyembunyikan input password
            decoration: const InputDecoration(
              contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              border: InputBorder.none,
            ),
          ),
        ),
        const SizedBox(height: 16),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Password Baru',
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
            controller: _passwordController,
            obscureText: true,  // Menyembunyikan input password
            decoration: const InputDecoration(
              contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              border: InputBorder.none,
            ),
          ),
        ),
        const SizedBox(height: 16),

        // Pilih Avatar
        ElevatedButton.icon(
          onPressed: _pickAvatar,
          icon: const Icon(Icons.image),
          label: const Text('Pilih Avatar'),
        ),
        const SizedBox(height: 30),

        // Tombol Simpan
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFEFB509),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            minimumSize: Size(screenWidth * 0.5, 50),
          ),
          onPressed: _updateProfile,
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
