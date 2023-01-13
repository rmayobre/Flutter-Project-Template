part of 'home_page.dart';

class HomePageMedium extends StatelessWidget {

  const HomePageMedium({
    super.key,
    required this.index,
    required this.child,
    required this.onNavigation,
  });

  final int index;

  final Widget child;

  final NavigationIndexChanged onNavigation;

  @override
  Widget build(BuildContext context) {
    return ScaffoldWithNavRail(
      navRail: NavigationRail(
        onDestinationSelected: onNavigation,
        destinations: const [
          NavigationRailDestination(
            label: Text('Home'),
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
          ),
          NavigationRailDestination(
            label: Text('Search'),
            icon: Icon(Icons.search_outlined),
            selectedIcon: Icon(Icons.search),
          ),
          NavigationRailDestination(
            label: Text('Profile'),
            icon: Icon(Icons.account_circle_outlined),
            selectedIcon: Icon(Icons.account_circle),
          ),
          NavigationRailDestination(
            label: Text('Settings'),
            icon: Icon(Icons.settings_outlined),
            selectedIcon: Icon(Icons.settings),
          ),
        ],
        selectedIndex: null,
      ),
      body: child,
    );
  }

}