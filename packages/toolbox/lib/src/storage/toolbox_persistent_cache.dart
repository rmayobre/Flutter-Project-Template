import 'dart:async';

import 'package:framework/storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ToolboxPersistentCache implements PersistentCache {

  const ToolboxPersistentCache._(this.preferences);

  /// Parse device's persistent storage and build a cache.
  static Future<PersistentCache> build() async {
    var cache = await SharedPreferences.getInstance();
    return ToolboxPersistentCache._(cache);
  }

  final SharedPreferences preferences;

  @override
  bool? getBool(String key) => preferences.getBool(key);

  @override
  void setBool(String key, bool value) {
    preferences.setBool(key, value);
  }

  @override
  double? getDouble(String key) => preferences.getDouble(key);

  @override
  void setDouble(String key, double value) {
    preferences.setDouble(key, value);
  }

  @override
  int? getInt(String key) => preferences.getInt(key);

  @override
  void setInt(String key, int value) {
    preferences.setInt(key, value);
  }

  @override
  String? getString(String key) => preferences.getString(key);

  @override
  void setString(String key, String value) {
    preferences.setString(key, value);
  }

  @override
  void remove(String key) {
    preferences.remove(key);
  }

  @override
  FutureOr<void> clear() async {
    await preferences.clear();
  }
}