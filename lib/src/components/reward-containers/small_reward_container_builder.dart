import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../features/screens/reward-details-screen/reward_details_screen.dart';
import '../../models/reward_model.dart';
import '../../routes/router.dart';
import '../constants/colors/ecopoints_colors.dart';
import '../constants/text_style/ecopoints_themes.dart';

class SliverSmallRewardContainer extends StatelessWidget {
  final RewardModel reward;
  const SliverSmallRewardContainer({super.key, required this.reward});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    bool isSoldOut = reward.rewardStock < 1;

    return Card(
      color: EcoPointsColors.white,
      elevation: 2,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25),
      ),
      child: InkWell(
        onTap: () => onRewardTap(),
        child: Column(
          children: [
            Stack(
              children: [
                Ink(
                  height: height * 0.15,
                  decoration: BoxDecoration(
                    borderRadius:
                        const BorderRadius.vertical(top: Radius.circular(25)),
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
                              size: width * 0.04, weight: FontWeight.w500),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            SizedBox(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
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
                                  size: width * 0.035,
                                  weight: FontWeight.w500)),
                        ),
                        Gap(width * 0.02),
                        Text("${reward.requiredPoint.toStringAsFixed(2)}pts",
                            style: EcoPointsTextStyles.lightGreenTextStyle(
                                size: width * 0.035, weight: FontWeight.w500)),
                      ],
                    ),
                    const Divider(
                      color: EcoPointsColors.lightGray,
                    ),
                    Center(
                      child: Text("See Details",
                          style: EcoPointsTextStyles.lightGreenTextStyle(
                              size: width * 0.033, weight: FontWeight.w500)),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void onRewardTap() {
    GlobalRouter.I.router.push(RewardDetailsScreen.route, extra: reward);
  }
}