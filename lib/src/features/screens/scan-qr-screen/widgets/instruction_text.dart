import 'package:flutter/material.dart';

import '../../../../components/constants/text_style/ecopoints_themes.dart';

class InstructionTextQRScreen extends StatelessWidget {
  final double width, height;
  const InstructionTextQRScreen(
      {super.key, required this.width, required this.height});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(height: height * 0.2),
          Text(
            "Scan an EcoPoints QR code",
            style: EcoPointsTextStyles.whiteTextStyle(
              size: width * 0.05,
              weight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
