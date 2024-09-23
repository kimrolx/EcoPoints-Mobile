import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get_it/get_it.dart';

import '../../../components/constants/colors/ecopoints_colors.dart';
import '../../../components/reward-containers/small_reward_container_builder.dart';
import '../../../components/reward-list-builder/sliver_rewards_list_builder.dart';
import '../../../models/reward_category_model.dart';
import '../../../models/reward_model.dart';
import '../../../routes/router.dart';
import '../../../shared/services/rewards_firestore_service.dart';
import '../../../shared/utils/ui_helpers.dart';
import '../most-claimed-screen/most_claimed_screen.dart';
import '../new-rewards-screen/new_rewards_screen.dart';
import '../placeholder_screen.dart';
import 'widgets/category_row.dart';
import 'widgets/category_text_row.dart';
import 'widgets/for_you_button.dart';
import 'widgets/new_rewards_list_builder.dart';
import 'widgets/search_bar.dart';

class RewardsCatalogScreen extends StatefulWidget {
  static const String route = "/rewards";
  static const String path = "/rewards";
  static const String name = "RewardsCatalogScreen";
  const RewardsCatalogScreen({super.key});

  @override
  State<RewardsCatalogScreen> createState() => _RewardsCatalogScreenState();
}

class _RewardsCatalogScreenState extends State<RewardsCatalogScreen> {
  late TextEditingController searchController;
  late FocusNode searchFn;

  late List<RewardCategoryModel> categories;
  final RewardsService _rewardsService = GetIt.instance<RewardsService>();
  late final RewardModel reward;

  @override
  void initState() {
    super.initState();
    searchController = TextEditingController();
    searchFn = FocusNode();
    initCategories();
  }

  @override
  void dispose() {
    searchController.dispose();
    searchFn.dispose();
    super.dispose();
  }

  void initCategories() {
    categories = [
      RewardCategoryModel(
        iconPath: "assets/icons/food-icon.png",
        name: "Food",
        onTap: () {
          //TODO: add food category event handler here
          print("Food category tapped");
        },
      ),
      RewardCategoryModel(
        iconPath: "assets/icons/supplies-icon.png",
        name: "Supplies",
        onTap: () {
          //TODO: add supplies category event handler here
          print("Supplies category tapped");
        },
      ),
      RewardCategoryModel(
        iconPath: "assets/icons/events-icon.png",
        name: "Events",
        onTap: () {
          //TODO: add events category event handler here
          print("Events category tapped");
        },
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return dismissKeyboardOnTap(
      context: context,
      child: Scaffold(
        backgroundColor: EcoPointsColors.lightGray,
        body: RefreshIndicator(
          onRefresh: () async {},
          color: EcoPointsColors.darkGreen,
          backgroundColor: EcoPointsColors.white,
          child: CustomScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            slivers: [
              SliverToBoxAdapter(
                child: Stack(
                  children: [
                    SizedBox(
                      height: height * 0.135,
                      width: width,
                    ),
                    Container(
                      color: EcoPointsColors.darkGreen,
                      height: height * 0.1,
                      width: width,
                    ),
                    Positioned(
                      top: height * 0.07,
                      right: width * 0.03,
                      left: width * 0.03,
                      child: SearchBarRewardsScreen(
                        searchController: searchController,
                        searchFn: searchFn,
                      ),
                    ),
                  ],
                ),
              ),
              SliverToBoxAdapter(
                child: CategoryRowRewardsScreen(
                  categories: categories,
                ),
              ),
              SliverPadding(
                padding: EdgeInsets.symmetric(horizontal: width * 0.03),
                sliver: SliverToBoxAdapter(
                  child: CategoryTextRowRewardsCatalogScreen(
                    title: "New Rewards",
                    onTap: onSeeMoreNewRewards,
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: NewRewardsListBuilderRewardsCatalogScreen(
                  rewardsService: _rewardsService,
                ),
              ),
              SliverPadding(
                padding: EdgeInsets.symmetric(horizontal: width * 0.03),
                sliver: SliverToBoxAdapter(
                  child: Column(
                    children: [
                      ForYouButtonRewardsCatalogScreen(onTap: onForYouTap),
                      Gap(height * 0.012),
                      CategoryTextRowRewardsCatalogScreen(
                        title: "Most Claimed",
                        onTap: onSeeMoreMostClaimedRewards,
                      ),
                    ],
                  ),
                ),
              ),
              SliverPadding(
                padding: EdgeInsets.only(
                    left: width * 0.03,
                    right: width * 0.03,
                    top: height * 0.005,
                    bottom: height * 0.035),
                sliver: RewardsListBuilder(
                  getRewardsFunction: _rewardsService.getMostClaimedRewards(),
                  rewardContainer: (reward) =>
                      SliverSmallRewardContainer(reward: reward),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  onSeeMoreNewRewards() {
    GlobalRouter.I.router.push(NewRewardsScreen.route);
  }

  onForYouTap() {
    GlobalRouter.I.router.push(PlaceholderScreen.route);
  }

  onSeeMoreMostClaimedRewards() {
    GlobalRouter.I.router.push(MostClaimedScreen.route);
  }
}
