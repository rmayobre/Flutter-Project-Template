import 'package:flutter/material.dart';
import 'package:framework/page.dart';
import 'package:pages/src/home/home_layout.dart';

class LoginPage extends StatelessWidget {

  static const String name = "Login";

  static const String path = "/login";

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
        title: const Text("Login Page"),
      ),
      body: _LoginForm(),
    );
  }
}

class _LoginForm extends StatefulWidget {

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<_LoginForm> {

  String _username = "";
  String _password = "";

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          const SizedBox(height: 8),
          TextField(
            onChanged: (newValue) => _username = newValue,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
              labelText: "Email",
              helperText: "user@email.com",
            ),
          ),
          const SizedBox(height: 8),
          TextField(
            onChanged: (newValue) => _password = newValue,
            obscureText: true,
            decoration: const InputDecoration(
              labelText: "Password",
              helperText: "",
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
              context.app.authenticator.login(
                email: _username,
                password: _password,
              ).then((value) {
                if (value != null) {
                  context.to(HomePage.name);
                }
              });
            },
            child: const Text("Login"),
          )
        ],
      ),
    );
  }
}