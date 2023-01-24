library storage;

export 'src/storage/cache.dart';
export 'src/storage/persistent_cache.dart';

import 'dart:async';

abstract class Storage {

  /// Clear all memory from storage.
  FutureOr<void> clear();
}