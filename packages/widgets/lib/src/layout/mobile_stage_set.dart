import 'package:flutter/material.dart';
import 'package:widgets/staging.dart';

class MobileStageSet extends StageSetWidget {

  MobileStageSet({
    Key? key,
    this.appBar,
    this.drawer,
    required this.body,
    this.navBar,
    this.fab,
  }) : super(key: key);

  final PreferredSizeWidget? appBar;

  final Widget? drawer;

  final Widget body;

  final FloatingActionButton? fab;

  final BottomNavigationBar? navBar;

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