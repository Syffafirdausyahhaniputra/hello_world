import 'dart:convert';
import 'package:hello_world/Model/PelatihanModel.dart';
import 'package:http/http.dart' as http;

class PelatihanService {
  static const String _baseUrl = 'https://your-api-domain.com/api';

  // Ambil semua data pelatihan
  Future<List<PelatihanModel>> getPelatihans() async {
    try {
      final response = await http.get(Uri.parse('$_baseUrl/pelatihans'));
      
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        
        if (responseData['status'] == true) {
          List<dynamic> pelatihanData = responseData['data'];
          return pelatihanData
              .map((json) => PelatihanModel.fromJson(json))
              .toList();
        } else {
          throw Exception(responseData['message'] ?? 'Gagal mengambil data');
        }
      } else {
        throw Exception('Gagal terhubung ke server');
      }
    } catch (e) {
      throw Exception('Error: ${e.toString()}');
    }
  }

  // Ambil form data untuk membuat pelatihan
  Future<PelatihanFormData> getPelatihanFormData() async {
    try {
      final response = await http.get(Uri.parse('$_baseUrl/pelatihan/form'));
      
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        
        if (responseData['status'] == true) {
          return PelatihanFormData.fromJson(responseData['data']);
        } else {
          throw Exception(responseData['message'] ?? 'Gagal mengambil data form');
        }
      } else {
        throw Exception('Gagal terhubung ke server');
      }
    } catch (e) {
      throw Exception('Error: ${e.toString()}');
    }
  }

  // Simpan data pelatihan baru
  Future<PelatihanModel> createPelatihan(Map<String, dynamic> pelatihanData) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/pelatihans'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: json.encode(pelatihanData),
      );
      
      if (response.statusCode == 201) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        
        if (responseData['status'] == true) {
          return PelatihanModel.fromJson(responseData['data']);
        } else {
          throw Exception(responseData['message'] ?? 'Gagal membuat pelatihan');
        }
      } else {
        final Map<String, dynamic> errorData = json.decode(response.body);
        throw Exception(errorData['message'] ?? 'Gagal terhubung ke server');
      }
    } catch (e) {
      throw Exception('Error: ${e.toString()}');
    }
  }

  // Ambil detail pelatihan berdasarkan ID
  Future<PelatihanModel> getPelatihanDetail(String id) async {
    try {
      final response = await http.get(Uri.parse('$_baseUrl/pelatihans/$id'));
      
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        
        if (responseData['status'] == true) {
          return PelatihanModel.fromJson(responseData['data']);
        } else {
          throw Exception(responseData['message'] ?? 'Gagal mengambil detail pelatihan');
        }
      } else {
        throw Exception('Gagal terhubung ke server');
      }
    } catch (e) {
      throw Exception('Error: ${e.toString()}');
    }
  }
}



// Model untuk Form Data
class PelatihanFormData {
  final List<dynamic> bidangs;
  final List<dynamic> jenis;
  final List<dynamic> matkuls;
  final List<dynamic> vendors;
  final List<dynamic> levels;
  final List<dynamic> dosens;

  PelatihanFormData({
    required this.bidangs,
    required this.jenis,
    required this.matkuls,
    required this.vendors,
    required this.levels,
    required this.dosens,
  });

  factory PelatihanFormData.fromJson(Map<String, dynamic> json) {
    return PelatihanFormData(
      bidangs: json['bidangs'] ?? [],
      jenis: json['jenis'] ?? [],
      matkuls: json['matkuls'] ?? [],
      vendors: json['vendors'] ?? [],
      levels: json['levels'] ?? [],
      dosens: json['dosens'] ?? [],
    );
  }
}