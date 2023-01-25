import 'package:flutter/material.dart';
import 'package:widgets/modals.dart';

class InputFieldModel extends Modal {

  const InputFieldModel({super.key});

  @override
  Widget buildModalLayout(BuildContext context) {
    return const SizedBox(
      height: 300,
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Center(
          child: Text(
            'This is an incomplete modal!',
            style: TextStyle(
              fontSize: 48,
            ),
          ),
        ),
      ),
    );
  }
}