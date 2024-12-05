import 'package:flutter/material.dart';
import 'package:hello_world/config.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:hello_world/core/sharedPref.dart';
import 'package:hello_world/Model/DataPelatihanModel.dart';

class Detailpelatihan {
  Future<Map<String, dynamic>> getDetailPelatihan(int id) async {
    final token = await Sharedpref.getToken();

    final url =
        Uri.parse('${Config.detailPelatihanEndpoint}/${id.toString()}');

    print(url);

    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };

    try {
      final response = await http.get(url, headers: headers);

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        return data;
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
