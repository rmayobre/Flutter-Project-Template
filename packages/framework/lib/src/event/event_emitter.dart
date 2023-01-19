abstract class EventEmitter<T> {

  final Type eventType = T;

  void emit(T event);
}

// mixin StreamEmitter<T> implements EventEmitter<T> {
//
//   // StreamEmitter() : _controller = StreamController<T>() {
//   //   _controller.stream.listen(onEvent);
//   // }
//
//
//   final StreamController<T> _controller = StreamController<T>();
//
//   late final StreamSubscription<T> _subscription = _controller
//       .stream
//       .asBroadcastStream()
//       .listen(onEvent);
//
//   @override
//   Future emit(T event) async {
//     onValidate(event);
//     _controller.sink.add(event);
//   }
//
//   /// Validate the event and it's data. Throw an [Exception] if data is invalid.
//   @protected
//   void onValidate(T event);
//
//   /// Post validation, if [onValidate] did not throw an [Exception]. Process the
//   /// [event]. Update any repos associated with this object.
//   @protected
//   void onEvent(T event);
//
//   Future closeEvents() => _controller.close();
// }