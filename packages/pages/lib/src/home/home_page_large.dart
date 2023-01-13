part of 'home_page.dart';

class HomePageLarge extends StatelessWidget {

  const HomePageLarge({
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
    // TODO: implement build
    return const Center(
      child: Text("Large Screen Layout"),
    );
  }

}