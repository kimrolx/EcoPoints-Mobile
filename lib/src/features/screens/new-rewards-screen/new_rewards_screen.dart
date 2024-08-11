import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import '../../../components/constants/colors/ecopoints_colors.dart';
import '../../../components/constants/text_style/ecopoints_themes.dart';
import '../../../shared/services/rewards_firestore_service.dart';
import 'widgets/new_rewards_builder.dart';

class NewRewardsScreen extends StatefulWidget {
  static const String route = "/new-rewards-screen";
  static const String path = "/new-rewards-screen";
  static const String name = "NewRewardsScreen";
  const NewRewardsScreen({super.key});

  @override
  State<NewRewardsScreen> createState() => _NewRewardsScreenState();
}

class _NewRewardsScreenState extends State<NewRewardsScreen> {
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
          physics: const BouncingScrollPhysics(),
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
                  "New Rewards",
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
            NewRewardsBuilderNewRewardsScreen(rewardsService: _rewardsService),
          ],
        ),
      ),
    );
  }
}
