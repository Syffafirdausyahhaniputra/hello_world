// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:hello_world/Model/pelatihanModel.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:hello_world/config.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';


// class InputDataPelatihanPage extends StatefulWidget {
//   const InputDataPelatihanPage({Key? key}) : super(key: key);

//   @override
//   _InputDataPelatihanPageState createState() => _InputDataPelatihanPageState();
// }

// class _InputDataPelatihanPageState extends State<InputDataPelatihanPage> {
//   final PelatihanController _controller = PelatihanController();
  
//   final TextEditingController _nameController = TextEditingController();
//   final TextEditingController _periodeController = TextEditingController();
//   final TextEditingController _startDateController = TextEditingController();
//   final TextEditingController _endDateController = TextEditingController();

//   int? _selectedLevelId;
//   int? _selectedVendorId;
//   int? _selectedBidangId;
//   int? _selectedMataKuliahId;

//   List<dynamic> _levels = [];
//   List<dynamic> _vendors = [];
//   List<dynamic> _bidangs = [];
//   List<dynamic> _matkuls = [];

//   bool isLoading = false;

//   @override
//   void initState() {
//     super.initState();
//     _loadDropdownData();
//   }

//   Future<void> _loadDropdownData() async {
//     setState(() {
//       isLoading = true;
//     });

//     try {
//       final dropdownData = await _controller.fetchDropdownOptions();
//       setState(() {
//         _levels = dropdownData['levels'];
//         _vendors = dropdownData['vendors'];
//         _bidangs = dropdownData['bidangs'];
//         _matkuls = dropdownData['matkuls'];
//       });
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Gagal memuat data dropdown: $e')),
//       );
//     } finally {
//       setState(() {
//         isLoading = false;
//       });
//     }
//   }

//   Future<void> _submitForm() async {
//     // Validation
//     if (_nameController.text.isEmpty ||
//         _selectedLevelId == null ||
//         _selectedVendorId == null ||
//         _selectedBidangId == null ||
//         _selectedMataKuliahId == null ||
//         _periodeController.text.isEmpty) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Harap lengkapi semua data')),
//       );
//       return;
//     }

//     setState(() {
//       isLoading = true;
//     });

//     try {
//       final pelatihan = PelatihanModel(
//         namaPelatihan: _nameController.text,
//         tanggal: DateTime.parse(_startDateController.text),
//         tanggalAkhir: DateTime.parse(_endDateController.text),
//         levelId: _selectedLevelId!,
//         vendorId: _selectedVendorId!,
//         bidangId: _selectedBidangId!,
//         mkId: _selectedMataKuliahId!,
//         periode: _periodeController.text, pelatihanId: null, kuota: null, lokasi: '',
//       );

//       await _controller.addPelatihan(pelatihan);

//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Pelatihan berhasil ditambahkan!')),
//       );

//       Navigator.pop(context);
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Terjadi kesalahan: $e')),
//       );
//     } finally {
//       setState(() {
//         isLoading = false;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
//           child: isLoading
//               ? Center(child: CircularProgressIndicator())
//               : Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     // Back button and title remain the same
//                     Expanded(
//                       child: SingleChildScrollView(
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             _buildTextField('Nama Pelatihan', _nameController),
//                             _buildDropdownField(
//                               'Level', 
//                               _selectedLevelId, 
//                               _levels.map((level) => {'id': level['id'], 'name': level['name']}).toList()
//                             ),
//                             _buildDateField('Tanggal Mulai', _startDateController),
//                             _buildDropdownField(
//                               'Vendor', 
//                               _selectedVendorId, 
//                               _vendors.map((vendor) => {'id': vendor['id'], 'name': vendor['name']}).toList()
//                             ),
//                             _buildDateField('Tanggal Akhir', _endDateController),
//                             _buildDropdownField(
//                               'Bidang', 
//                               _selectedBidangId, 
//                               _bidangs.map((bidang) => {'id': bidang['id'], 'name': bidang['name']}).toList()
//                             ),
//                             _buildDropdownField(
//                               'Mata Kuliah', 
//                               _selectedMataKuliahId, 
//                               _matkuls.map((mk) => {'id': mk['id'], 'name': mk['name']}).toList()
//                             ),
//                             _buildTextField('Periode', _periodeController),
//                             const SizedBox(height: 30),
//                             Center(
//                               child: ElevatedButton(
//                                 style: ElevatedButton.styleFrom(
//                                   backgroundColor: const Color(0xFFEFB509),
//                                   shape: RoundedRectangleBorder(
//                                     borderRadius: BorderRadius.circular(20),
//                                   ),
//                                   minimumSize: const Size(120, 40),
//                                 ),
//                                 onPressed: _submitForm,
//                                 child: Text(
//                                   'KIRIM',
//                                   style: GoogleFonts.poppins(
//                                     color: Colors.black,
//                                     fontSize: 16,
//                                     fontWeight: FontWeight.w600,
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//         ),
//       ),
//       backgroundColor: const Color(0xFF0D47A1),
//     );
//   }

//   Widget _buildTextField(String label, TextEditingController controller) {
//     // Existing implementation remains the same
//     // ...
//   }

//   Widget _buildDropdownField(String label, int? selectedValue, List<Map<String, dynamic>> items) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           label,
//           style: GoogleFonts.montserrat(
//             color: Colors.white,
//             fontSize: 16,
//           ),
//         ),
//         const SizedBox(height: 8),
//         Container(
//           height: 50,
//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(10),
//           ),
//           child: DropdownButtonFormField<int>(
//             value: selectedValue,
//             onChanged: (newValue) {
//               setState(() {
//                 if (label == 'Level') _selectedLevelId = newValue;
//                 else if (label == 'Vendor') _selectedVendorId = newValue;
//                 else if (label == 'Bidang') _selectedBidangId = newValue;
//                 else if (label == 'Mata Kuliah') _selectedMataKuliahId = newValue;
//               });
//             },
//             items: items.map<DropdownMenuItem<int>>((Map<String, dynamic> value) {
//               return DropdownMenuItem<int>(
//                 value: value['id'],
//                 child: Text(value['name']),
//               );
//             }).toList(),
//             decoration: const InputDecoration(
//               contentPadding: EdgeInsets.symmetric(horizontal: 20),
//               border: InputBorder.none,
//             ),
//           ),
//         ),
//         const SizedBox(height: 16),
//       ],
//     );
//   }

//   Widget _buildDateField(String label, TextEditingController controller) {
//     // Existing implementation remains the same
//     // ...
//   }
// }