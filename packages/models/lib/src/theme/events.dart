import 'package:flutter/material.dart';

abstract class ThemeEvent {

  factory ThemeEvent.change({required ThemeMode mode}) => ChangeTheme(mode);
}

class ChangeTheme implements ThemeEvent {
  
  const ChangeTheme(this.mode);
  
  final ThemeMode mode;
}