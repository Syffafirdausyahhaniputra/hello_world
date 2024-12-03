import 'package:flutter/material.dart';
import 'package:hello_world/Model/MatkulModel.dart';
import 'package:hello_world/config.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AddPelatihanPage extends StatefulWidget {
  @override
  _AddPelatihanPageState createState() => _AddPelatihanPageState();
}

class _AddPelatihanPageState extends State<AddPelatihanPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _namaPelatihanController =
      TextEditingController();
  final TextEditingController _tanggalController = TextEditingController();
  // final TextEditingController _kuotaController = TextEditingController();
  final TextEditingController _lokasiController = TextEditingController();
  int? _levelId;
  int? _bidangId;
  int? _mkId;
  int? _vendorId;

  bool isLoading = false;

  Future<void> _submitForm() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      isLoading = true;
    });

    final url = Config.inputpelatihan; // Ganti dengan endpoint API Anda
    final body = {
      'nama_pelatihan': _namaPelatihanController.text,
      'tanggal': _tanggalController.text,
      // 'kuota': int.tryParse(_kuotaController.text),
      // 'lokasi': _lokasiController.text,
      'level_id': _levelId,
      'bidang_id': _bidangId,
      'mk_id': _mkId,
      'vendor_id': _vendorId,
    };

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(body),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseData = json.decode(response.body);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Pelatihan berhasil ditambahkan!')),
        );
        Navigator.pop(context);
      } else {
        final errorData = json.decode(response.body);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: ${errorData['message']}')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Terjadi kesalahan: $e')),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  List<dynamic> _levels = [];
  List<dynamic> _bidangs = [];
  List<dynamic> _matkuls = [];
  List<dynamic> _vendors = [];

  bool isLoadingDropdown = true;

// Fungsi untuk memuat data dropdown
  Future<void> _loadDropdownData() async {
    try {
      final levelResponse =
          await http.get(Uri.parse('${Config.baseUrl}/levels'));
      final bidangResponse =
          await http.get(Uri.parse('${Config.baseUrl}/bidangs'));
      final mkResponse =
          await http.get(Uri.parse('${Config.baseUrl}/matkuls'));
      final vendorResponse =
          await http.get(Uri.parse('${Config.baseUrl}/vendors'));

      if (levelResponse.statusCode == 200 && bidangResponse.statusCode == 200) {
        setState(() {
          _levels = json.decode(levelResponse.body);
          _bidangs = json.decode(bidangResponse.body);
          isLoadingDropdown = false;
        });
      } else {
        throw Exception('Failed to load dropdown data');
      }
    } catch (e) {
      print('Error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal memuat data dropdown: $e')),
      );
    }
  }

// Panggil di initState
  @override
  void initState() {
    super.initState();
    _loadDropdownData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tambah Pelatihan'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _namaPelatihanController,
                decoration: InputDecoration(labelText: 'Nama Pelatihan'),
                validator: (value) =>
                    value!.isEmpty ? 'Nama pelatihan wajib diisi' : null,
              ),
              TextFormField(
                controller: _tanggalController,
                decoration: InputDecoration(labelText: 'Tanggal'),
                validator: (value) =>
                    value!.isEmpty ? 'Tanggal wajib diisi' : null,
              ),
              // TextFormField(
              //   controller: _kuotaController,
              //   decoration: InputDecoration(labelText: 'Kuota'),
              //   keyboardType: TextInputType.number,
              //   validator: (value) => value!.isEmpty ? 'Kuota wajib diisi' : null,
              // ),
              // TextFormField(
              //   controller: _lokasiController,
              //   decoration: InputDecoration(labelText: 'Lokasi'),
              //   validator: (value) => value!.isEmpty ? 'Lokasi wajib diisi' : null,
              // ),

              DropdownButtonFormField<int>(
                value: _levelId,
                items: _levels.map<DropdownMenuItem<int>>((dynamic level) {
                  return DropdownMenuItem<int>(
                    value: level['id'],
                    child: Text(level['name']), // Sesuaikan dengan atribut API
                  );
                }).toList(),
                onChanged: (value) => setState(() => _levelId = value),
                decoration: InputDecoration(labelText: 'Level ID'),
                validator: (value) =>
                    value == null ? 'Level ID wajib dipilih' : null,
              ),
              DropdownButtonFormField<int>(
                value: _bidangId,
                items: _bidangs.map<DropdownMenuItem<int>>((dynamic bidang) {
                  return DropdownMenuItem<int>(
                    value: bidang['id'],
                    child: Text(bidang['name']), // Sesuaikan dengan atribut API
                  );
                }).toList(),
                onChanged: (value) => setState(() => _bidangId = value),
                decoration: InputDecoration(labelText: 'Level ID'),
                validator: (value) =>
                    value == null ? 'Bidang ID wajib dipilih' : null,
              ),

              DropdownButtonFormField<int>(
                value: _mkId,
                items: _bidangs.map<DropdownMenuItem<int>>((dynamic mk) {
                  return DropdownMenuItem<int>(
                    value: mk['id'],
                    child: Text(mk['name']), // Sesuaikan dengan atribut API
                  );
                }).toList(),
                onChanged: (value) => setState(() => _mkId = value),
                decoration: InputDecoration(labelText: 'Matkul ID'),
                validator: (value) =>
                    value == null ? 'Mata Kuliah ID wajib dipilih' : null,
              ),

              DropdownButtonFormField<int>(
                value: _vendorId,
                items: _bidangs.map<DropdownMenuItem<int>>((dynamic vendor) {
                  return DropdownMenuItem<int>(
                    value: vendor['id'],
                    child: Text(vendor['name']), // Sesuaikan dengan atribut API
                  );
                }).toList(),
                onChanged: (value) => setState(() => _vendorId = value),
                decoration: InputDecoration(labelText: 'Level ID'),
                validator: (value) =>
                    value == null ? 'Bidang ID wajib dipilih' : null,
              ),
            //   DropdownButtonFormField<int>(
            //     value: _matkulId,
            //     items: [
            //       DropdownMenuItem(value: 1, child: Text('Level 1')),
            //       DropdownMenuItem(value: 2, child: Text('Level 2')),
            //     ],
            //     onChanged: (value) => setState(() => _levelId = value),
            //     decoration: InputDecoration(labelText: 'Level ID'),
            //     validator: (value) =>
            //         value == null ? 'Level ID wajib dipilih' : null,
            //   ),
            //   DropdownButtonFormField<int>(
            //     value: _bidangId,
            //     items: [
            //       DropdownMenuItem(value: 1, child: Text('Bidang 1')),
            //       DropdownMenuItem(value: 2, child: Text('Bidang 2')),
            //     ],
            //     onChanged: (value) => setState(() => _bidangId = value),
            //     decoration: InputDecoration(labelText: 'Bidang ID'),
            //     validator: (value) =>
            //         value == null ? 'Bidang ID wajib dipilih' : null,
            //   ),
            //   DropdownButtonFormField<int>(
            //     value: _mkId,
            //     items: [
            //       DropdownMenuItem(value: 1, child: Text('Mata Kuliah 1')),
            //       DropdownMenuItem(value: 2, child: Text('Mata Kuliah 2')),
            //     ],
            //     onChanged: (value) => setState(() => _mkId = value),
            //     decoration:
            //         InputDecoration(labelText: 'Mata Kuliah ID (Opsional)'),
            //   ),
            //   DropdownButtonFormField<int>(
            //     value: _vendorId,
            //     items: [
            //       DropdownMenuItem(value: 1, child: Text('Vendor 1')),
            //       DropdownMenuItem(value: 2, child: Text('Vendor 2')),
            //     ],
            //     onChanged: (value) => setState(() => _vendorId = value),
            //     decoration: InputDecoration(labelText: 'Vendor ID (Opsional)'),
            //   ),
            //   SizedBox(height: 16),
            //   isLoading
            //       ? Center(child: CircularProgressIndicator())
            //       : ElevatedButton(
            //           onPressed: _submitForm,
            //           child: Text('Simpan'),
            //         ),
            ],
          ),
        ),
      ),
    );
  }
}
