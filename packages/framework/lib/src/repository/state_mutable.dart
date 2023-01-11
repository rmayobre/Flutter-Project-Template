import 'package:flutter/widgets.dart';

import 'state_listenable.dart';

abstract class StateMutable<T> implements StateListenable<T> {

  void empty();

  void loaded(T value);

  void loading();

  void failed(Exception? exception);
}

class StateNotifier<T> extends ChangeNotifier implements StateMutable<T> {

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