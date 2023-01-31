import 'package:flutter/material.dart';
import 'package:widgets/constants.dart';

class TextRow extends StatelessWidget {

  const TextRow(this.text, {
    super.key,
    this.crossAxisAlignment = CrossAxisAlignment.start,
  });

  final String text;

  final CrossAxisAlignment crossAxisAlignment;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: crossAxisAlignment,
      children: [
        Padding(
          padding: p16all,
          child: Text(text,
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
        const Divider(
          height: d2,
          indent: d18,
          endIndent: d18,
        ),
      ],
    );
  }
}