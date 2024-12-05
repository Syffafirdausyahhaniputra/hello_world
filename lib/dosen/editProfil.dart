import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hello_world/config.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:hello_world/Model/BidangModel.dart';
import 'package:hello_world/Model/MatkulModel.dart';

class EditProfilPage extends StatelessWidget {
  const EditProfilPage({super.key, required this.token});

  final String token;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
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
  int? _selectedBidang;
  int? _selectedMatkul;
  File? _selectedAvatar;
  bool _isLoading = true;
  String? avatarUrl;

  @override
  void initState() {
    super.initState();
    _fetchInitialData();
  }

  Future<void> _fetchInitialData() async {
    try {
      // Fetch data from API
      final profileData = await _fetchProfile(widget.token);
      final bidangData = await _fetchBidang(widget.token);
      final matkulData = await _fetchMatkul(widget.token);

      setState(() {
        avatarUrl = profileData['avatar'];
        _usernameController.text = profileData['username'];
        _nameController.text = profileData['nama'];
        _nipController.text = profileData['nip'];
        _bidangList = bidangData;
        _matkulList = matkulData;

        _selectedBidang = profileData['bidang'];
        _selectedMatkul = profileData['matkul'];
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal memuat data: $e')),
      );
    }
  }

  Future<List<BidangModel>> _fetchBidang(String token) async {
    final response = await http.get(
      Uri.parse(Config.bidangList),
      headers: {'Authorization': 'Bearer $token'},
    );
    if (response.statusCode == 200) {
      print(response.body);
      final List<BidangModel> data = (jsonDecode(response.body)['data'] as List)
          .map((json) => BidangModel.fromJson(json))
          .toList();
      return data;
    } else {
      throw Exception('Failed to load bidang');
    }
  }

  Future<List<MatkulModel>> _fetchMatkul(String token) async {
    final response = await http.get(
      Uri.parse(Config.matkulList),
      headers: {'Authorization': 'Bearer $token'},
    );
    if (response.statusCode == 200) {
      print(response.body);
      final List<MatkulModel> data = (jsonDecode(response.body)['data'] as List)
          .map((json) => MatkulModel.fromJson(json))
          .toList();
      ;
      return data;
    } else {
      throw Exception('Failed to load matkul');
    }
  }

  Future<Map<String, dynamic>> _fetchProfile(String token) async {
    final response = await http.get(
      Uri.parse(Config.dosenProfile),
      headers: {'Authorization': 'Bearer $token'},
    );
    if (response.statusCode == 200) {
      print(response.body);
      return json.decode(response.body)['data'];
    } else {
      throw Exception('Failed to load profile');
    }
  }

  Future<void> _pickAvatar() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _selectedAvatar = File(pickedFile.path);
      });
    }
  }

  Future<void> _saveProfile() async {
    try {
      final header = {
        'Authorization': 'Bearer ${widget.token}',
      };

      final data = {
        'username': _usernameController.text,
        'nama': _nameController.text,
        'nip': _nipController.text,
        'bidang_id': _selectedBidang.toString(),
        'mk_id': _selectedMatkul.toString(),
      };

      final request = http.MultipartRequest(
        'POST',
        Uri.parse(Config.dosenProfile),
      )
        ..headers.addAll(header)
        ..fields.addAll(data);
      if (_selectedAvatar != null) {
        request.files.add(
            await http.MultipartFile.fromPath('avatar', _selectedAvatar!.path));
      }
      print(request.headers);
      final response = await request.send();
      print(response.statusCode);
      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Profil berhasil diperbarui')),
        );
      } else {
        throw Exception('Gagal menyimpan profil');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    return Column(
      children: [
        GestureDetector(
          onTap: _pickAvatar,
          child: CircleAvatar(
            radius: 50,
            backgroundImage: _selectedAvatar != null
                ? FileImage(_selectedAvatar!)
                : avatarUrl != null
                    ? NetworkImage(avatarUrl ?? '')
                    : null,
            child: _selectedAvatar == null && avatarUrl == null
                ? const Icon(Icons.person, size: 50, color: Colors.white)
                : null,
          ),
        ),
        const SizedBox(height: 16),
        _buildTextField("Username", _usernameController, true),
        const SizedBox(height: 16),
        _buildTextField("Nama", _nameController, false),
        const SizedBox(height: 16),
        _buildTextField("NIP", _nipController, false),
        const SizedBox(height: 16),
        _buildDropdownBidang("Bidang", _bidangList, _selectedBidang, (value) {
          setState(() {
            _selectedBidang = value;
          });
        }),
        const SizedBox(height: 16),
        _buildDropdownMatkul("Mata Kuliah", _matkulList, _selectedMatkul,
            (value) {
          setState(() {
            _selectedMatkul = value;
          });
        }),
        const SizedBox(height: 30),
        ElevatedButton(
          onPressed: _saveProfile,
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

  Widget _buildTextField(
      String label, TextEditingController controller, bool readOnly) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: GoogleFonts.montserrat(color: Colors.white, fontSize: 16)),
        const SizedBox(height: 8),
        Container(
          height: 50,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: TextField(
            controller: controller,
            readOnly: readOnly,
            decoration: const InputDecoration(
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              border: InputBorder.none,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDropdownMatkul(String label, List<MatkulModel> items,
      int? selectedItem, ValueChanged onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: GoogleFonts.montserrat(color: Colors.white, fontSize: 16)),
        const SizedBox(height: 8),
        Container(
          height: 50,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: DropdownButton(
            value: selectedItem,
            onChanged: onChanged,
            underline: const SizedBox(),
            isExpanded: true,
            items: items.map((item) {
              return DropdownMenuItem(
                value: item.mkId,
                child: Text(item.mkNama),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildDropdownBidang(String label, List<BidangModel> items,
      int? selectedItem, ValueChanged onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: GoogleFonts.montserrat(color: Colors.white, fontSize: 16)),
        const SizedBox(height: 8),
        Container(
          height: 50,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: DropdownButton(
            value: selectedItem,
            onChanged: onChanged,
            underline: const SizedBox(),
            isExpanded: true,
            items: items.map((item) {
              return DropdownMenuItem(
                value: item.bidangId,
                child: Text(item.bidangNama),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
