import 'package:flutter/material.dart';
import 'package:widgets/constants.dart';

class TextRow extends StatelessWidget {

  const TextRow({
    super.key,
    required this.title,
    this.crossAxisAlignment = CrossAxisAlignment.start,
  });

  final String title;

  final CrossAxisAlignment crossAxisAlignment;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: crossAxisAlignment,
      children: [
        Padding(
          padding: p16all,
          child: Text(title,
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