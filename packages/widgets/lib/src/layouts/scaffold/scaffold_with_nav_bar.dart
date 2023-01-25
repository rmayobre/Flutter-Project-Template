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
      if (destinations.length > 2 && destinations.length < 6) {
        navigationBar = _buildNavigationBar(destinations.length);
      } else if (destinations.length > 5) {
        navigationBar = _buildNavigationBar(5);
        drawer = _buildDrawer(5);
      } else {
        drawer = _buildDrawer(0); // put all destinations in drawer.
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

  Widget _buildNavigationBar(int end) {
    List<NavigationDestination> navDestinations = [];
    for (var i = 0; i < end; i++) {
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