import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  static final LocalStorage _instance = LocalStorage._internal();

  factory LocalStorage() {
    return _instance;
  }

  LocalStorage._internal();

  static SharedPreferences? _prefs;

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  Future<void> saveSession(String email) async {
    await _prefs?.setString('email', email);
  }

  Future<void> clearSession() async {
    await _prefs?.remove('email');
  }

  Future<String?> loadSession() async {
    return _prefs?.getString('email');
  }
}
