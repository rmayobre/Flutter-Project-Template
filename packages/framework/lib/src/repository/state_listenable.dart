import 'package:flutter/foundation.dart';
import 'package:framework/src/repository/repo_state.dart';

typedef OnEmptyCallback<R> = R Function();
typedef OnLoadingCallback<R> = R Function();
typedef OnLoadedCallback<R, T> = R Function(T value);
typedef OnErrorCallback<R> = R Function(Exception? exception);

/// Interface for the State of a [Repository].
abstract class StateListenable<T> implements ValueListenable<RepoState<T>> {

  /// Runs this callback if the state is [StateType.empty].
  void onEmpty(OnEmptyCallback<void> handle) {
    if (value.type == StateType.empty) {
      handle();
    }
  }

  /// Runs this callback if the state is [StateType.loading].
  void onLoading(OnLoadingCallback<void> handle) {
    if (value.type == StateType.loading) {
      handle();
    }
  }

  /// Runs this callback if the state is [StateType.loaded].
  void onLoaded(OnLoadedCallback<void, T> handle) {
    if (value.type == StateType.loaded) {
      var data = value.data;
      if (data != null) {
        handle(data);
      }
    }
  }

  /// Runs this callback if the state is [StateType.failed].
  void onFailed(OnErrorCallback<void> handle) {
    if (value.type == StateType.failed) {
      handle(value.exception);
    }
  }

  /// Reduce the state into a result type of [R].
  R reduce<R>({
    required OnEmptyCallback<R> onEmpty,
    required OnLoadingCallback<R> onLoading,
    required OnLoadedCallback<R, T> onLoaded,
    required OnErrorCallback<R> onError,
  }) {
    switch(value.type) {
      case StateType.empty:
        return onEmpty();
      case StateType.loading:
        return onLoading();
      case StateType.loaded:
        return onLoaded(value.data as T);
      case StateType.failed:
        return onError(value.exception);
    }
  }
}