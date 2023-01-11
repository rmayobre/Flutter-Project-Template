import 'state_listenable.dart';

abstract class Repository {

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