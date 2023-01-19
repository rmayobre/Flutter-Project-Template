import 'dart:async';

abstract class Storage {

  /// Clear all memory from storage.
  FutureOr<void> clear();
}