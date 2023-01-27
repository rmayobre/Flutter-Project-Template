import 'package:flutter/material.dart';
import 'package:widgets/constants.dart';

class OutlinedCard extends StatelessWidget {

  const OutlinedCard({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: Theme.of(context).colorScheme.outline,
        ),
        borderRadius: const BorderRadius.all(Radius.circular(12)),
      ),
      child: Padding(
        padding: p16all,
        child: child,
      ),
    );
  }
}