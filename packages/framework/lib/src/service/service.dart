import '../repository/repository.dart';
import '../repository/state_listenable.dart';
import '../event/event_emitter.dart';

abstract class Service<E, M> with EventEmitter<E>, Repository<M> {

  /// Used to help clean up or close pending connections to the Service
  /// before the application shuts down.
  Future close();

}

abstract class FutureService<E, M> with FutureRepository<M> implements Service<E, Future<M>> {

  @override
  final Type eventType = E;
}

abstract class StreamService<E, M> with StreamRepository<M> implements Service<E, Stream<M>> {

  @override
  final Type eventType = E;
}

abstract class StatefulService<E, M> with StatefulRepository<M> implements Service<E, StateListenable<M>> {

  @override
  final Type eventType = E;
}

