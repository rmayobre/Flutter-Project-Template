import 'state_listenable.dart';

abstract class Repository {

  /// Used to help clean up or close pending connections to a [Repository]
  /// before the application shuts down.
  Future close();
}

abstract class FutureRepository<T> implements Repository {

  Future<T> get data;
}

abstract class StreamRepository<T> implements Repository {

  Stream<T> get stream;
}

abstract class StatefulRepository<T> implements Repository {

  StateListenable<T> get state;
}