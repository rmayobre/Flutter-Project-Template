import 'package:flutter/material.dart';
import 'package:framework/main.dart';
import 'package:pages/pages.dart';
import 'package:services/firebase.dart';
import 'package:services/offline.dart';
import 'package:toolbox/tools.dart';
import 'package:theme/theme.dart';

const initialThemeMode = ThemeMode.light;

void main() => runOfflineApp();

/// Simple function to run a production application.
// void runProductionApp() async {
//   var authService = FirebaseAuthService();
//   var persistentCache = await ToolboxPersistentCache.build();
//   var themeService = ThemeService(initialMode: initialThemeMode);
//   runApp(
//       Application(
//         analytics: ToolboxAnalytics(),
//         cache: const ToolboxCache(),
//         console: LogConsole.noLogs(),
//         darkTheme: darkThemeData,
//         persistent: persistentCache,
//         routeHandler: ToolboxRouteHandler(
//           loginPath: loginPath,
//           onRedirect: onRedirect,
//           authStateListenable: authService.model,
//           errorPage: ErrorPageWidget.delegate,
//           pages: pageRegistry,
//         ),
//         theme: lightThemeData,
//         themeModeListenable: themeService.model,
//         services: [
//           authService,
//           themeService,
//         ],
//       )
//   );
// }

/// Simple function to run an offline version of the application. This typically
/// used for UI development/testing.
void runOfflineApp() {
  var dispatcher = ToolboxEventDispatcher();
  var authService = OfflineAuthService(dispatcher, authDelay: 3, sessionId: '123');
  var themeService = ThemeService(dispatcher, initialMode: initialThemeMode);
  List<Service<dynamic, dynamic>> services = [
    authService,
    ContentGenerator(dispatcher, delay: 3),
    themeService,
  ];
  runApp(
    ApplicationScope(
      analytics: Analytics.offline(),
      cache: const ToolboxCache(),
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
      services: services,
      child: Application(
        title: 'Template Application',
        darkTheme: darkThemeData,
        theme: lightThemeData,
        themeModeListenable: themeService.model,
        onDispose: () async {
          // Make sure to close the dispatcher and all services.
          await dispatcher.close();
          await Future.wait(services.map((service) => service.close()));
        },
      ),
    )
  );
  /*
  runApp(
      Application.test(
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
        themeModeListenable: themeService.model,
        services: [
          authService,
          ContentGenerator(delay: 3),
          themeService
        ],
      )
  );*/
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