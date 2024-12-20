import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hello_world/config.dart';
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

  // Method to fetch dropdown data
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

  // Method to pick a file
  Future<void> _pickFile() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _selectedFile = File(pickedFile.path);
      });
    }
  }

  // Method to submit the form
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
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xFF0D47A1),
        title: Text(
          'Input Sertifikasi',
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          // Background gradient - unchanged
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFF0D47A1).withOpacity(0.1),
                  Colors.white,
                ],
              ),
            ),
          ),
          // Responsive scroll and padding
          LayoutBuilder(
            builder: (context, constraints) {
              final double maxWidth = constraints.maxWidth;
              final double horizontalPadding = maxWidth * 0.05;

              return SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: horizontalPadding,
                    vertical: 20.0,
                  ),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      maxWidth: 600, // Limit form width on larger screens
                    ),
                    child: Card(
                      elevation: 8,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                              'Detail Sertifikasi',
                              style: GoogleFonts.poppins(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF0D47A1),
                              ),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 20),
                            // Existing form fields with responsive sizing
                            ..._buildResponsiveFormFields(maxWidth),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  List<Widget> _buildResponsiveFormFields(double maxWidth) {
    return [
      _buildTextField('Nama Sertifikasi', _nameController),
      _buildTextField('Biaya', _biayaController, 
        prefixIcon: Icon(Icons.attach_money, color: Color(0xFF0D47A1)),
        keyboardType: TextInputType.number
      ),
      _buildDateField('Tanggal Mulai', _startDateController),
      _buildDateField('Tanggal Akhir', _endDateController),
      _buildDateField('Masa Berlaku', _masaController),
      _buildTextField('Periode', _periodeController),
      
      // Responsive dropdown and button sizes
      _buildStyledDropdown(
        'Jenis',
        jenis,
        selectedJenis,
        (value) => setState(() => selectedJenis = value),
        (level) => level['jenis_nama'],
        (level) => level['jenis_id'],
      ),
      _buildStyledDropdown(
        'Vendor',
        vendors,
        selectedVendor,
        (value) => setState(() => selectedVendor = value),
        (vendor) => vendor['vendor_nama'],
        (vendor) => vendor['vendor_id'],
      ),
      _buildStyledDropdown(
        'Bidang',
        bidangs,
        selectedBidang,
        (value) => setState(() => selectedBidang = value),
        (bidang) => bidang['bidang_nama'],
        (bidang) => bidang['bidang_id'],
      ),
      _buildStyledDropdown(
        'Mata Kuliah',
        matkuls,
        selectedMatkul,
        (value) => setState(() => selectedMatkul = value),
        (matkul) => matkul['mk_nama'],
        (matkul) => matkul['mk_id'],
      ),
      
      _buildFileUploadSection(maxWidth),
      
      // Responsive submit button
      Padding(
        padding: EdgeInsets.symmetric(
          vertical: 20.0,
          horizontal: maxWidth > 600 ? 24.0 : 16.0,
        ),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xFF0D47A1),
            padding: EdgeInsets.symmetric(
              vertical: maxWidth > 600 ? 15 : 12,
              horizontal: maxWidth > 600 ? 24 : 16,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          onPressed: _submitForm,
          child: Text(
            'Submit Sertifikasi',
            style: GoogleFonts.poppins(
              fontSize: maxWidth > 600 ? 18 : 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
    ];
  }

  Widget _buildFileUploadSection(double maxWidth) {
return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 10.0,
        horizontal: maxWidth > 600 ? 0.0 : 16.0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ElevatedButton.icon(
            icon: Icon(Icons.upload_file, color: Colors.white),
            label: Text(
              'Pilih Surat Tugas',
              style: GoogleFonts.poppins(color: Colors.white),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFF0D47A1).withOpacity(0.8),
              padding: EdgeInsets.symmetric(
                vertical: maxWidth > 600 ? 12 : 10,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            onPressed: _pickFile,
          ),
          if (_selectedFile != null)
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Row(
                children: [
                  Icon(Icons.file_present, color: Color(0xFF0D47A1)),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      _selectedFile!.path.split('/').last,
                      style: GoogleFonts.montserrat(
                        color: Colors.black87,
                      ),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  // Enhanced Dropdown Method with Better Styling
  Widget _buildStyledDropdown(
    String label, 
    List<dynamic> items, 
    int? selectedValue, 
    void Function(int?) onChanged,
    String Function(dynamic) labelExtractor,
    int Function(dynamic) valueExtractor,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: DropdownButtonFormField<int>(
        value: selectedValue,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: GoogleFonts.montserrat(
            color: Color(0xFF0D47A1),
            fontWeight: FontWeight.w600,
          ),
          prefixIcon: Icon(Icons.list, color: Color(0xFF0D47A1)),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Color(0xFF0D47A1), width: 1.5),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey.shade300, width: 1.5),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Color(0xFF0D47A1), width: 2),
          ),
        ),
        items: items.map((item) {
          return DropdownMenuItem<int>(
            value: valueExtractor(item),
            child: Text(
              labelExtractor(item),
              style: GoogleFonts.montserrat(),
            ),
          );
        }).toList(),
        onChanged: onChanged,
      ),
    );
  }



  // Enhanced TextField Method
  Widget _buildTextField(
    String label, 
    TextEditingController controller, {
    Icon? prefixIcon,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: GoogleFonts.montserrat(
            color: Color(0xFF0D47A1),
            fontWeight: FontWeight.w600,
          ),
          prefixIcon: prefixIcon,
          filled: true,
          fillColor: Colors.grey.shade100,
          hintText: 'Masukkan $label',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Color(0xFF0D47A1), width: 2),
          ),
        ),
      ),
    );
  }

  // Enhanced Date Field Method
  Widget _buildDateField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: GestureDetector(
        onTap: () async {
          DateTime? pickedDate = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2000),
            lastDate: DateTime(2101),
            builder: (context, child) {
              return Theme(
                data: ThemeData.light().copyWith(
                  colorScheme: ColorScheme.light(
                    primary: Color(0xFF0D47A1),
                  ),
                ),
                child: child!,
              );
            },
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
              labelText: label,
              labelStyle: GoogleFonts.montserrat(
                color: Color(0xFF0D47A1),
                fontWeight: FontWeight.w600,
              ),
              prefixIcon: Icon(Icons.calendar_today, color: Color(0xFF0D47A1)),
              filled: true,
              fillColor: Colors.grey.shade100,
              hintText: 'Pilih tanggal',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.grey.shade300),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.grey.shade300),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Color(0xFF0D47A1), width: 2),
              ),
            ),
          ),
        ),
      ),
    );
  }
}