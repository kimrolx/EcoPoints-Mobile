import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../components/constants/colors/ecopoints_colors.dart';

class ForgotPasswordScreen extends StatelessWidget {
  static const String route = '/forgotpassword';
  static const String path = "/forgotpassword";
  static const String name = "Forgotten Password Screen";
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: EcoPointsColors.white,
      body: SafeArea(
        child: IconButton(
          icon: const Icon(CupertinoIcons.back),
          onPressed: () {
            context.pop();
          },
        ),
      ),
    );
  }
}
