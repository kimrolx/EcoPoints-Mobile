import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../../components/constants/colors/ecopoints_colors.dart';
import '../../../../components/constants/text_style/ecopoints_themes.dart';
import '../../../../models/reward_model.dart';

class TextDetailsRewardDetailsScreen extends StatelessWidget {
  final RewardModel reward;
  const TextDetailsRewardDetailsScreen({super.key, required this.reward});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              reward.rewardName,
              style: EcoPointsTextStyles.blackTextStyle(
                  size: width * 0.045, weight: FontWeight.w500),
            ),
            const Spacer(),
            Text(
              "${reward.requiredPoint.toStringAsFixed(2)}pts",
              style: EcoPointsTextStyles.lightGreenTextStyle(
                  size: width * 0.045, weight: FontWeight.w500),
            ),
          ],
        ),
        Gap(height * 0.005),
        Text(reward.rewardDescription,
            style: EcoPointsTextStyles.blackTextStyle(
                size: width * 0.035, weight: FontWeight.normal)),
        Gap(height * 0.015),
        Center(
          child: Text("Stock: ${reward.rewardStock}",
              style: EcoPointsTextStyles.grayTextStyle(
                  size: width * 0.035, weight: FontWeight.normal)),
        ),
        const Divider(color: EcoPointsColors.lightGray),
        Text("Claim at ${reward.stallName} - ${reward.campus} Campus",
            style: EcoPointsTextStyles.blackTextStyle(
                size: width * 0.035, weight: FontWeight.w500)),
        const Divider(color: EcoPointsColors.lightGray),
      ],
    );
  }
}
