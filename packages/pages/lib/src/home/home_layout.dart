import 'package:flutter/material.dart';
import 'package:framework/page.dart';
import 'package:pages/src/account/account_page.dart';
import 'package:pages/src/search/search_page.dart';
import 'package:pages/src/settings/settings_page.dart';
import 'package:widgets/layouts.dart';

part 'home_page.dart';

typedef NavigationIndexChanged = void Function(int index);

class HomeLayout extends StatelessWidget {

  const HomeLayout({
    Key? key,
    required this.child,
  }) : super(key: key);

  static const String _indexKey = "HOME_NAV_INDEX";

  final Widget child;

  @override
  Widget build(BuildContext context) {
    int index = context.app.cache.read(key: _indexKey) ?? 0;
    return ResponsiveScaffold(
      currentIndex: index,
      onIndexChanged: (index) => _onNavigate(context, index),
      destinations: const [
        NavigationItem(
          label: 'Home',
          icon: Icon(Icons.home_outlined),
          selectedIcon: Icon(Icons.home),
        ),
        NavigationItem(
          label: 'Search',
          icon: Icon(Icons.search_outlined),
          selectedIcon: Icon(Icons.search),
        ),
        NavigationItem(
          label: 'Profile',
          icon: Icon(Icons.account_circle_outlined),
          selectedIcon: Icon(Icons.account_circle),
        ),
        NavigationItem(
          label: 'Settings',
          icon: Icon(Icons.settings_outlined),
          selectedIcon: Icon(Icons.settings),
        ),
      ],
      child: child,
    );
  }

  void _onNavigate(BuildContext context, int index) {
    context.page.logger.i("Navigation to page number: $index");
    switch (index) {
      case 0:
        context.app.cache.write(key: _indexKey, value: 0);
        return context.to(HomePage.name);
      case 1:
        context.app.cache.write(key: _indexKey, value: 1);
        return context.to(SearchPage.name);
      case 2:
        context.app.cache.write(key: _indexKey, value: 2);
        return context.to(AccountPage.name);
      case 3:
        context.app.cache.write(key: _indexKey, value: 3);
        return context.to(SettingsPage.name);
      default:
        context.app.cache.write(key: _indexKey, value: 0);
        return context.to(HomePage.name);
    }
  }
}