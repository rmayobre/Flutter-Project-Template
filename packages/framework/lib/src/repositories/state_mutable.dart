import 'package:flutter/widgets.dart';

import 'repo_state.dart';
import 'state_listenable.dart';

abstract class StateMutable<T> extends StateListenable<T> {

  /// Set state to [StateType.empty] and removed stored value.
  void empty();

  /// Set state to [StateType.loaded] and set a value.
  void loaded(T data);

  /// Set state to [StateType.loading]. [value] may be set to null.
  void loading();

  /// Set state to [StateType.error]. Failed state might have been caused by an exception.
  void failed(Exception? exception);
}

/// Standard implementation of a [StateListenable] with the mixin of a [ChangeNotifier].
class StateNotifier<T> with ChangeNotifier implements StateMutable<T> {

  StateNotifier._(this.value);

  factory StateNotifier.empty() => StateNotifier._(RepoState.empty());
  factory StateNotifier.loading() => StateNotifier._(RepoState.loading());
  factory StateNotifier.loaded(T value) => StateNotifier._(RepoState.loaded(value));
  factory StateNotifier.failed(Exception? error) => StateNotifier._(RepoState.failed(error));

  @override
  RepoState<T> value;

  @override
  void empty() => _update(RepoState.empty());

  @override
  void loaded(T data) => _update(RepoState.loaded(data));

  @override
  void loading() => _update(RepoState.loading());

  @override
  void failed(Exception? exception) => _update(RepoState.failed(exception));

  void _update(RepoState<T> state) {
    value = state;
    notifyListeners();
  }
}