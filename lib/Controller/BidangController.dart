import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:hello_world/Model/BidangModel.dart';

class BidangController with ChangeNotifier {
  final Dio _dio = Dio(); // Menggunakan Dio untuk HTTP request
  final String baseUrl = 'http://172.16.14.84:8000'; // Ganti dengan URL API Anda

  List<BidangModel> _bidangList = [];
  bool _isLoading = false;

  List<BidangModel> get bidangList => _bidangList;
  bool get isLoading => _isLoading;

  // Fungsi untuk mengambil data bidang (GET /list)
  Future<void> fetchBidang() async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await _dio.get('$baseUrl/bidang/list');
      if (response.statusCode == 200) {
        _bidangList = (response.data as List)
            .map((item) => BidangModel.fromJson(item))
            .toList();
      }
    } catch (e) {
      debugPrint('Error fetching bidang: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Fungsi untuk menambah bidang (POST /store_ajax)
  Future<bool> addBidang(Map<String, dynamic> bidangData) async {
    try {
      final response = await _dio.post('$baseUrl/bidang/store_ajax', data: bidangData);
      if (response.statusCode == 200 && response.data['status'] == true) {
        await fetchBidang(); // Refresh data
        return true;
      }
    } catch (e) {
      debugPrint('Error adding bidang: $e');
    }
    return false;
  }

  // Fungsi untuk memperbarui bidang (PUT /update_ajax/{id})
  Future<bool> updateBidang(String id, Map<String, dynamic> bidangData) async {
    try {
      final response = await _dio.put('$baseUrl/bidang/update_ajax/$id', data: bidangData);
      if (response.statusCode == 200 && response.data['status'] == true) {
        await fetchBidang(); // Refresh data
        return true;
      }
    } catch (e) {
      debugPrint('Error updating bidang: $e');
    }
    return false;
  }

  // Fungsi untuk menghapus bidang (DELETE /delete_ajax/{id})
  Future<bool> deleteBidang(String id) async {
    try {
      final response = await _dio.delete('$baseUrl/bidang/delete_ajax/$id');
      if (response.statusCode == 200 && response.data['status'] == true) {
        await fetchBidang(); // Refresh data
        return true;
      }
    } catch (e) {
      debugPrint('Error deleting bidang: $e');
    }
    return false;
  }
}
