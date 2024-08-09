import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

import '../../../../components/buttons/custom_elevated_button.dart';
import '../../../../components/constants/colors/ecopoints_colors.dart';
import '../../../../components/constants/text_style/ecopoints_themes.dart';

class ContinueWithGoogleButtonLoginScreen extends StatelessWidget {
  final Function() onPressed;
  const ContinueWithGoogleButtonLoginScreen(
      {super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return CustomElevatedButton(
      onPressed: onPressed,
      backgroundColor: EcoPointsColors.lightGray,
      width: width,
      borderRadius: 50.0,
      padding: const EdgeInsets.all(4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            "assets/icons/google-icon.svg",
            width: width * 0.032,
            height: height * 0.032,
          ),
          Gap(width * 0.02),
          Text(
            "Continue with Google",
            style: EcoPointsTextStyles.blackTextStyle(
              size: width * 0.037,
              weight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
