import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../components/buttons/custom_elevated_button.dart';
import '../../../components/constants/colors/ecopoints_colors.dart';
import '../../../components/constants/text_style/ecopoints_themes.dart';
import '../../../models/reward_model.dart';
import '../../../shared/utils/date_formatter_util.dart';
import 'widgets/confirm_claim_dialog.dart';
import 'widgets/picture_stack.dart';
import 'widgets/text_details.dart';

class RewardDetailsScreen extends StatelessWidget {
  final RewardModel reward;

  static const String route = "/reward-details";
  static const String path = "/reward-details";
  static const String name = "RewardDetailsScreen";

  const RewardDetailsScreen({super.key, required this.reward});

  void _showConfirmClaimDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => const ConfirmClaimDialog(),
    );
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    String formattedExpiryDate =
        DateFormatterUtil.formatDateWithoutTime(reward.expiryDate);

    return Scaffold(
      backgroundColor: EcoPointsColors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PictureStackRewardDetailsScreen(reward: reward),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: width * 0.03, vertical: height * 0.01),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                      child: TextDetailsRewardDetailsScreen(reward: reward)),
                  Text(
                    "Expires: $formattedExpiryDate",
                    style: EcoPointsTextStyles.blackTextStyle(
                        size: width * 0.035, weight: FontWeight.normal),
                  ),
                  Gap(height * 0.03),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: CustomElevatedButton(
                      borderRadius: 7,
                      width: width * 0.8,
                      backgroundColor: EcoPointsColors.darkGreen,
                      onPressed: () {
                        _showConfirmClaimDialog(context);
                      },
                      child: Text(
                        "Claim Reward",
                        style: EcoPointsTextStyles.whiteTextStyle(
                            size: width * 0.04, weight: FontWeight.w600),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
