import 'dart:convert';
import 'package:hello_world/Model/BidangModel.dart';
import 'package:hello_world/config.dart';
import 'package:http/http.dart' as http;
import 'package:hello_world/Model/KompetensiModel.dart';

class KompetensiController {

  Future<List<KompetensiProdi>> fetchKompetensiList() async {
    final response = await http.post(Uri.parse(Config.kompetensiList));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body)['data'];
      return data.map((item) => KompetensiProdi.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load Kompetensi Prodi');
    }
  }

  Future<List<BidangModel>> fetchBidangList(int prodiId) async {
    try {
      final String endpoint =
          '${Config.baseUrl}/api/kompetensi/$prodiId/show_ajax';

      final response = await http.get(Uri.parse(endpoint));

      if (response.statusCode == 200) {
        final rawData = json.decode(response.body);
        print("Raw Data: $rawData");

        final List<dynamic> data = rawData['bidangList'] ?? [];
        print("Bidang List: $data");

        return data.map((item) => BidangModel.fromJson(item)).toList();
      } else {
        print("Server Error: ${response.statusCode} ${response.reasonPhrase}");
        throw Exception('Failed to load Bidang List');
      }
    } catch (e) {
      print("Fetch Bidang List Error: $e");
      throw e;
    }
  }
}
