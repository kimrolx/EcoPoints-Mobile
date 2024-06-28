import 'package:flutter/cupertino.dart';

import '../../../../components/constants/colors/ecopoints_colors.dart';
import '../../../../components/constants/text_style/ecopoints_themes.dart';

class HeaderRegistrationScreen extends StatelessWidget {
  const HeaderRegistrationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Row(
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
    );
  }
}
