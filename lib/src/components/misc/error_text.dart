import 'package:flutter/material.dart';

import '../constants/text_style/ecopoints_themes.dart';

class ErrorText extends StatelessWidget {
  final double width;
  final String text;
  const ErrorText({super.key, required this.width, required this.text});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        text,
        style: EcoPointsTextStyles.grayTextStyle(
          size: width * 0.035,
          weight: FontWeight.w500,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
