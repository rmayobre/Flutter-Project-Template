import 'package:flutter/material.dart';
import 'package:widgets/layouts.dart';


class SettingsPage extends StatelessWidget {

  const SettingsPage({Key? key}) : super(key: key);

  static const String name = "Settings";

  static const String path = "/settings";

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(name),  // TODO finish Settings Page example.
    );
  }
}