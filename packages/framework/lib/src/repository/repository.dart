import 'state_listenable.dart';

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