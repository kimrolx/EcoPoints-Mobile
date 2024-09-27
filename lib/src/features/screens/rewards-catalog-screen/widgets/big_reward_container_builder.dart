import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../../components/constants/colors/ecopoints_colors.dart';
import '../../../../components/constants/text_style/ecopoints_themes.dart';
import '../../../../components/misc/out_of_stock_banner.dart';
import '../../../../models/reward_model.dart';
import '../../../../routes/router.dart';
import '../../../../shared/utils/date_formatter_util.dart';
import '../../../../shared/utils/debouncer.dart';
import '../../reward-details-screen/reward_details_screen.dart';

class RewardContainerBuilderRewardScreen extends StatelessWidget {
  final RewardModel reward;
  const RewardContainerBuilderRewardScreen({super.key, required this.reward});

  static final Debouncer debouncer = Debouncer(milliseconds: 1000);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    String formattedExpiryDate =
        DateFormatterUtil.formatDateWithoutTime(reward.expiryDate);

    bool isSoldOut = reward.rewardStock < 1;

    return Card(
      color: EcoPointsColors.white,
      clipBehavior: Clip.antiAlias,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25),
      ),
      child: InkWell(
        onTap: () => onRewardTap(),
        child: SizedBox(
          width: width * 0.65,
          child: Column(
            children: [
              Stack(
                children: [
                  Ink(
                    height: height * 0.18,
                    decoration: BoxDecoration(
                      borderRadius:
                          const BorderRadius.vertical(top: Radius.circular(25)),
                      image: DecorationImage(
                        image: NetworkImage(reward.rewardPicture),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  if (isSoldOut) OutOfStockBanner(fontSize: width * 0.05)
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: SizedBox(
                  height: height * 0.13,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Flexible(
                            child: Text(reward.rewardName,
                                overflow: TextOverflow.ellipsis,
                                style: EcoPointsTextStyles.blackTextStyle(
                                    size: width * 0.04,
                                    weight: FontWeight.w500)),
                          ),
                          Gap(width * 0.05),
                          Text("${reward.requiredPoint.toStringAsFixed(2)}pts",
                              style: EcoPointsTextStyles.lightGreenTextStyle(
                                  size: width * 0.04, weight: FontWeight.w500)),
                        ],
                      ),
                      Gap(height * 0.005),
                      Text(reward.rewardDescription,
                          overflow: TextOverflow.ellipsis,
                          style: EcoPointsTextStyles.grayTextStyle(
                              size: width * 0.035, weight: FontWeight.w500)),
                      const Spacer(),
                      const Divider(
                        color: EcoPointsColors.lightGray,
                      ),
                      const Spacer(),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "${reward.campus} Campus",
                              style: EcoPointsTextStyles.blackTextStyle(
                                  size: width * 0.035,
                                  weight: FontWeight.normal),
                            ),
                            Text(
                              "Ends $formattedExpiryDate",
                              overflow: TextOverflow.ellipsis,
                              style: EcoPointsTextStyles.grayTextStyle(
                                  size: width * 0.035,
                                  weight: FontWeight.normal),
                            ),
                          ],
                        ),
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
    if (debouncer.canExecute()) {
      GlobalRouter.I.router.push(RewardDetailsScreen.route, extra: reward);
    }
  }
}
