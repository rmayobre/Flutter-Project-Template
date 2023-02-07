import 'package:flutter/material.dart';

extension TextStyles on BuildContext {

  TextStyle? get displayLargeStyle => Theme.of(this).textTheme.displayLarge;
  TextStyle? get displayMediumStyle => Theme.of(this).textTheme.displayMedium;
  TextStyle? get displaySmallStyle => Theme.of(this).textTheme.displaySmall;

  TextStyle? get headlineLargeStyle => Theme.of(this).textTheme.headlineLarge;
  TextStyle? get headlineMediumStyle => Theme.of(this).textTheme.headlineMedium;
  TextStyle? get headlineSmallStyle => Theme.of(this).textTheme.headlineSmall;

  TextStyle? get titleLargeStyle => Theme.of(this).textTheme.titleLarge;
  TextStyle? get titleMediumStyle => Theme.of(this).textTheme.titleMedium;
  TextStyle? get titleSmallStyle => Theme.of(this).textTheme.titleSmall;

  TextStyle? get labelLargeStyle => Theme.of(this).textTheme.labelLarge;
  TextStyle? get labelMediumStyle => Theme.of(this).textTheme.labelMedium;
  TextStyle? get labelSmallStyle => Theme.of(this).textTheme.labelSmall;

  TextStyle? get bodyLargeStyle => Theme.of(this).textTheme.bodyLarge;
  TextStyle? get bodyMediumStyle => Theme.of(this).textTheme.bodyMedium;
  TextStyle? get bodySmallStyle => Theme.of(this).textTheme.bodySmall;
}