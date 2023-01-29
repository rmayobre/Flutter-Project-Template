import 'package:flutter/foundation.dart';

import 'state_listenable.dart';

abstract class Repository<T> {

  T get model;

  Type get modelType => T;
}

abstract class FutureRepository<T> implements Repository<Future<T>> {

  @override
  Type get modelType => T;
}

abstract class ListenableRepository<T> implements Repository<ValueListenable<T>> {

  @override
  Type get modelType => T;
}

abstract class StreamRepository<T> implements Repository<Stream<T>> {

  @override
  Type get modelType => T;
}

abstract class StatefulRepository<T> implements Repository<StateListenable<T>> {

  @override
  Type get modelType => T;
}