import 'package:flutter/material.dart';
import 'package:widgets/layouts.dart';
import 'package:widgets/staging.dart';

class DesktopStageSet extends StageSetWidget {

  DesktopStageSet({
    Key? key,
    this.appBar,
    this.navColumn,
    required this.body,
    this.fab,
  }) : super(key: key);

  final PreferredSizeWidget? appBar;

  final NavigationColumn? navColumn;

  final Widget body;

  final FloatingActionButton? fab;

  @override
  Widget build(BuildContext context) {
    var column = navColumn;
    var scaffoldBody = body;
    if (column != null) {
      scaffoldBody = Row(
        children: [
          column,
          body,
        ],
      );
    }

    return Scaffold(
      appBar: appBar,
      body: scaffoldBody,
      floatingActionButton: fab,
    );
  }
}