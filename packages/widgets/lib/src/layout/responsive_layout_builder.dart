import 'package:flutter/widgets.dart';
import 'package:widgets/screen.dart';

typedef ResponsiveWidgetBuilder = Widget Function(BuildContext context, Screen screen);

class ResponsiveLayoutBuilder extends StatelessWidget {
  const ResponsiveLayoutBuilder({
    Key? key,
    this.mobileBreakpoint = Screen.materialMobileBreakpoint,
    this.tabletBreakpoint = Screen.materialTabletBreakpoint,
    required this.builder,
  }) : super(key: key);

  final ResponsiveWidgetBuilder builder;

  final int mobileBreakpoint;

  final int tabletBreakpoint;

  @override
  Widget build(BuildContext context) {
    Screen screen = Screen.from(
      query: MediaQuery.of(context),
      mobileBreakpoint: mobileBreakpoint,
      tabletBreakpoint: tabletBreakpoint,
    );
    return ScreenProvider(
      screen: screen,
      child: builder(context, screen),
    );
  }
}