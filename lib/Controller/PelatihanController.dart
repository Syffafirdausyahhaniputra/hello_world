import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:hello_world/config.dart';
import 'package:hello_world/Model/pelatihanModel.dart';

class PelatihanController {
  // URL dasar backend
  final String baseUrl = Config.baseUrl;

  // Mengambil data dropdown dari API
  Future<Map<String, dynamic>> fetchDropdownOptions() async {
    final response = await http.get(Uri.parse('http://192.168.69.112:8000/api/pelatihan/dropdown'));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Gagal memuat data dropdown');
    }
  }

  // Menambahkan pelatihan baru
  Future<void> addPelatihan(PelatihanModel pelatihan) async {
    final response = await http.post(
      Uri.parse('http://192.168.69.112:8000/api/pelatihan/create'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(pelatihan.toJson()),
    );

    if (response.statusCode != 200) {
      throw Exception('Gagal menambahkan pelatihan');
    }
  }
}
