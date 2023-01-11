import 'storage.dart';

abstract class PersistentCache implements Storage {

  int getInt(String key);
  int setInt(String key, int value);

  double getDouble(String key);
  double setDouble(String key, double value);

  bool getBool(String key);
  bool setBool(String key, bool value);

  String getString(String key);
  String setString(String key, String value);
}
/*
abstract class PersistentData {


}
 */