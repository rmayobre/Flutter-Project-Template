part of 'home_page.dart';

class HomePageSmall extends StatelessWidget {

  const HomePageSmall({
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
    return ScaffoldWithNavBar(
      body: child,
      navBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: index,
        onTap: onNavigation,
        items: const [
          BottomNavigationBarItem(
            label: 'Home',
            icon: Icon(Icons.home),
          ),
          BottomNavigationBarItem(
            label: 'Search',
            icon: Icon(Icons.search),
          ),
          BottomNavigationBarItem(
            label: 'Profile',
            icon: Icon(Icons.account_circle),
          ),
          BottomNavigationBarItem(
            label: 'Settings',
            icon: Icon(Icons.settings),
          ),
        ],
      ),
    );
  }
}