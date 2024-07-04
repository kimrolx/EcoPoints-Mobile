import 'package:flutter/material.dart';

class BottomSheetProvider extends InheritedWidget {
  final void Function(BuildContext context) showBottomSheet;

  const BottomSheetProvider({
    super.key,
    required super.child,
    required this.showBottomSheet,
  });

  static BottomSheetProvider? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<BottomSheetProvider>();
  }

  @override
  bool updateShouldNotify(BottomSheetProvider oldWidget) {
    return showBottomSheet != oldWidget.showBottomSheet;
  }
}
