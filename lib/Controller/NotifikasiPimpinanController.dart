import 'dart:convert';
import 'package:http/http.dart' as http;
import '../config.dart'; // Import Config

class NotifikasiPimpinanController {
  // Mendapatkan daftar notifikasi
  Future<List<dynamic>> list({required String token}) async {
    final url =
        Uri.parse(Config.notifikasiPimpinanListEndpoint); // Perbaiki endpoint
    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      }, // Tambahkan header autentikasi
    );
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    if (response.statusCode == 200) {
      try {
        return jsonDecode(response.body);
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
    final url =
        Uri.parse('${Config.baseUrl}/api/notifikasiPimpinan/show/$type/$id');
    final response = await http.get(
      url,
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      try {
        return jsonDecode(response.body);
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
      },
      body: body,
    );
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    if (response.statusCode == 200) {
      try {
        return jsonDecode(response.body);
      } catch (e) {
        throw Exception('Format data tidak valid: ${response.body}');
      }
    } else {
      throw Exception('Gagal memverifikasi notifikasi: ${response.body}');
    }
  }
}
