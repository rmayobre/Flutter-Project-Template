import 'package:flutter/material.dart';
import 'package:widgets/constants.dart';

class ElevatedCard extends StatelessWidget {

  const ElevatedCard({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).colorScheme.surface,
      child: Padding(
        padding: p16all,
        child: child,
      ),
    );
  }
}