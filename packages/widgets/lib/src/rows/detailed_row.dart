import 'package:flutter/material.dart';
import 'package:widgets/constants.dart';

typedef OnTapCallback = void Function();

class DetailedRow extends StatelessWidget {
  const DetailedRow({
    super.key,
    required this.title,
    this.subTitle,
    this.leading,
    this.trailing,
    this.onTap,
  });

  final String title;

  final String? subTitle;

  final Widget? leading;

  final Widget? trailing;

  final OnTapCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return onTap != null
        ? InkWell(onTap: onTap, child: _buildPadding(context))
        : _buildPadding(context);
  }

  Widget _buildPadding(BuildContext context) {
    return Padding(padding: p16all, child: _buildRow(context));
  }

  Widget _buildRow(BuildContext context) {
    if (leading != null || trailing != null) {
      return Row(
        children: [
          if (leading != null) Padding(
            padding: p16right,
            child: leading,
          ),
          Expanded(flex: 1, child: _buildText(context)),
          if (trailing != null) Padding(
            padding: p16left,
            child: trailing,
          ),
        ],
      );
    } else {
      return _buildText(context);
    }
  }

  Widget _buildText(BuildContext context) {
    var sub = subTitle;
    if (sub != null) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: Theme.of(context).textTheme.labelLarge),
          Text(sub, style: Theme.of(context).textTheme.labelSmall),
        ],
      );
    } else {
      return Text(title, style: Theme.of(context).textTheme.labelLarge);
    }
  }
}