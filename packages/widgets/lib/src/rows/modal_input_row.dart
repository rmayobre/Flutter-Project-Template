import 'package:flutter/material.dart';
import 'package:widgets/constants.dart';
import 'package:widgets/modals.dart';

class ModalInputRow extends StatelessWidget {
  
  const ModalInputRow({
    super.key,
    this.icon,
    this.value,
    required this.builder,
    required this.title,
  });

  final IconData? icon;
  
  final String? value;

  final String title;
  
  final ModalBuilder builder;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => showModal(context: context, builder: builder),
      child: Padding(
        padding: p16all,
        child: Row(
          children: [
            if (icon != null) _buildIcon(icon!),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                  style: const TextStyle(
                    fontSize: d12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(value ?? ""),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIcon(IconData data) {
    return Padding(
      padding: p16right,
      child: Icon(data),
    );
  }
}