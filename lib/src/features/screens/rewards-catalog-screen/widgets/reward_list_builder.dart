import 'package:ecopoints/src/features/screens/rewards-catalog-screen/widgets/reward_container_builder.dart';
import 'package:flutter/material.dart';

import '../../../../components/misc/error_text.dart';
import '../../../../components/misc/shimmer_loading_containers.dart';
import '../../../../models/reward_model.dart';
import '../../../../shared/services/rewards_firestore_service.dart';

class RewardsListBuilderRewardScreen extends StatelessWidget {
  final RewardsService rewardsService;
  const RewardsListBuilderRewardScreen(
      {super.key, required this.rewardsService});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return StreamBuilder<List<RewardModel>>(
      stream: rewardsService.getRewards(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return ErrorText(
            width: width,
            text:
                "Oh no! An error occurred while trying to load the rewards. Please try again later or contact support.",
          );
        } else if (!snapshot.hasData) {
          return SizedBox(
            height: height * 0.35,
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemCount: 5,
              itemBuilder: (context, index) => Padding(
                padding: EdgeInsets.symmetric(horizontal: width * 0.03),
                child: ShimmerSkeleton(
                  width: width * 0.65,
                  height: height * 0.35,
                ),
              ),
            ),
          );
        } else if (snapshot.data!.isEmpty) {
          return ErrorText(
            width: width,
            text:
                "It seems like there are no rewards available at the moment. Please check back later.",
          );
        } else {
          final rewards = snapshot.data!;
          return SizedBox(
            height: height * 0.35,
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemCount: rewards.length,
              itemBuilder: (context, index) {
                final reward = rewards[index];
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: width * 0.03),
                  child: RewardContainerBuilderRewardScreen(reward: reward),
                );
              },
            ),
          );
        }
      },
    );
  }
}
