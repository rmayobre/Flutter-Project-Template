library application;

import 'package:flutter/material.dart';
import 'package:framework/src/analytics/analytics.dart';
import 'package:framework/src/application/application_scope.dart';
import 'package:framework/src/authentication/authentication_repository.dart';
import 'package:framework/src/logger/log_console.dart';
import 'package:framework/src/page/page_delegate.dart';
import 'package:framework/src/routing/route_handler.dart';
import 'package:framework/src/storage/cache.dart';
import 'package:framework/src/storage/persistent_cache.dart';

export 'package:framework/src/analytics/analytics.dart';
export 'package:framework/src/application/application_scope.dart';
export 'package:framework/src/authentication/authentication_repository.dart';
export 'package:framework/src/logger/log_console.dart';
export 'package:framework/src/page/page_delegate.dart';
export 'package:framework/src/routing/route_handler.dart';
export 'package:framework/src/storage/cache.dart';
export 'package:framework/src/storage/persistent_cache.dart';

class Application extends StatelessWidget {

  Application({
    super.key,
    this.title = '',
    required this.analytics,
    required this.authRepo,
    required this.cache,
    required this.reporter,
    required this.pages,
    required this.persistent,
    required this.routeHandler,
    required this.theme,
  }) {
    authRepo.stream.listen((session) { analytics.setUserId(session?.id); });
  }

  final Analytics analytics;

  final AuthenticationRepository authRepo;

  final Cache cache;

  final LogConsole reporter;

  final List<PageDelegate> pages;

  final PersistentCache persistent;

  final RouteHandler routeHandler;

  final String title;

  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return ApplicationScope(
        authRepo: authRepo,
        analytics: analytics,
        cache: cache,
        console: reporter,
        persistent: persistent,
        routeHandler: routeHandler,
        child: MaterialApp.router(
          title: title,
          theme: theme,
          routerConfig: routeHandler.config,
        )
    );
  }
}