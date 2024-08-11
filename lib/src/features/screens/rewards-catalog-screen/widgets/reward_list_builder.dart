import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../components/constants/colors/ecopoints_colors.dart';
import '../../../../components/misc/error_text.dart';
import '../../../../components/misc/shimmer_loading_containers.dart';
import '../../../../models/reward_model.dart';
import '../../../../routes/router.dart';
import '../../../../shared/services/rewards_firestore_service.dart';
import '../../new-rewards-screen/new_rewards_screen.dart';
import 'reward_container_builder.dart';

class RewardsListBuilderRewardScreen extends StatefulWidget {
  final RewardsService rewardsService;
  const RewardsListBuilderRewardScreen(
      {super.key, required this.rewardsService});

  @override
  State<RewardsListBuilderRewardScreen> createState() =>
      _RewardsListBuilderRewardScreenState();
}

class _RewardsListBuilderRewardScreenState
    extends State<RewardsListBuilderRewardScreen> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return StreamBuilder<List<RewardModel>>(
      stream: widget.rewardsService.getRewards(),
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
          bool hasMore = rewards.length > 4;
          int itemCount = hasMore ? 4 : rewards.length;

          return SizedBox(
            height: height * 0.4,
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemCount: itemCount + (hasMore ? 1 : 0),
              itemBuilder: (context, index) {
                if (index < itemCount) {
                  return Padding(
                      padding: EdgeInsets.only(
                        left: width * 0.02,
                        right: width * 0.02,
                        top: height * 0.005,
                        bottom: height * 0.025,
                      ),
                      child: RewardContainerBuilderRewardScreen(
                          reward: rewards[index]));
                } else {
                  return Padding(
                    padding: EdgeInsets.only(
                        left: width * 0.02, right: width * 0.045),
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: EcoPointsColors.black.withOpacity(0.1),
                            blurRadius: 15,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: CircleAvatar(
                        backgroundColor: EcoPointsColors.white,
                        child: IconButton(
                          icon: const Icon(CupertinoIcons.forward),
                          onPressed: () => GlobalRouter.I.router
                              .push(NewRewardsScreen.route),
                        ),
                      ),
                    ),
                  );
                }
              },
            ),
          );
        }
      },
    );
  }
}
