import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../../components/constants/colors/ecopoints_colors.dart';
import '../../../../components/constants/properties/ecopoints_properties.dart';
import '../../../../components/constants/text_style/ecopoints_themes.dart';

class GoalSetterHomeScreen extends StatelessWidget {
  final VoidCallback onUpdate;
  final Function(BuildContext, double, double) displayBottomSheet;

  const GoalSetterHomeScreen({
    super.key,
    required this.onUpdate,
    required this.displayBottomSheet,
  });

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      color: EcoPointsColors.white,
      elevation: 2,
      child: SizedBox(
        height: height * 0.12,
        width: width,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    "Don't forget to set your target!",
                    style: EcoPointsTextStyles.blackTextStyle(
                      size: width * 0.035,
                      weight: FontWeight.w600,
                    ),
                  ),
                  Gap(width * 0.005),
                  Image.asset(
                    "assets/icons/target-icon.png",
                    width: width * 0.05,
                  ),
                ],
              ),
              Gap(height * 0.003),
              Text(
                EcopointsProperties.helpKeepTrack,
                style: EcoPointsTextStyles.grayTextStyle(
                  size: width * 0.03,
                  weight: FontWeight.w500,
                ),
              ),
              const Spacer(),
              InkWell(
                onTap: () {
                  displayBottomSheet(context, height, width);
                },
                child: Text(
                  "Set Target",
                  style: EcoPointsTextStyles.darkGreenTextStyle(
                    size: width * 0.0325,
                    weight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
