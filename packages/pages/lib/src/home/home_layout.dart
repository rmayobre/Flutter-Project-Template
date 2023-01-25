import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:framework/page.dart';
import 'package:models/content.dart';
import 'package:widgets/layouts.dart';
import 'package:widgets/modals.dart';
import 'package:widgets/rows.dart';

part 'account/account_page.dart';
part 'overview/overview_page.dart';
part 'search/search_page.dart';
part 'settings/settings_page.dart';

class HomeLayout extends StatelessWidget {

  const HomeLayout({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  /// Supported destinations for home layout.
  static const _homeDestinations = [
    NavigationItem(
      label: OverviewPage.name,
      icon: Icon(Icons.home_outlined),
      selectedIcon: Icon(Icons.home),
    ),
    NavigationItem(
      label: SearchPage.name,
      icon: Icon(Icons.search_outlined),
      selectedIcon: Icon(Icons.search),
    ),
    NavigationItem(
      label: AccountPage.name,
      icon: Icon(Icons.account_circle_outlined),
      selectedIcon: Icon(Icons.account_circle),
    ),
    NavigationItem(
      label: SettingsPage.name,
      icon: Icon(Icons.settings_outlined),
      selectedIcon: Icon(Icons.settings),
    ),
  ];

  /// Handles navigation for each page.
  static void _onNavigate(BuildContext context, int index) {
    context.page.logger.i("Navigation to page number: $index");
    switch (index) {
      case 1:
        return context.to(SearchPage.name);
      case 2:
        return context.to(AccountPage.name);
      case 3:
        return context.to(SettingsPage.name);
      default:
        return context.to(OverviewPage.name);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ResponsiveScaffold(
        currentIndex: context.currentIndex,
        onIndexChanged: (index) => _onNavigate(context, index),
        destinations: _homeDestinations,
        appBar: AppBar(
          title: Text(context.pageName),
        ),
        child: child,
      ),
    );
  }
}

extension on BuildContext {

  String get pageName {
    switch(page.path) {
      case SearchPage.path:
        return SearchPage.name;
      case AccountPage.path:
        return AccountPage.name;
      case SettingsPage.path:
        return SettingsPage.name;
      default:
        return OverviewPage.name;
    }
  }

  /// Current index to Home Layout.
  int get currentIndex {
    switch(page.path) {
      case OverviewPage.path:
        return 0;
      case SearchPage.path:
        return 1;
      case AccountPage.path:
        return 2;
      case SettingsPage.path:
        return 3;
      default:
        return 0;
    }
  }
}