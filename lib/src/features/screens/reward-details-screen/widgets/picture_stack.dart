import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../components/constants/colors/ecopoints_colors.dart';
import '../../../../components/constants/text_style/ecopoints_themes.dart';
import '../../../../models/reward_model.dart';

class PictureStackRewardDetailsScreen extends StatelessWidget {
  final RewardModel reward;
  const PictureStackRewardDetailsScreen({super.key, required this.reward});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    bool isSoldOut = reward.rewardStock < 1;

    return Stack(
      children: [
        Container(
          height: height * 0.55,
          decoration: BoxDecoration(
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
                color: Colors.black.withOpacity(0.55),
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(25)),
              ),
              child: Center(
                child: Text(
                  "Out of Stock",
                  style: EcoPointsTextStyles.whiteTextStyle(
                      size: width * 0.06, weight: FontWeight.w600),
                ),
              ),
            ),
          ),
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: width * 0.03, vertical: height * 0.02),
          child: SafeArea(
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: EcoPointsColors.white,
                borderRadius: BorderRadius.circular(50),
              ),
              child: IconButton(
                icon: const Icon(CupertinoIcons.clear),
                onPressed: () => context.pop(),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
