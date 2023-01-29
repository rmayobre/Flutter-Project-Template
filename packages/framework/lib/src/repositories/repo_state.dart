typedef OnEmptyCallback<R> = R Function();
typedef OnLoadingCallback<R> = R Function();
typedef OnLoadedCallback<R, T> = R Function(T value);
typedef OnErrorCallback<R> = R Function(Exception? exception);

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

/// Indicates the state of a Repository.
class RepoState<T> {

  const RepoState._({
    this.data,
    this.exception,
    required this.type,
  });

  factory RepoState.empty() => RepoState<T>._(type: StateType.empty);
  factory RepoState.loading() => RepoState<T>._(type: StateType.loading);
  factory RepoState.loaded(T value) => RepoState._(type: StateType.loaded, data: value);
  factory RepoState.failed(Exception? error) => RepoState._(type: StateType.failed, exception: error);

  final T? data;
  final Exception? exception;
  final StateType type;

  /// Runs this callback if the state is [StateType.empty].
  void onEmpty(OnEmptyCallback<void> handle) {
    if (type == StateType.empty) {
      handle();
    }
  }

  /// Runs this callback if the state is [StateType.loading].
  void onLoading(OnLoadingCallback<void> handle) {
    if (type == StateType.loading) {
      handle();
    }
  }

  /// Runs this callback if the state is [StateType.loaded].
  void onLoaded(OnLoadedCallback<void, T> handle) {
    if (type == StateType.loaded) {
      var value = data;
      if (value != null) {
        handle(value);
      }
    }
  }

  /// Runs this callback if the state is [StateType.failed].
  void onFailed(OnErrorCallback<void> handle) {
    if (type == StateType.failed) {
      handle(exception);
    }
  }

  /// Reduce the state into a result type of [R].
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
        return onLoaded(data as T);
      case StateType.failed:
        return onError(exception);
    }
  }
}