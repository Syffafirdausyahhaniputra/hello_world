import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hello_world/config.dart';
import 'package:hello_world/sessionManager.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:hello_world/dosen.dart';
import 'package:image_picker/image_picker.dart';

class DataPelatihanForm extends StatefulWidget {
  @override
  _DataPelatihanFormState createState() => _DataPelatihanFormState();
}

class _DataPelatihanFormState extends State<DataPelatihanForm> {
  final String baseUrl = Config.baseUrl;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _periodeController = TextEditingController();
  final TextEditingController _startDateController = TextEditingController();
  final TextEditingController _endDateController = TextEditingController();
  final TextEditingController _biayaController = TextEditingController();
  final TextEditingController _kuotaController = TextEditingController();
  final TextEditingController _lokasiController = TextEditingController();
  
  List<dynamic> levels = [];
  List<dynamic> vendors = [];
  List<dynamic> bidangs = [];
  List<dynamic> matkuls = [];
  File? _selectedFile;
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
      final response =
          await http.get(Uri.parse('$baseUrl/api/pelatihan/dropdown'));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          levels = data['levels'] ?? [];
          vendors = data['vendors'] ?? [];
          bidangs = data['bidangs'] ?? [];
          matkuls = data['matkuls'] ?? [];
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to load dropdown data')),
        );
      }
    } catch (e) {
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
        _selectedFile = File(pickedFile.path);
      });
    }
  }

  Future<void> _submitForm() async {
    Map<String, String?> userData = await SessionManager.getUserData();
    String token = userData['token'] ?? "";
    String id = userData['id'] ?? "";

    final Map<String, dynamic> requestData = {
      "level_id": selectedLevel,
      "bidang_id": selectedBidang,
      "mk_id": selectedMatkul,
      "vendor_id": selectedVendor,
      "nama_pelatihan": _nameController.text,
      "biaya": _biayaController.text,
      "tanggal": _startDateController.text,
      "tanggal_akhir": _endDateController.text,
      "kuota": _kuotaController.text,
      "lokasi": _lokasiController.text,
      "periode": _periodeController.text,
      "status": "Proses",
      "dosen_id": id,
      "keterangan" : "Mandiri",
      "surat_tugas": null,
    };

    try {
      final response = await http.post(
        Uri.parse('$baseUrl/api/pelatihan/store'),
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
          'Input Pelatihan',
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
                      maxWidth: 600,
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
                              'Detail Pelatihan',
                              style: GoogleFonts.poppins(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF0D47A1),
                              ),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 20),
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
      _buildTextField('Nama Pelatihan', _nameController),
      _buildTextField('Biaya', _biayaController, 
        prefixIcon: Icon(Icons.attach_money, color: Color(0xFF0D47A1)),
        keyboardType: TextInputType.number
      ),
      _buildTextField('Kuota', _kuotaController, 
        prefixIcon: Icon(Icons.people, color: Color(0xFF0D47A1)),
        keyboardType: TextInputType.number
      ),
      _buildTextField('Lokasi', _lokasiController),
      _buildDateField('Tanggal Mulai', _startDateController),
      _buildDateField('Tanggal Akhir', _endDateController),
      _buildTextField('Periode', _periodeController),
      
      _buildStyledDropdown(
        'Jenis',
        levels,
        selectedLevel,
        (value) => setState(() => selectedLevel = value),
        (level) => level['level_nama'],
        (level) => level['level_id'],
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
            'Submit Pelatihan',
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