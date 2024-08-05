import 'package:flutter/material.dart';

import '../../../../components/constants/colors/ecopoints_colors.dart';

class GreenBackgroundTransactionReceiptScreen extends StatelessWidget {
  const GreenBackgroundTransactionReceiptScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return Container(
      height: height * 0.5,
      decoration: const BoxDecoration(
        color: EcoPointsColors.darkGreen,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
    );
  }
}
