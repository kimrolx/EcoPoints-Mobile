import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../../components/constants/colors/ecopoints_colors.dart';
import '../../../models/reward_category_model.dart';
import '../../../shared/services/rewards_firestore_service.dart';
import 'widgets/category_row.dart';
import 'widgets/new_rewards_row.dart';
import 'widgets/reward_list_builder.dart';
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
        name: "Food",
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

    return Scaffold(
      backgroundColor: EcoPointsColors.lightGray,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
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
            CategoryRowRewardsScreen(
              categories: categories,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.03),
              child: NewRewardsRowRewardsScreen(
                onTap: onSeeMoreNewRewards,
              ),
            ),
            RewardsListBuilderRewardScreen(
              rewardsService: _rewardsService,
            ),
            Text("asdasdasd"),
          ],
        ),
      ),
    );
  }

  onSeeMoreNewRewards() {
    //TODO add see more new rewards event handler here
    print("See more new rewards tapped");
  }
}
