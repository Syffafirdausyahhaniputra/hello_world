import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hello_world/Controller/PelatihanController.dart';
import 'package:hello_world/Model/pelatihanModel.dart';
import 'package:hello_world/config.dart';
import 'package:hello_world/dosen.dart';
import 'package:hello_world/sessionManager.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
// import 'dart:io';


import 'package:image_picker/image_picker.dart';

class DropdownForm extends StatefulWidget {
    
  @override
  _DropdownFormState createState() => _DropdownFormState();
}

class _DropdownFormState extends State<DropdownForm> {
  final PelatihanController _controller = PelatihanController();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _periodeController = TextEditingController();
  final TextEditingController _startDateController = TextEditingController();
  final TextEditingController _endDateController = TextEditingController();
  final TextEditingController _namaPelatihanController =
      TextEditingController();
  final TextEditingController _biayaController = TextEditingController();
  final TextEditingController _tanggalController = TextEditingController();
  final TextEditingController _tanggalAkhirController = TextEditingController();
  final TextEditingController _kuotaController = TextEditingController();
  final TextEditingController _lokasiController = TextEditingController();
  List<dynamic> levels = [];
  List<dynamic> vendors = [];
  List<dynamic> bidangs = [];
  List<dynamic> matkuls = [];
  File? _selectedfiles;
  int? selectedLevel;
  int? selectedVendor;
  int? selectedBidang;
  int? selectedMatkul;

  @override
  void initState() {
    super.initState();
    fetchDropdownData();
  }

  Future<void> fetchDropdownData() async {
    try {
      final String baseUrl = Config.baseUrl;
      final response = await http
          .get(Uri.parse('$baseUrl/api/pelatihan/dropdown'));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          levels = data['levels'] ?? [];
          vendors = data['vendors'] ?? [];
          bidangs = data['bidangs'] ?? [];
          matkuls = data['matkuls'] ?? [];
        });
      } else {
        // Handle server errors
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to load dropdown data')),
        );
      }
    } catch (e) {
      // Handle network errors
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error fetching data: $e')),
      );
    }
  }

  Future<void> _pickFile() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _selectedfiles = File(pickedFile.path);
      });
    }
  }

  Future<void> _submitForm() async {
    Map<String, String?> userData = await SessionManager.getUserData();
    String token = userData['token'] ?? "";
    String id = userData['id'] ?? "";

    try {
      final String baseUrl = Config.baseUrl;
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('$baseUrl/api/pelatihan/store'),
      );

      // Headers
      request.headers.addAll({
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      });

      // Fields
      request.fields['level_id'] = selectedLevel.toString();
      request.fields['bidang_id'] = selectedBidang.toString();
      request.fields['mk_id'] = selectedMatkul.toString();
      request.fields['vendor_id'] = selectedVendor.toString();
      request.fields['nama_pelatihan'] = _namaPelatihanController.text;
      request.fields['biaya'] = _biayaController.text;
      request.fields['tanggal'] = _tanggalController.text;
      request.fields['tanggal_akhir'] = _tanggalAkhirController.text;
      request.fields['kuota'] = _kuotaController.text;
      request.fields['lokasi'] = _lokasiController.text;
      request.fields['periode'] = _periodeController.text;
      request.fields['status'] = 'Aktif';
      request.fields['dosen_id'] = id;

      // Attach file
      // if (_selectedfiles != null) {
      //   request.files.add(await http.MultipartFile.fromPath(
      //     'surat_tugas', // Sesuaikan dengan nama field di API Laravel
      //     _selectedfiles!.path,
      //   ));
      // }

      var response = await request.send();

      if (response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Data berhasil ditambahkan!')),
        );
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DosenPage(token: token),
          ),
        );
      } else {
        final responseBody = await response.stream.bytesToString();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text('Error: ${jsonDecode(responseBody)['message']}')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dropdown Form'),
      ),
      body: SingleChildScrollView(
        controller: ScrollController(),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              _buildTextField('Nama Pelatihan', _nameController),
              _buildTextField('Biaya', _biayaController),
              _buildTextField('kuota', _kuotaController),
              _buildTextField('lokasi', _lokasiController),
              _buildDateField('Tanggal Mulai', _startDateController),
              _buildDateField('Tanggal Akhir', _endDateController),
              _buildTextField('Periode', _periodeController),
              DropdownButtonFormField<int>(
                value: selectedLevel,
                decoration: const InputDecoration(
                  labelText: 'Jenis',
                  border: OutlineInputBorder(),
                ),
                items: levels.map((level) {
                  return DropdownMenuItem<int>(
                    value: level['level_id'],
                    child: Text(level['level_nama']),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedLevel = value;
                  });
                },
              ),
              DropdownButtonFormField<int>(
                value: selectedVendor,
                decoration: const InputDecoration(
                  labelText: 'Vendor',
                  border: OutlineInputBorder(),
                ),
                items: vendors.map((vendor) {
                  return DropdownMenuItem<int>(
                    value: vendor['vendor_id'],
                    child: Text(vendor['vendor_nama']),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedVendor = value;
                  });
                },
              ),
              DropdownButtonFormField<int>(
                value: selectedBidang,
                decoration: const InputDecoration(
                  labelText: 'Bidang',
                  border: OutlineInputBorder(),
                ),
                items: bidangs.map((bidang) {
                  return DropdownMenuItem<int>(
                    value: bidang['bidang_id'],
                    child: Text(bidang['bidang_nama']),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedBidang = value;
                  });
                },
              ),
              DropdownButtonFormField<int>(
                value: selectedMatkul,
                decoration: const InputDecoration(
                  labelText: 'Mata Kuliah',
                  border: OutlineInputBorder(),
                ),
                items: matkuls.map((matkul) {
                  return DropdownMenuItem<int>(
                    value: matkul['mk_id'],
                    child: Text(matkul['mk_nama']),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedMatkul = value;
                  });
                },
              ),
              // ElevatedButton(
              //   onPressed: _pickFile,
              //   child: Text('Upload Sertifikat'),
              // ),
              // if (_selectedfiles != null)
              //   Text('File: ${_selectedfiles!.path.split('/').last}'),
              // SizedBox(height: 20),
              // ElevatedButton(
              //   onPressed: _submitForm,
              //   child: Text('Submit'),
              // ),
              SizedBox(height: 32),
              ElevatedButton(
                onPressed: () {
                  _submitForm();
                },
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.montserrat(
            color: Colors.black,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            hintText: 'Masukkan $label',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildDateField(String label, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.montserrat(
            color: Colors.black,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: () async {
            DateTime? pickedDate = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(2000),
              lastDate: DateTime(2101),
            );

            if (pickedDate != null) {
              setState(() {
                controller.text = pickedDate.toIso8601String().split('T')[0];
              });
            }
          },
          child: AbsorbPointer(
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                hintText: 'Pilih tanggal',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}