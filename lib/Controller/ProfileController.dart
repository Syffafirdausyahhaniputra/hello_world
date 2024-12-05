import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import '../config.dart';

class ProfileController {
  /// Mengambil profil dosen berdasarkan user ID yang sedang login.
  static Future<Map<String, dynamic>> fetchProfile(String token) async {
    final url = Uri.parse(Config.Profile);

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
            'message': data['message'] ?? 'Data User tidak ditemukan.',
          };
        }
      } else {
        return {
          'success': false,
          'message':
              'Gagal mengambil data. Kode status: ${response.statusCode}',
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'Terjadi kesalahan: $e',
      };
    }
  }

  // /// Memperbarui profil dosen.
  // Future<Map<String, dynamic>> updateProfile({
  //   required String token,
  //   required String username,
  //   required String nama,
  //   required String nip,
  //   String? oldPassword,
  //   String? password,
  //   File? avatar,
  // }) async {
  //   final url = Uri.parse(Config.dosenProfile);

  //   try {
  //     final request = http.MultipartRequest('POST', url)
  //       ..headers['Authorization'] = 'Bearer $token'
  //       ..fields['username'] = username
  //       ..fields['nama'] = nama
  //       ..fields['nip'] = nip;

  //     if (oldPassword != null) request.fields['old_password'] = oldPassword;
  //     if (password != null) request.fields['password'] = password;
  //     if (avatar != null) {
  //       final avatarStream = http.ByteStream(avatar.openRead());
  //       final avatarLength = await avatar.length();
  //       final multipartFile = http.MultipartFile(
  //         'avatar',
  //         avatarStream,
  //         avatarLength,
  //         filename: avatar.path.split('/').last,
  //       );
  //       request.files.add(multipartFile);
  //     }

  //     final response = await request.send();

  //     if (response.statusCode == 200) {
  //       final responseData = jsonDecode(await response.stream.bytesToString());
  //       return {
  //         'success': responseData['success'],
  //         'message': responseData['message'],
  //         'data': responseData['data'],
  //       };
  //     } else {
  //       return {
  //         'success': false,
  //         'message':
  //             'Gagal memperbarui profil. Kode status: ${response.statusCode}',
  //       };
  //     }
  //   } catch (e) {
  //     return {
  //       'success': false,
  //       'message': 'Terjadi kesalahan: $e',
  //     };
  //   }
  // }

  // 
  
  Future<Map<String, dynamic>> updateProfile({
    required String token,
    required String username,
    required String nama,
    required String nip,
    required String oldPassword,
    required String password,
    File? avatar,
  }) async {
    try {
      final request = http.MultipartRequest(
        'POST',
        Uri.parse('http://172.16.14.84:8000/api/profileUpdate'), // Ganti dengan endpoint update
      );

      // Header
      request.headers['Authorization'] = 'Bearer $token';

      // Tambahkan data ke dalam request
      request.fields['username'] = username;
      request.fields['nama'] = nama;
      request.fields['nip'] = nip;
      request.fields['old_password'] = oldPassword;
      request.fields['password'] = password;

      // Tambahkan avatar jika ada
      if (avatar != null) {
        request.files.add(
          await http.MultipartFile.fromPath('avatar', avatar.path),
        );
      }

      final response = await request.send();

      if (response.statusCode == 200) {
        final responseBody = await response.stream.bytesToString();
        return jsonDecode(responseBody);
      } else {
        throw Exception('Gagal memperbarui profil');
      }
    } catch (e) {
      throw Exception('Terjadi kesalahan: $e');
    }
  }
}
