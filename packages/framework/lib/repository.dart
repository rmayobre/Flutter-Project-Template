library repository;

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

mixin StreamRepository<T> implements Repository<Stream<T>> {

  @override
  final Type modelType = T;
}

mixin StatefulRepository<T> implements Repository<StateListenable<T>> {

  @override
  final Type modelType = T;
}