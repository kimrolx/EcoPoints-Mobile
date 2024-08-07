import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:lottie/lottie.dart';

import '../../../../components/buttons/custom_elevated_button.dart';
import '../../../../components/constants/colors/ecopoints_colors.dart';
import '../../../../components/constants/text_style/ecopoints_themes.dart';

class GetStartedRegistrationScreen extends StatelessWidget {
  final Function() onSubmit;
  const GetStartedRegistrationScreen({super.key, required this.onSubmit});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: width * 0.045,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Join EcoPoints",
            style: EcoPointsTextStyles.blackTextStyle(
                size: width * 0.045, weight: FontWeight.w600),
          ),
          Gap(height * 0.01),
          _buildHeader(width, height),
          Gap(height * 0.02),
          _buildGetStartedButton(onSubmit, width),
        ],
      ),
    );
  }

  Widget _buildHeader(double width, double height) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: EcoPointsColors.lightGreenShade,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Lottie.asset(
            "assets/animations/join-ecopoints-animation.json",
            width: width,
            fit: BoxFit.cover,
          ),
        ),
        Gap(height * 0.01),
        Text(
          "Create an account to start earning EcoPoints and use them to redeem rewards!",
          style: EcoPointsTextStyles.blackTextStyle(
              size: width * 0.035, weight: FontWeight.normal),
        ),
      ],
    );
  }

  Widget _buildGetStartedButton(Function() onSubmit, double width) {
    return CustomElevatedButton(
      onPressed: onSubmit,
      backgroundColor: EcoPointsColors.darkGreen,
      width: width,
      padding: const EdgeInsets.all(10),
      borderRadius: 50.0,
      child: Text(
        "Get Started",
        style: EcoPointsTextStyles.whiteTextStyle(
          size: width * 0.04,
          weight: FontWeight.w500,
        ),
      ),
    );
  }
}
