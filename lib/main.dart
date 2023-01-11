import 'package:flutter/material.dart';
import 'package:framework/application.dart';
import 'package:pages/pages.dart';
import 'package:repositories/authentication.dart';
import 'package:toolbox/toolbox.dart';

void main() => runOfflineApp();

void runFirebaseApp() {
  final AuthenticationRepository authenticationRepository = FirebaseAuthRepository();
  runApp(
      Application(
        analytics: ToolboxAnalytics(),
        authRepo: authenticationRepository,
        cache: Cache(),
        console: ToolboxConsole(),
        pages: pageRegistry,
        persistent: ToolboxPersistentCache(),
        routeHandler: ToolboxRouteHandler.go(
          loginPath: "/login",
          sessionState: authenticationRepository.state,
          errorPage: ErrorPageWidget.delegate,
          pages: pageRegistry,
        ),
        theme: ThemeData(primarySwatch: Colors.blue,),
        registry: RepoRegistry.from(
            repos: {
              Authenticator.repoKey : authenticationRepository,
            }
        ),
      )
  );
}

void runOfflineApp() {
  final AuthenticationRepository authenticationRepository = AuthenticationRepository.offline();
  runApp(
      Application(
        analytics: Analytics.offline(),
        authRepo: authenticationRepository,
        cache: Cache(),
        console: ToolboxConsole(),
        pages: pageRegistry,
        persistent: ToolboxPersistentCache(),
        routeHandler: ToolboxRouteHandler.go(
          loginPath: "/login",
          sessionState: authenticationRepository.state,
          errorPage: ErrorPageWidget.delegate,
          pages: pageRegistry,
        ),
        theme: ThemeData(primarySwatch: Colors.blue,),
        registry: RepoRegistry.from(
            repos: {
              Authenticator.repoKey : authenticationRepository,
            }
        ),
      )
  );
}