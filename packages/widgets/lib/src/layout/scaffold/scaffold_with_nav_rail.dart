part of 'responsive_scaffold.dart';

class ScaffoldWithNavRail extends StatelessWidget {

  const ScaffoldWithNavRail({
    Key? key,
    this.currentIndex = 0,
    required this.onIndexChanged,
    required this.destinations,
    this.drawerHeader,
    this.drawerFooter,
    this.appBar,
    required this.body,
    this.fab,
    this.bottomSheet,
  }) : super(key: key);

  final int currentIndex;

  final IndexChangeHandler onIndexChanged;

  final PreferredSizeWidget? appBar;

  final List<NavigationItem> destinations;

  final Widget? drawerHeader;

  final Widget? drawerFooter;

  final Widget body;

  final FloatingActionButton? fab;

  final Widget? bottomSheet;

  @override
  Widget build(BuildContext context) {
    Widget? drawer;
    Widget scaffoldBody = body;

    if (destinations.isNotEmpty) {
      // Add navigation rail to scaffold.
      if (destinations.length > 2) {
        scaffoldBody = _buildNavigationRail();
      }
      // Add extra destinations to drawer.
      if (destinations.length > 7) {
        drawer = _buildDrawer();
      }
    }

    return Scaffold(
      appBar: appBar,
      drawer: drawer,
      body: scaffoldBody,
      floatingActionButton: fab,
      bottomSheet: bottomSheet,
    );
  }

  Widget _buildDrawer() {
    List<Widget> drawerWidgets = [];
    var header = drawerHeader;
    if (header != null) {
      drawerWidgets.add(header);
    }
    for (var i = 7; i < destinations.length; i++) {
      drawerWidgets.add(destinations[i].toListTile(index: i, onTap: onIndexChanged));
    }
    var footer = drawerFooter;
    if (footer != null) {
      drawerWidgets.add(footer);
    }
    return Drawer(
      child: ListView(
        children: drawerWidgets,
      ),
    );
  }

  Widget _buildNavigationRail() {
    List<NavigationRailDestination> navDestinations = [];
    for (var i = 0; i < 7; i++) {
      navDestinations.add(destinations[i].toNavRailDestination());
    }
    return Row(
      children: [
        NavigationRail(
          selectedIndex: currentIndex,
          labelType: NavigationRailLabelType.selected,
          onDestinationSelected: onIndexChanged,
          destinations: navDestinations,
        ),
        const VerticalDivider(
          thickness: 1,
          width: 1,
        ),
        Expanded(child: body),
      ],
    );
  }
}