import 'session.dart';

abstract class Authenticator {
  
  static const repoKey = "AUTHENTICATION";

  /// Log into session.
  ///
  /// Throws [AuthenticationException] whenever authentication failed.
  Future<Session?> login({
    required String email,
    required String password
  });

  Future logout();
}