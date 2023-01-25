import 'package:flutter/widgets.dart';

enum ScreenType {
  small,
  medium,
  large
}

class Screen {

  const Screen({
    required this.size,
    required this.type,
    required this.orientation,
  });

  factory Screen.from(BuildContext context, {
    int smallScreenBreakpoint = Screen.materialSmallScreenBreakpoint,
    int mediumScreenBreakpoint = Screen.materialMediumScreenBreakpoint,
  }) {
    // Collect Screen dimensions and determine screen type.
    var query = MediaQuery.of(context);
    ScreenType screenType;
    if (query.size.width < smallScreenBreakpoint) {
      screenType = ScreenType.small;
    } else if (query.size.width < mediumScreenBreakpoint) {
      screenType = ScreenType.medium;
    } else {
      screenType = ScreenType.large;
    }
    return Screen(
      size: query.size,
      type: screenType,
      orientation: query.orientation,
    );
  }

  /// Breakpoint screen size for medium size widgets. Medium widgets cover a range of 600-1239dp.
  static const materialMediumScreenBreakpoint = 1240;

  /// The breakpoint for a small screen size. Layouts designed for small screens
  /// will cover a range of 360-599dp.
  static const materialSmallScreenBreakpoint = 600;

  final Size size;

  final ScreenType type;

  final Orientation orientation;
}