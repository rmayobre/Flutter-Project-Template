import 'package:flutter/material.dart';
import 'package:framework/routing.dart';
import 'package:framework/src/analytics/analytics.dart';
import 'package:framework/src/authentication/authenticator.dart';
import 'package:framework/src/logger/log_console.dart';
import 'package:framework/src/storage/persistent_cache.dart';

/// Application level scope. This provides everything the entire application will
/// ever need. This scope does not change until the app is killed and reloaded.
/// This is also the root of the application (comes before [MaterialApp] or even
/// [WidgetsApp]).
@immutable
class ApplicationScope extends InheritedWidget {

  const ApplicationScope({
    super.key,
    required this.analytics,
    required this.authenticator,
    required this.cache,
    required this.console,
    required this.persistent,
    required this.routeHandler,
    required super.child,
  });

  static ApplicationScope of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType()!;
  }

  final Analytics analytics;

  final Authenticator authenticator;

  final Cache cache;

  final LogConsole console;

  final PersistentCache persistent;

  final RouteHandler routeHandler;

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => false;

}

extension ApplicationExtension on BuildContext {

  ApplicationScope get app => ApplicationScope.of(this);
}

extension RoutingExtension on BuildContext {

  void to(String name, {
    Map<String, String> pathParams = const {},
    Map<String, dynamic> queryParams = const {}
  }) {
    app.routeHandler.route(this, name, pathParams: pathParams, queryParams: queryParams);
  }
}