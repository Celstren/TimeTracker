

import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  static Preferences _instance;
  static SharedPreferences _prefs;

  Preferences._();

  factory Preferences() => _getInstance();

  static Preferences _getInstance() {
    if (_instance == null) {
      _instance = Preferences._();
    }
    return _instance;
  }

  static Future<void> initPrefs() async => _prefs = await SharedPreferences.getInstance();
  static Future<bool> clear() async => await _prefs.clear();
}