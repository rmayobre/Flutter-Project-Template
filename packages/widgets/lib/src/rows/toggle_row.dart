import 'package:flutter/material.dart';
import 'package:widgets/constants.dart';

typedef OnToggleCallback = void Function(bool value);

class ToggleRow extends StatelessWidget {
  
  const ToggleRow({
    super.key,
    this.icon,
    this.isActive = false,
    this.onToggle,
    this.subTitle,
    required this.title,
  });
  
  final IconData? icon;
  
  final String title;
  
  final String? subTitle;
  
  final bool isActive;
  
  final OnToggleCallback? onToggle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: p16all,
      child: Row(
        children: [
          if (icon != null) _buildIcon(icon!),
          _buildTextBody(),
          _buildSwitch()
        ],
      ),
    );
  }

  Widget _buildIcon(IconData data) {
    return Padding(
      padding: p16right,
      child: Icon(data),
    );
  }

  Widget _buildTextBody() {
    var sub = subTitle;
    if (sub != null) {
      return Column(
        children: [
          Text(title),
          Text(sub)
        ],
      );
    }
    return Text(title);
  }

  Widget _buildSwitch() {
    ValueNotifier<bool> switchNotifier = ValueNotifier(isActive);
    return Expanded(
      flex: 1,
      child: Container(
        alignment: Alignment.centerRight,
        child: ValueListenableBuilder(
          valueListenable: switchNotifier,
          builder: (BuildContext context, value, Widget? child) => Switch(
            value: value,
            onChanged: (newValue) {
              switchNotifier.value = newValue;
              onToggle?.call(newValue);
            },
          ),
        ),
      ),
    );
  }
}