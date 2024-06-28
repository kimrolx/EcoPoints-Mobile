import 'package:ecopoints/src/components/constants/text_style/ecopoints_themes.dart';
import 'package:flutter/material.dart';

import '../../../../components/constants/colors/ecopoints_colors.dart';

class TransactionsHomeScreen extends StatelessWidget {
  const TransactionsHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Card(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
      ),
      color: EcoPointsColors.lighGray,
      elevation: 2,
      child: SizedBox(
        height: height,
        width: width,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Transactions",
                style: EcoPointsTextStyles.blackTextStyle(
                  size: width * 0.04,
                  weight: FontWeight.w500,
                ),
                //TODO: Transaction List here
              ),
            ],
          ),
        ),
      ),
    );
  }
}
