library application;

import 'package:flutter/material.dart';
import 'package:framework/authentication.dart';
import 'package:framework/page.dart';
import 'package:framework/src/analytics/analytics.dart';
import 'package:framework/src/authentication/authentication_repository.dart';
import 'package:framework/src/authentication/authenticator.dart';
import 'package:framework/src/logger/log_console.dart';
import 'package:framework/src/routing/route_handler.dart';
import 'package:framework/src/storage/cache.dart';
import 'package:framework/src/storage/persistent_cache.dart';

export 'package:framework/src/analytics/analytics.dart';
export 'package:framework/src/application/application_scope.dart';
export 'package:framework/src/authentication/authenticator.dart';
export 'package:framework/src/authentication/authentication_repository.dart';
export 'package:framework/src/logger/log_console.dart';
export 'package:framework/src/page/page_delegate.dart';
export 'package:framework/src/repository/registry.dart';
export 'package:framework/src/routing/route_handler.dart';
export 'package:framework/src/storage/cache.dart';
export 'package:framework/src/storage/persistent_cache.dart';

class Application extends StatelessWidget {

  Application({
    super.key,
    this.title = '',
    required this.analytics,
    required this.cache,
    required this.console,
    required this.pages,
    required this.persistent,
    required this.registry,
    required this.routeHandler,
    required this.theme,
    required AuthenticationRepository authRepo,
  }) : authenticator = authRepo {
    authRepo.stream.listen((session) => analytics.setUserId(session?.id));
  }

  final Analytics analytics;

  final Authenticator authenticator;

  final Cache cache;

  final LogConsole console;

  final List<PageDelegate> pages;

  final PersistentCache persistent;
  
  final RepoRegistry registry;
  
  final RouteHandler routeHandler;

  final String title;

  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return ApplicationScope(
        authenticator: authenticator,
        analytics: analytics,
        cache: cache,
        console: console,
        persistent: persistent,
        registry: registry,
        routeHandler: routeHandler,
        child: MaterialApp.router(
          title: title,
          theme: theme,
          routerConfig: routeHandler.config,
        )
    );
  }
}