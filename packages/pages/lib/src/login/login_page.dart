import 'package:flutter/material.dart';
import 'package:framework/page.dart';
import 'package:pages/src/home/home_layout.dart';

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
            TextField(
              onChanged: (newValue) => _emailNotifier.value = newValue,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                labelText: "Email",
                helperText: "user@email.com",
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              onChanged: (newValue) => _passwordNotifier.value = newValue,
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
                  email: _emailNotifier.value,
                  password: _passwordNotifier.value,
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

// class _AppBar extends StatelessWidget implements PreferredSizeWidget {
//   @override
//   Widget build(BuildContext context
//       ) {
//     // TODO: implement build
//     throw UnimplementedError();
//   }
//
//   @override
//   // TODO: implement preferredSize
//   Size get preferredSize => Size();
//
// }