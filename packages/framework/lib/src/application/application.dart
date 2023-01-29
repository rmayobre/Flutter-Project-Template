import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'application_scope.dart';

class Application extends StatefulWidget {

  const Application({
    super.key,
    required this.title,
    this.darkTheme,
    required this.theme,
    required this.themeModeListenable,
    this.onDispose,
  });

  final String title;

  final ThemeData? darkTheme;
  final ThemeData theme;
  final ValueListenable<ThemeMode> themeModeListenable;

  final VoidCallback? onDispose;

  @override
  State<StatefulWidget> createState() => _AppState();
}

class _AppState extends State<Application> {

  @override
  void dispose() {
    widget.onDispose?.call();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: context.value<ThemeMode>(),
      builder: (context, value, child) {
        return MaterialApp.router(
          themeMode: value,
          title: widget.title,
          theme: widget.theme,
          darkTheme: widget.darkTheme,
          routerConfig: context.app.routeHandler.config,
        );
      },
    );
  }
}
/*
class Application extends StatefulWidget {

  Application({
    super.key,
    this.darkTheme,
    this.title = '',
    required this.analytics,
    required this.cache,
    required this.console,
    required this.persistent,
    required this.routeHandler,
    required this.services,
    required this.theme,
    required this.themeModeListenable,
  });

  factory Application.test({
    ThemeData? darkTheme,
    String title = '',
    required ValueListenable<ThemeMode> themeModeListenable,
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
      themeModeListenable: themeModeListenable,
      title: title,
      services: services,
    );
  }

  //
  // Application Themes
  //

  final String title;
  final ThemeData? darkTheme;
  final ThemeData theme;
  final ValueListenable<ThemeMode> themeModeListenable;

  //
  // Framework tools
  //

  final actor = EventActor();
  final Analytics analytics;
  final Cache cache;
  final LogConsole console;
  final PersistentCache persistent;
  final RouteHandler routeHandler;
  final List<Service<dynamic, dynamic>> services;

  @override
  State<StatefulWidget> createState() => _ApplicationState();
}

class _ApplicationState extends State<Application> {

  //
  // Repositories
  //

  final Map<Type, FutureRepository<dynamic>> futures = {};
  final Map<Type, StatefulRepository<dynamic>> states = {};
  final Map<Type, StreamRepository<dynamic>> streams = {};
  final Map<Type, ListenableRepository<dynamic>> values = {};

  @override
  void initState() {
    super.initState();
    for (var service in widget.services) {
      widget.actor.register(service);
      Repository<dynamic> repo = service;
      if (repo is FutureRepository<dynamic>) { futures[repo.modelType] = repo; }
      if (repo is StatefulRepository<dynamic>) { states[repo.modelType] = repo; }
      if (repo is StreamRepository<dynamic>) { streams[repo.modelType] = repo; }
      if (repo is ListenableRepository<dynamic>) { values[repo.modelType] = repo; }
    }
  }

  @override
  void dispose() async {
    super.dispose();
    // Shut down events.
    await widget.actor.close();
    // Shut down services.
    await Future.wait(widget.services.map((service) => service.close()));
  }

  @override
  Widget build(BuildContext context) {
    return ApplicationScope(
      actor: widget.actor,
      analytics: widget.analytics,
      cache: widget.cache,
      console: widget.console,
      futures: futures,
      values: values,
      persistent: widget.persistent,
      routeHandler: widget.routeHandler,
      streams: streams,
      states: states,
      child: ValueListenableBuilder(
        valueListenable: widget.themeModeListenable,
        builder: (context, value, child) {
          return MaterialApp.router(
            themeMode: value,
            title: widget.title,
            theme: widget.theme,
            darkTheme: widget.darkTheme,
            routerConfig: widget.routeHandler.config,
          );
        },
      ),
    );
  }
}
*/