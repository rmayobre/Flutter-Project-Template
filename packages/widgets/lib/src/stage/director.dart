import 'package:flutter/widgets.dart';

abstract class Director {

  static Director of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<DirectorWidget>()!;
  }

}

class DirectorWidget extends InheritedWidget implements Director {

  const DirectorWidget({
    Key? key,
    required Widget child
  }) : super(key: key, child: child);

  @override
  bool updateShouldNotify(covariant DirectorWidget oldWidget) {
    return oldWidget != this;
  }
}