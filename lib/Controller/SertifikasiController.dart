import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:hello_world/config.dart';
import 'package:hello_world/Model/sertifikasiModel.dart';

class SertifikasiController {

  final String baseUrl = Config.baseUrl;
  // Mengambil data dropdown dari API
  Future<Map<String, dynamic>> fetchDropdownOptions() async {
    final response = await http.get(Uri.parse('$baseUrl/api/sertifikasi/dropdown'));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Gagal memuat data dropdown sertifikasi');
    }
  }

  // Menambahkan sertifikasi baru
  Future<void> addSertifikasi(SertifikasiModel sertifikasi) async {
    final response = await http.post(
      Uri.parse('$baseUrl/api/sertifikasi/store'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(sertifikasi.toJson()),
    );

    if (response.statusCode != 200) {
      throw Exception('Gagal menambahkan pelatihan');
    }
  }
}