import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
  BidangModel? _selectedBidang;
  MatkulModel? _selectedMatkul;
  File? _selectedAvatar;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchInitialData();
  }

  Future<void> _fetchInitialData() async {
    try {
      // Fetch data from API
      final bidangData = await _fetchBidang(widget.token);
      final matkulData = await _fetchMatkul(widget.token);
      final profileData = await _fetchProfile(widget.token);

      setState(() {
        _usernameController.text = profileData['username'];
        _nameController.text = profileData['nama'];
        _nipController.text = profileData['nip'];
        _bidangList = bidangData;
        _matkulList = matkulData;

        _selectedBidang = _bidangList.firstWhere((b) => b.id == profileData['bidangId']);
        _selectedMatkul = _matkulList.firstWhere((m) => m.id == profileData['matkulId']);
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal memuat data: $e')),
      );
    }
  }

  Future<List<BidangModel>> _fetchBidang(String token) async {
    final response = await http.get(
      Uri.parse('http://yourapi.com/api/bidang'),
      headers: {'Authorization': 'Bearer $token'},
    );
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => BidangModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load bidang');
    }
  }

  Future<List<MatkulModel>> _fetchMatkul(String token) async {
    final response = await http.get(
      Uri.parse('http://yourapi.com/api/matkul'),
      headers: {'Authorization': 'Bearer $token'},
    );
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => MatkulModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load matkul');
    }
  }

  Future<Map<String, dynamic>> _fetchProfile(String token) async {
    final response = await http.get(
      Uri.parse('http://yourapi.com/api/profile'),
      headers: {'Authorization': 'Bearer $token'},
    );
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load profile');
    }
  }

  Future<void> _pickAvatar() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _selectedAvatar = File(pickedFile.path);
      });
    }
  }

  Future<void> _saveProfile() async {
    try {
      final request = http.MultipartRequest(
        'POST',
        Uri.parse('http://yourapi.com/api/profile/update'),
      );
      request.headers['Authorization'] = 'Bearer ${widget.token}';
      request.fields['username'] = _usernameController.text;
      request.fields['nama'] = _nameController.text;
      request.fields['nip'] = _nipController.text;
      request.fields['bidangId'] = _selectedBidang!.id.toString();
      request.fields['matkulId'] = _selectedMatkul!.id.toString();
      if (_selectedAvatar != null) {
        request.files.add(await http.MultipartFile.fromPath('avatar', _selectedAvatar!.path));
      }
      final response = await request.send();
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
            backgroundImage: _selectedAvatar != null ? FileImage(_selectedAvatar!) : null,
            child: _selectedAvatar == null
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
        _buildDropdown("Bidang", _bidangList, _selectedBidang, (value) {
          setState(() {
            _selectedBidang = value;
          });
        }),
        const SizedBox(height: 16),
        _buildDropdown("Mata Kuliah", _matkulList, _selectedMatkul, (value) {
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

  Widget _buildTextField(String label, TextEditingController controller, bool readOnly) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: GoogleFonts.montserrat(color: Colors.white, fontSize: 16)),
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
              contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              border: InputBorder.none,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDropdown<T>(String label, List<T> items, T? selectedItem, ValueChanged<T?> onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: GoogleFonts.montserrat(color: Colors.white, fontSize: 16)),
        const SizedBox(height: 8),
        Container(
          height: 50,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: DropdownButton<T>(
            value: selectedItem,
            onChanged: onChanged,
            underline: const SizedBox(),
            isExpanded: true,
            items: items.map((item) {
              return DropdownMenuItem<T>(
                value: item,
                child: Text(item.toString()),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
