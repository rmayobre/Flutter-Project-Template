import 'package:flutter/material.dart';
import 'package:framework/page.dart';
import 'package:models/authentication.dart';
import 'package:pages/src/home/home_layout.dart';

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
    var state = context.state<Session>();
    if (state?.type == StateType.loaded) {
      context.to(OverviewPage.name);
      return Container(); // Blank widget for page transitions.
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login Page'),
      ),
      body: state?.type == StateType.loading
          ? const Center(child: CircularProgressIndicator(color: Colors.blue,),)
          : _LoginForm(),
    );
  }
}

class _LoginForm extends StatefulWidget {

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<_LoginForm> {

  String _email = '';
  String _password = '';

  @override
  Widget build(BuildContext context) {
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
              context.emit(
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