import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

Widget dismissKeyboardOnTap(
    {required Widget child, required BuildContext context}) {
  return GestureDetector(
    onTap: () {
      FocusScopeNode currentFocus = FocusScope.of(context);
      if (!currentFocus.hasPrimaryFocus) {
        currentFocus.unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      }
    },
    child: child,
  );
}
