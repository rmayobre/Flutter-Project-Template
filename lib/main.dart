import 'package:flutter/material.dart';
import 'package:framework/main.dart';
import 'package:pages/pages.dart';
import 'package:repositories/firebase.dart';
import 'package:repositories/offline.dart';
import 'package:toolbox/tools.dart';
import 'package:theme/theme.dart';

const initialThemeMode = ThemeMode.light;

void main() => runOfflineApp();

/// Simple function to run a production application.
void runProductionApp() async {
  var dispatcher = ToolboxEventDispatcher();
  var authService = FirebaseAuthService(dispatcher);
  var persistentCache = await ToolboxPersistentCache.build();
  var themeService = ThemeService(dispatcher, initialMode: initialThemeMode);
  runApp(
    ApplicationScope(
      analytics: ToolboxAnalytics(),
      cache: ToolboxCache(),
      console: ToolboxConsole(),
      dispatcher: dispatcher,
      persistent: persistentCache,
      routeHandler: ToolboxRouteHandler(
        loginPath: loginPath,
        onRedirect: onRedirect,
        authStateListenable: authService.model,
        errorPage: ErrorPageWidget.delegate,
        pages: pageRegistry,
      ),
      repositories: [
        authService,
        ContentGenerator(dispatcher, delay: 3),
        themeService,
      ],
      child: Application(
        title: 'Template Application',
        darkTheme: darkThemeData,
        theme: lightThemeData,
      ),
    ),
  );
}

/// Simple function to run an offline version of the application. This typically
/// used for UI development/testing.
void runOfflineApp() {
  var dispatcher = ToolboxEventDispatcher();
  var authService = OfflineAuthService(
    dispatcher,
    authDelay: 3,
    // sessionId: '123',
  ); // comment out "sessionId" to show login screen.
  var themeService = ThemeService(dispatcher, initialMode: initialThemeMode);
  runApp(
    ApplicationScope(
      analytics: Analytics.offline(),
      cache: ToolboxCache(),
      console: ToolboxConsole(),
      dispatcher: dispatcher,
      persistent: PersistentCache.noStorage(),
      routeHandler: ToolboxRouteHandler(
        loginPath: loginPath,
        onRedirect: onRedirect,
        authStateListenable: authService.model,
        errorPage: ErrorPageWidget.delegate,
        pages: pageRegistry,
      ),
      repositories: [
        authService,
        ContentGenerator(dispatcher, delay: 3),
        themeService,
      ],
      child: Application(
        title: 'Template Application',
        darkTheme: darkThemeData,
        theme: lightThemeData,
      ),
    ),
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
