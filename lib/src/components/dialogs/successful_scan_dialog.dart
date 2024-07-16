import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:lottie/lottie.dart';

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
          Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                height: height * 0.11,
              ),
              SizedBox(
                height: height * 0.05,
                width: width * 0.4,
                child: Lottie.asset(
                  "assets/animations/recycle-animation.json",
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                top: height * 0.055,
                child: SizedBox(
                  height: height * 0.05,
                  width: width * 0.3,
                  child: Lottie.asset(
                    "assets/animations/star-animation.json",
                    height: height * 0.5,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          ),
          Gap(height * 0.15),
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
          Gap(height * 0.025),
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
