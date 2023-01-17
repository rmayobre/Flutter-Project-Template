import 'package:flutter/widgets.dart';

import 'state_listenable.dart';

abstract class StateMutable<T> extends StateListenable<T> {

  /// Set state to [StateType.empty] and removed stored value.
  void empty();

  /// Set state to [StateType.loaded] and set a value.
  void loaded(T value);

  /// Set state to [StateType.loading]. [value] may be set to null.
  void loading();

  /// Set state to [StateType.error]. Failed state might have been caused by an exception.
  void failed(Exception? exception);
}

/// Standard implementation of a [StateListenable] with the mixin of a [ChangeNotifier].
class StateNotifier<T> extends StateMutable<T> with ChangeNotifier {

  StateNotifier({
    T? value,
    Exception? exception,
    required StateType initialState,
  }) : _value = value,
        _exception = exception,
        _type = initialState;

  T? _value;

  Exception? _exception;

  StateType _type;

  @override
  T? get value => _value;

  @override
  Exception? get exception => _exception;

  @override
  StateType get type => _type;

  @override
  void empty() => _update(type: StateType.empty);

  @override
  void loaded(T value) => _update(
    value: value,
    type: StateType.loaded,
  );

  @override
  void loading() => _update(type: StateType.loading);

  @override
  void failed(Exception? exception) => _update(
    exception: exception,
    type: StateType.failed,
  );

  void _update({T? value, Exception? exception, required StateType type}) {
    _value = value;
    _exception = exception;
    _type = type;
    notifyListeners();
  }
}