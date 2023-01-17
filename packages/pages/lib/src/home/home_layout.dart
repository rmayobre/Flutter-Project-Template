import 'package:flutter/material.dart';
import 'package:framework/page.dart';
import 'package:pages/src/account/account_page.dart';
import 'package:pages/src/search/search_page.dart';
import 'package:pages/src/settings/settings_page.dart';
import 'package:widgets/layouts.dart';

part 'home_page.dart';

class HomeLayout extends StatelessWidget {

  const HomeLayout({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  /// Supported destinations for home layout.
  static const homeDestinations = [
    NavigationItem(
      label: HomePage.name,
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

  @override
  Widget build(BuildContext context) {
    return ResponsiveScaffold(
      currentIndex: context.currentIndex,
      onIndexChanged: (index) => _onNavigate(context, index),
      destinations: homeDestinations,
      child: child,
    );
  }

  /// Handles navigation for each page.
  void _onNavigate(BuildContext context, int index) {
    context.page.logger.i("Navigation to page number: $index");
    switch (index) {
      case 0:
        return context.to(HomePage.name);
      case 1:
        return context.to(SearchPage.name);
      case 2:
        return context.to(AccountPage.name);
      case 3:
        return context.to(SettingsPage.name);
      default:
        return context.to(HomePage.name);
    }
  }
}

extension on BuildContext {

  /// Current index to Home Layout.
  int get currentIndex {
    switch(page.path) {
      case HomePage.path:
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