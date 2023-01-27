import 'package:flutter/material.dart';
import 'package:framework/analytics.dart';
import 'package:framework/logging.dart';
import 'package:framework/routing.dart';
import 'package:framework/service.dart';
import 'package:framework/storage.dart';

class Application extends StatefulWidget {

  const Application({
    super.key,
    this.darkTheme,
    this.title = '',
    this.themeMode = ThemeMode.system,
    required this.analytics,
    required this.cache,
    required this.console,
    required this.persistent,
    required this.routeHandler,
    required this.services,
    required this.theme,
  });

  factory Application.test({
    ThemeData? darkTheme,
    String title = '',
    ThemeMode themeMode = ThemeMode.system,
    required Cache cache,
    required LogConsole console,
    required RouteHandler routeHandler,
    required List<Service<dynamic, dynamic>> services,
    required ThemeData theme,
  }) {

    return Application(
      analytics: Analytics.offline(),
      cache: cache,
      console: console,
      darkTheme: darkTheme,
      persistent: PersistentCache.noStorage(),
      routeHandler: routeHandler,
      theme: theme,
      themeMode: themeMode,
      title: title,
      services: services,
    );
  }

  final Analytics analytics;

  final Cache cache;

  final LogConsole console;

  final ThemeData? darkTheme;

  final PersistentCache persistent;

  final RouteHandler routeHandler;

  final List<Service<dynamic, dynamic>> services;

  final ThemeData theme;

  final ThemeMode themeMode;

  final String title;

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
    Map<Type, ListenableRepository<dynamic>> values = {};
    Map<Type, StreamRepository<dynamic>> streams = {};
    Map<Type, StatefulRepository<dynamic>> states = {};
    for (var service in widget.services) {
      Repository<dynamic> repo = service;
      if (repo is FutureRepository<dynamic>) { futures[repo.modelType] = repo; }
      if (repo is ListenableRepository<dynamic>) { values[repo.modelType] = repo; }
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
      values: values,
      persistent: widget.persistent,
      routeHandler: widget.routeHandler,
      streams: streams,
      states: states,
      child: MaterialApp.router(
        themeMode: widget.themeMode,
        title: widget.title,
        theme: widget.theme,
        darkTheme: widget.darkTheme,
        routerConfig: widget.routeHandler.config,
      ),
    );
  }
}