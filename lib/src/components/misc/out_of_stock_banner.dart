import 'package:flutter/material.dart';

import '../constants/text_style/ecopoints_themes.dart';

class OutOfStockBanner extends StatelessWidget {
  final double fontSize;
  const OutOfStockBanner({super.key, required this.fontSize});

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.6),
          borderRadius: const BorderRadius.vertical(top: Radius.circular(25)),
        ),
        child: Center(
          child: Text(
            "Out of Stock",
            style: EcoPointsTextStyles.whiteTextStyle(
                size: fontSize, weight: FontWeight.w500),
          ),
        ),
      ),
    );
  }
}
