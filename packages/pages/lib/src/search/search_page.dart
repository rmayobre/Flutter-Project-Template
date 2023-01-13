import 'package:flutter/material.dart';

class SearchPage extends StatelessWidget {

  const SearchPage({Key? key}) : super(key: key);

  static const String name = "Search";

  static const String path = "/search";

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(name), // TODO finish Search Page example.
    );
  }
}