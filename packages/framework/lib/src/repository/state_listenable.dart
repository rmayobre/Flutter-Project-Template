import 'package:flutter/widgets.dart';

import 'repository.dart';

/// Interface for the State of a [Repository].
abstract class StateListenable<T> implements Listenable {

  /// The current value held by the [Repository].
  T? get value;

  /// The exception thrown while fetching data.
  Exception? get exception;

  /// Marks the type of state the [Repository] is in.
  StateType get type;
}

enum StateType {
  /// The [Repository] has no data. This can also act as the initial state.
  empty,

  /// The [Repository] is loading it's data.
  loading,

  /// The [Repository] is done loading, and data may be available.
  loaded,

  /// The [Repository] failed to collect data. This typically results in an [Exception].
  failed;
}

// extension <T> on StateListenable<T> {
//
//   StateListenable<T> onEmpty(void Function() handle) {
//     if (type == StateType.empty) {
//       handle;
//     }
//     return this;
//   }
//
//   StateListenable<T> onLoading(void Function() handle) {
//     if (type == StateType.loading) {
//       handle;
//     }
//     return this;
//   }
//
//   StateListenable<T> onLoaded(void Function(T value) handle) {
//     if (type == StateType.loaded) {
//       var val = value;
//       if (val != null) {
//         handle(val);
//       }
//     }
//     return this;
//   }
//
//   StateListenable<T> onFailed(void Function(Exception? exception) handle) {
//     if (type == StateType.failed) {
//       handle(exception);
//     }
//     return this;
//   }
// }