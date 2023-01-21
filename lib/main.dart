import 'package:flutter/material.dart';
import 'package:framework/application.dart';
import 'package:pages/pages.dart';
import 'package:services/authentication.dart';
import 'package:services/generator.dart';
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
          loginPath: loginPath,
          authState: authService.model,
          errorPage: ErrorPageWidget.delegate,
          pages: pageRegistry,
        ),
        theme: ThemeData(
          primarySwatch: Colors.blue,
          useMaterial3: true,
        ),
        services: [authService],
      )
  );
}

void runOfflineApp() {
  var authService = OfflineAuthService(authDelay: 3/*, sessionId: '123'*/);
  runApp(
      Application.test(
        console: ToolboxConsole(),
        routeHandler: ToolboxRouteHandler(
          loginPath: loginPath,
          authState: authService.model,
          errorPage: ErrorPageWidget.delegate,
          pages: pageRegistry,
        ),
        theme: ThemeData(
          primarySwatch: Colors.blue,
          useMaterial3: true,
          scaffoldBackgroundColor: Colors.black12
        ),
        services: [
          authService,
          ContentGenerator(delay: 3),
        ],
      )
  );
}