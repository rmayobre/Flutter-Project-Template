import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:framework/page.dart';
import 'package:models/authentication.dart';
import 'package:models/content.dart';
import 'package:models/theme.dart';
import 'package:widgets/cards.dart';
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
  static final _homeDestinations = [
    Destination(
      label: OverviewPage.name,
      icon: const Icon(Icons.home_outlined),
      selectedIcon: const Icon(Icons.home),
      onSelected: (context) => context.to(OverviewPage.name),
    ),
    Destination(
      label: SearchPage.name,
      icon: const Icon(Icons.search_outlined),
      selectedIcon: const Icon(Icons.search),
      onSelected: (context) => context.to(SearchPage.name),
    ),
    Destination(
      label: AccountPage.name,
      icon: const Icon(Icons.account_circle_outlined),
      selectedIcon: const Icon(Icons.account_circle),
      onSelected: (context) => context.to(AccountPage.name),
    ),
    Destination(
      label: SettingsPage.name,
      icon: const Icon(Icons.settings_outlined),
      selectedIcon: const Icon(Icons.settings),
      onSelected: (context) => context.to(SettingsPage.name),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return ResponsiveScaffold(
      title: context.pageName,
      enableAppBar: true,
      navBarLimit: 4,
      navRailLimit: 4,
      selectedIndex: context.currentIndex,
      destinations: _homeDestinations,
      fabConfig: FabConfiguration(
        icon: const Icon(Icons.change_circle),
        label: Text("Change Theme", style: Theme.of(context).textTheme.labelMedium),
        tooltip: "Change Theme",
        onPressed: () {
          var themeMode = context.value<ThemeMode>().value;
          context.dispatch(
            ThemeEvent.change(
              mode: themeMode != ThemeMode.dark
                  ? ThemeMode.dark
                  : ThemeMode.light,
            ),
          );
        },
      ),
      body: child,
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