import 'package:flutter/material.dart';
import 'package:framework/main.dart';
import 'package:pages/pages.dart';
import 'package:services/authentication.dart';
import 'package:services/generator.dart';
import 'package:services/theme.dart';
import 'package:toolbox/toolbox.dart';
import 'package:theme/theme.dart';

const initialThemeMode = ThemeMode.light;

void main() => runOfflineApp();

/// Simple function to run a production application.
void runProductionApp() async {
  var authService = FirebaseAuthService();
  var persistentCache = await ToolboxPersistentCache.build();
  var themeService = ThemeService(initialMode: initialThemeMode);
  runApp(
      ValueListenableBuilder(
        valueListenable: themeService.model,
        builder: (BuildContext context, ThemeMode value, Widget? child) {
          return Application(
            analytics: ToolboxAnalytics(),
            cache: const ToolboxCache(),
            console: LogConsole.noLogs(),
            darkTheme: darkThemeData,
            persistent: persistentCache,
            routeHandler: ToolboxRouteHandler(
              loginPath: loginPath,
              onRedirect: onRedirect,
              authStateListenable: authService.model,
              errorPage: ErrorPageWidget.delegate,
              pages: pageRegistry,
            ),
            theme: lightThemeData,
            themeMode: value,
            services: [
              authService,
              themeService,
            ],
          );
        },
      )
  );
}

/// Simple function to run an offline version of the application. This typically
/// used for UI development/testing.
void runOfflineApp() {
  var authService = OfflineAuthService(authDelay: 3, sessionId: '123');
  var themeService = ThemeService(initialMode: initialThemeMode);
  runApp(
      ValueListenableBuilder(
        valueListenable: themeService.model,
        builder: (BuildContext context, ThemeMode value, Widget? child) {
          return Application.test(
            cache: const ToolboxCache(),
            console: ToolboxConsole(),
            darkTheme: darkThemeData,
            routeHandler: ToolboxRouteHandler(
              loginPath: loginPath,
              onRedirect: onRedirect,
              authStateListenable: authService.model,
              errorPage: ErrorPageWidget.delegate,
              pages: pageRegistry,
            ),
            theme: lightThemeData,
            themeMode: value,
            services: [
              authService,
              ContentGenerator(delay: 3),
              themeService
            ],
          );
        },
      )
  );
}

/// How redirects work for the application.
String? onRedirect(
    BuildContext context,
    StateType authState,
    RouteInfo info,) {
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