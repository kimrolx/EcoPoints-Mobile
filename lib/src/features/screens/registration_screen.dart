import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

import '../../components/buttons/custom_elevated_button.dart';
import '../../components/constants/colors/ecopoints_colors.dart';
import '../../components/constants/text_style/ecopoints_themes.dart';

class RegistrationScreen extends StatelessWidget {
  static const String route = '/register';
  static const String path = "/register";
  static const String name = "Register Screen";
  const RegistrationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IconButton(
              onPressed: Navigator.of(context).pop,
              icon: const Icon(CupertinoIcons.back),
            ),
            Gap(height * 0.05),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                ShaderMask(
                  shaderCallback: (bounds) {
                    return const LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        EcoPointsColors.darkGreen,
                        EcoPointsColors.lightGreen,
                      ],
                    ).createShader(bounds);
                  },
                  child: Text(
                    "Eco",
                    style: EcoPointsTextStyles.whiteSuezOneTextStyle(
                      size: width * 0.1,
                      weight: FontWeight.normal,
                    ),
                  ),
                ),
                ShaderMask(
                  shaderCallback: (bounds) {
                    return const LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        EcoPointsColors.darkBlue,
                        EcoPointsColors.lightBlue,
                      ],
                    ).createShader(bounds);
                  },
                  child: Text(
                    "Points",
                    style: EcoPointsTextStyles.whiteSuezOneTextStyle(
                      size: width * 0.1,
                      weight: FontWeight.normal,
                    ),
                  ),
                ),
              ],
            ),
            Text(
              "Let's Turn Trash into Treasure",
              style: EcoPointsTextStyles.blackTextStyle(
                size: width * 0.04,
                weight: FontWeight.w600,
              ),
            ),
            CustomElevatedButton(
              onPressed: () {},
              backgroundColor: EcoPointsColors.lighGray,
              width: width,
              borderRadius: 10.0,
              padding: const EdgeInsets.all(7),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    "assets/icons/google-icon.svg",
                    width: width * 0.035,
                    height: height * 0.035,
                  ),
                  Gap(width * 0.02),
                  Text(
                    "Sign Up With Google",
                    style: EcoPointsTextStyles.blackTextStyle(
                      size: width * 0.035,
                      weight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
