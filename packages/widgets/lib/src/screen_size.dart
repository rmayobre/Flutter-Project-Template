import 'dart:ui';

import 'breakpoints.dart';

/// Screen sizes based on Material Design 3 breakpoints.
enum ScreenSize {
  xSmall,
  small,
  medium,
  medium2,
  large;

  static ScreenSize from(Size size) {
    if (Breakpoint.xSmall.inRange(size.width)) {
      return xSmall;
    } else if (Breakpoint.small.inRange(size.width)) {
      return small;
    } else if (Breakpoint.medium.inRange(size.width)) {
      return medium;
    } else if (Breakpoint.medium2.inRange(size.width)) {
      return medium2;
    } else {
      return large;
    }
  }
}