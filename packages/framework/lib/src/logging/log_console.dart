import 'log.dart';

abstract class LogConsole {

  /// Creates a filter that does not log.
  factory LogConsole.noLogs() => _NoLogsConsole();

  void output(Log log);
}

/// Does not run any logs. This can be used for environments where the application
/// should not being populating system logs (possibly production).
class _NoLogsConsole implements LogConsole {

  @override
  void output(Log _) {}
}