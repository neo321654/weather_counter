import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

class KeyValueStorage {
  late SharedPreferences _sharedPreferences;

  static const _themeKey = '__theme_key__';

  Future<bool>? setThemeValue(String value) =>
      _sharedPreferences.setString(_themeKey, value);

  Future<String> getThemeValue() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    return _sharedPreferences.getString(_themeKey) ?? 'dark';
  }
}
