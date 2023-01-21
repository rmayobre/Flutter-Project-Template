import 'dart:async';

import '../repository/repository.dart';
import '../repository/state_listenable.dart';
import '../event/event_emitter.dart';

abstract class Service<E, M> implements EventEmitter<E>, Repository<M> {

  /// Used to help clean up or close pending connections to the Service
  /// before the application shuts down.
  Future close();

}

abstract class FutureService<E, M> extends Service<E, Future<M>> with FutureRepository<M> {

  @override
  final Type eventType = E;
}

abstract class StreamService<E, M> extends Service<E, Stream<M>> with StreamRepository<M> {

  @override
  final Type eventType = E;
}

abstract class StatefulService<E, M> extends Service<E, StateListenable<M>> with StatefulRepository<M> {

  @override
  final Type eventType = E;
}

