import 'package:shared_preferences/shared_preferences.dart';

class Sharedpref {
  static const String USER_TOKEN = "USER_TOKEN";

  static Future<void> saveToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(USER_TOKEN, token);
  }

  static Future<String> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(USER_TOKEN) ?? '';
  }
}
