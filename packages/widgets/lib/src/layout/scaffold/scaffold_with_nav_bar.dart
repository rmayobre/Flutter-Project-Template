part of 'responsive_scaffold.dart';

class ScaffoldWithNavBar extends StatelessWidget {

  const ScaffoldWithNavBar({
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

  final List<NavigationItem> destinations;

  final PreferredSizeWidget? appBar;

  final Widget? drawerHeader;

  final Widget? drawerFooter;

  final Widget body;

  final FloatingActionButton? fab;

  final Widget? bottomSheet;

  @override
  Widget build(BuildContext context) {
    Widget? drawer;
    Widget? navigationBar;

    if (destinations.isNotEmpty) {
      // Add navigation rail to scaffold.
      if (destinations.length > 2) {
        navigationBar = _buildNavigationBar();
      }
      // Add extra destinations to drawer.
      if (destinations.length > 5) {
        drawer = _buildDrawer();
      }
    }

    return Scaffold(
      appBar: appBar,
      drawer: drawer,
      body: body,
      floatingActionButton: fab,
      bottomNavigationBar: navigationBar,
      bottomSheet: bottomSheet,
    );
  }

  Widget _buildDrawer() {
    List<Widget> drawerWidgets = [];
    var header = drawerHeader;
    if (header != null) {
      drawerWidgets.add(header);
    }
    for (var i = 5; i < destinations.length; i++) {
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

  Widget _buildNavigationBar() {
    List<NavigationDestination> navDestinations = [];
    for (var i = 0; i < 5; i++) {
      navDestinations.add(destinations[i].toNavDestination());
    }
    return  NavigationBar(
      labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
      selectedIndex: currentIndex,
      onDestinationSelected: onIndexChanged,
      destinations: navDestinations,
    );
  }
}