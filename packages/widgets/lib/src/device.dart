import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'screen_size.dart';
import 'window.dart';

@immutable
class Device {

  const Device._({
    required this.height,
    required this.width,
    required this.size,
    required this.window,
    required this.orientation,
    required TargetPlatform platform,
  }) : isApple = platform == TargetPlatform.macOS || platform == TargetPlatform.iOS;

  factory Device.from(BuildContext context) {
    // Collect Screen dimensions and determine screen type.
    var query = MediaQuery.of(context);
    return Device._(
      height: query.size.height,
      width: query.size.width,
      size: ScreenSize.from(query.size),
      window: Window.from(query.size),
      orientation: query.orientation,
      platform: defaultTargetPlatform,
    );
  }

  final bool isApple;
  final bool isWeb = kIsWeb;
  final double height;
  final double width;
  final Window window;
  final ScreenSize size;
  final Orientation orientation;
}