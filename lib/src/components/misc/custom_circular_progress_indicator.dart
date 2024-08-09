import 'package:flutter/material.dart';

import '../constants/colors/ecopoints_colors.dart';

class CustomCircularProgressIndicator extends StatelessWidget {
  final double width;
  final double height;
  final Color backgroundColor;
  final Color color;
  final double strokeWidth;

  const CustomCircularProgressIndicator({
    super.key,
    required this.width,
    required this.height,
    required this.backgroundColor,
    this.color = EcoPointsColors.lightGreen,
    this.strokeWidth = 3.5,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor,
      width: width,
      height: height,
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(color),
        strokeWidth: strokeWidth,
      ),
    );
  }
}
