part of 'responsive_scaffold.dart';

class ScaffoldWithNavColumn extends StatelessWidget {

  const ScaffoldWithNavColumn({
    Key? key,
    this.currentIndex = 0,
    required this.onIndexChanged,
    this.appBar,
    this.drawerHeader,
    this.drawerFooter,
    required this.destinations,
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
    List<Widget> drawerWidgets = [];
    var header = drawerHeader;
    if (header != null) {
      drawerWidgets.add(header);
    }
    for (var i = 0; i < destinations.length; i++) {
      drawerWidgets.add(
        destinations[i].toListTile(
          index: i,
          selected: i == currentIndex,
          onTap: onIndexChanged,
        ),
      );
    }
    var footer = drawerFooter;
    if (footer != null) {
      drawerWidgets.add(footer);
    }
    return Scaffold(
      appBar: appBar,
      body: Row(
        children: [
          Drawer(
            elevation: 0,
            child: ListView(
              children: drawerWidgets,
            ),
          ),
          const VerticalDivider(
            thickness: 1,
            width: 1,
          ),
          Expanded(
            // flex: 3,
            child: body,
          ),
        ],
      ),
      floatingActionButton: fab,
    );
  }
}