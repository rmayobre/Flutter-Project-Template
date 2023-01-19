import 'dart:async';

import 'package:framework/service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:models/authentication.dart';

class FirebaseAuthService extends StatefulService<AuthEvent, Session> {

  FirebaseAuthService() : _auth = FirebaseAuth.instance {
    _auth.authStateChanges().listen(_onStateChange);
  }

  final FirebaseAuth _auth;

  @override
  final StateMutable<Session> model = StateNotifier(initialState: StateType.empty);

  @override
  void emit(AuthEvent event) {
    if (event is Login) {
      _login(
        email: event.email,
        password: event.password,
      );
    } else if (event is Logout) {
      _auth.signOut();
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

  void _login({
    required String email,
    required String password,
  }) {
    if (email.isEmpty || password.isEmpty) {
      model.failed(const AuthenticationException.message('Username or password is empty.'));
      return;
    }
    model.loading();
    try {
      _auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (exception) {
      model.failed(exception);
    }
  }
}