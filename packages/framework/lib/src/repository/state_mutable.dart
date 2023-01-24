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
class StateNotifier<T> extends StateMutable<T> with ChangeNotifier {

  StateNotifier._(this.value);
  
  StateNotifier({
    T? data,
    Exception? exception,
    required StateType initialState,
  }) : this._(RepoState(type: initialState, data: data, exception: exception));

  @override
  RepoState<T> value;

  @override
  void empty() => _update(type: StateType.empty);

  @override
  void loaded(T data) => _update(
    data: data,
    type: StateType.loaded,
  );

  @override
  void loading() => _update(type: StateType.loading);

  @override
  void failed(Exception? exception) => _update(
    exception: exception,
    type: StateType.failed,
  );

  void _update({T? data, Exception? exception, required StateType type}) {
    value = RepoState(type: type, data: data, exception: exception);
    notifyListeners();
  }
}