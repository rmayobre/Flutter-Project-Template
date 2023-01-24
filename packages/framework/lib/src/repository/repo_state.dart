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

  const RepoState({
    required this.type,
    required this.data,
    required this.exception,
  });

  final StateType type;

  final T? data;

  final Exception? exception;
}