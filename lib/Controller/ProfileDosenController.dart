import 'dart:convert';
import 'dart:io';

import 'package:hello_world/Model/BidangModel.dart';
import 'package:hello_world/Model/MatkulModel.dart';
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

  // Fungsi untuk mengambil data bidang
  static Future<List<BidangModel>> fetchBidang(String token) async {
    try {
      final response = await http.get(
        Uri.parse('https://api.example.com/bidang'), // Ganti dengan endpoint bidang
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final List data = jsonDecode(response.body)['data'];
        return data.map((e) => BidangModel.fromJson(e)).toList();
      } else {
        throw Exception('Gagal mengambil data bidang');
      }
    } catch (e) {
      throw Exception('Terjadi kesalahan: $e');
    }
  }

  // Fungsi untuk mengambil data mata kuliah
  static Future<List<MatkulModel>> fetchMatkul(String token) async {
    try {
      final response = await http.get(
        Uri.parse('https://api.example.com/matkul'), // Ganti dengan endpoint mata kuliah
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final List data = jsonDecode(response.body)['data'];
        return data.map((e) => MatkulModel.fromJson(e)).toList();
      } else {
        throw Exception('Gagal mengambil data mata kuliah');
      }
    } catch (e) {
      throw Exception('Terjadi kesalahan: $e');
    }
  }

  // Fungsi untuk mengirim data profil yang diperbarui
  Future<Map<String, dynamic>> updateDosenProfile({
    required String token,
    required String username,
    required String nama,
    required String nip,
    required int? bidangId,
    required int? mkId,
    required String oldPassword,
    required String password,
    File? avatar,
  }) async {
    try {
      final request = http.MultipartRequest(
        'POST',
        Uri.parse('https://api.example.com/updateProfile'), // Ganti dengan endpoint update
      );

      // Header
      request.headers['Authorization'] = 'Bearer $token';

      // Tambahkan data ke dalam request
      request.fields['username'] = username;
      request.fields['nama'] = nama;
      request.fields['nip'] = nip;
      if (bidangId != null) request.fields['bidang_id'] = bidangId.toString();
      if (mkId != null) request.fields['mk_id'] = mkId.toString();
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
