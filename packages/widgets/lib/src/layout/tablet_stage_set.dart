import 'package:flutter/material.dart';
import 'package:widgets/staging.dart';

class TabletStageSet extends StageSetWidget {

  TabletStageSet({
    Key? key,
    this.appBar,
    this.drawer,
    this.navRail,
    required this.body,
    this.fab,
  }) : super(key: key);

  final PreferredSizeWidget? appBar;

  final Widget? drawer;

  final NavigationRail? navRail;

  final Widget body;

  final FloatingActionButton? fab;


  @override
  Widget build(BuildContext context) {
    var rail = navRail;
    var scaffoldBody = body;
    if (rail != null) {
      scaffoldBody = Row(
        children: [
          rail,
          body,
        ],
      );
    }

    return Scaffold(
      appBar: appBar,
      drawer: drawer,
      body: scaffoldBody,
      floatingActionButton: fab,
    );
  }
}