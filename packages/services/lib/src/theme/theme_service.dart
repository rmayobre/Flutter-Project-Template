import 'dart:async';

import 'package:flutter/material.dart';
import 'package:framework/main.dart';
import 'package:models/theme.dart';

class ThemeService extends ListenableService<ThemeEvent, ThemeMode> {

  ThemeService({ThemeMode initialMode = ThemeMode.system})
      : model = ValueNotifier(initialMode) {
    _eventController.stream.listen((event) {
      if (event is ChangeTheme) {
        model.value = event.mode;
      }
    });
  }

  final StreamController<ThemeEvent> _eventController = StreamController.broadcast();

  @override
  final ValueNotifier<ThemeMode> model;

  @override
  void emit(ThemeEvent event) {
    _eventController.add(event);
  }

  @override
  Future close() async {
    await _eventController.close();
  }

}