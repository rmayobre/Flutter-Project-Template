import 'package:flutter/widgets.dart';

import 'screen_provider.dart';

enum ScreenType { mobile, tablet, desktop }

class Screen {

  const Screen({
    required this.size,
    required this.type,
    required this.orientation,
  });

  /// Breakpoint screen size for medium size widgets. Medium widgets cover a range of 600-1239dp.
  static const materialTabletBreakpoint = 1240;

  /// The breakpoint for a small screen size. Layouts designed for small screens
  /// will cover a range of 360-599dp.
  static const materialMobileBreakpoint = 600;

  static Screen of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ScreenProvider>()!.screen;
  }

  static Screen from({
    required MediaQueryData query,
    int mobileBreakpoint = Screen.materialMobileBreakpoint,
    int tabletBreakpoint = Screen.materialTabletBreakpoint,
  }) {
    ScreenType screenType;
    if (query.size.width < mobileBreakpoint) {
      screenType = ScreenType.mobile;
    } else if (query.size.width < tabletBreakpoint) {
      screenType = ScreenType.tablet;
    } else {
      screenType = ScreenType.desktop;
    }
    return Screen(
      size: query.size,
      type: screenType,
      orientation: query.orientation,
    );
  }

  final Size size;

  final ScreenType type;

  final Orientation orientation;

}