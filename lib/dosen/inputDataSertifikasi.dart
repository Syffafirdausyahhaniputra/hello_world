import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hello_world/config.dart';
import 'package:hello_world/Model/DataSertifikasiModel.dart';
import 'package:hello_world/Model/SertifikasiModel.dart';
import 'package:hello_world/sessionManager.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:hello_world/dosen.dart';
import 'package:image_picker/image_picker.dart';

class DataSertifikasiForm extends StatefulWidget {
  @override
  _DataSertifikasiFormState createState() => _DataSertifikasiFormState();
}

class _DataSertifikasiFormState extends State<DataSertifikasiForm> {
  final String baseUrl = Config.baseUrl;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _periodeController = TextEditingController();
  final TextEditingController _startDateController = TextEditingController();
  final TextEditingController _endDateController = TextEditingController();
  final TextEditingController _biayaController = TextEditingController();
  final TextEditingController _masaController = TextEditingController();
  List<dynamic> jenis = [];
  List<dynamic> vendors = [];
  List<dynamic> bidangs = [];
  List<dynamic> matkuls = [];
  File? _selectedFile;
  int? selectedJenis;
  int? selectedVendor;
  int? selectedBidang;
  int? selectedMatkul;

  @override
  void initState() {
    super.initState();
    fetchDropdownData();
  }

    Future<void> _pickFile() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _selectedFile= File(pickedFile.path);
      });
    }
  }

  Future<void> fetchDropdownData() async {
    try {
      final response =
          await http.get(Uri.parse('$baseUrl/api/sertifikasi/dropdown'));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          jenis   = data['jenis'] ?? [];
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

Future<void> _submitForm() async {
  Map<String, String?> userData = await SessionManager.getUserData();
  String token = userData['token'] ?? "";
  String id = userData['id'] ?? "";

  final Map<String, dynamic> requestData = {
    "jenis_id": selectedJenis,
    "bidang_id": selectedBidang,
    "mk_id": selectedMatkul,
    "vendor_id": selectedVendor,
    "nama_pelatihan": _nameController.text,
    "biaya": _biayaController.text,
    "tanggal": _startDateController.text,
    "tanggal_akhir": _endDateController.text,
    "masa berlakur": _masaController.text,
    "periode": _periodeController.text,
    "status": "Proses",
    "dosen_id": id,
    "keterangan" : "Mandiri",
    "surat_tugas": null,
  };

  try {
    final response = await http.post(
      Uri.parse('$baseUrl/api/sertifikasi/store'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(requestData),
    );

    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      final responseData =
          response.body.isNotEmpty ? jsonDecode(response.body) : {};
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DosenPage(token: token),
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Data berhasil ditambahkan!')),
      );
    } else {
      final errorData =
          response.body.isNotEmpty ? jsonDecode(response.body) : {};
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(
                '${errorData['message'] ?? "Kesalahan tidak diketahui"}')),
      );
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DosenPage(token: token),
        ),
      );
    }
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Errorss: $e')),
    );
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF0D47A1),
        title: Text(
          'Input Data Sertifikasi',
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        controller: ScrollController(),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              _buildTextField('Nama Sertifikasi', _nameController),
              _buildTextField('Biaya', _biayaController),
              _buildDateField('Tanggal Mulai', _startDateController),
              _buildDateField('Tanggal Akhir', _endDateController),
              _buildDateField('Masa Berlaku', _masaController),
              _buildTextField('Periode', _periodeController),
              DropdownButtonFormField<int>(
                value: selectedJenis,
                decoration: const InputDecoration(
                  labelText: 'Jenis',
                  border: OutlineInputBorder(),
                ),
                items: jenis.map((level) {
                  return DropdownMenuItem<int>(
                    value: level['jenis_id'],
                    child: Text(level['jenis_nama']),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedJenis = value;
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
              ElevatedButton(
                onPressed: _pickFile,
                child: Text('Pilih Surat Tugas'),
              ),
              if (_selectedFile != null)
                Text('File: ${_selectedFile!.path.split('/').last}'),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitForm,
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