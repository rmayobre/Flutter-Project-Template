import 'package:flutter/material.dart';
import 'package:framework/main.dart';
import 'package:pages/pages.dart';
import 'package:services/authentication.dart';
import 'package:services/generator.dart';
import 'package:toolbox/toolbox.dart';

void main() => runOfflineApp();

/// Simple function to run a production application.
void runProductionApp() async {
  var authService = FirebaseAuthService();
  var persistentCache = await ToolboxPersistentCache.build();
  runApp(
      Application(
        analytics: ToolboxAnalytics(),
        cache: const ToolboxCache(),
        console: LogConsole.noLogs(),
        persistent: persistentCache,
        routeHandler: ToolboxRouteHandler(
          loginPath: loginPath,
          onRedirect: onRedirect,
          authStateListenable: authService.model,
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

/// Simple function to run an offline version of the application. This typically
/// used for UI development/testing.
void runOfflineApp() {
  var authService = OfflineAuthService(authDelay: 3, /*sessionId: '123'*/);
  runApp(
      Application.test(
        cache: const ToolboxCache(),
        console: ToolboxConsole(),
        routeHandler: ToolboxRouteHandler(
          loginPath: loginPath,
          onRedirect: onRedirect,
          authStateListenable: authService.model,
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

/// How redirects work for the application.
String? onRedirect(
    BuildContext context,
    StateType authState,
    RouteInfo info,
    ) {
  if (authState == StateType.empty || authState == StateType.failed) {
    if (info.path != loginPath) {
      return loginPath;
    }
  }
  if (authState == StateType.loaded && info.path == loginPath) {
    return homePath;
  }
  return null;
}