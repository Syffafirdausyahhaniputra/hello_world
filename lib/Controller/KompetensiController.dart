import 'dart:convert';
import 'package:hello_world/Model/BidangModel.dart';
import 'package:http/http.dart' as http;
import 'package:hello_world/Model/KompetensiModel.dart';
// import 'package:hello_world/Model/BidangModel.dart';

class KompetensiController {
  final String baseUrl = "http://172.16.14.84:8000";

  Future<List<KompetensiProdi>> fetchKompetensiList() async {
    final response = await http.post(Uri.parse("$baseUrl/api/kompetensi/list"));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body)['data'];
      return data.map((item) => KompetensiProdi.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load Kompetensi Prodi');
    }
  }

  Future<List<BidangModel>> fetchBidangList(String prodiId) async {
    final response = await http.get(Uri.parse("http://172.16.14.84:8000/api/kompetensi/{prodi_kode}/show_ajax"));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body)['bidangList'];
      return data.map((item) => BidangModel.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load Bidang List');
    }
  }
}

