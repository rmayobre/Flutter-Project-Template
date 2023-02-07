import 'package:flutter/material.dart';
import 'package:widgets/constants.dart';

import '../../device.dart';

part 'navigation_bar_scaffold.dart';
part 'navigation_drawer_scaffold.dart';
part 'navigation_rail_scaffold.dart';

typedef OnTapCallback = void Function();
typedef OnNavCallback = void Function(BuildContext context);
typedef OnIndexChange = void Function(int index);

class Destination {

  const Destination({
    required this.label,
    required this.icon,
    this.selectedIcon,
    required this.onSelected,
  });

  final String label;

  final Widget icon;

  final Widget? selectedIcon;

  final OnNavCallback onSelected;
}

class FabConfiguration {

  const FabConfiguration({
    required this.icon,
    required this.label,
    required this.tooltip,
    required this.onPressed,
  });

  final Widget icon;

  final Widget label;

  final String? tooltip;

  final OnTapCallback onPressed;
}

class ResponsiveScaffold extends StatelessWidget {

  const ResponsiveScaffold({
    super.key,
    this.title = '',
    this.enableAppBar = true,
    this.navBarLimit = 5,
    this.navRailLimit = 7,
    required this.selectedIndex,
    required this.destinations,
    this.fabConfig,
    required this.body,
  });

  final String title;
  
  final bool enableAppBar;

  /// Navigation limit for bottom navigation bar. Any extra [Destination]s will
  /// be placed inside of a drawer.
  final int navBarLimit;

  /// Navigation limit for navigation rail. Any extra [Destination]s will
  /// be placed inside of a drawer.
  final int navRailLimit;

  final int selectedIndex;

  final List<Destination> destinations;

  final FabConfiguration? fabConfig;

  final Widget body;

  @override
  Widget build(BuildContext context) {
    var device = Device.from(context);
    switch(device.type) {
      case ScreenType.small:
        return _NavigationBarScaffold(
          appBarTitle: enableAppBar ? title : null,
          navBarLimit: navBarLimit,
          selectedIndex: selectedIndex,
          fabConfig: fabConfig,
          drawerDestinations: destinations.length > navBarLimit
              ? destinations.sublist(navBarLimit)
              : const [],
          bottomBarDestinations: destinations.length > navBarLimit
              ? destinations.sublist(0, navBarLimit)
              : destinations,
          body: body,
        );
      case ScreenType.medium:
        return _NavigationRailScaffold(
          navRailLimit: navRailLimit,
          selectedIndex: selectedIndex,
          fabConfig: fabConfig,
          navRailDestinations: destinations.length > navRailLimit
              ? destinations.sublist(0, navRailLimit)
              : destinations,
          drawerDestinations: destinations.length > navRailLimit
              ? destinations.sublist(navRailLimit)
              : const [],
          body: body,
        );
      case ScreenType.large:
        return _NavigationDrawerScaffold(
          selectedIndex: selectedIndex,
          destinations: destinations,
          fabConfig: fabConfig,
          body: body,
        );
    }
  }

}

/// TODO build a separate drawer for each scaffold.
class _NavigationDrawer extends StatelessWidget {
  const _NavigationDrawer({
    this.selectedIndex = -1,
    required this.startPos,
    required this.destinations,
    this.body,
    this.floatingActionButton,
  });

  /// if -1, no selected destination
  final int selectedIndex;

  /// Starting position of destinations this drawer will use.
  final int startPos;

  final List<Destination> destinations;

  final Widget? body;

  final Widget? floatingActionButton;

  @override
  Widget build(BuildContext context) {
    List<Widget> drawerWidgets = [];
    var fab = floatingActionButton;
    if (fab != null) drawerWidgets.add(fab);
    drawerWidgets.addAll(destinations.map((e) => e.toNavDrawerDestination()));

    var bodyWidget = body;
    if (bodyWidget != null) {
      return Row(
        children: [
          NavigationDrawer(
            elevation: 0,
            selectedIndex: selectedIndex,
            onDestinationSelected: (index) => destinations[index].onSelected(context),
            children: List.from(drawerWidgets),
          ),
          Expanded(
            child: bodyWidget,
          ),
        ],
      );
    } else {
      return NavigationDrawer(
        selectedIndex: selectedIndex,
        onDestinationSelected: (index) => destinations[index].onSelected(context),
        children: List.from(drawerWidgets),
      );
    }
  }
}

extension on Destination {

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
      padding: p16all,
      selectedIcon: selectedIcon,
    );
  }

  NavigationDrawerDestination toNavDrawerDestination() {
    return NavigationDrawerDestination(
      icon: icon,
      label: Text(label),
      selectedIcon: selectedIcon,
    );
  }
}