import 'package:ecopoints/src/components/constants/text_style/ecopoints_themes.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../../../../components/constants/colors/ecopoints_colors.dart';

class PointsIndicatorHomeScreen extends StatelessWidget {
  final double points;
  const PointsIndicatorHomeScreen({super.key, required this.points});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
      color: EcoPointsColors.white,
      elevation: 2,
      child: SizedBox(
        height: height * 0.3,
        child: Center(
          child: CircularPercentIndicator(
            //TODO: Dynamic points percentage (target points)
            percent: (points / 100).clamp(0.0, 1.0),
            radius: 115,
            lineWidth: width * 0.04,
            progressColor: EcoPointsColors.darkGreen,
            backgroundColor: EcoPointsColors.lighGray,
            circularStrokeCap: CircularStrokeCap.round,
            center: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset('assets/icons/star-icon.png'),
                Flexible(
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: points.toStringAsFixed(2),
                          style: EcoPointsTextStyles.blackTextStyle(
                            size: width * 0.06,
                            weight: FontWeight.w700,
                          ),
                        ),
                        TextSpan(
                          text: "pts",
                          style: EcoPointsTextStyles.blackTextStyle(
                            size: width * 0.04,
                            weight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
