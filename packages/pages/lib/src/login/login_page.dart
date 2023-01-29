import 'package:flutter/material.dart';
import 'package:framework/page.dart';
import 'package:models/authentication.dart';

class LoginPage extends StatelessWidget {

  static const String name = 'Login';

  static const String path = '/login';

  static SinglePage delegate = SinglePage(
    name: LoginPage.name,
    path: LoginPage.path,
    builder: (context) => const LoginPage(),
  );

  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login Page'),
      ),
      body: const _LoginForm(),
    );
  }
}

class _LoginForm extends StatefulWidget {

  const _LoginForm();

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<_LoginForm> {

  String _email = '';
  String _password = '';

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: context.state<Session>(),
      builder: (context, state, child) {
        switch(state.type) {
          case StateType.empty:
            return _buildForm();
          case StateType.failed:
            return _buildForm();
          default:
            return const Center(child: CircularProgressIndicator(color: Colors.blue,),);
        }
      },
    );
  }

  Widget _buildForm() {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          const SizedBox(height: 8),
          TextField(
            onChanged: (newValue) => _email = newValue,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
              labelText: 'Email',
              helperText: 'user@email.com',
            ),
          ),
          const SizedBox(height: 8),
          TextField(
            onChanged: (newValue) => _password = newValue,
            obscureText: true,
            decoration: const InputDecoration(
              labelText: 'Password',
              helperText: '',
            ),
          ),
          const SizedBox(height: 8),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            onPressed: () {
              context.dispatch(
                AuthEvent.login(
                  email: _email,
                  password: _password,
                ),
              );
            },
            child: const Text('Login'),
          )
        ],
      ),
    );
  }
}