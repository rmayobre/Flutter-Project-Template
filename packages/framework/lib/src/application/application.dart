import 'package:flutter/material.dart';
import 'package:framework/main.dart';

import 'application_scope.dart';

/// Depends on [ApplicationScope] to be built first.
class Application extends StatefulWidget {

  const Application({
    super.key,
    required this.title,
    this.darkTheme,
    required this.theme,
  });

  final String title;

  final ThemeData? darkTheme;
  final ThemeData theme;

  @override
  State<StatefulWidget> createState() => _AppState();
}

class _AppState extends State<Application> {

  @override
  void dispose() {
    _closeServices(context.app);
    super.dispose();
  }

  /// close services register to the application's scope.
  void _closeServices(ApplicationScope scope) async {
    await scope.dispatcher.close();
    await scope.closeRepos();
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