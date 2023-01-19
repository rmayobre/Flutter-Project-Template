import 'package:flutter/material.dart';
import 'package:framework/repository.dart';

import '../analytics/analytics.dart';
import '../event/event_emitter.dart';
import '../logger/log_console.dart';
import '../page/page_scope.dart';
import '../repository/repository.dart';
import '../routing/route_handler.dart';
import '../storage/cache.dart';
import '../storage/persistent_cache.dart';

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

  final PersistentCache persistent;

  final RouteHandler routeHandler;

  final Map<Type, StreamRepository<dynamic>> streams;

  final Map<Type, StatefulRepository<dynamic>> states;

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => false;
}

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


  Future<T>? future<T>() => app.futures[T]?.model as Future<T>;

  Stream<T>? stream<T>() => app.streams[T]?.model as Stream<T>;

  StateListenable<T>? state<T>() => app.states[T]?.model as StateListenable<T>;

}