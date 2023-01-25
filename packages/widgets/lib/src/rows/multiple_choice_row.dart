import 'package:flutter/material.dart';
import 'package:widgets/modals.dart';

class MultipleChoiceRow extends StatelessWidget {
  const MultipleChoiceRow({
    super.key,
    this.icon,
    required this.title,
    required this.selected,
    required this.choices
  }) : assert(choices.length > 0),
        assert(selected >= 0),
        assert(selected < choices.length);

  final IconData? icon;

  final String title;

  final int selected;

  final List<String> choices;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => showModal(context: context, builder: (context) {
        throw UnimplementedError("Build modal");
      }),
      child: throw UnimplementedError("Build modal"),
    );
  }

}