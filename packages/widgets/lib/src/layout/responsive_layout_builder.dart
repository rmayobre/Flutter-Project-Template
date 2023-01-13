library responsive_layout;

import 'package:flutter/widgets.dart';

typedef ResponsiveWidgetBuilder = Widget Function(BuildContext context, Screen screen);

enum ScreenType { small, medium, large }

class ResponsiveLayoutBuilder extends StatelessWidget {

  const ResponsiveLayoutBuilder({
    Key? key,
    this.smallScreenBreakpoint = Screen.materialSmallScreenBreakpoint,
    this.mediumScreenBreakpoint = Screen.materialMediumScreenBreakpoint,
    required this.builder,
  }) : super(key: key);

  final int smallScreenBreakpoint;

  final int mediumScreenBreakpoint;
  
  final ResponsiveWidgetBuilder builder;

  @override
  Widget build(BuildContext context) {
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

    // Build a widget using the screen's meta data.
    return builder(
      context,
      Screen(
        size: query.size,
        type: screenType,
        orientation: query.orientation,
      ),
    );
  }
}

class Screen {

  const Screen({
    required this.size,
    required this.type,
    required this.orientation,
  });

  /// Breakpoint screen size for medium size widgets. Medium widgets cover a range of 600-1239dp.
  static const materialMediumScreenBreakpoint = 1240;

  /// The breakpoint for a small screen size. Layouts designed for small screens
  /// will cover a range of 360-599dp.
  static const materialSmallScreenBreakpoint = 600;

  final Size size;

  final ScreenType type;

  final Orientation orientation;
}