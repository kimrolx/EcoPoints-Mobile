import 'package:flutter/material.dart';

import '../../../components/constants/colors/ecopoints_colors.dart';
import '../../../models/reward_model.dart';
import '../../../shared/utils/date_formatter_util.dart';
import 'widgets/picture_stack.dart';

class RewardDetailsScreen extends StatelessWidget {
  final RewardModel reward;

  static const String route = "/reward-details";
  static const String path = "/reward-details";
  static const String name = "RewardDetailsScreen";

  const RewardDetailsScreen({super.key, required this.reward});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    // Format the expiry date
    String formattedExpiryDate =
        DateFormatterUtil.formatDateWithoutTime(reward.expiryDate);

    return Scaffold(
      backgroundColor: EcoPointsColors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PictureStackRewardDetailsScreen(reward: reward),
          Text(
            reward.rewardName,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: height * 0.02),
          Text(
            reward.rewardDescription,
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: height * 0.02),
          Text(
            "Points Required: ${reward.requiredPoint}",
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: height * 0.02),
          Text(
            "Stock: ${reward.rewardStock}",
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: height * 0.02),
          Text(
            "Expiry Date: $formattedExpiryDate",
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}
