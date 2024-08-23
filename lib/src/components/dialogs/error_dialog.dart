import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../buttons/custom_elevated_button.dart';
import '../constants/colors/ecopoints_colors.dart';
import '../constants/text_style/ecopoints_themes.dart';

class ErrorDialog extends StatelessWidget {
  final String title;
  final String description;
  const ErrorDialog(
      {super.key, required this.description, required this.title});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Dialog(
      child: Container(
        height: height * 0.2,
        width: width * 0.7,
        padding: const EdgeInsets.all(14),
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
                    Text(
                      title,
                      style: EcoPointsTextStyles.redTextStyle(
                        size: width * 0.05,
                        weight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Gap(height * 0.005),
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
                Navigator.pop(context);
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
