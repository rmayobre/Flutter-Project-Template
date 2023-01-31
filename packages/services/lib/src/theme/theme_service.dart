import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:framework/main.dart';
import 'package:models/theme.dart';

class ThemeService extends ListenableService<ThemeEvent, ThemeMode> {

  ThemeService(super.dispatcher, {ThemeMode initialMode = ThemeMode.system})
      : model = ValueNotifier(initialMode == ThemeMode.system ? defaultTheme : initialMode);

  static ThemeMode get defaultTheme {
    return SchedulerBinding.instance.window.platformBrightness == Brightness.light
        ? ThemeMode.light
        : ThemeMode.dark;
  }

  @override
  final ValueNotifier<ThemeMode> model;

  @override
  void onEvent(ThemeEvent event) async {
    if (event is ChangeTheme) {
      model.value = event.mode == ThemeMode.system
          ? defaultTheme
          : event.mode;
    }
  }

  @override
  Future close() => Future.value(null);
}