import 'package:flutter/widgets.dart';
import 'package:framework/authentication.dart';

import 'repository.dart';

typedef OnEmptyCallback<R> = R Function();
typedef OnLoadingCallback<R> = R Function();
typedef OnLoadedCallback<R, T> = R Function(T value);
typedef OnErrorCallback<R> = R Function(Exception? exception);

/// Interface for the State of a [Repository].
abstract class StateListenable<T> implements Listenable {

  /// The current value held by the [Repository].
  T? get value;

  /// The exception thrown while fetching data.
  Exception? get exception;

  /// Marks the type of state the [Repository] is in.
  StateType get type;

  StateListenable<T> onEmpty(OnEmptyCallback<void> handle) {
    if (type == StateType.empty) {
      handle();
    }
    return this;
  }

  StateListenable<T> onLoading(OnLoadingCallback<void> handle) {
    if (type == StateType.loading) {
      handle();
    }
    return this;
  }

  StateListenable<T> onLoaded(OnLoadedCallback<void, T> handle) {
    if (type == StateType.loaded) {
      var val = value;
      if (val != null) {
        handle(val);
      }
    }
    return this;
  }

  StateListenable<T> onFailed(OnErrorCallback<void> handle) {
    if (type == StateType.failed) {
      handle(exception);
    }
    return this;
  }

  R reduce<R>({
    required OnEmptyCallback<R> onEmpty,
    required OnLoadingCallback<R> onLoading,
    required OnLoadedCallback<R, T> onLoaded,
    required OnErrorCallback<R> onError,
  }) {
    switch(type) {
      case StateType.empty:
        return onEmpty();
      case StateType.loading:
        return onLoading();
      case StateType.loaded:
        return onLoaded(value as T);
      case StateType.failed:
        return onError(exception);
    }
  }
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