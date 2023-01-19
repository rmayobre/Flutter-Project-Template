abstract class AuthEvent {

  const AuthEvent._();

  factory AuthEvent.login({
    required String email,
    required String password,
  }) {
    assert(email.isNotEmpty);
    assert(password.isNotEmpty);
    return Login(email, password);
  }

  factory AuthEvent.logout() {
    return Logout();
  }
}

class Login implements AuthEvent {

  const Login(this.email, this.password);

  final String email;

  final String password;
}

class Logout implements AuthEvent {}