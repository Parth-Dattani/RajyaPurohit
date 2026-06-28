import 'package:shared_preferences/shared_preferences.dart';

// ==========================================
// SHARED PREFERENCES HELPER - Optimized
// ==========================================

import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';

class SharedPreferencesHelper {
  static SharedPreferencesHelper? _instance;
  SharedPreferences? _prefs;

  // Singleton pattern
  SharedPreferencesHelper._();

  static SharedPreferencesHelper get instance {
    _instance ??= SharedPreferencesHelper._();
    return _instance!;
  }

  // Initialize SharedPreferences
  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // Ensure prefs is initialized
  SharedPreferences get prefs {
    if (_prefs == null) {
      throw Exception('SharedPreferences not initialized. Call init() first.');
    }
    return _prefs!;
  }

  // ✅ Store String
  Future<bool> storePrefData(String key, String value) async {
    return await prefs.setString(key, value);
  }

  // ✅ Get String
  String? getPrefData(String key) {
    return prefs.getString(key);
  }

  // ✅ Store Bool
  Future<bool> storeBoolPrefData(String key, bool value) async {
    return await prefs.setBool(key, value);
  }

  // ✅ Get Bool
  bool retrievePrefBoolData(String key) {
    return prefs.getBool(key) ?? false;
  }

  // ✅ Store Int
  Future<bool> storeIntPrefData(String key, int value) async {
    return await prefs.setInt(key, value);
  }

  // ✅ Get Int
  int? getIntPrefData(String key) {
    return prefs.getInt(key);
  }

  // ✅ Store Double
  Future<bool> storeDoublePrefData(String key, double value) async {
    return await prefs.setDouble(key, value);
  }

  // ✅ Get Double
  double? getDoublePrefData(String key) {
    return prefs.getDouble(key);
  }

  // ✅ Clear all data
  Future<bool> clearPrefData() async {
    return await prefs.clear();
  }

  // ✅ Clear specific key
  Future<bool> clearPrefDataByKey(String key) async {
    return await prefs.remove(key);
  }

  // ✅ Check if key exists
  bool containsKey(String key) {
    return prefs.containsKey(key);
  }

  // ✅ Get all keys
  Set<String> getAllKeys() {
    return prefs.getKeys();
  }
}

// Global instance
final sharedPreferencesHelper = SharedPreferencesHelper.instance;
