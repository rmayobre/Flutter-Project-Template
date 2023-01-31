import 'package:flutter/material.dart';
import 'package:widgets/rows.dart';

typedef OnToggleCallback = void Function(bool value);

class ToggleRow extends StatelessWidget {
  
  const ToggleRow(this.initialState, {
    super.key, 
    this.icon, 
    required this.title,
    this.subTitle,
    required this.onToggle,
  });
  
  final IconData? icon;

  final String title;

  final String? subTitle;

  final bool initialState;

  final OnToggleCallback onToggle;

  @override
  Widget build(BuildContext context) {
    var state = initialState;
    return DetailedRow(
      leading: Icon(icon),
      title: title,
      subTitle: subTitle,
      trailing: StatefulBuilder(
        builder: (context, setState) {
          return Switch.adaptive(
            value: state,
            onChanged: (isToggled) => setState(() {
              state = isToggled;
              onToggle(isToggled);
            }),
          );
        },
      ),
    );
  }
}