import 'dart:async';
import 'dart:math';

import 'package:framework/services.dart';
import 'package:models/authentication.dart';

class OfflineAuthService extends StatefulService<AuthEvent, Session> {

  OfflineAuthService(super.dispatcher, {
    int authDelay = 0,
    String? sessionId,
  }) : _authDelay = authDelay,
        model = sessionId != null
            ? StateNotifier.loaded(Session(id: sessionId))
            : StateNotifier.empty();

  /// Delay in seconds.
  final int _authDelay;

  @override
  final StateMutable<Session> model;

  @override
  void onEvent(AuthEvent event) async {
    if (event is Login) {
      await _login(email: event.email, password: event.password);
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

  Future _login({required String email, required String password}) async {
    if (email.isEmpty || password.isEmpty) {
      model.failed(const AuthenticationException.message('Email or password was null.'));
      return;
    }
    model.loading();
    final session = Session(
      id: Random.secure().nextInt(99999999).toString(),
      email: email,
    );
    await Future.delayed(Duration(seconds: _authDelay), () {
      model.loaded(session);
    });
  }

  void _logout() {
    model.empty();
  }
}