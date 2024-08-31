import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../../../../components/misc/error_text.dart';
import '../../../../components/misc/shimmer_loading_containers.dart';
import '../../../../models/reward_model.dart';
import '../../../../shared/services/rewards_firestore_service.dart';
import 'small_reward_container_builder.dart';

class NewRewardsBuilderNewRewardsScreen extends StatelessWidget {
  final RewardsService rewardsService;
  const NewRewardsBuilderNewRewardsScreen(
      {super.key, required this.rewardsService});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return StreamBuilder<List<RewardModel>>(
      stream: rewardsService.getNewRewards(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return SliverFillRemaining(
            child: ErrorText(
              width: width,
              text:
                  "Error loading new rewards. Please try again later or contact support.",
            ),
          );
        } else if (!snapshot.hasData) {
          return SliverToBoxAdapter(
            child: GridView.count(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              crossAxisCount: 2,
              childAspectRatio: 1,
              children: List.generate(
                6,
                (index) => ShimmerSkeleton(width: width / 2, height: width / 2),
              ),
            ),
          );
        } else if (snapshot.data!.isEmpty) {
          return SliverFillRemaining(
            child: ErrorText(
              width: width,
              text: "No new rewards available at the moment.",
            ),
          );
        } else {
          final rewards = snapshot.data!;
          return SliverMasonryGrid.count(
            crossAxisCount: 2,
            childCount: rewards.length,
            itemBuilder: (context, index) {
              final reward = rewards[index];
              return Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: width * 0.03, vertical: height * 0.01),
                child: SmallRewardContainerNewRewardsScreen(reward: reward),
              );
            },
          );
        }
      },
    );
  }
}
