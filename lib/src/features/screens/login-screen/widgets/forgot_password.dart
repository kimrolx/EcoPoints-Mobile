import 'package:flutter/material.dart';

class ForgotPasswordLoginScreen extends StatelessWidget {
  final Function() onPressed;
  const ForgotPasswordLoginScreen({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        padding: EdgeInsets.zero,
        minimumSize: const Size(0, 0),
        textStyle: TextStyle(
          fontSize: width * 0.035,
          fontWeight: FontWeight.normal,
        ),
      ),
      child: const Text(
        "Forgot your password?",
      ),
    );
  }
}
