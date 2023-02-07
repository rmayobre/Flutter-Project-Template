part of 'responsive_scaffold.dart';

class _NavigationBarScaffold extends StatelessWidget {
  const _NavigationBarScaffold({
    this.appBarTitle,
    required this.navBarLimit,
    required this.selectedIndex,
    required this.drawerDestinations,
    required this.bottomBarDestinations,
    this.fabConfig,
    required this.body,
  });
  
  final String? appBarTitle;

  /// Navigation limit for bottom navigation bar. Any extra [Destination]s will
  /// be placed inside of a drawer.
  final int navBarLimit;

  final int selectedIndex;

  final List<Destination> drawerDestinations;

  final List<Destination> bottomBarDestinations;

  final FabConfiguration? fabConfig;

  final Widget body;

  @override
  Widget build(BuildContext context) {
    var title = appBarTitle;
    var config = fabConfig;
    return Scaffold(
      appBar: title != null
          ? AppBar(centerTitle: true, title: Text(title))
          : null,
      drawer: drawerDestinations.isNotEmpty
          ? _NavigationDrawer(
              startPos: navBarLimit,
              destinations: drawerDestinations,
            )
          : null,
      body: body,
      floatingActionButton: config != null
          ? _NavigationBarFab(configuration: config)
          : null,
      bottomNavigationBar: _NavigationBottomBar(
        selectedIndex: selectedIndex,
        destinations: bottomBarDestinations,
      ),
    );
  }
}

class _NavigationBottomBar extends StatelessWidget {
  const _NavigationBottomBar({
    required this.selectedIndex,
    required this.destinations,
  });

  final int selectedIndex;

  final List<Destination> destinations;

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
      selectedIndex: selectedIndex,
      onDestinationSelected: (index) => destinations[index].onSelected(context),
      destinations: destinations.map((e) => e.toNavDestination()).toList(),
    );
  }
}

class _NavigationBarFab extends StatelessWidget {
  const _NavigationBarFab({
    required this.configuration,
  });

  final FabConfiguration configuration;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      tooltip: configuration.tooltip,
      onPressed: configuration.onPressed,
      child: configuration.icon,
    );
  }
}
