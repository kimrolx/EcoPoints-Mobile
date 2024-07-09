import 'package:flutter/material.dart';

import '../../../components/constants/colors/ecopoints_colors.dart';
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

  @override
  void initState() {
    super.initState();
    searchController = TextEditingController();
    searchFn = FocusNode();
  }

  @override
  void dispose() {
    searchController.dispose();
    searchFn.dispose();
    super.dispose();
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
            Text("Yes"),
          ],
        ),
      ),
    );
  }
}
