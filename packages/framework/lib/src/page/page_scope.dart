import 'package:flutter/widgets.dart';
import 'package:framework/src/storage/cache.dart';

import '../logging/logger.dart';

/// A scope that represents the available resources within a Page.
class PageScope extends InheritedWidget {

  const PageScope({
    super.key,
    required this.cache,
    required this.logger,
    required this.name,
    required this.path,
    required this.pathParams,
    required this.queryParams,
    required super.child,
  });
  
  static PageScope of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType()!;
  }

  /// Page's cached memory Check page's delegate for [StorageScope]. Use this
  /// to help share data between Widgets within the Page.
  final Cache cache;

  /// Page's logging interface.
  final Logger logger;

  /// Name of current page.
  final String name;

  /// Current Page path.
  final String path;

  /// Required parameters of the page.
  final Map<String, String> pathParams;

  /// Additional parameters from the route to this page.
  final Map<String, String> queryParams;
  
  @override
  bool updateShouldNotify(covariant PageScope oldWidget) =>
      oldWidget.pathParams != pathParams || oldWidget.queryParams != queryParams;
}

/// Extensions for Pages
extension PageExtensions on BuildContext {

  PageScope get page => PageScope.of(this);
}