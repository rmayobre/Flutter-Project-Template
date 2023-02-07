part of 'responsive_scaffold.dart';

class _NavigationDrawerScaffold extends StatelessWidget {
  const _NavigationDrawerScaffold({
    required this.selectedIndex,
    required this.destinations,
    this.fabConfig,
    required this.body,
  });

  final int selectedIndex;

  final List<Destination> destinations;

  final FabConfiguration? fabConfig;

  final Widget body;

  @override
  Widget build(BuildContext context) {
    var config = fabConfig;
    return Scaffold(
      body: _NavigationDrawer(
        startPos: 0,
        selectedIndex: selectedIndex,
        destinations: destinations,
        body: body,
        floatingActionButton: config != null
            ? _NavigationDrawerFab(configuration: config)
            : null,
      ),
    );
  }
}

class _NavigationDrawerFab extends StatelessWidget {
  const _NavigationDrawerFab({
    required this.configuration,
  });

  final FabConfiguration configuration;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: p16all,
      child: FloatingActionButton.extended(
        elevation: 0,
        icon: configuration.icon,
        label: configuration.label,
        onPressed: configuration.onPressed,
      ),
    );
  }
}
