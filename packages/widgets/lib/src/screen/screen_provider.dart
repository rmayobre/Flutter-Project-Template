import 'package:flutter/widgets.dart';

import 'screen.dart';

class ScreenProvider extends InheritedWidget {

  const ScreenProvider({
    Key? key,
    required this.screen,
    required Widget child,
  }) : super(key: key, child: child);

  ScreenProvider.query({
    Key? key,
    int mobileBreakpoint = Screen.materialMobileBreakpoint,
    int tabletBreakpoint = Screen.materialTabletBreakpoint,
    required MediaQueryData query,
    required Widget child
  }) : this(
    key: key,
    screen: Screen.from(
      query: query,
      mobileBreakpoint: mobileBreakpoint,
      tabletBreakpoint: tabletBreakpoint,
    ),
    child: child,
  );

  final Screen screen;

  @override
  bool updateShouldNotify(covariant ScreenProvider oldWidget) {
    return oldWidget.screen != screen;
  }
}