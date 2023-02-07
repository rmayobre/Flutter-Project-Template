import 'package:flutter/material.dart';

import '../device.dart';
import '../window.dart';

/// A [Widget] designed to prevent interaction with the rest of the screen while
/// this [Widget] is being displayed on screen. This is typically paired with a
/// call to the [showModalBottomSheet] or [showDialog] function calls.
abstract class Modal extends StatelessWidget {

  const Modal({super.key});

  @protected
  Widget buildModalLayout(BuildContext context);

  @override
  Widget build(BuildContext context) {
    var device = Device.from(context);
    switch(device.window) {
      case Window.expanded:
        return Dialog(
          child: buildModalLayout(context),
        );
      default:
        return buildModalLayout(context);
    }
  }
}