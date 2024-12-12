import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class InputDataPelatihanPage extends StatelessWidget {
  const InputDataPelatihanPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 1),
                ),
                padding: EdgeInsets.all(0),
                child: IconButton(
                  icon: const Icon(Icons.arrow_back_ios_new),
                  color: Colors.white,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              const SizedBox(height: 20),
              Center(
                child: Text(
                  'INPUT DATA PELATIHAN',
                  style: GoogleFonts.poppins(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Expanded(child: const InputDataForm()), // Gunakan Expanded di sini
            ],
          ),
        ),
      ),
      backgroundColor: const Color(0xFF0D47A1),
    );
  }
}

class InputDataForm extends StatefulWidget {
  const InputDataForm({Key? key}) : super(key: key);

  @override
  InputDataFormState createState() => InputDataFormState();
}

class InputDataFormState extends State<InputDataForm> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _periodeController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _expiredDateController = TextEditingController();

  String? _selectedJenis;
  String? _selectedVendor;
  String? _selectedBidang;
  String? _selectedMataKuliah;

  @override
  void dispose() {
    _nameController.dispose();
    _periodeController.dispose();
    _dateController.dispose();
    _expiredDateController.dispose();
    super.dispose();
  }

  Future<void> _submitData() async {
    const String apiUrl = 'https://your-api-domain.com/api/pelatihans';

    final Map<String, dynamic> data = {
      'nama_pelatihan': _nameController.text,
      'tanggal': _dateController.text,
      'tanggal_akhir': _expiredDateController.text,
      'periode': _periodeController.text,
      'jenis': _selectedJenis,
      'vendor': _selectedVendor,
      'bidang': _selectedBidang,
      'mata_kuliah': _selectedMataKuliah,
    };

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(data),
      );

      if (response.statusCode == 201) {
        // Jika berhasil
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Data berhasil dikirim')),
        );
      } else {
        final responseBody = json.decode(response.body);
        throw Exception(responseBody['message'] ?? 'Gagal mengirim data');
      }
    } catch (e) {
      // Jika gagal
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTextField('Nama Pelatihan', _nameController),
          _buildDropdownField('Level', _selectedJenis, ['Internasional', 'Nasional']),
          _buildDateField('Tanggal', _dateController),
          _buildDropdownField('Vendor', _selectedVendor, ['Vendor 1', 'Vendor 2', 'Vendor 3']),
          _buildDateField('Tanggal Akhir', _expiredDateController),
          _buildDropdownField('Bidang', _selectedBidang, ['Bidang 1', 'Bidang 2']),
          _buildDropdownField('Mata Kuliah', _selectedMataKuliah, ['Mata Kuliah 1', 'Mata Kuliah 2']),
          _buildTextField('Periode', _periodeController),
      
          const SizedBox(height: 30),
          Center(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFEFB509),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                minimumSize: const Size(120, 40),
              ),
              onPressed: _submitData, // Panggil fungsi submit di sini
              child: Text(
                'KIRIM',
                style: GoogleFonts.poppins(
                  color: Colors.black,
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

  Widget _buildTextField(String label, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.montserrat(
            color: Colors.white,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          height: 45,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: TextField(
            controller: controller,
            decoration: const InputDecoration(
              contentPadding: EdgeInsets.symmetric(horizontal: 20),
              border: InputBorder.none,
            ),
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildDropdownField(String label, String? selectedValue, List<String> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.montserrat(
            color: Colors.white,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          height: 50,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: DropdownButtonFormField<String>(
            value: selectedValue,
            onChanged: (newValue) {
              setState(() {
                selectedValue = newValue;
              });
            },
            items: items.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            decoration: const InputDecoration(
              contentPadding: EdgeInsets.symmetric(horizontal: 20),
              border: InputBorder.none,
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
            color: Colors.white,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          height: 50,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: TextField(
            controller: controller,
            readOnly: true,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
              border: InputBorder.none,
              suffixIcon: IconButton(
                icon: const Icon(Icons.calendar_today, color: Colors.grey),
                onPressed: () async {
                  final DateTime? picked = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2101),
                  );
                  if (picked != null) {
                    setState(() {
                      controller.text = "${picked.toLocal()}".split(' ')[0];
                    });
                  }
                },
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
