import 'dart:async';
import 'dart:math';

import 'package:framework/src/authentication/session.dart';
import 'package:framework/src/repository/repository.dart';
import 'package:framework/src/repository/state_listenable.dart';
import 'package:framework/src/repository/state_mutable.dart';

import 'authenticator.dart';

/// An object that helps update the authenticated status of the user.
abstract class AuthenticationRepository implements Authenticator,
    StreamRepository<Session?>,
    StatefulRepository<Session> {

  factory AuthenticationRepository.offline({
    int authDelay = 0,
    String? sessionId,
  }) {
    Session? session;
    StateType type = StateType.empty;
    if (sessionId != null) {
      session = Session(id: sessionId);
      type = StateType.loaded;
    }
    return _OfflineAuthenticationRepository(
        authDelay: authDelay,
        state: StateNotifier(
          initialState: type,
          value: session,
        )
    );
  }
}

class _OfflineAuthenticationRepository implements AuthenticationRepository {

  _OfflineAuthenticationRepository({
    required this.authDelay,
    required this.state,
  });

  StreamController<Session?> _controller = StreamController();

  /// Delay in seconds.
  final int authDelay;

  @override
  final StateMutable<Session> state;

  @override
  Stream<Session?> get stream => _controller.stream.asBroadcastStream();

  @override
  Future<Session?> login({required String email, required String password}) {
    state.loading();
    if (email.isEmpty || password.isEmpty) {
      return Future.delayed(Duration(seconds: authDelay), () {
        state.empty();
        _controller.add(null);
        return null;
      });
    }
    if (_controller.isClosed) {
      _controller = StreamController();
    }
    final session = Session(
        id: Random.secure().nextInt(99999999).toString(),
        email: email
    );
    return Future.delayed(Duration(seconds: authDelay), () {
      state.loaded(session);
      _controller.add(session);
      return session;
    });
  }

  @override
  Future close() async {
    return Future.delayed(Duration(seconds: authDelay), () async {
      state.empty();
      _controller.add(null);
      await _controller.close();
    });
  }

  @override
  Future logout() async {
    return Future.delayed(Duration(seconds: authDelay), () {
      state.empty();
      _controller.add(null);
    });
  }
}