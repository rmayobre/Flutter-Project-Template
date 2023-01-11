import 'dart:async';

import 'package:framework/authentication.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthRepository implements AuthenticationRepository {

  FirebaseAuthRepository._(this._auth) {
    _auth.authStateChanges().listen(_onStateChange);
  }

  FirebaseAuthRepository({FirebaseAuth? firebaseAuth})
      : this._(firebaseAuth ?? FirebaseAuth.instance);

  final FirebaseAuth _auth;

  StreamController<Session?> _controller = StreamController();

  @override
  final StateMutable<Session> state = StateNotifier(initialState: StateType.empty);
  
  @override
  Stream<Session?> get stream =>_controller.stream.asBroadcastStream();

  @override
  Future<Session?> login({
    required String email,
    required String password,
  }) async {
    if (_controller.isClosed) {
      _controller = StreamController();
      _auth.authStateChanges().listen(_onStateChange);
    }
    try {
      final userCredential = await _auth.signInWithEmailAndPassword(email: email, password: password);
      return userCredential.session;
    } on FirebaseAuthException catch (exception) {
      throw AuthenticationException.cause(exception);
    }
  }

  @override
  Future logout() => _auth.signOut();

  @override
  Future close() async {
    await _auth.signOut();
    _controller.close();
  }

  void _onStateChange(User? user) => _controller.add(user?.session);
}

extension on UserCredential {
  Session? get session => user?.session;
}

extension on User {
  Session get session => Session(id: uid, email: email, name: displayName);
}