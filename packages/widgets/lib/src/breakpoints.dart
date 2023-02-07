class BreakpointRange {
  const BreakpointRange({
    required this.min,
    required this.max,
  });

  final double min;

  final double max;

  bool inRange(double dimension) {
    return min <= dimension && dimension <= max;
  }
}

/// Width dimensional breakpoints based on Material Design 3.
class Breakpoint {

  //
  // Window Class breakpoints
  //

  static const compatWindow = BreakpointRange(min: 0.0, max: 599.0);
  static const mediumWindow = BreakpointRange(min: 600.0, max: 839.0);
  static const expandedWindow = BreakpointRange(min: 840.0, max: double.maxFinite);

  //
  // Screen size breakpoints
  //

  static const xSmall = BreakpointRange(min: 0.0, max: 599.0);
  static const small = BreakpointRange(min: 600.0, max: 904.0);

  static const medium = BreakpointRange(min: 905.0, max: 1239.0);
  static const medium2 = BreakpointRange(min: 1240.0, max: 1439.0);

  static const large = BreakpointRange(min: 1440.0, max: double.maxFinite);
}
