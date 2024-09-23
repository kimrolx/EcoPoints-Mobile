import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import '../../../components/constants/colors/ecopoints_colors.dart';
import '../../../components/constants/text_style/ecopoints_themes.dart';
import '../../../components/reward-containers/small_reward_container_builder.dart';
import '../../../components/reward-list-builder/sliver_rewards_list_builder.dart';
import '../../../shared/services/rewards_firestore_service.dart';

class MostClaimedScreen extends StatefulWidget {
  static const String route = "/most-claimed-screen";
  static const String path = "/most-claimed-screen";
  static const String name = "MostClaimedScreen";
  const MostClaimedScreen({super.key});

  @override
  State<MostClaimedScreen> createState() => _MostClaimedScreenState();
}

class _MostClaimedScreenState extends State<MostClaimedScreen> {
  final RewardsService _rewardsService = GetIt.instance<RewardsService>();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: EcoPointsColors.white,
      body: RefreshIndicator(
        onRefresh: () async {
          //TODO add refresh logic
        },
        child: CustomScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          slivers: [
            SliverAppBar(
              floating: true,
              automaticallyImplyLeading: false,
              leading: IconButton(
                icon: const Icon(CupertinoIcons.back,
                    color: EcoPointsColors.white),
                onPressed: () {
                  context.pop();
                },
              ),
              backgroundColor: EcoPointsColors.darkGreen,
              expandedHeight: height * 0.15,
              flexibleSpace: FlexibleSpaceBar(
                title: Text(
                  "Most Claimed Rewards",
                  style: EcoPointsTextStyles.whiteTextStyle(
                    size: width * 0.038,
                    weight: FontWeight.w500,
                  ),
                ),
                background: Stack(
                  children: [
                    SizedBox(
                      width: width,
                      child: Image.asset(
                        "assets/images/leaves-background.png",
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(
                      width: width,
                      child: Image.asset(
                        "assets/images/leaves2-background.png",
                        fit: BoxFit.cover,
                      ),
                    )
                  ],
                ),
              ),
            ),
            SliverPadding(
              padding: EdgeInsets.symmetric(
                  horizontal: width * 0.035, vertical: height * 0.015),
              sliver: RewardsListBuilder(
                getRewardsFunction: _rewardsService.getMostClaimedRewards(),
                rewardContainer: (reward) =>
                    SliverSmallRewardContainer(reward: reward),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
