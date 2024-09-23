import 'package:flutter/material.dart';

import '../../../../components/constants/colors/ecopoints_colors.dart';
import '../../../../components/constants/text_style/ecopoints_themes.dart';

class ForYouButtonRewardsCatalogScreen extends StatelessWidget {
  final Function() onTap;
  const ForYouButtonRewardsCatalogScreen({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Card(
      color: EcoPointsColors.white,
      clipBehavior: Clip.antiAlias,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: width * 0.03, vertical: height * 0.02),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "For you",
                style: EcoPointsTextStyles.blackTextStyle(
                    size: width * 0.05, weight: FontWeight.w500),
              ),
              const Icon(Icons.arrow_forward_sharp),
            ],
          ),
        ),
      ),
    );
  }
}
