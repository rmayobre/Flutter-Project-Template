import 'dart:async';
import 'dart:math';

import 'package:framework/service.dart';
import 'package:models/authentication.dart';

class OfflineAuthService extends StatefulService<AuthEvent, Session> {

  OfflineAuthService({
    int authDelay = 0,
    String? sessionId,
  }) : _authDelay = authDelay,
        model = sessionId != null
            ? StateNotifier(initialState: StateType.loaded, value: Session(id: sessionId),)
            : StateNotifier(initialState: StateType.empty);

  /// Delay in seconds.
  final int _authDelay;

  @override
  final StateMutable<Session> model;
  
  @override
  void emit(AuthEvent event) {
    if (event is Login) {
      _login(email: event.email, password: event.password);
    } else if (event is Logout) {
      _logout();
    }
  }
  
  @override
  Future close() {
    return Future.delayed(Duration(seconds: _authDelay), () {
      model.empty();
    });
  }

  void _login({required String email, required String password}) {
    if (email.isEmpty || password.isEmpty) {
      model.failed(const AuthenticationException.message('Email or password was null.'));
      return;
    }
    model.loading();
    final session = Session(
      id: Random.secure().nextInt(99999999).toString(),
      email: email,
    );
    Future.delayed(Duration(seconds: _authDelay), () {
      model.loaded(session);
    });
  }

  void _logout() {
    Future.delayed(Duration(seconds: _authDelay), () {
      model.empty();
    });
  }
}