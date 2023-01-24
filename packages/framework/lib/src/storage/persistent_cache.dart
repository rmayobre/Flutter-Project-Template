import 'dart:async';

import 'package:framework/storage.dart';

abstract class PersistentCache implements Storage {

  factory PersistentCache.noStorage() => _NoStorage();

  void remove(String key);

  int? getInt(String key);

  void setInt(String key, int value);

  double? getDouble(String key);

  void setDouble(String key, double value);

  bool? getBool(String key);

  void setBool(String key, bool value);

  String? getString(String key);

  void setString(String key, String value);
}

class _NoStorage implements PersistentCache {

  @override
  FutureOr<void> clear() {}

  @override
  bool? getBool(String key) => null;

  @override
  double? getDouble(String key) => null;

  @override
  int? getInt(String key) => null;

  @override
  String? getString(String key) => null;

  @override
  void remove(String key) {}

  @override
  void setBool(String key, bool value) {}

  @override
  void setDouble(String key, double value) {}

  @override
  void setInt(String key, int value) {}

  @override
  void setString(String key, String value) {}
}
/*
abstract class PersistentData {


}
 */