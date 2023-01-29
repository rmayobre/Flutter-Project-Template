import 'package:flutter/foundation.dart';
import 'package:framework/src/event/event_dispatcher.dart';

import '../repositories/repository.dart';
import '../repositories/state_listenable.dart';

abstract class Service<E, M> implements Repository<M> {

  Service(this.dispatcher) {
    dispatcher.subscribe<E>(onEvent);
  }

  /// Services have access to the application's EventDispatcher.
  /// This allows services to communicate between each other.
  final EventDispatcher dispatcher;

  /// Called when an event has been dispatched to this service.
  void onEvent(E event);

  /// Used to help clean up or close pending connections to the Service
  /// before the application shuts down.
  Future<void> close();
}

abstract class FutureService<E, M> extends Service<E, Future<M>>
    with FutureRepository<M> {
  FutureService(super.dispatcher);
}

abstract class ListenableService<E, M> extends Service<E, ValueListenable<M>>
    with ListenableRepository<M> {
  ListenableService(super.dispatcher);
}


abstract class StreamService<E, M> extends Service<E, Stream<M>>
    with StreamRepository<M> {
  StreamService(super.dispatcher);
}

abstract class StatefulService<E, M> extends Service<E, StateListenable<M>>
    with StatefulRepository<M> {
  StatefulService(super.dispatcher);
}