import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hello_world/config.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;


class EditProfilPage extends StatelessWidget {
  const EditProfilPage({super.key, required this.token});

  final String token;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              const Color(0xFF0D47A1),
              const Color(0xFF1565C0),
              Colors.blue.shade600,
            ],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                // Custom App Bar
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: IconButton(
                          icon: const Icon(Icons.arrow_back_ios_new),
                          color: Colors.white,
                          onPressed: () => Navigator.pop(context),
                        ),
                      ),
                      const Expanded(
                        child: Text(
                          'Edit Profil',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(width: 48), // Balance the layout
                    ],
                  ),
                ),
                
                // Main Content Container
                Container(
                  margin: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(color: Colors.white.withOpacity(0.2)),
                  ),
                  child: EditProfileForm(token: token),
                ),
              ],
            ),
          ),
        ),
      ),
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
  final TextEditingController _oldPasswordController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();


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


      setState(() {
        avatarUrl = profileData['avatar'];
        _usernameController.text = profileData['username'];
        _nameController.text = profileData['nama'];
        _nipController.text = profileData['nip'];


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

  Future<Map<String, dynamic>> _fetchProfile(String token) async {
    final response = await http.get(
      Uri.parse(Config.profile),
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
        'password': _passwordController.text,
        'old_password': _oldPasswordController.text,
      };

      final request = http.MultipartRequest(
        'POST',
        Uri.parse(Config.profile),
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
    if (_isLoading) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(32.0),
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
          ),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        children: [
          // Profile Image Section
          Stack(
            alignment: Alignment.center,
            children: [
              GestureDetector(
                onTap: _pickAvatar,
                child: Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 3),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 10,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: CircleAvatar(
                    radius: 55,
                    backgroundImage: _selectedAvatar != null
                        ? FileImage(_selectedAvatar!)
                        : avatarUrl != null
                            ? NetworkImage(avatarUrl!) as ImageProvider
                            : null,
                    backgroundColor: Colors.blue.shade200,
                    child: _selectedAvatar == null && avatarUrl == null
                        ? const Icon(Icons.person, size: 50, color: Colors.white)
                        : null,
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 5,
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.camera_alt,
                    size: 20,
                    color: Colors.blue,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 32),

          // Form Fields
          _buildTextField("Username", _usernameController, true),
          _buildTextField("Nama Lengkap", _nameController, false),
          _buildTextField("NIP", _nipController, false),
          _buildTextField("Password Lama", _oldPasswordController, false, obscureText: true),
          _buildTextField("Password Baru", _passwordController, false, obscureText: true),
          
          const SizedBox(height: 32),

          // Save Button
          Container(
            width: double.infinity,
            height: 55,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.blue.shade400, Colors.blue.shade600],
              ),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: const Color.fromARGB(255, 255, 255, 255).withOpacity(0.3),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: ElevatedButton(
              onPressed: _saveProfile,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                shadowColor: Colors.transparent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: Text(
                'Simpan Perubahan',
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(
    String label,
    TextEditingController controller,
    bool readOnly, {
    bool obscureText = false,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.white),
            ),
            child: TextField(
              controller: controller,
              readOnly: readOnly,
              obscureText: obscureText,
              style: const TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                border: InputBorder.none,
                hintText: 'Masukkan $label',
                hintStyle: TextStyle(color: Colors.white.withOpacity(0.5)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}