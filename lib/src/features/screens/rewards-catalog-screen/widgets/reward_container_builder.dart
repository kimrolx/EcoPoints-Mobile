import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

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

    bool isSoldOut = reward.rewardStock < 1;

    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: EcoPointsColors.black.withOpacity(0.05),
            blurRadius: 15,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Card(
        color: EcoPointsColors.white,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
        child: InkWell(
          onTap: () => onRewardTap(),
          child: SizedBox(
            width: width * 0.7,
            child: Column(
              children: [
                Stack(
                  children: [
                    Ink(
                      height: height * 0.1725,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(25)),
                        image: DecorationImage(
                          image: NetworkImage(reward.rewardPicture),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    if (isSoldOut)
                      Positioned.fill(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.6),
                            borderRadius: const BorderRadius.vertical(
                                top: Radius.circular(25)),
                          ),
                          child: Center(
                            child: Text(
                              "Out of Stock",
                              style: EcoPointsTextStyles.whiteTextStyle(
                                  size: width * 0.05, weight: FontWeight.w500),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: SizedBox(
                    height: height * 0.165,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Flexible(
                              child: Text(reward.rewardName,
                                  style: EcoPointsTextStyles.blackTextStyle(
                                      size: width * 0.04,
                                      weight: FontWeight.w500)),
                            ),
                            Gap(width * 0.05),
                            Text(
                                "${reward.requiredPoint.toStringAsFixed(2)}pts",
                                style: EcoPointsTextStyles.lightGreenTextStyle(
                                    size: width * 0.04,
                                    weight: FontWeight.w500)),
                          ],
                        ),
                        Gap(height * 0.005),
                        Text(reward.rewardDescription,
                            style: EcoPointsTextStyles.grayTextStyle(
                                size: width * 0.035, weight: FontWeight.w500)),
                        const Spacer(),
                        Row(
                          children: [
                            Text(
                              reward.campus,
                              style: EcoPointsTextStyles.blackTextStyle(
                                  size: width * 0.035,
                                  weight: FontWeight.normal),
                            ),
                            const Spacer(),
                            Text(
                              "Ends $formattedExpiryDate",
                              style: EcoPointsTextStyles.grayTextStyle(
                                  size: width * 0.035,
                                  weight: FontWeight.normal),
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
      ),
    );
  }

  void onRewardTap() {
    GlobalRouter.I.router.push(RewardDetailsScreen.route, extra: reward);
  }
}
