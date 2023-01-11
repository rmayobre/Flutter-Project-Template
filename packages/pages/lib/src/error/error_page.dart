import 'package:flutter/material.dart';
import 'package:framework/page.dart';

class ErrorPageWidget extends StatelessWidget {

  static const String name = "Error";

  static const String path = "/error";

  static ErrorPage delegate = ErrorPage(
    name: ErrorPageWidget.name,
    path: ErrorPageWidget.path,
    builder: (context, error) => ErrorPageWidget(error: error),
  );

  const ErrorPageWidget({super.key, this.error});

  final Exception? error;

  @override
  Widget build(BuildContext context) {
    context.page.logger.e("Exception was called", error: error);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Error Page"),
      ),
      body: Center(
        child: Text("Error Message: $error"),
      ),
    );
  }
}