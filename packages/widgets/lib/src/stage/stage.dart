import 'package:flutter/material.dart';
import 'package:widgets/layouts.dart';
import 'package:widgets/screen.dart';

import 'director.dart';
import 'stage_set.dart';

typedef StageSetWidgetBuilder = StageSetWidget Function(BuildContext);

class Stage extends StatelessWidget {

  const Stage({
    Key? key,
    required this.mobile,
    required this.tablet,
    required this.desktop
  }) : super(key: key);

  final StageSetWidgetBuilder mobile;

  final StageSetWidgetBuilder tablet;

  final StageSetWidgetBuilder desktop;

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayoutBuilder(
      builder: (BuildContext context, Screen screen) {
        StageSetWidget stageSetWidget;
        switch (screen.type) {
          case ScreenType.mobile:
            stageSetWidget = mobile(context);
            break;
          case ScreenType.tablet:
            stageSetWidget = tablet(context);
            break;
          case ScreenType.desktop:
            stageSetWidget = desktop(context);
            break;
        }
        return DirectorWidget(child: stageSetWidget);
      },
    );
  }
}