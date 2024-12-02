import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hello_world/Model/BidangModel.dart';
import 'package:hello_world/Model/MatkulModel.dart';

class EditProfilPage extends StatelessWidget {
  const EditProfilPage({super.key, required this.token});

  final String token;

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
                  IconButton(
                    icon: const Icon(Icons.arrow_back_ios_new),
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
              CircleAvatar(
                radius: 50,
                backgroundColor: Colors.white,
                child: const Icon(
                  Icons.person,
                  size: 50,
                  color: Color(0xFF0D47A1),
                ),
              ),
              const SizedBox(height: 30),
              EditProfileForm(token: token), // Pass token to the form
            ],
          ),
        ),
      ),
      backgroundColor: const Color(0xFF0D47A1),
    );
  }
}

class EditProfileForm extends StatefulWidget {
  const EditProfileForm({super.key, required this.token});

  final String token;

  @override
  _EditProfileFormState createState() => _EditProfileFormState();
}

class _EditProfileFormState extends State<EditProfileForm> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _nipController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();

  List<BidangModel> _bidangList = [];
  List<MatkulModel> _matkulList = [];
  BidangModel? _selectedBidang;
  MatkulModel? _selectedMatkul;

  @override
  void initState() {
    super.initState();
    _fetchInitialData();
  }

  Future<void> _fetchInitialData() async {
    // Simulasi fetching data dari server atau API
    setState(() {
      // Set default user data
      _usernameController.text = "john_doe"; // Ganti dengan data dari API
      _nameController.text = "John Doe";
      _nipController.text = "123456789";

      // Set bidang and matkul list
      _bidangList = [
        BidangModel(bidangId: 1, bidangKode: "BD001", bidangNama: "Teknologi Informasi"),
        BidangModel(bidangId: 2, bidangKode: "BD002", bidangNama: "Sistem Informasi"),
      ];
      _matkulList = [
        MatkulModel(mkId: 1, mkKode: "MK001", mkNama: "Pemrograman"),
        MatkulModel(mkId: 2, mkKode: "MK002", mkNama: "Manajemen Data"),
      ];

      _selectedBidang = _bidangList.first;
      _selectedMatkul = _matkulList.first;
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _nipController.dispose();
    _usernameController.dispose();
    super.dispose();
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
            readOnly: true,
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
            readOnly: true,
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
            readOnly: true,
            decoration: const InputDecoration(
              contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              border: InputBorder.none,
            ),
          ),
        ),
        const SizedBox(height: 16),

        // Dropdown Bidang
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
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: DropdownButton<BidangModel>(
            value: _selectedBidang,
            isExpanded: true,
            underline: const SizedBox(),
            onChanged: (value) {
              setState(() {
                _selectedBidang = value;
              });
            },
            items: _bidangList
                .map((bidang) => DropdownMenuItem(
                      value: bidang,
                      child: Text(bidang.bidangNama),
                    ))
                .toList(),
          ),
        ),
        const SizedBox(height: 16),

        // Dropdown Matkul
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Mata Kuliah',
            style: GoogleFonts.montserrat(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Container(
          width: screenWidth * 0.9,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: DropdownButton<MatkulModel>(
            value: _selectedMatkul,
            isExpanded: true,
            underline: const SizedBox(),
            onChanged: (value) {
              setState(() {
                _selectedMatkul = value;
              });
            },
            items: _matkulList
                .map((matkul) => DropdownMenuItem(
                      value: matkul,
                      child: Text(matkul.mkNama),
                    ))
                .toList(),
          ),
        ),
        const SizedBox(height: 30),

        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFEFB509),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            minimumSize: Size(screenWidth * 0.5, 50),
          ),
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Data berhasil disimpan')),
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
