import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';

import '../../../../components/buttons/custom_elevated_button.dart';
import '../../../../components/constants/colors/ecopoints_colors.dart';
import '../../../../components/constants/text_style/ecopoints_themes.dart';

class InsufficientPointsDialogRewardDetailsScreen extends StatelessWidget {
  const InsufficientPointsDialogRewardDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Dialog(
      child: Container(
        height: height * 0.4,
        width: width * 0.8,
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
                    const Gap(10),
                    Text(
                      "Oh no!",
                      style: EcoPointsTextStyles.redTextStyle(
                        size: width * 0.05,
                        weight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const Gap(5),
                    Text(
                      "You don't have enough Eco Points to redeem this reward.",
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
                context.pop();
              },
              child: Text(
                "Okay",
                style: EcoPointsTextStyles.whiteTextStyle(
                  size: width * 0.04,
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
