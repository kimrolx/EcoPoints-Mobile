import 'package:flutter/material.dart';

import '../../../../components/constants/colors/ecopoints_colors.dart';

class ColorFilterBackgroundQRScreen extends StatelessWidget {
  final double cutoutSize, width;
  const ColorFilterBackgroundQRScreen(
      {super.key, required this.cutoutSize, required this.width});

  @override
  Widget build(BuildContext context) {
    return ColorFiltered(
      colorFilter: ColorFilter.mode(
        EcoPointsColors.black.withOpacity(0.6),
        BlendMode.srcOut,
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            decoration: const BoxDecoration(
              color: EcoPointsColors.black,
              backgroundBlendMode: BlendMode.dstOut,
            ),
          ),
          Center(
            child: Container(
              width: cutoutSize,
              height: cutoutSize,
              decoration: const BoxDecoration(
                color: Colors.red,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
