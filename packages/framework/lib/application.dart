library application;

import 'package:flutter/material.dart';
import 'package:framework/page.dart';
import 'package:framework/service.dart';
import 'package:framework/src/analytics/analytics.dart';
import 'package:framework/src/logger/log_console.dart';
import 'package:framework/src/storage/cache.dart';
import 'package:framework/src/storage/persistent_cache.dart';

export 'package:framework/src/analytics/analytics.dart';
export 'package:framework/src/application/application_scope.dart';
export 'package:framework/src/logger/log_console.dart';
export 'package:framework/src/page/page_delegate.dart';
export 'package:framework/src/routing/route_handler.dart';
export 'package:framework/src/repository/repo_state.dart';
export 'package:framework/src/storage/cache.dart';
export 'package:framework/src/storage/persistent_cache.dart';


class Application extends StatefulWidget {

  const Application({
    super.key,
    this.cache = const Cache(),
    this.title = '',
    required this.analytics,
    required this.console,
    required this.persistent,
    required this.routeHandler,
    required this.services,
    required this.theme,
  });

  factory Application.test({
    String title = '',
    Cache cache = const Cache(),
    required LogConsole console,
    required RouteHandler routeHandler,
    required List<Service<dynamic, dynamic>> services,
    required ThemeData theme,
  }) {

    return Application(
      analytics: Analytics.offline(),
      cache: cache,
      console: console,
      persistent: PersistentCache.noStorage(),
      routeHandler: routeHandler,
      theme: theme,
      services: services,
    );
  }

  final String title;

  final Analytics analytics;

  final Cache cache;

  final LogConsole console;

  final PersistentCache persistent;

  final RouteHandler routeHandler;

  final List<Service<dynamic, dynamic>> services;

  final ThemeData theme;

  @override
  State<StatefulWidget> createState() => _ApplicationState();
}

class _ApplicationState extends State<Application> {

  @override
  void dispose() async {
    for (var service in widget.services) {
      await service.close();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Map<Type, EventEmitter<dynamic>> emitters = {};
    Map<Type, FutureRepository<dynamic>> futures = {};
    Map<Type, StreamRepository<dynamic>> streams = {};
    Map<Type, StatefulRepository<dynamic>> states = {};
    for (var service in widget.services) {
      Repository<dynamic> repo = service;
      if (repo is FutureRepository<dynamic>) { futures[repo.modelType] = repo; }
      if (repo is StreamRepository<dynamic>) { streams[repo.modelType] = repo; }
      if (repo is StatefulRepository<dynamic>) { states[repo.modelType] = repo; }
      emitters[service.eventType] = service;
    }

    return ApplicationScope(
      analytics: widget.analytics,
      cache: widget.cache,
      console: widget.console,
      emitters: emitters,
      futures: futures,
      persistent: widget.persistent,
      routeHandler: widget.routeHandler,
      streams: streams,
      states: states,
      child: MaterialApp.router(
        title: widget.title,
        theme: widget.theme,
        routerConfig: widget.routeHandler.config,
      ),
    );
  }
}