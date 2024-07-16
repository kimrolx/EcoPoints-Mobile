import 'package:ecopoints/src/features/screens/rewards-catalog-screen/widgets/reward_container_builder.dart';
import 'package:flutter/material.dart';

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
          print('Error: ${snapshot.error}');
          return const Text('Error loading rewards');
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          print('No rewards found');
          return const Center(child: Text('No rewards found'));
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
