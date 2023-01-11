import 'package:framework/storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ToolboxPersistentCache implements PersistentCache {

  late SharedPreferences preferences;

  @override
  void clear() {
    // TODO: implement clear
  }

  @override
  bool getBool(String key) {
    // TODO: implement getBool
    throw UnimplementedError();
  }

  @override
  double getDouble(String key) {
    // TODO: implement getDouble
    throw UnimplementedError();
  }

  @override
  int getInt(String key) {
    // TODO: implement getInt
    throw UnimplementedError();
  }

  @override
  String getString(String key) {
    // TODO: implement getString
    throw UnimplementedError();
  }

  @override
  bool setBool(String key, bool value) {
    // TODO: implement setBool
    throw UnimplementedError();
  }

  @override
  double setDouble(String key, double value) {
    // TODO: implement setDouble
    throw UnimplementedError();
  }

  @override
  int setInt(String key, int value) {
    // TODO: implement setInt
    throw UnimplementedError();
  }

  @override
  String setString(String key, String value) {
    // TODO: implement setString
    throw UnimplementedError();
  }

}