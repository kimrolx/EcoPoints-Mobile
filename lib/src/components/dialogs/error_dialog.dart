import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:lottie/lottie.dart';

import '../buttons/custom_elevated_button.dart';
import '../constants/colors/ecopoints_colors.dart';
import '../constants/text_style/ecopoints_themes.dart';

class ErrorDialog extends StatelessWidget {
  const ErrorDialog({super.key});

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
                      "assets/animations/sad-star-animation.json",
                      height: height * 0.15,
                      fit: BoxFit.cover,
                    ),
                    Gap(height * 0.01),
                    Text(
                      "Oh no!",
                      style: EcoPointsTextStyles.redTextStyle(
                        size: width * 0.05,
                        weight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Gap(height * 0.002),
                    Text(
                      "Something went wrong. Try again later or contact support.",
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
                Navigator.pop(context);
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
