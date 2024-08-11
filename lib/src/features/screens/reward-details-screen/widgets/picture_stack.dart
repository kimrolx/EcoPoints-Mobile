import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../components/constants/colors/ecopoints_colors.dart';
import '../../../../models/reward_model.dart';

class PictureStackRewardDetailsScreen extends StatelessWidget {
  final RewardModel reward;
  const PictureStackRewardDetailsScreen({super.key, required this.reward});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

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
