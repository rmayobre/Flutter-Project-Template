import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

abstract class StageSetWidget extends StatelessWidget {

  StageSetWidget({Key? key, int startIndex = 0})
      : _indexNotifier = ValueNotifier(startIndex),
        super(key: key);

  final ValueNotifier<int> _indexNotifier;

  @protected
  ValueListenable<int> get index => _indexNotifier;

  void changeIndex(int index) {
    _indexNotifier.value = index;
  }
}
