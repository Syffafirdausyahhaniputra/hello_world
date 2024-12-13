import 'package:shared_preferences/shared_preferences.dart';

class SessionManager {
  static Future<void> saveLoginSession(String username) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('loggedInUser', username);
  }

  static Future<void> saveRole(int role) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('userRole', role);
  }

  static Future<String?> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  static Future<void> saveUserData(
      int id, String username, String token, int roleId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('id', id);
    await prefs.setString('username', username);
    await prefs.setString('token', token);
    await prefs.setInt('role_id', roleId);
  }

  static Future<Map<String, String?>> getUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? username = prefs.getString('username');
    String? token = prefs.getString('token');
    int? roleId = prefs.getInt('role_id');
    int? id = prefs.getInt('id');

    return {
      'username': username,
      'token': token,
      'id': id.toString(),
      'level': roleId.toString(),
    };
  }

  static Future<void> clearSession() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
