import 'package:flutter/material.dart';

import '../../../../components/constants/colors/ecopoints_colors.dart';
import '../../../../components/constants/text_style/ecopoints_themes.dart';
import '../../../../models/reward_category_model.dart';

class CategoryRowRewardsScreen extends StatelessWidget {
  final List<RewardCategoryModel> categories;
  const CategoryRowRewardsScreen({super.key, required this.categories});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return SizedBox(
      height: height * 0.1,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          return Padding(
            padding: EdgeInsets.symmetric(
                horizontal: width * 0.1, vertical: height * 0.012),
            child: Column(
              children: [
                InkWell(
                  onTap: category.onTap,
                  child: Container(
                    width: width * 0.1,
                    decoration: BoxDecoration(
                      color: EcoPointsColors.lightGreenShade,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Image.asset(category.iconPath),
                  ),
                ),
                Text(
                  category.name,
                  style: EcoPointsTextStyles.blackTextStyle(
                      size: width * 0.035, weight: FontWeight.w500),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
