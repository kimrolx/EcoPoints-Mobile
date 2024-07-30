import 'package:flutter/material.dart';

import '../../../../components/constants/colors/ecopoints_colors.dart';
import '../../../../components/constants/text_style/ecopoints_themes.dart';
import '../../../../models/reward_model.dart';
import '../../../../routes/router.dart';
import '../../../../shared/utils/date_formatter_util.dart';
import '../../reward-details-screen/reward_details_screen.dart';

class RewardContainerBuilderRewardScreen extends StatelessWidget {
  final RewardModel reward;
  const RewardContainerBuilderRewardScreen({super.key, required this.reward});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    String formattedExpiryDate =
        DateFormatterUtil.formatDateWithoutTime(reward.expiryDate);

    return GestureDetector(
      onTap: () {
        onRewardTap();
      },
      child: Padding(
        padding: EdgeInsets.only(
          top: height * 0.0125,
          bottom: height * 0.02,
        ),
        child: Container(
          width: width * 0.7,
          decoration: BoxDecoration(
            color: EcoPointsColors.white,
            borderRadius: BorderRadius.circular(25),
            boxShadow: [
              BoxShadow(
                color: EcoPointsColors.black.withOpacity(0.1),
                blurRadius: 15,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            children: [
              Container(
                height: height * 0.19,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  image: DecorationImage(
                    image: NetworkImage(reward.rewardPicture),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(
                height: height * 0.1275,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(reward.rewardName,
                              style: EcoPointsTextStyles.blackTextStyle(
                                  size: width * 0.04, weight: FontWeight.w500)),
                          const Spacer(),
                          Text("${reward.requiredPoint.toStringAsFixed(2)}pts",
                              style: EcoPointsTextStyles.lightGreenTextStyle(
                                  size: width * 0.04, weight: FontWeight.w500)),
                        ],
                      ),
                      Text(reward.rewardDescription,
                          style: EcoPointsTextStyles.grayTextStyle(
                              size: width * 0.035, weight: FontWeight.w500)),
                      const Spacer(),
                      Row(
                        children: [
                          Text(
                            reward.campus,
                            style: EcoPointsTextStyles.blackTextStyle(
                                size: width * 0.035, weight: FontWeight.normal),
                          ),
                          const Spacer(),
                          Text(
                            "Ends $formattedExpiryDate",
                            style: EcoPointsTextStyles.grayTextStyle(
                                size: width * 0.035, weight: FontWeight.normal),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void onRewardTap() {
    GlobalRouter.I.router.push(RewardDetailsScreen.route, extra: reward);
  }
}
