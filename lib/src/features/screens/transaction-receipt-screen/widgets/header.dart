import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../../components/constants/text_style/ecopoints_themes.dart';

class HeaderTransactionReceiptScreen extends StatelessWidget {
  const HeaderTransactionReceiptScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Column(
      children: [
        Image.asset("assets/images/redeemed-image.png"),
        Gap(height * 0.02),
        Text(
          "Woohoo! You redeemed a reward!",
          style: EcoPointsTextStyles.blackTextStyle(
            size: width * 0.033,
            weight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}
