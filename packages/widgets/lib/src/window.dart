import 'dart:ui';

import 'breakpoints.dart';

/// Windowing classes based on Material Design 3
///
/// link: https://m3.material.io/foundations/layout/applying-layout/window-size-classes
enum Window {
  compact,
  medium,
  expanded;

  static Window from(Size size) {
    if (Breakpoint.compatWindow.inRange(size.width)) {
      return Window.compact;
    } else if (Breakpoint.mediumWindow.inRange(size.width)) {
      return Window.medium;
    } else {
      return Window.expanded;
    }
  }
}