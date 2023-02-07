import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

/// Breakpoint screen size for medium size widgets. Medium screen sizes cover
/// a range of 600-839dp.
const _mediumBreakpoint = 840;

/// The breakpoint for a small screen size. Layouts designed for small screens
/// will cover a range of 0-599dp.
const _smallBreakpoint = 600;

enum ScreenType {
  small,
  medium,
  large;
}

@immutable
class Device {

  const Device._({
    required this.size,
    required this.type,
    required this.orientation,
    required TargetPlatform platform,
  }) : isApple = platform == TargetPlatform.macOS || platform == TargetPlatform.iOS;

  factory Device.from(BuildContext context) {
    // Collect Screen dimensions and determine screen type.
    var query = MediaQuery.of(context);
    ScreenType screenSize;
    if (query.size.width < _smallBreakpoint) {
      screenSize = ScreenType.small;
    } else if (query.size.width < _mediumBreakpoint) {
      screenSize = ScreenType.medium;
    } else {
      screenSize = ScreenType.large;
    }
    return Device._(
      size: query.size,
      type: screenSize,
      orientation: query.orientation,
      platform: defaultTargetPlatform,
    );
  }

  final Size size;
  final ScreenType type;
  final Orientation orientation;
  final bool isApple;
  final bool isWeb = kIsWeb;
}