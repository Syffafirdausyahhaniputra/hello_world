import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hello_world/Model/GologanModel.dart';
import 'package:hello_world/Model/JabatanModel.dart';
import 'package:hello_world/Model/PangkatModel.dart';
import 'package:hello_world/config.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:hello_world/Model/BidangModel.dart';
import 'package:hello_world/Model/MatkulModel.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

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
  final TextEditingController _oldPasswordController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  List<BidangModel> _bidangList = [];
  List<MatkulModel> _matkulList = [];
  List<JabatanModel> _jabatanList = [];
  List<GolonganModel> _golonganList = [];
  List<PangkatModel> _pangkatList = [];
  List<int> _selectedBidang = [];
  List<int> _selectedMatkul = [];
  int? _selectedJabatan;
  int? _selectedGolongan;
  int? _selectedPangkat;
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
      final jabatanData = await _fetchJabatan(widget.token);
      final golonganData = await _fetchGolongan(widget.token);
      final pangkatData = await _fetchPangkat(widget.token);

      setState(() {
        avatarUrl = profileData['avatar'];
        _usernameController.text = profileData['username'];
        _nameController.text = profileData['nama'];
        _nipController.text = profileData['nip'].toString();
        _bidangList = bidangData;
        _matkulList = matkulData;
        _jabatanList = jabatanData;
        _golonganList = golonganData;
        _pangkatList = pangkatData;
        _selectedBidang = profileData['bidang'].cast<int>();
        _selectedMatkul = profileData['matkul'].cast<int>();
        _selectedJabatan = profileData['jabatan'] ?? 1;
        _selectedGolongan = profileData['golongan'] ?? 1;
        _selectedPangkat = profileData['pangkat'] ?? 1;
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

  Future<List<JabatanModel>> _fetchJabatan(String token) async {
    final response = await http.get(
      Uri.parse(Config.jabatanList),
      headers: {'Authorization': 'Bearer $token'},
    );
    if (response.statusCode == 200) {
      print(response.body);
      final List<JabatanModel> data =
          (jsonDecode(response.body)['data'] as List)
              .map((json) => JabatanModel.fromJson(json))
              .toList();
      return data;
    } else {
      throw Exception('Failed to load bidang');
    }
  }

  Future<List<GolonganModel>> _fetchGolongan(String token) async {
    final response = await http.get(
      Uri.parse(Config.golonganList),
      headers: {'Authorization': 'Bearer $token'},
    );
    if (response.statusCode == 200) {
      print(response.body);
      final List<GolonganModel> data =
          (jsonDecode(response.body)['data'] as List)
              .map((json) => GolonganModel.fromJson(json))
              .toList();
      return data;
    } else {
      throw Exception('Failed to load bidang');
    }
  }

  Future<List<PangkatModel>> _fetchPangkat(String token) async {
    final response = await http.get(
      Uri.parse(Config.pangkatList),
      headers: {'Authorization': 'Bearer $token'},
    );
    if (response.statusCode == 200) {
      print(response.body);
      final List<PangkatModel> data =
          (jsonDecode(response.body)['data'] as List)
              .map((json) => PangkatModel.fromJson(json))
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

      print(_selectedBidang);

      final data = {
        'username': _usernameController.text,
        'nama': _nameController.text,
        'nip': _nipController.text,
        'jabatan': _selectedJabatan.toString(),
        'golongan': _selectedGolongan.toString(),
        'pangkat': _selectedPangkat.toString(),
        'password': _passwordController.text,
        'old_password': _oldPasswordController.text,
      };
      final request = http.MultipartRequest(
        'POST',
        Uri.parse(Config.dosenProfile),
      )
        ..headers.addAll(header)
        ..fields.addAll(data);
      for (int i = 0; i < _selectedBidang.length; i++) {
        request.fields['bidang[${i}]'] = _selectedBidang[i].toString();
      }
      for (int i = 0; i < _selectedMatkul.length; i++) {
        request.fields['matakuliah[${i}]'] = _selectedMatkul[i].toString();
      }
      if (_selectedAvatar != null) {
        request.files.add(
            await http.MultipartFile.fromPath('avatar', _selectedAvatar!.path));
      }
      print(request.headers);
      print(request.fields);
      final response = await request.send();
      //see the response
      print(response.stream.bytesToString().then((value) => print(value)));
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
        
        const SizedBox(height: 16),
        _buildTextField("Username", _usernameController, true),
        const SizedBox(height: 16),
        _buildTextField("Nama", _nameController, false),
        const SizedBox(height: 16),
        _buildTextField("NIP", _nipController, false),
        const SizedBox(height: 16),
        _buildMultiSelectBidang("Bidang", _bidangList, _selectedBidang,
            (value) {
          setState(() {
            _selectedBidang = value;
          });
        }),
        const SizedBox(height: 16),
        _buildMultiSelectMatkul("Mata Kuliah", _matkulList, _selectedMatkul,
            (value) {
          setState(() {
            _selectedMatkul = value;
          });
        }),
        _buildDropdownJabatan('Jabatan', _jabatanList, _selectedJabatan,
            (value) {
          setState(() {
            _selectedJabatan = value;
          });
        }),
        _buildDropdownGolongan('Golongan', _golonganList, _selectedGolongan,
            (value) {
          setState(() {
            _selectedGolongan = value;
          });
        }),
        _buildDropdownPangkat('Pangkat', _pangkatList, _selectedPangkat,
            (value) {
          setState(() {
            _selectedPangkat = value;
          });
        }),
        const SizedBox(height: 16),
        _buildTextField("Old Password", _oldPasswordController, false,
            obscureText: true),
        const SizedBox(height: 16),
        _buildTextField("Password", _passwordController, false,
            obscureText: true),
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
    ));
  }

  Widget _buildTextField(
      String label, TextEditingController controller, bool readOnly,
      {bool obscureText = false}) {
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
            obscureText: obscureText,
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

  Widget _buildMultiSelectMatkul(String label, List<MatkulModel> items,
      List<int>? selectedItem, ValueChanged onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: GoogleFonts.montserrat(color: Colors.white, fontSize: 16)),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: MultiSelectDialogField(
              buttonText: const Text('Mata Kuliah'),
              title: const Text('Mata Kuliah'),
              items: items
                  .map((matkul) => MultiSelectItem(matkul.mkId, matkul.mkNama))
                  .toList(),
              searchHint: "Pilih Bidang",
              initialValue: selectedItem ?? [],
              onConfirm: (values) {
                setState(() {
                  _selectedBidang = values.cast<int>();
                });
              }),
        ),
      ],
    );
  }

  Widget _buildMultiSelectBidang(String label, List<BidangModel> items,
      List<int>? selectedItem, ValueChanged onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: GoogleFonts.montserrat(color: Colors.white, fontSize: 16)),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: MultiSelectDialogField(
              buttonText: const Text('Bidang'),
              title: const Text('Bidang Minat'),
              items: items
                  .map((bidang) =>
                      MultiSelectItem(bidang.bidangId, bidang.bidangNama))
                  .toList(),
              searchHint: "Pilih Bidang",
              initialValue: selectedItem ?? [],
              onConfirm: (values) {
                setState(() {
                  _selectedMatkul = values.cast<int>();
                });
              }),
        ),
      ],
    );
  }

  Widget _buildDropdownJabatan(String label, List<JabatanModel> items,
      int? selectedItem, ValueChanged onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: GoogleFonts.montserrat(color: Colors.white, fontSize: 16)),
        const SizedBox(height: 8),
        Container(
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
                value: item.jabatanId,
                child: Text(item.jabatanNama),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildDropdownGolongan(String label, List<GolonganModel> items,
      int? selectedItem, ValueChanged onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: GoogleFonts.montserrat(color: Colors.white, fontSize: 16)),
        const SizedBox(height: 8),
        Container(
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
                value: item.golonganId,
                child: Text(item.golonganNama),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildDropdownPangkat(String label, List<PangkatModel> items,
      int? selectedItem, ValueChanged onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: GoogleFonts.montserrat(color: Colors.white, fontSize: 16)),
        const SizedBox(height: 8),
        Container(
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
                value: item.pangkatId,
                child: Text(item.pangkatNama),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
