import 'dart:convert';
import 'package:http/http.dart' as http;
import '../config.dart'; // Import Config

class NotifikasiPimpinanController {
  // Mendapatkan daftar notifikasi
  Future<List<dynamic>> list({required String token}) async {
    final url = Uri.parse('${Config.baseUrl}/api/notifikasiPimpinan/list');
    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      try {
        final Map<String, dynamic> json = jsonDecode(response.body);
        if (json['success'] == true) {
          return json['data']; // Mengembalikan daftar notifikasi
        } else {
          throw Exception(json['message'] ?? 'Gagal memuat data notifikasi.');
        }
      } catch (e) {
        throw Exception('Format data tidak valid: ${response.body}');
      }
    } else {
      throw Exception('Gagal mendapatkan data notifikasi: ${response.body}');
    }
  }

  // Mendapatkan detail notifikasi berdasarkan tipe dan ID
  Future<Map<String, dynamic>> show({
    required String type,
    required int id,
    required String token,
  }) async {
    final endpoint = type.toLowerCase() == 'sertifikasi'
        ? 'show/sertifikasi/$id'
        : 'show/pelatihan/$id';
    final url = Uri.parse('${Config.baseUrl}/api/notifikasiPimpinan/$endpoint');
    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      },
    );

    print('Type: $type');
    print('ID: $id');
    print('Token: $token');

    print('Response Code: ${response.statusCode}');
    print('Response Body: ${response.body}');

    if (response.statusCode == 200) {
      try {
        final Map<String, dynamic> json = jsonDecode(response.body);
        if (json['success'] == true) {
          return json['data']; // Mengembalikan detail notifikasi
        } else {
          throw Exception(json['message'] ?? 'Gagal memuat detail notifikasi.');
        }
      } catch (e) {
        throw Exception('Format data tidak valid: ${response.body}');
      }
    } else {
      throw Exception('Gagal mendapatkan detail notifikasi: ${response.body}');
    }
  }

  // Verifikasi notifikasi
  Future<Map<String, dynamic>> verify({
    required String type,
    required int id,
    required String status,
    required String token,
  }) async {
    final url =
        Uri.parse('${Config.baseUrl}/api/notifikasiPimpinan/verify/$type/$id');
    final body = jsonEncode({'status': status});

    final response = await http.put(
      url,
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      body: body,
    );

    if (response.statusCode == 200) {
      try {
        final Map<String, dynamic> json = jsonDecode(response.body);
        return json; // Mengembalikan respons verifikasi
      } catch (e) {
        throw Exception('Format data tidak valid: ${response.body}');
      }
    } else {
      throw Exception('Gagal memverifikasi notifikasi: ${response.body}');
    }
  }
}
