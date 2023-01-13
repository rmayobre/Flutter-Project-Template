library responsive_layout;

import 'package:flutter/widgets.dart';

import 'screen_state.dart';

export 'screen_state.dart';

class ResponsiveLayout extends StatelessWidget {
  const ResponsiveLayout({
    Key? key,
    this.smallScreenBreakpoint = ScreenState.materialSmallScreenBreakpoint,
    this.mediumScreenBreakpoint = ScreenState.materialMediumScreenBreakpoint,
    required this.smallChild,
    required this.mediumChild,
    required this.largeChild,
  }) : super(key: key);

  final int smallScreenBreakpoint;

  final int mediumScreenBreakpoint;
  
  final Widget smallChild;
  
  final Widget mediumChild;
  
  final Widget largeChild;

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

    // Build a ScreenState widget so other widgets can utilize the screen meta data.
    return ScreenState(
      size: query.size,
      type: screenType,
      orientation: query.orientation,
      child: _getChild(screenType),
    );
  }

  /// Determine which child will be built.
  Widget _getChild(ScreenType type) {
    switch(type) {
      case ScreenType.small:
        return smallChild;
      case ScreenType.medium:
        return mediumChild;
      case ScreenType.large:
        return largeChild;
    }
  }
}