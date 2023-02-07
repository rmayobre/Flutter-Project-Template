part of 'responsive_scaffold.dart';

class _NavigationRailScaffold extends StatelessWidget {
  const _NavigationRailScaffold({
    required this.navRailLimit,
    required this.selectedIndex,
    this.fabConfig,
    required this.navRailDestinations,
    required this.drawerDestinations,
    required this.body,
  });

  /// Navigation limit for navigation rail. Any extra [Destination]s will
  /// be placed inside of a drawer.
  final int navRailLimit;

  final int selectedIndex;

  final FabConfiguration? fabConfig;

  final List<Destination> navRailDestinations;

  final List<Destination> drawerDestinations;

  final Widget body;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: drawerDestinations.isNotEmpty
          ? _NavigationDrawer(
              startPos: navRailLimit,
              destinations: drawerDestinations,
            )
          : null,
      body: _NavigationRailBody(
        selectedIndex: selectedIndex,
        destinations: navRailDestinations,
        fabConfig: fabConfig,
        body: body,
      ),
    );
  }
}

class _NavigationRailBody extends StatelessWidget {

  const _NavigationRailBody({
    required this.selectedIndex,
    required this.destinations,
    required this.body,
    this.fabConfig,
  });

  final int selectedIndex;

  final List<Destination> destinations;

  final FabConfiguration? fabConfig;

  final Widget body;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        NavigationRail(
          selectedIndex: selectedIndex,
          destinations: destinations
              .map((e) => e.toNavRailDestination())
              .toList(),
          labelType: NavigationRailLabelType.all,
          onDestinationSelected: (index) => destinations[index].onSelected(context),
          leading: _NavigationRailLeading(fabConfig: fabConfig),
        ),
        Expanded(child: body),
      ],
    );
  }
}

class _NavigationRailLeading extends StatelessWidget {
  const _NavigationRailLeading({
    required this.fabConfig,
  });

  final FabConfiguration? fabConfig;

  @override
  Widget build(BuildContext context) {
    var config = fabConfig;
    if (Scaffold.of(context).hasDrawer) {
      if (config != null) {
        return Column(
          children: [
            const Padding(
              padding: p8bottom,
              child: _MenuButton(),
            ),
            _NavigationRailFab(configuration: config),
          ],
        );
      }
      return const _MenuButton();
    } else if (config != null) {
      return _NavigationRailFab(configuration: config);
    }
    return Container();
  }
}

class _NavigationRailFab extends StatelessWidget {
  const _NavigationRailFab({
    required this.configuration,
  });

  final FabConfiguration configuration;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      elevation: 0,
      tooltip: configuration.tooltip,
      onPressed: configuration.onPressed,
      child: configuration.icon,
    );
  }
}

class _MenuButton extends StatelessWidget {
  const _MenuButton();

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.menu),
      iconSize: 24,
      onPressed: () => Scaffold.of(context).openDrawer(),
      tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
    );
  }
}