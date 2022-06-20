// ignore_for_file: unused_field

import 'package:shared_preferences/shared_preferences.dart';

class UserSimplePreferences {
  static late SharedPreferences _preferences;
  static const _keyUserEmail = 'userEmail';
  static Future init() async =>
      _preferences = await SharedPreferences.getInstance();
  static Future setUserEmail(String userEmail) async =>
      await _preferences.setString(_keyUserEmail, userEmail);
  static String? getUserEmail() => _preferences.getString(_keyUserEmail);
}
