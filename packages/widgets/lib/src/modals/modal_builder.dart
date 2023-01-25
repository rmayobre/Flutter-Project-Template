import 'package:flutter/material.dart';
import 'package:widgets/constants.dart';

import '../screen.dart';
import 'modal.dart';

const int _defaultDialogOffset = 600;

const _defaultBottomSheetShape = RoundedRectangleBorder(
  borderRadius: BorderRadius.only(
    topLeft: Radius.circular(d16),
    topRight: Radius.circular(d16),
  ),
);

/// A builder function for creating [Modal] widgets.
typedef ModalBuilder = Modal Function(BuildContext context);

// /// Determines how the [showModal] function will choose to show a [BottomSheet]
// /// or a [Dialog] for the modal.
// enum ModalSelection {
//
//   /// Selects a [BottomSheet] if the platform is mobile, otherwise, use a [Dialog].
//   platform,
//
//   /// Selects a [BottomSheet] if the screen size is small or medium, otherwise,
//   /// a [Dialog] will be shown.
//   screen
// }

/// Show a modal on screen. Depending on the screen dimensions, this will show
/// either a [BottomSheet] or a [Dialog] modal.
Future<T?> showModal<T>({
  required BuildContext context,
  required ModalBuilder builder,
  int dialogHeightOffset = _defaultDialogOffset,
  int dialogWidthOffset = _defaultDialogOffset,
  ShapeBorder bottomSheetShape = _defaultBottomSheetShape,
}) {
  var screen = Screen.from(context);
  switch(screen.type) {
    case ScreenType.large:
      return showDialog(
        context: context,
        builder: (context) => Dialog(
          child: SizedBox(
            height: screen.size.height - dialogHeightOffset,
            width: screen.size.width - dialogWidthOffset,
            child: builder(context),
          ),
        ),
        //     Wrap(
        //   children: [
        //     Dialog(
        //       child: builder(context),
        //     ),
        //   ],
        // ),
      );
    default:
      return showModalBottomSheet(
        context: context,
        shape: bottomSheetShape,
        builder: builder,
      );
  }
}