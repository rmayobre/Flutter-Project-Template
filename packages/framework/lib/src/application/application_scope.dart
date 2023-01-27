import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:framework/analytics.dart';
import 'package:framework/event_emitter.dart';
import 'package:framework/logging.dart';
import 'package:framework/repository.dart';
import 'package:framework/routing.dart';
import 'package:framework/storage.dart';

/// Application level scope. This provides everything the entire application will
/// ever need. This scope does not change until the app is killed and reloaded.
/// This is also the root of the application (comes before [MaterialApp] or even
/// [WidgetsApp]).
@immutable
class ApplicationScope extends InheritedWidget {

  const ApplicationScope({
    super.key,
    required this.analytics,
    required this.cache,
    required this.console,
    required this.emitters,
    required this.futures,
    required this.values,
    required this.persistent,
    required this.routeHandler,
    required this.streams,
    required this.states,
    required super.child,
  });

  static ApplicationScope of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType()!;
  }

  final Analytics analytics;

  final Cache cache;

  final LogConsole console;

  final Map<Type, EventEmitter<dynamic>> emitters;

  final Map<Type, FutureRepository<dynamic>> futures;

  final Map<Type, ListenableRepository<dynamic>> values;

  final PersistentCache persistent;

  final RouteHandler routeHandler;

  final Map<Type, StreamRepository<dynamic>> streams;

  final Map<Type, StatefulRepository<dynamic>> states;

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => false;
}

/// Extensions for Pages
extension AppScopeExtensions on BuildContext {

  ApplicationScope get app => ApplicationScope.of(this);

  /// Route to a page by name.
  void to(String name, {
    Map<String, String> pathParams = const {},
    Map<String, dynamic> queryParams = const {}
  }) {
    page.logger.i('Attempting to route to $name...');
    app.routeHandler.route(this, name, pathParams: pathParams, queryParams: queryParams);
  }

  /// Emit an [event]. If an [EventEmitter] is not available, this statement
  /// returns false; otherwise it will return true.
  bool emit<T>(T event) {
    var emitter = app.emitters[T];
    if (emitter != null && emitter is EventEmitter<T>) {
      emitter.emit(event);
      return true;
    }
    return false;
  }

  Future<T> future<T>() => app.futures[T]!.model as Future<T>;

  ValueListenable<T> value<T>() => app.values[T]!.model as ValueListenable<T>;

  Stream<T> stream<T>() => app.streams[T]!.model as Stream<T>;

  StateListenable<T> state<T>() => app.states[T]!.model as StateListenable<T>;
}