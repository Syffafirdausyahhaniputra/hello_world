import 'dart:convert';
import 'package:http/http.dart' as http;
import '../config.dart';
import '../core/sharedPref.dart';
import '../Model/DataSertifikasiModel.dart';
import '../Model/DataPelatihanModel.dart';

class ListAllDataController {
  ListAllDataController() {
    print("ListAllDataController");
  }

  // Fungsi untuk mendapatkan data dari server
  static Future<Map<String, dynamic>> getListAllData() async {
    final url = Uri.parse(Config.listAllDataEndpoint);

    var token = await Sharedpref.getToken();

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

        final sertifikasi = (data['data']['sertifikasi'] as List)
            .map((e) => DataSertifikasiModel.fromJson(e))
            .toList();

        final pelatihan = (data['data']['pelatihan'] as List)
            .map((e) => DataPelatihanModel.fromJson(e))
            .toList();

        // Kembalikan data ke dashboard.dart
        return {
          'sertifikasi': sertifikasi,
          'pelatihan': pelatihan,
        };
      } else {
        print('Error loading data: ${response.statusCode} - ${response.body}');
        throw Exception('Failed to load data');
      }
    } catch (e) {
      print('Error loading data: $e');
      throw Exception('Failed to load data');
    }
  }
}
