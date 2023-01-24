import 'package:framework/storage.dart';

/// An implementation of the [Cache] interface that utilizes a [Map] for storing
/// data as cached memory.
class ToolboxCache implements Cache {

  final Map<String, Object> _map;

  const ToolboxCache({Map<String, Object>? map}) : _map = map ?? const {};

  @override
  void write<T extends Object>({required String key, required T value}) {
    _map[key] = value;
  }

  @override
  T? read<T extends Object>(String key) {
    var value = _map[key];
    if (value is T) {
      return value;
    }
    return null;
  }

  @override
  T? remove<T extends Object>(String key) {
    var value = _map.remove(key);
    if (value is T) {
      return value;
    }
    return null;
  }

  @override
  void clear() => _map.clear();
}