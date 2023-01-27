import 'package:flutter/material.dart';
import 'package:widgets/constants.dart';

class FilledCard extends StatelessWidget {

  const FilledCard({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Theme.of(context).colorScheme.surfaceVariant,
      child: Padding(
        padding: p16all,
        child: child,
      ),
    );
  }
}