import 'package:flutter/material.dart';
import 'package:framework/page.dart';
import 'package:pages/src/home/home_page.dart';

class LoginPage extends StatelessWidget {

  static const String name = "Login";

  static const String path = "/login";

  static SinglePage delegate = SinglePage(
    name: LoginPage.name,
    path: LoginPage.path,
    builder: (context) => LoginPage(),
  );

  LoginPage({super.key});
  
  final ValueNotifier<String> _emailNotifier = ValueNotifier("");
  final ValueNotifier<String> _passwordNotifier = ValueNotifier("");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login Page"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const SizedBox(height: 8),
            ValueListenableBuilder(
                valueListenable: _emailNotifier, 
                builder: (context, email, child) {
                  return TextField(
                    onChanged: (newValue) => _emailNotifier.value = newValue,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      labelText: "Email",
                      helperText: "user@email.com",
                    ),
                  );
                }
            ),
            const SizedBox(height: 8),
            ValueListenableBuilder(
                valueListenable: _passwordNotifier,
                builder: (context, password, child) {
                  return TextField(
                    onChanged: (newValue) => _passwordNotifier.value = newValue,
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: "Password",
                      helperText: "",
                    ),
                  );
                }
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () {
                context.app.authRepo.login(
                  email: _emailNotifier.value,
                  password: _passwordNotifier.value,
                ).then((value) => context.to(HomePage.name));
              },
              child: const Text("Login"),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.page.logger.i("Logging in...");
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}