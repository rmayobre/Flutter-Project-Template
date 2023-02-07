import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:framework/repositories.dart';
import 'package:models/authentication.dart';

class FirebaseAuthService extends StatefulRepository<AuthEvent, Session> {
  FirebaseAuthService(super.dispatcher) : _auth = FirebaseAuth.instance {
    _auth.authStateChanges().listen(_onStateChange);
  }

  final FirebaseAuth _auth;

  @override
  final StateMutable<Session> model = StateNotifier.empty();

  @override
  void onEvent(AuthEvent event) async {
    if (event is Login) {
      await _login(
        email: event.email,
        password: event.password,
      );
    } else if (event is Logout) {
      await _auth.signOut();
    }
  }

  @override
  Future close() async {
    await _auth.signOut();
  }

  void _onStateChange(User? user) {
    if (user != null) {
      model.loaded(
        Session(
          id: user.uid,
          email: user.email,
          name: user.displayName,
        ),
      );
    } else {
      model.empty();
    }
  }

  Future<void> _login({
    required String email,
    required String password,
  }) async {
    if (email.isEmpty || password.isEmpty) {
      model.failed(const AuthenticationException.message(
          'Username or password is empty.'));
      return;
    }
    model.loading();
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (exception) {
      model.failed(exception);
    }
  }
}
