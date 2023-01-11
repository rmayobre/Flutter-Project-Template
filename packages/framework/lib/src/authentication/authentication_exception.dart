const _defaultExceptionMessage = "There was an unknown authentication related issue.";

class AuthenticationException implements Exception {

  const AuthenticationException._({
    this.message,
    this.cause,
  });

  const AuthenticationException({
    required String message,
    required Exception cause,
  }) : this._(message: message, cause: cause);

  const AuthenticationException.message(String message)
      : this._(message: message);

  const AuthenticationException.cause(Exception exception)
      : this._(cause: exception);

  final String? message;

  final Exception? cause;

  @override
  String toString() {
    String? message = this.message;
    Exception? cause = this.cause;
    if (message != null) {
      if (cause != null) {
        return "Message: $message\nCause: $cause";
      }
      return "Message: $message";
    } else if (cause != null) {
      return "Cause: $cause";
    }
    return _defaultExceptionMessage;
  }
}