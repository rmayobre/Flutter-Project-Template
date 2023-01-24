import 'package:framework/storage.dart';

/// A wrapper for a [Map] object that will map objects based on type.
class Cache implements Storage {

  /// Mapping of cached objects.
  final Map<String, Object> _map;

  /// Construct an empty Cache.
  const Cache({Map<String, Object>? map}) : _map = map ?? const {};

  /// Write to storage.
  void write<T extends Object>({required String key, required T value}) {
    _map[key] = value;
  }

  /// Read from storage.
  T? read<T extends Object>({required String key}) {
    var value = _map[key];
    if (value is T) {
      return value;
    }
    return null;
  }

  /// Remove from storage.
  T? remove<T extends Object>({required String key}) {
    var value = _map[key];
    if (value is T) {
      _map.remove(key);
      return value;
    }
    return null;
  }

  @override
  void clear() => _map.clear();
}