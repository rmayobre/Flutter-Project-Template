import 'log.dart';
import 'log_console.dart';
import 'log_type.dart';

/// Logging interface for the application. Tags for each log message come with a
/// default value set in the constructor of this class. Default tag value typically
/// identifies the current page of the application.
abstract class Logger {

  factory Logger({
    required String pageTag,
    required LogConsole console,
  }) => _Logger(pageTag: pageTag, console: console);

  /// Verbose level logging
  void v(String message, {
    String? tag,
    Exception? error,
    StackTrace? stack,
  });

  /// Information level logging
  void i(String message, {
    String? tag,
    Exception? error,
    StackTrace? stack,
  });

  /// Debug level logging.
  void d(String message, {
    String? tag,
    Exception? error,
    StackTrace? stack,
  });

  /// Warning level logging
  void w(String message, {
    String? tag,
    Exception? error,
    StackTrace? stack,
  });

  /// Error level logging
  void e(String message, {
    String? tag,
    Exception? error,
    StackTrace? stack,
  });
}

class _Logger implements Logger {

  const _Logger({
    required this.pageTag,
    required this.console,
  });

  final String pageTag;

  final LogConsole console;

  /// Verbose level logging
  @override
  void v(String message, {
    String? tag,
    Exception? error,
    StackTrace? stack,
  }) {
    console.output(
        Log(
          type: LogType.verbose,
          tag: tag ?? pageTag,
          message: message,
          exception: error,
          stack: stack,
        )
    );
  }

  /// Information level logging
  @override
  void i(String message, {
    String? tag,
    Exception? error,
    StackTrace? stack,
  }) {
    console.output(
        Log(
          type: LogType.info,
          tag: tag ?? pageTag,
          message: message,
          exception: error,
          stack: stack,
        )
    );
  }

  /// Debug level logging.
  @override
  void d(String message, {
    String? tag,
    Exception? error,
    StackTrace? stack,
  }) {
    console.output(
        Log(
          type: LogType.debug,
          tag: tag ?? pageTag,
          message: message,
          exception: error,
          stack: stack,
        )
    );
  }

  /// Warning level logging
  @override
  void w(String message, {
    String? tag,
    Exception? error,
    StackTrace? stack,
  }) {
    console.output(
        Log(
          type: LogType.warning,
          tag: tag ?? pageTag,
          message: message,
          exception: error,
          stack: stack,
        )
    );
  }

  /// Error level logging
  @override
  void e(String message, {
    String? tag,
    Exception? error,
    StackTrace? stack,
  }) {
    console.output(
        Log(
          type: LogType.error,
          tag: tag ?? pageTag,
          message: message,
          exception: error,
          stack: stack,
        )
    );
  }
}