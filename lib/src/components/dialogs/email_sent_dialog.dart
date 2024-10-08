import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:lottie/lottie.dart';

import '../buttons/custom_elevated_button.dart';
import '../constants/colors/ecopoints_colors.dart';
import '../constants/text_style/ecopoints_themes.dart';

class PasswordResetDialogForgotPasswordScreen extends StatelessWidget {
  final Function() onDialogDismiss;
  final String? title;
  final String description;
  const PasswordResetDialogForgotPasswordScreen(
      {super.key,
      required this.onDialogDismiss,
      required this.description,
      this.title});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Dialog(
      child: Container(
        height: height * 0.38,
        width: width * 0.7,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: EcoPointsColors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Lottie.asset(
                      "assets/animations/email-sent-animation.json",
                      height: height * 0.15,
                      fit: BoxFit.cover,
                    ),
                    Gap(height * 0.01),
                    Text(
                      title ?? "Email Sent!",
                      style: EcoPointsTextStyles.lightGreenTextStyle(
                        size: width * 0.05,
                        weight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Gap(height * 0.01),
                    Text(
                      description,
                      style: EcoPointsTextStyles.blackTextStyle(
                        size: width * 0.035,
                        weight: FontWeight.normal,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
            CustomElevatedButton(
              borderRadius: 50,
              backgroundColor: EcoPointsColors.darkGreen,
              width: width,
              onPressed: () {
                onDialogDismiss();
              },
              child: Text(
                "Okay",
                style: EcoPointsTextStyles.whiteTextStyle(
                  size: width * 0.037,
                  weight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
