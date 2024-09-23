import 'package:flutter/material.dart';

import '../../../../components/constants/colors/ecopoints_colors.dart';
import '../../../../components/constants/text_style/ecopoints_themes.dart';

class CategoryTextRowRewardsCatalogScreen extends StatelessWidget {
  final Function() onTap;
  final String title;
  const CategoryTextRowRewardsCatalogScreen(
      {super.key, required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          title,
          style: EcoPointsTextStyles.blackTextStyle(
              size: width * 0.05, weight: FontWeight.w500),
        ),
        GestureDetector(
          onTap: onTap,
          child: Text(
            "See more",
            style: EcoPointsTextStyles.blackTextStyle(
              size: width * 0.035,
              weight: FontWeight.w500,
              decoration: TextDecoration.underline,
              decorationColor: EcoPointsColors.black,
            ),
          ),
        ),
      ],
    );
  }
}
