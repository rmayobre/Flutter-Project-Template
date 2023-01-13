import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:framework/routing.dart';
import 'package:go_router/go_router.dart';

abstract class ToolboxRouteHandler implements RouteHandler {

  const ToolboxRouteHandler({required this.config});

  /// Construct a [ToolboxRouteHandler] using the [GoRouter] library.
  factory ToolboxRouteHandler.go({
    String homePath = "/",
    required String loginPath,
    required StateListenable<Session> sessionState,
    required ErrorPage errorPage,
    required List<PageDelegate> pages,
  }) {
    final GlobalKey<NavigatorState> rootKey = GlobalKey();
    return _GoRouteHandler(
      config: GoRouter(
        navigatorKey: rootKey,
        initialLocation: homePath,
        refreshListenable: sessionState,
        errorPageBuilder: (context, state) => errorPage.toPage(context, state),
        routes: _GoRouteHandler.createRoutes(rootKey, pages),
        redirect: (context, state) {
          return _GoRouteHandler.onRedirect(
            buildContext: context,
            goRouterState: state,
            sessionState: sessionState,
            loginPath: loginPath,
          );
        },
      ),
    );
  }

  @override
  final RouterConfig<Object> config;

}

class _GoRouteHandler extends ToolboxRouteHandler {

  const _GoRouteHandler({required super.config});

  static FutureOr<String?> onRedirect({
    required BuildContext buildContext,
    required GoRouterState goRouterState,
    required StateListenable<Session> sessionState,
    required String loginPath,
  }) {
    // If session is missing, user is unauthenticated.
    if (sessionState.value == null) {
      return loginPath;
    }
    return null;
  }

  static List<RouteBase> createRoutes(GlobalKey<NavigatorState> rootKey, List<PageDelegate> delegates) =>
      delegates.map((page) => page.toRoute(rootKey, null)).toList(growable: false);

  @override
  void route(BuildContext context, String name, {
    Map<String, String> pathParams = const {},
    Map<String, dynamic> queryParams = const {},
  }) => context.goNamed(name, params: pathParams, queryParams: queryParams);
}

extension on PageDelegate {

  RouteBase toRoute(GlobalKey<NavigatorState> rootKey, GlobalKey<NavigatorState>? shellKey) {
    if (this is SinglePage) {
      return (this as SinglePage).toGoRoute(rootKey, shellKey);
    } else {
      return (this as LayoutPage).toShellRoute(rootKey);
    }
  }
}

extension on SinglePage {

  GoRoute toGoRoute(GlobalKey<NavigatorState> rootKey, GlobalKey<NavigatorState>? shellKey) {
    return GoRoute(
      name: name,
      path: path,
      parentNavigatorKey: shellKey ?? rootKey,
      pageBuilder: (context, state) => toPage(context, state),
    );
  }

  Page<dynamic> toPage(BuildContext context, GoRouterState state) {
    switch(type) {
      case PageType.auto:
        if (defaultTargetPlatform == TargetPlatform.iOS || defaultTargetPlatform == TargetPlatform.macOS) {
          return CupertinoPage(child: toPageScope(context, state));
        } 
        return MaterialPage(child: toPageScope(context, state));
      case PageType.material:
        return MaterialPage(child: toPageScope(context, state));
      case PageType.cupertino:
        return CupertinoPage(child: toPageScope(context, state));
      case PageType.noTransition:
        return NoTransitionPage(child: toPageScope(context, state));
    }
  }
  
  Widget toPageScope(BuildContext context, GoRouterState state) {
    var pageWidget = builder(context);
    context.app.analytics.setPage(name, pageWidget.runtimeType.toString());
    return PageScope(
      cache: Cache(),
      name: name,
      pathParams: state.params,
      queryParams: state.queryParams,
      logger: Logger(pageTag: name, console: context.app.console),
      child: pageWidget,
    );
  }
}

extension on LayoutPage {

  ShellRoute toShellRoute(GlobalKey<NavigatorState> rootKey) {
    final GlobalKey<NavigatorState> shellKey = GlobalKey();

    // TODO combine subPages with nested pages.
    return ShellRoute(
      navigatorKey: shellKey,
      pageBuilder: (context, state, child) => toPage(context, state, child),
      routes: childPages.map((delegate) => delegate
          .toRoute(rootKey, shellKey))
          .toList(growable: false),
    );
  }

  Page<dynamic> toPage(BuildContext context, GoRouterState state, Widget child) {
    switch(type) {
      case PageType.auto:
        if (defaultTargetPlatform == TargetPlatform.iOS || defaultTargetPlatform == TargetPlatform.macOS) {
          return CupertinoPage(child: toPageScope(context, state, child));
        }
        return MaterialPage(child: toPageScope(context, state, child));
      case PageType.material:
        return MaterialPage(child: toPageScope(context, state, child));
      case PageType.cupertino:
        return CupertinoPage(child: toPageScope(context, state, child));
      case PageType.noTransition:
        return NoTransitionPage(child: toPageScope(context, state, child));
    }
  }

  Widget toPageScope(BuildContext context, GoRouterState state, Widget child) {
    var pageName = state.subloc;//state.name ?? "unknown-page";
    var pageWidget = builder(context, child);
    return PageScope(
      cache: Cache(),
      name: pageName,
      pathParams: state.params,
      queryParams: state.queryParams,
      logger: Logger(pageTag: pageName, console: context.app.console),
      child: pageWidget,
    );
  }
}

extension on ErrorPage {
  Page<dynamic> toPage(BuildContext context, GoRouterState state) {
    switch(type) {
      case PageType.auto:
        if (defaultTargetPlatform == TargetPlatform.iOS || defaultTargetPlatform == TargetPlatform.macOS) {
          return CupertinoPage(child: toPageScope(context, state));
        }
        return MaterialPage(child: toPageScope(context, state));
      case PageType.material:
        return MaterialPage(child: toPageScope(context, state));
      case PageType.cupertino:
        return CupertinoPage(child: toPageScope(context, state));
      case PageType.noTransition:
        return NoTransitionPage(child: toPageScope(context, state));
    }
  }

  Widget toPageScope(BuildContext context, GoRouterState state) {
    var pageWidget = builder(context, state.error);
    context.app.analytics.setPage(name, pageWidget.runtimeType.toString());
    return PageScope(
      cache: Cache(),
      name: name,
      pathParams: state.params,
      queryParams: state.queryParams,
      logger: Logger(pageTag: name, console: context.app.console),
      child: pageWidget,
    );
  }
}
