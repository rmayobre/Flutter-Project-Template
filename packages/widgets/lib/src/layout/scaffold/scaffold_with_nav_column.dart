import 'package:flutter/material.dart';

class ScaffoldWithNavColumn extends StatelessWidget {

  const ScaffoldWithNavColumn({
    Key? key,
    this.appBar,
    required this.navColumn,
    required this.body,
    this.fab,
  }) : super(key: key);

  final PreferredSizeWidget? appBar;

  final Widget navColumn;

  final Widget body;

  final FloatingActionButton? fab;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      body: Row(
        children: [
          Expanded(
            flex: 1,
            child: navColumn,
          ),
          Expanded(
            flex: 3,
            child: body,
          ),
        ],
      ),
      floatingActionButton: fab,
    );
  }
}