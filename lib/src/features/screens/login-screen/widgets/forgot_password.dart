import 'package:flutter/material.dart';

import '../../../../components/constants/colors/ecopoints_colors.dart';
import '../../../../components/constants/text_style/ecopoints_themes.dart';
import '../../../../components/misc/custom_circular_progress_indicator.dart';

class ForgotPasswordLoginScreen extends StatelessWidget {
  final Function() onPressed;
  final bool isLoading;
  const ForgotPasswordLoginScreen(
      {super.key, required this.onPressed, required this.isLoading});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return SizedBox(
      width: width * 0.5,
      height: height * 0.04,
      child: Center(
        child: GestureDetector(
          onTap: onPressed,
          child: isLoading
              ? const CustomCircularProgressIndicator(
                  backgroundColor: EcoPointsColors.white,
                  width: 22.5,
                  height: 22.5,
                )
              : Text("Forgot your password?",
                  style: EcoPointsTextStyles.darkGreenTextStyle(
                      size: width * 0.035, weight: FontWeight.normal)),
        ),
      ),
    );
  }
}
