import 'package:flutter/material.dart';

import '../constants/colors/ecopoints_colors.dart';

class ShimmerSkeleton extends StatelessWidget {
  final double? width, height;
  const ShimmerSkeleton({super.key, this.width, this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: EcoPointsColors.black.withOpacity(0.05),
        borderRadius: (BorderRadius.circular(15.0)),
      ),
    );
  }
}
