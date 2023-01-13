import 'package:flutter/material.dart';

class AccountPage extends StatelessWidget {

  const AccountPage({Key? key}) : super(key: key);

  static const String name = "Account";

  static const String path = "/account";

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(name),  // TODO finish Account Page example.
    );
  }
}