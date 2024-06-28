import 'package:flutter/material.dart';

import '../../../../components/constants/colors/ecopoints_colors.dart';

class TrashcanBackgroundHomeScreen extends StatelessWidget {
  const TrashcanBackgroundHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Container(
      color: EcoPointsColors.darkGreen,
      height: height * 0.3,
      child: Image.asset(
        "assets/images/two-trashcans-background.png",
        fit: BoxFit.cover,
        width: double.infinity,
      ),
    );
  }
}
