import 'dart:convert';
import 'package:http/http.dart' as http;

class LoginController {
  final String baseUrl;

  LoginController(this.baseUrl);

  // Fungsi untuk melakukan login
  Future<Map<String, dynamic>> login(String username, String password) async {
    final url = Uri.parse('$baseUrl/api/login');
    try {
      // Mengirim request POST
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'username': username,
          'password': password,
        }),
      );

      // Memproses respons
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return {
          'success': true,
          'data': data,
        };
      } else {
        final error = jsonDecode(response.body);
        return {
          'success': false,
          'message': error['message'] ?? 'Login failed',
        };
      }
    } catch (e) {
      // Menangani error
      return {
        'success': false,
        'message': 'An error occurred: $e',
      };
    }
  }
}
