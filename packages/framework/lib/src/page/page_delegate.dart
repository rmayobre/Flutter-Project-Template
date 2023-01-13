library page_delegate;

import 'package:flutter/widgets.dart';

import 'page_type.dart';

typedef ErrorPageWidgetBuilder = Widget Function(BuildContext context, Exception? error);
typedef MultiPageWidgetBuilder = Widget Function(BuildContext context, Widget child);

///
class PageDelegate {

  PageDelegate._({
    required this.type,
    required this.nestedPages,
  });

  /// Defines the type of Page to be built.
  final PageType type;

  /// These are pages that can be routed from the existing path of the parent page.
  final List<PageDelegate> nestedPages;
}

///
class SinglePage extends PageDelegate {

  SinglePage({
    required this.name,
    PageType? type,
    required this.path,
    required this.builder,
    List<PageDelegate> nestedPages = const [],
  }) : super._(
    type: type ?? PageType.auto,
    nestedPages: nestedPages,
  );

  final String name;

  final String path;

  ///
  final WidgetBuilder builder;
}

///
class MultiPage extends PageDelegate {

  MultiPage({
    PageType? type,
    required this.builder,
    required this.subPages,
    List<PageDelegate> nestedPages = const [],
  }) : super._(
    type: type ?? PageType.auto,
    nestedPages: nestedPages,
  );

  final MultiPageWidgetBuilder builder;

  /// Used for creating navigable pages within the parent page. Typically used
  /// with a BottomNavigationBar or NavigationRail.
  final List<PageDelegate> subPages;
}

class ErrorPage extends PageDelegate {

  ErrorPage({
    required this.name,
    PageType? type,
    required this.path,
    required this.builder,
    List<PageDelegate> nestedPages = const [],
  }) : super._(
    type: type ?? PageType.auto,
    nestedPages: nestedPages,
  );

  final String name;

  final String path;

  ///
  final ErrorPageWidgetBuilder builder;
}