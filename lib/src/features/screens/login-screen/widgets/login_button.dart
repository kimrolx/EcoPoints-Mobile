import 'package:flutter/material.dart';

import '../../../../components/buttons/custom_elevated_button.dart';
import '../../../../components/constants/colors/ecopoints_colors.dart';
import '../../../../components/constants/text_style/ecopoints_themes.dart';

class LoginButtonLoginScreen extends StatelessWidget {
  final Function() onSubmit;
  const LoginButtonLoginScreen({super.key, required this.onSubmit});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return CustomElevatedButton(
      onPressed: onSubmit,
      backgroundColor: EcoPointsColors.darkGreen,
      width: width,
      padding: const EdgeInsets.all(10),
      borderRadius: 10.0,
      child: Text(
        "Log in",
        style: EcoPointsTextStyles.whiteTextStyle(
          size: width * 0.04,
          weight: FontWeight.w600,
        ),
      ),
    );
  }
}
