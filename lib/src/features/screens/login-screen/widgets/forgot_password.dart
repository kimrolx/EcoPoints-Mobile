import 'package:flutter/material.dart';

import '../../../../components/constants/colors/ecopoints_colors.dart';
import '../../../../components/misc/custom_circular_progress_indicator.dart';

class ForgotPasswordLoginScreen extends StatelessWidget {
  final Function() onPressed;
  final bool isLoading;
  const ForgotPasswordLoginScreen(
      {super.key, required this.onPressed, required this.isLoading});

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
      child: isLoading
          ? const CustomCircularProgressIndicator(
              backgroundColor: EcoPointsColors.white, width: 22.5, height: 22.5)
          : const Text(
              "Forgot your password?",
            ),
    );
  }
}
