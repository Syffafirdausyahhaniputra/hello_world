import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'notifikasiInputData.dart'; // Import halaman notifikasi

class InputDataSertifikasiPage extends StatelessWidget {
  const InputDataSertifikasiPage({Key? key}) : super(key: key);

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
                  'INPUT DATA SERTIFIKASI',
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
  final TextEditingController _noController = TextEditingController();
  final TextEditingController _periodeController = TextEditingController();
  final TextEditingController _dateController = TextEditingController(); // Controller untuk tanggal
  final TextEditingController _expiredDateController = TextEditingController(); // Controller untuk masa berlaku

  String? _selectedJenis;
  DateTime? _selectedDate;
  String? _selectedVendor;
  DateTime? _selectedExpired;
  String? _selectedBidang;
  String? _selectedMataKuliah;

  @override
  void dispose() {
    _nameController.dispose();
    _noController.dispose();
    _dateController.dispose();
    _expiredDateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTextField('Nama Sertifikasi', _nameController),
          _buildTextField('No. Sertifikat', _noController),
          _buildDropdownField('Jenis', _selectedJenis, ['Jenis 1', 'Jenis 2', 'Jenis 3']),
          _buildDateField('Tanggal', _dateController, (newDate) => setState(() => _selectedDate = newDate)),
          _buildDropdownField('Vendor', _selectedVendor, ['Vendor 1', 'Vendor 2', 'Vendor 3']),
          _buildDateField('Masa Berlaku', _expiredDateController, (newDate) => setState(() => _selectedExpired = newDate)),
          _buildDropdownField('Bidang', _selectedBidang, ['Bidang 1', 'Bidang 2', 'Bidang 3']),
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
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const NotificationPage(),
                  ),
                );
              },
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

  Widget _buildDateField(String label, TextEditingController controller, Function(DateTime) onDateSelected) {
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
                  onDateSelected(picked);
                  // Update controller agar tanggal muncul di TextField
                  controller.text = "${picked.day}-${picked.month}-${picked.year}";
                }
              },
            ),
          ),
          style: GoogleFonts.montserrat(
            fontSize: 16,
          ),
        ),
      ),
      const SizedBox(height: 16),
    ],
  );
}

}
