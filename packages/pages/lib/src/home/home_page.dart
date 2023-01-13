import 'package:flutter/material.dart';
import 'package:framework/page.dart';
import 'package:pages/src/account/account_page.dart';
import 'package:pages/src/search/search_page.dart';
import 'package:pages/src/settings/settings_page.dart';
import 'package:widgets/layouts.dart';

part 'home_page_child.dart';
part 'home_page_large.dart';
part 'home_page_medium.dart';
part 'home_page_small.dart';

typedef NavigationIndexChanged = void Function(int index);

class HomePage extends StatelessWidget {

  const HomePage({
    Key? key,
    required this.child,
  }) : super(key: key);

  static const String name = "Home";

  static const String path = "/";

  static const String _indexKey = "NAV_INDEX";

  final Widget child;

  @override
  Widget build(BuildContext context) {
    // Current Navigation index.
    int index = context.page.cache.read(key: _indexKey) ?? 0;
    return ResponsiveLayout(
      smallChild: HomePageSmall(
        index: index,
        child: child,
        onNavigation: (index) => _onNavigate(context, index),
      ),
      mediumChild: HomePageMedium(
        index: index,
        child: child,
        onNavigation: (index) => _onNavigate(context, index),
      ),
      largeChild: HomePageLarge(
        index: index,
        child: child,
        onNavigation: (index) => _onNavigate(context, index),
      ),
    );
  }

  void _onNavigate(BuildContext context, int index) {
    context.page.logger.i("Navigation to page number: $index");
    switch (index) {
      case 0:
        context.page.cache.write(key: _indexKey, value: 0);
        return context.to(HomePageChild.name);
      case 1:
        context.page.cache.write(key: _indexKey, value: 1);
        return context.to(SearchPage.name);
      case 2:
        context.page.cache.write(key: _indexKey, value: 2);
        return context.to(AccountPage.name);
      case 3:
        context.page.cache.write(key: _indexKey, value: 3);
        return context.to(SettingsPage.name);
      default:
        context.page.cache.write(key: _indexKey, value: 0);
        return context.to(HomePageChild.name);
    }
  }
}