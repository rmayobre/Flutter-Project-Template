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
      if (destinations.length > 2 && destinations.length < 8) {
        scaffoldBody = _buildNavigationRail(destinations.length);
      } else if (destinations.length > 7) {
        scaffoldBody = _buildNavigationRail(7);
        drawer = _buildDrawer(7);
      } else {
        drawer = _buildDrawer(0); // put all destinations in drawer.
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

  Widget _buildDrawer(int start) {
    List<Widget> drawerWidgets = [];
    var header = drawerHeader;
    if (header != null) {
      drawerWidgets.add(header);
    }
    for (var i = start; i < destinations.length; i++) {
      drawerWidgets.add(
          destinations[i].toListTile(
            index: i,
            selected: i == currentIndex,
            onTap: onIndexChanged,
          )
      );
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

  Widget _buildNavigationRail(int end) {
    List<NavigationRailDestination> navDestinations = [];
    for (var i = 0; i < end; i++) {
      navDestinations.add(destinations[i].toNavRailDestination());
    }
    return Row(
      children: [
        NavigationRail(
          backgroundColor: Colors.transparent,
          selectedIndex: currentIndex,
          groupAlignment: 0.0,
          labelType: NavigationRailLabelType.selected,
          onDestinationSelected: onIndexChanged,
          destinations: navDestinations,
        ),
        Expanded(child: body),
      ],
    );
  }
}