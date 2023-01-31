import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

enum ScreenSize {
  small,
  medium,
  large;
}

@immutable
class Device {

  const Device({
    this.isWeb = kIsWeb,
    required this.size,
    required this.orientation,
    required TargetPlatform platform,
  }) : isApple = platform == TargetPlatform.macOS || platform == TargetPlatform.iOS,
        isMobile = platform == TargetPlatform.iOS || platform == TargetPlatform.android;

  factory Device.from(BuildContext context, {
    int smallScreenBreakpoint = _materialSmallScreenBreakpoint,
    int mediumScreenBreakpoint = _materialMediumScreenBreakpoint,
  }) {
    // Collect Screen dimensions and determine screen type.
    var query = MediaQuery.of(context);
    ScreenSize screenSize;
    if (query.size.width < smallScreenBreakpoint) {
      screenSize = ScreenSize.small;
    } else if (query.size.width < mediumScreenBreakpoint) {
      screenSize = ScreenSize.medium;
    } else {
      screenSize = ScreenSize.large;
    }
    return Device(
      size: screenSize,
      orientation: query.orientation,
      platform: defaultTargetPlatform,
    );
  }

  /// Breakpoint screen size for medium size widgets. Medium widgets cover a range of 600-1239dp.
  static const _materialMediumScreenBreakpoint = 1240;

  /// The breakpoint for a small screen size. Layouts designed for small screens
  /// will cover a range of 360-599dp.
  static const _materialSmallScreenBreakpoint = 600;

  final ScreenSize size;

  final Orientation orientation;
  
  final bool isApple;
  
  final bool isMobile;

  final bool isWeb;
}