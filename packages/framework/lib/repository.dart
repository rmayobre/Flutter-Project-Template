library repository;

import 'package:flutter/foundation.dart';
import 'package:framework/main.dart';

import 'src/repository/state_listenable.dart';

export 'src/repository/repo_state.dart';
export 'src/repository/state_listenable.dart';
export 'src/repository/state_mutable.dart';

abstract class Repository<T> {

  T get model;

  final Type modelType = T;
}

mixin FutureRepository<T> implements Repository<Future<T>> {

  @override
  final Type modelType = T;
}

mixin ListenableRepository<T> implements Repository<ValueListenable<T>> {

  @override
  final Type modelType = T;
}

mixin StreamRepository<T> implements Repository<Stream<T>> {

  @override
  final Type modelType = T;
}

mixin StatefulRepository<T> implements Repository<StateListenable<T>> {

  @override
  final Type modelType = T;
}