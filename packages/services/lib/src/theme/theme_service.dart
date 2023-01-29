import 'dart:async';

import 'package:flutter/material.dart';
import 'package:framework/main.dart';
import 'package:models/theme.dart';

class ThemeService extends ListenableService<ThemeEvent, ThemeMode> {

  ThemeService(super.dispatcher, {ThemeMode initialMode = ThemeMode.system})
      : model = ValueNotifier(initialMode);

  @override
  final ValueNotifier<ThemeMode> model;

  @override
  void onEvent(ThemeEvent event) async {
    if (event is ChangeTheme) {
      model.value = event.mode;
    }
  }

  @override
  Future close() => Future.value(null);
}