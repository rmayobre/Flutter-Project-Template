import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../analytics/analytics.dart';
import '../event/event_dispatcher.dart';
import '../logging/log_console.dart';
import '../page/page_scope.dart';
import '../repositories/repository.dart';
import '../repositories/state_listenable.dart';
import '../routing/route_handler.dart';
import '../storage/cache.dart';
import '../storage/persistent_cache.dart';

/// Application level scope. This provides everything the entire application will
/// ever need. This scope does not change until the app is killed and reloaded.
/// This is also the root of the application (comes before [MaterialApp] or even
/// [WidgetsApp]).
@immutable
class ApplicationScope extends InheritedWidget {

  ApplicationScope({
    super.key,
    required this.analytics,
    required this.cache,
    required this.console,
    required this.dispatcher,
    required this.persistent,
    required this.routeHandler,
    required List<Repository<dynamic, dynamic>> repositories,
    required super.child,
  }) {
    for (var repo in repositories) {
      if (repo is FutureRepository<dynamic, dynamic>) { _futures[repo.modelType] = repo; }
      if (repo is StatefulRepository<dynamic, dynamic>) { _states[repo.modelType] = repo; }
      if (repo is StreamRepository<dynamic, dynamic>) { _streams[repo.modelType] = repo; }
      if (repo is ListenableRepository<dynamic, dynamic>) { _values[repo.modelType] = repo; }
    }
  }

  static ApplicationScope of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType()!;
  }

  //
  // Framework tools
  //

  final Analytics analytics;
  final Cache cache;
  final EventDispatcher dispatcher;
  final LogConsole console;
  final PersistentCache persistent;
  final RouteHandler routeHandler;

  //
  // Repositories
  //

  final Map<Type, FutureRepository<dynamic, dynamic>> _futures = {};
  final Map<Type, StatefulRepository<dynamic, dynamic>> _states = {};
  final Map<Type, StreamRepository<dynamic, dynamic>> _streams = {};
  final Map<Type, ListenableRepository<dynamic, dynamic>> _values = {};

  Future closeRepos() async {
    await Future.wait(_futures.values.map((repo) => repo.close()));
    await Future.wait(_states.values.map((repo) => repo.close()));
    await Future.wait(_streams.values.map((repo) => repo.close()));
    await Future.wait(_values.values.map((repo) => repo.close()));
  }

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
  void dispatch(Object event) {
    app.dispatcher.dispatch(event);
  }

  Future<T> future<T>() => app._futures[T]!.model as Future<T>;

  StateListenable<T> state<T>() => app._states[T]!.model as StateListenable<T>;

  Stream<T> stream<T>() => app._streams[T]!.model as Stream<T>;

  ValueListenable<T> value<T>() => app._values[T]!.model as ValueListenable<T>;
}