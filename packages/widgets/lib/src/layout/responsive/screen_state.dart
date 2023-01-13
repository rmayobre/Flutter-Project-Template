import 'package:flutter/widgets.dart';

enum ScreenType { small, medium, large }

class ScreenState extends InheritedWidget{

  const ScreenState({
    super.key,
    required this.size,
    required this.type,
    required this.orientation,
    required super.child,
  });

  /// Breakpoint screen size for medium size widgets. Medium widgets cover a range of 600-1239dp.
  static const materialMediumScreenBreakpoint = 1240;

  /// The breakpoint for a small screen size. Layouts designed for small screens
  /// will cover a range of 360-599dp.
  static const materialSmallScreenBreakpoint = 600;

  static ScreenState of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType()!;
  }


  final Size size;

  final ScreenType type;

  final Orientation orientation;

  @override
  bool updateShouldNotify(covariant ScreenState oldWidget) {
    return oldWidget.type != type
        || oldWidget.orientation != orientation
        || oldWidget.size != size;
  }

}

extension ScreenExtension on BuildContext {

  ScreenState get screen => ScreenState.of(this);
}