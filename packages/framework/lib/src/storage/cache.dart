import 'storage.dart';

/// A wrapper for a [Map] object that will map objects based on type.
abstract class Cache implements Storage {

  factory Cache({Map<String, Object>? map}) => _Cache(map ?? const {});

  /// Write to storage.
  void write<T extends Object>({required String key, required T value});

  /// Read from storage.
  T? read<T extends Object>({required String key});

  /// Remove from storage.
  T? remove<T extends Object>({required String key});

}

/// Standard implementation of [Cache].
class _Cache implements Cache {

  /// Mapping of cached objects.
  final Map<String, Object> _map;

  /// Construct an empty Cache.
  const _Cache(this._map);

  @override
  void write<T extends Object>({required String key, required T value}) {
    _map[key] = value;
  }

  @override
  T? read<T extends Object>({required String key}) {
    var value = _map[key];
    if (value is T) {
      return value;
    }
    return null;
  }

  @override
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