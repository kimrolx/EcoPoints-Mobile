import 'package:flutter/material.dart';

import '../../../../components/constants/colors/ecopoints_colors.dart';

class PointsIndicatorHomeScreen extends StatelessWidget {
  const PointsIndicatorHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Positioned(
      top: height * 0.12,
      left: width * 0.16,
      right: width * 0.16,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(40),
        ),
        color: EcoPointsColors.white,
        elevation: 5,
        child: Container(height: height * 0.3),
      ),
    );
  }
}
