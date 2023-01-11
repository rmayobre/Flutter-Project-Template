library page_delegate;

import 'package:flutter/widgets.dart';
import 'package:framework/src/repository/registry.dart';

import 'page_type.dart';

typedef ErrorPageWidgetBuilder = Widget Function(BuildContext context, Exception? error);
typedef MultiPageWidgetBuilder = Widget Function(BuildContext context, Widget child);

///
class PageDelegate {

  PageDelegate._({
    required this.name,
    required this.type,
    required this.nestedPages,
    required this.registryBuilder,
  });

  /// Used for navigation reference and the default logger tag.
  final String name;

  /// Defines the type of Page to be built.
  final PageType type;

  /// These are pages that can be routed from the existing path of the parent page.
  final List<PageDelegate> nestedPages;

  /// A registry of [Repository] this page will utilize.
  final RepoRegistryBuilder registryBuilder;
}

///
class SinglePage extends PageDelegate {

  SinglePage({
    required String name,
    PageType? type,
    required this.path,
    required this.builder,
    RepoRegistryBuilder? registryBuilder,
    List<PageDelegate> nestedPages = const [],
  }) : super._(
    name: name,
    type: type ?? PageType.auto,
    nestedPages: nestedPages,
    registryBuilder: registryBuilder ?? (_) => const RepoRegistry(),
  );

  final String path;

  ///
  final WidgetBuilder builder;
}

///
class MultiPage extends PageDelegate {

  MultiPage({
    required String name,
    PageType? type,
    required this.builder,
    RepoRegistryBuilder? registryBuilder,
    this.subPages = const [],
    List<PageDelegate> nestedPages = const [],
  }) : super._(
    name: name,
    type: type ?? PageType.auto,
    nestedPages: nestedPages,
    registryBuilder: registryBuilder ?? (_) => const RepoRegistry(),
  );

  final MultiPageWidgetBuilder builder;

  /// Used for creating navigable pages within the parent page. Typically used
  /// with a BottomNavigationBar or NavigationRail.
  final List<PageDelegate> subPages;
}

class ErrorPage extends PageDelegate {

  ErrorPage({
    required String name,
    PageType? type,
    required this.path,
    required this.builder,
    RepoRegistryBuilder? registryBuilder,
    List<PageDelegate> nestedPages = const [],
  }) : super._(
    name: name,
    type: type ?? PageType.auto,
    nestedPages: nestedPages,
    registryBuilder: registryBuilder ?? (_) => const RepoRegistry(),
  );

  final String path;

  ///
  final ErrorPageWidgetBuilder builder;
}