import 'package:framework/storage.dart';

/// Storage for temporary memory; guaranteed to not survive when the application
/// ends. Some [Cache] is only available as long as the user stays on a page.
abstract class Cache implements Storage {

  /// Write to storage.
  void write<T extends Object>({required String key, required T value});

  /// Read from storage.
  T? read<T extends Object>(String key);

  /// Remove from storage.
  T? remove<T extends Object>(String key);
}