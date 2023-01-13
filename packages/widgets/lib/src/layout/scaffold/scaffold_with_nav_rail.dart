import 'package:flutter/material.dart';

class ScaffoldWithNavRail extends StatelessWidget {

  const ScaffoldWithNavRail({
    Key? key,
    this.appBar,
    this.drawer,
    required this.navRail,
    required this.body,
    this.fab,
  }) : super(key: key);

  final PreferredSizeWidget? appBar;

  final Widget? drawer;

  final NavigationRail navRail;

  final Widget body;

  final FloatingActionButton? fab;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      drawer: drawer,
      body: Row(
        children: [
          navRail,
          Expanded(child: body),
        ],
      ),
      floatingActionButton: fab,
    );
  }
}