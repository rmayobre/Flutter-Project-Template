import 'package:flutter/material.dart';
import 'package:framework/application.dart';
import 'package:pages/pages.dart';
import 'package:services/authentication.dart';
import 'package:toolbox/toolbox.dart';

void main() => runOfflineApp();

void runFirebaseApp() async {
  var authService = FirebaseAuthService();
  var persistentCache = await ToolboxPersistentCache.build();
  runApp(
      Application(
        analytics: ToolboxAnalytics(),
        console: LogConsole.noLogs(),
        persistent: persistentCache,
        routeHandler: ToolboxRouteHandler(
          loginPath: '/login',
          authState: authService.model,
          errorPage: ErrorPageWidget.delegate,
          pages: pageRegistry,
        ),
        theme: ThemeData(primarySwatch: Colors.blue,),
        services: [authService],
      )
  );
}

void runOfflineApp() {
  var authService = OfflineAuthService(authDelay: 3);
  runApp(
      Application.test(
        console: ToolboxConsole(),
        routeHandler: ToolboxRouteHandler(
          loginPath: '/login',
          authState: authService.model,
          errorPage: ErrorPageWidget.delegate,
          pages: pageRegistry,
        ),
        theme: ThemeData(primarySwatch: Colors.blue,),
        services: [authService],
      )
  );
}