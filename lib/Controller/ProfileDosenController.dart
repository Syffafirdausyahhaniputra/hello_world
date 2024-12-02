import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import '../config.dart';

class ProfileDosenController {
  /// Mengambil profil dosen berdasarkan user ID yang sedang login.
  static Future<Map<String, dynamic>> fetchDosenProfile(String token) async {
  final url = Uri.parse(Config.dosenProfile);

  try {
    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      },
    ).timeout(const Duration(seconds: 10));

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      if (data['success']) {
        // Kembalikan semua data dari respons JSON
        return {
          'success': true,
          'data': data['data'],
        };
      } else {
        return {
          'success': false,
          'message': data['message'] ?? 'Data dosen tidak ditemukan.',
        };
      }
    } else {
      return {
        'success': false,
        'message': 'Gagal mengambil data. Kode status: ${response.statusCode}',
      };
    }
  } catch (e) {
    return {
      'success': false,
      'message': 'Terjadi kesalahan: $e',
    };
  }
}

  /// Memperbarui profil dosen.
  Future<Map<String, dynamic>> updateDosenProfile({
    required String token,
    required String username,
    required String nama,
    required String nip,
    int? bidangId,
    int? mkId,
    String? oldPassword,
    String? password,
    File? avatar,
  }) async {
    final url = Uri.parse(Config.dosenProfile);

    try {
      final request = http.MultipartRequest('POST', url)
        ..headers['Authorization'] = 'Bearer $token'
        ..fields['username'] = username
        ..fields['nama'] = nama
        ..fields['nip'] = nip;

      if (bidangId != null) request.fields['bidang_id'] = bidangId.toString();
      if (mkId != null) request.fields['mk_id'] = mkId.toString();
      if (oldPassword != null) request.fields['old_password'] = oldPassword;
      if (password != null) request.fields['password'] = password;
      if (avatar != null) {
        final avatarStream = http.ByteStream(avatar.openRead());
        final avatarLength = await avatar.length();
        final multipartFile = http.MultipartFile(
          'avatar',
          avatarStream,
          avatarLength,
          filename: avatar.path.split('/').last,
        );
        request.files.add(multipartFile);
      }

      final response = await request.send();

      if (response.statusCode == 200) {
        final responseData = jsonDecode(await response.stream.bytesToString());
        return {
          'success': responseData['success'],
          'message': responseData['message'],
          'data': responseData['data'],
        };
      } else {
        return {
          'success': false,
          'message': 'Gagal memperbarui profil. Kode status: ${response.statusCode}',
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'Terjadi kesalahan: $e',
      };
    }
  }
}
