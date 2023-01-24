import 'package:flutter/widgets.dart';

import 'log_type.dart';

@immutable
class Log {

  const Log({
    required this.type,
    required this.tag,
    required this.message,
    this.exception,
    this.stack,
  });

  final LogType type;

  final String tag;

  final String message;

  final Exception? exception;
  
  final StackTrace? stack;
}