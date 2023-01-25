import 'package:flutter/material.dart';

import '../../screen.dart';

part 'scaffold_with_nav_bar.dart';
part 'scaffold_with_nav_column.dart';
part 'scaffold_with_nav_rail.dart';

typedef IndexChangeHandler = void Function(int index);

class ResponsiveScaffold extends StatelessWidget {
  
  const ResponsiveScaffold({
    super.key,
    required this.currentIndex,
    required this.onIndexChanged,
    required this.destinations,
    this.appBar,
    required this.child,
    this.drawerHeader,
    this.drawerFooter,
    this.fab,
    this.bottomSheet,
  });

  final int currentIndex;

  final IndexChangeHandler onIndexChanged;

  final List<NavigationItem> destinations;

  final PreferredSizeWidget? appBar;

  final Widget child;

  final Widget? drawerHeader;

  final Widget? drawerFooter;

  final FloatingActionButton? fab;

  final Widget? bottomSheet;

  @override
  Widget build(BuildContext context) {
    var screen = Screen.from(context);
    switch(screen.type) {
      case ScreenType.small:
        return ScaffoldWithNavBar(
          currentIndex: currentIndex,
          onIndexChanged: onIndexChanged,
          appBar: appBar,
          destinations: destinations,
          drawerHeader: drawerHeader,
          drawerFooter: drawerFooter,
          body: child,
          bottomSheet: bottomSheet,
        );
      case ScreenType.medium:
        return ScaffoldWithNavRail(
          currentIndex: currentIndex,
          onIndexChanged: onIndexChanged,
          appBar: appBar,
          destinations: destinations,
          drawerHeader: drawerHeader,
          drawerFooter: drawerFooter,
          body: child,
          bottomSheet: bottomSheet,
        );
      case ScreenType.large:
        return ScaffoldWithNavColumn(
          currentIndex: currentIndex,
          onIndexChanged: onIndexChanged,
          appBar: appBar,
          destinations: destinations,
          drawerHeader: drawerHeader,
          drawerFooter: drawerFooter,
          body: child,
          bottomSheet: bottomSheet,
        );
    }
  }
}

class NavigationItem {

  const NavigationItem({
    required this.label,
    required this.icon,
    this.selectedIcon,
  });

  final String label;

  final Widget icon;

  final Widget? selectedIcon;
}

extension on NavigationItem {

  NavigationDestination toNavDestination() {
    return NavigationDestination(
      icon: icon,
      label: label,
      selectedIcon: selectedIcon,
    );
  }

  NavigationRailDestination toNavRailDestination() {
    return NavigationRailDestination(
      icon: icon,
      label: Text(label),
      padding: const EdgeInsets.all(16.0),
      selectedIcon: selectedIcon,
    );
  }

  ListTile toListTile({
    required int index,
    required bool selected,
    required IndexChangeHandler onTap,
  }) => ListTile(
    leading: icon,
    selected: selected,
    title: Text(label),
    onTap: () => onTap(index),
  );
}