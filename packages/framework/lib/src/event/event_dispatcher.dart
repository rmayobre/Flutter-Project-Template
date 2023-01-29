import 'dart:async';

typedef EventHandler<T> = void Function(T event);

abstract class EventDispatcher {

  void subscribe<T>(EventHandler<T> onEvent);

  void dispatch(Object event);

  Future<void> close();
}

// class EventDispatcher {
//   final _eventController = StreamController<Object>.broadcast();
//   final _subscriptions = <Type, StreamSubscription<Object>>{};
//
//   void subscribe<T>(EventHandler<T> onEvent) {
//     if (_subscriptions.containsKey(T)) {
//       throw StateError("EventDispatcher does allow multiple subscriptions to an Event type - $T");
//     }
//     _subscriptions[T] = _eventController.stream
//         .where((event) => event is T)
//         .listen((event) => onEvent(event as T));
//   }
//
//   void dispatch(Object event) {
//     _eventController.add(event);
//   }
//
//   Future<void> close() async {
//     await _eventController.close();
//     await Future.wait(_subscriptions.values.map((sub) => sub.cancel()));
//   }
// }