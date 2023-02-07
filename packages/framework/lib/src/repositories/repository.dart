import 'package:flutter/foundation.dart';

import '../../dispatcher.dart';
import 'state_listenable.dart';

abstract class Repository<E, M> {
  
  Repository(this.dispatcher) {
    dispatcher.subscribe<E>(onEvent);
  }

  M get model;

  Type get modelType;

  /// Services have access to the application's EventDispatcher.
  /// This allows services to communicate between each other.
  @protected
  final EventDispatcher dispatcher;

  /// Called when an event has been dispatched to this service.
  @protected
  void onEvent(E event);
}

abstract class FutureRepository<E, M> extends Repository<E, Future<M>> {
  FutureRepository(super.dispatcher);

  @override
  Type get modelType => M;

  /// Used to help clean up or close pending connections to the Service
  /// before the application shuts down.
  Future<void> close();
}

abstract class ListenableRepository<E, M> extends Repository<E, ValueListenable<M>> {
  ListenableRepository(super.dispatcher);

  @override
  Type get modelType => M;

  /// Used to help clean up or close pending connections to the Service
  /// before the application shuts down.
  Future<void> close();
}

abstract class StreamRepository<E, M> extends Repository<E, Stream<M>> {
  StreamRepository(super.dispatcher);
  
  @override
  Type get modelType => M;

  /// Used to help clean up or close pending connections to the Service
  /// before the application shuts down.
  Future<void> close();
}

abstract class StatefulRepository<E, M> extends Repository<E, StateListenable<M>> {
  StatefulRepository(super.dispatcher);

  @override
  Type get modelType => M;

  /// Used to help clean up or close pending connections to the Service
  /// before the application shuts down.
  Future<void> close();
}