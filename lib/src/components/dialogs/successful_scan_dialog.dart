import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../buttons/custom_elevated_button.dart';
import '../constants/colors/ecopoints_colors.dart';
import '../constants/text_style/ecopoints_themes.dart';

//* Dialog Global Service
class QRScanDialogService {
  Future<void> showSuccessfulScanDialog(
      BuildContext context, int bottlesRecycled, double pointsGained) async {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => SuccessfulScanDialog(
        bottlesRecycled: bottlesRecycled,
        pointsGained: pointsGained,
      ),
    );
  }
}

final successfulScanDialogService = QRScanDialogService();

//* Dialog Design
class SuccessfulScanDialog extends StatelessWidget {
  final int bottlesRecycled;
  final double pointsGained;
  const SuccessfulScanDialog({
    super.key,
    required this.bottlesRecycled,
    required this.pointsGained,
  });

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            "assets/images/successful-recycle-image.png",
            height: height * 0.15,
            width: width * 0.3,
          ),
          Text(
            "Good job!",
            style: EcoPointsTextStyles.lightGreenTextStyle(
              size: width * 0.045,
              weight: FontWeight.bold,
            ),
          ),
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              text:
                  "You have recycled $bottlesRecycled plastic bottles! You gained ",
              style: EcoPointsTextStyles.blackTextStyle(
                size: width * 0.04,
                weight: FontWeight.normal,
              ),
              children: [
                TextSpan(
                  text: "$pointsGained ",
                  style: EcoPointsTextStyles.lightGreenTextStyle(
                    size: width * 0.04,
                    weight: FontWeight.bold,
                  ),
                ),
                const TextSpan(text: "EcoPoints!"),
              ],
            ),
          ),
          Gap(height * 0.05),
          CustomElevatedButton(
            borderRadius: 50,
            width: width,
            backgroundColor: EcoPointsColors.darkGreen,
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              "Okay!",
              style: EcoPointsTextStyles.whiteTextStyle(
                size: width * 0.045,
                weight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
