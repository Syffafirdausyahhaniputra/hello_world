import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart'; // Tambahkan import
import '../config.dart';
import '../Model/UserModel.dart';
import '../Model/DataSertifikasiModel.dart';
import '../Model/DataPelatihanModel.dart';

class DashboardController {
  static Future<Map<String, dynamic>> getDashboardData(String token) async {
    final url = Uri.parse(Config.dashboardEndpoint);

    final headers = {
      'Authorization': 'Bearer $token',
      'Accept': 'application/json',
    };

    try {
      final response = await http.get(url, headers: headers);

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        // Pastikan data user memiliki key 'nama'
        final user = data['data']['user'] ?? {};
        final userName = user['nama'] ?? 'Pengguna';

        // Parsing data sertifikasi dan pelatihan
        final sertifikasi = (data['data']['sertifikasi'] as List)
            .map((e) => DataSertifikasiModel.fromJson(e))
            .toList();

        final pelatihan = (data['data']['pelatihan'] as List)
            .map((e) => DataPelatihanModel.fromJson(e))
            .toList();

        // Parsing jumlah sertifikasi dan pelatihan
        final jumlahSertifikasi = data['data']['jumlahSertifikasi'] ?? 0;
        final jumlahPelatihan = data['data']['jumlahPelatihan'] ?? 0;
        final jumlahSertifikasiPelatihan =
            data['data']['jumlahSertifikasiPelatihan'] ?? 0;

        // Kembalikan data ke dashboard.dart
        return {
          'user': {'nama': userName}, // Hanya mengembalikan nama pengguna
          'jumlahSertifikasi': jumlahSertifikasi,
          'jumlahPelatihan': jumlahPelatihan,
          'jumlahSertifikasiPelatihan': jumlahSertifikasiPelatihan,
          'sertifikasi': sertifikasi,
          'pelatihan': pelatihan,
        };
      } else {
        print('Error loading data: ${response.statusCode} - ${response.body}');
        throw Exception('Failed to load dashboard data');
      }
    } catch (e) {
      print('Error loading dashboard data: $e');
      throw Exception('Failed to load dashboard data');
    }
  }
}
