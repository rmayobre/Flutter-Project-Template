import 'dart:async';

import 'package:framework/dispatcher.dart';

class ToolboxEventDispatcher implements EventDispatcher {
  final _eventController = StreamController<Object>.broadcast();
  final _subscriptions = <Type, StreamSubscription<Object>>{};

  @override
  void subscribe<T>(EventHandler<T> onEvent) {
    if (_subscriptions.containsKey(T)) {
      throw StateError("EventDispatcher does allow multiple subscriptions to an Event type - $T");
    }
    _subscriptions[T] = _eventController.stream
        .where((event) => event is T)
        .listen((event) => onEvent(event as T));
  }

  @override
  void dispatch(Object event) {
    _eventController.add(event);
  }

  @override
  Future<void> close() async {
    await _eventController.close();
    await Future.wait(_subscriptions.values.map((sub) => sub.cancel()));
  }
}