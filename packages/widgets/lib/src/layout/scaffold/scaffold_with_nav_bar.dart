import 'package:flutter/material.dart';

class ScaffoldWithNavBar extends StatelessWidget {

  const ScaffoldWithNavBar({
    Key? key,
    this.appBar,
    this.drawer,
    required this.body,
    required this.navBar,
    this.fab,
  }) : super(key: key);

  final PreferredSizeWidget? appBar;

  final Widget? drawer;

  final Widget body;

  final FloatingActionButton? fab;

  final BottomNavigationBar navBar;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      drawer: drawer,
      body: body,
      bottomNavigationBar: navBar,
      floatingActionButton: fab,
    );
  }
}