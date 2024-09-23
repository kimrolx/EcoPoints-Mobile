import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../../models/reward_model.dart';
import '../misc/error_text.dart';
import '../misc/shimmer_loading_containers.dart';

class RewardsListBuilder extends StatelessWidget {
  final Stream<List<RewardModel>> getRewardsFunction;
  final Widget Function(RewardModel reward) rewardContainer;
  const RewardsListBuilder(
      {super.key,
      required this.getRewardsFunction,
      required this.rewardContainer});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return StreamBuilder<List<RewardModel>>(
      stream: getRewardsFunction,
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
            crossAxisSpacing: 12.0,
            childCount: rewards.length,
            itemBuilder: (context, index) {
              final reward = rewards[index];
              return rewardContainer(reward);
            },
          );
        }
      },
    );
  }
}
