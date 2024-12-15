// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:hello_world/Model/pelatihanModel.dart';
// import 'package:hello_world/config.dart';
// import 'package:hello_world/sessionManager.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

// import '../Controller/pelatihanController.dart';

// class InputDataPelatihanPage extends StatefulWidget {
//   const InputDataPelatihanPage({super.key});

//   @override
//   InputDataPelatihanPageState createState() => InputDataPelatihanPageState();
// }

// class InputDataPelatihanPageState extends State<InputDataPelatihanPage> {
//     final String baseUrl = Config.baseUrl;

//   final PelatihanController _controller = PelatihanController();
//   final _formKey = GlobalKey<FormState>();

//   final TextEditingController _nameController = TextEditingController();
//   final TextEditingController _periodeController = TextEditingController();
//   final TextEditingController _startDateController = TextEditingController();
//   final TextEditingController _endDateController = TextEditingController();

//   final TextEditingController _namaPelatihanController =
//       TextEditingController();
//   final TextEditingController _biayaController = TextEditingController();
//   final TextEditingController _tanggalController = TextEditingController();
//   final TextEditingController _tanggalAkhirController = TextEditingController();
//   final TextEditingController _kuotaController = TextEditingController();
//   final TextEditingController _lokasiController = TextEditingController();

//   int? selectedLevelId;
//   int? selectedVendorId;
//   int? selectedBidangId;
//   int? selectedMataKuliahId;

//   List<dynamic> levels = [];
//   List<dynamic> vendors = [];
//   List<dynamic> bidangs = [];
//   List<dynamic> matkuls = [];

//   bool isLoading = false;

//   @override
//   void dispose() {
//     _loadDropdownData();
//     _nameController.dispose();
//     _periodeController.dispose();
//     _startDateController.dispose();
//     _endDateController.dispose();
//     super.dispose();
//   }

//   Future<Map<String, dynamic>> fetchDropdownOptions() async {
//     final response = await http
//         .get(Uri.parse('$baseUrl/api/pelatihan/dropdown'));
//     if (response.statusCode == 200) {
//       return jsonDecode(response.body);
//     } else {
//       throw Exception('Gagal memuat data dropdown');
//     }
//   }

//   Future<void> _loadDropdownData() async {
//     setState(() {
//       isLoading = true;
//     });

//     try {
//       final response = await http
//           .get(Uri.parse('$baseUrl/api/pelatihan/dropdown'));
//       if (response.statusCode == 200) {
//         final data = jsonDecode(response.body);
//         if (mounted) {
//           setState(() {
//             levels = data['levels'] ?? [];
//             vendors = data['vendors'] ?? [];
//             bidangs = data['bidangs'] ?? [];
//           });
//         }
//       } else {
//         throw Exception('Failed to load data');
//       }
//     } catch (e) {
//       if (mounted) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Error loading dropdown data: $e')),
//         );
//       }
//     } finally {
//       if (mounted) {
//         setState(() {
//           isLoading = false;
//         });
//       }
//     }
//   }

//   Future<void> _submitForm() async {
//     Map<String, String?> userData = await SessionManager.getUserData();
//     String token = userData['token'] ?? "";
//     if (!_formKey.currentState!.validate()) return;

//     final Map<String, dynamic> requestData = {
//       "level_id": selectedLevelId,
//       "bidang_id": selectedBidangId,
//       "mk_id": selectedMataKuliahId,
//       "vendor_id": selectedVendorId,
//       "nama_pelatihan": _namaPelatihanController.text,
//       "biaya": _biayaController.text,
//       "tanggal": _tanggalController.text,
//       "tanggal_akhir": _tanggalAkhirController.text,
//       "kuota": _kuotaController.text,
//       "lokasi": _lokasiController.text,
//       "periode": _periodeController.text,
//       "status": "Aktif",
//       "keterangan": null,
//       "surat_tugas": null,
//     };

//     try {
//       final response = await http.post(
//         Uri.parse('$baseUrl/api/pelatihan/store'),
//         headers: {
//           'Content-Type': 'application/json',
//           'Accept': 'application/json',
//           'Authorization': 'Bearer $token',
//         },
//         body: jsonEncode(requestData),
//       );

//       if (response.statusCode == 201) {
//         final responseData = jsonDecode(response.body);
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Data berhasil ditambahkan!')),
//         );
//       } else {
//         final errorData = jsonDecode(response.body);
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Error: ${errorData['message']}')),
//         );
//       }
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Error: $e')),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: const Color(0xFF0D47A1),
//         title: Text(
//           'Input Data Pelatihan',
//           style: GoogleFonts.poppins(
//             color: Colors.white,
//             fontSize: 20,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//       ),
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
//           child: isLoading
//               ? const Center(child: CircularProgressIndicator())
//               : SingleChildScrollView(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       _buildTextField('Nama Pelatihan', _nameController),
//                       _buildTextField('Biaya', _biayaController),
//                       _buildTextField('kuota', _kuotaController),
//                       _buildTextField('lokasi', _lokasiController),
//                       _buildDateField('Tanggal Mulai', _startDateController),
//                       _buildDateField('Tanggal Akhir', _endDateController),
//                       _buildTextField('Periode', _periodeController),
//                       _buildDropdownField(
//                           'Level',
//                           selectedLevelId,
//                           levels,
//                           'level_id',
//                           'level_nama',
//                           (value) => setState(() => selectedLevelId = value)),
//                       _buildDropdownField(
//                           'Vendor',
//                           selectedVendorId,
//                           vendors,
//                           'vendor_id',
//                           'vendor_nama',
//                           (value) => setState(() => selectedVendorId = value)),
//                       _buildDropdownField(
//                           'Bidang',
//                           selectedBidangId,
//                           bidangs,
//                           'bidang_id',
//                           'bidang_nama',
//                           (value) => setState(() => selectedBidangId = value)),
//                       _buildDropdownField(
//                           'matkuls',
//                           selectedMataKuliahId,
//                           matkuls,
//                           'mk_id',
//                           'mk_nama',
//                           (value) =>
//                               setState(() => selectedMataKuliahId = value)),
//                       const SizedBox(height: 30),
//                       Center(
//                         child: ElevatedButton(
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: const Color(0xFFEFB509),
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(20),
//                             ),
//                             minimumSize: const Size(120, 40),
//                           ),
//                           onPressed: _submitForm,
//                           child: Text(
//                             'KIRIM',
//                             style: GoogleFonts.poppins(
//                               color: Colors.black,
//                               fontSize: 16,
//                               fontWeight: FontWeight.w600,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//         ),
//       ),
//     );
//   }

//   Widget _buildTextField(String label, TextEditingController controller) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           label,
//           style: GoogleFonts.montserrat(
//             color: Colors.black,
//             fontSize: 16,
//           ),
//         ),
//         const SizedBox(height: 8),
//         TextField(
//           controller: controller,
//           decoration: InputDecoration(
//             filled: true,
//             fillColor: Colors.white,
//             hintText: 'Masukkan $label',
//             border: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(10),
//               borderSide: BorderSide.none,
//             ),
//           ),
//         ),
//         const SizedBox(height: 16),
//       ],
//     );
//   }

//   Widget _buildDropdownField(
//     String label,
//     int? selectedValue,
//     List<dynamic> items,
//     String valueKey,
//     String displayKey,
//     ValueChanged<int?> onChanged,
//   ) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           label,
//           style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w500),
//         ),
//         SizedBox(height: 8),
//         DropdownButtonFormField<int>(
//           value: selectedValue,
//           onChanged: onChanged,
//           items: items.map<DropdownMenuItem<int>>((item) {
//             return DropdownMenuItem<int>(
//               value: item[valueKey],
//               child: Text(item[displayKey]),
//             );
//           }).toList(),
//           decoration: InputDecoration(
//             contentPadding: EdgeInsets.symmetric(horizontal: 16),
//             border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
//           ),
//         ),
//         SizedBox(height: 16),
//       ],
//     );
//   }

//   Widget _buildDateField(String label, TextEditingController controller) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           label,
//           style: GoogleFonts.montserrat(
//             color: Colors.black,
//             fontSize: 16,
//           ),
//         ),
//         const SizedBox(height: 8),
//         GestureDetector(
//           onTap: () async {
//             DateTime? pickedDate = await showDatePicker(
//               context: context,
//               initialDate: DateTime.now(),
//               firstDate: DateTime(2000),
//               lastDate: DateTime(2101),
//             );

//             if (pickedDate != null) {
//               setState(() {
//                 controller.text = pickedDate.toIso8601String().split('T')[0];
//               });
//             }
//           },
//           child: AbsorbPointer(
//             child: TextField(
//               controller: controller,
//               decoration: InputDecoration(
//                 filled: true,
//                 fillColor: Colors.white,
//                 hintText: 'Pilih tanggal',
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(10),
//                   borderSide: BorderSide.none,
//                 ),
//               ),
//             ),
//           ),
//         ),
//         const SizedBox(height: 16),
//       ],
//     );
//   }
// }