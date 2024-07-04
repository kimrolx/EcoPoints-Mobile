import 'package:flutter/cupertino.dart';

import '../../../../components/buttons/custom_elevated_button.dart';
import '../../../../components/constants/colors/ecopoints_colors.dart';
import '../../../../components/constants/text_style/ecopoints_themes.dart';

class UploadQRCodeScreen extends StatelessWidget {
  final double width, height;
  final Function() onPressed;
  const UploadQRCodeScreen(
      {super.key,
      required this.width,
      required this.height,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 32,
      left: 0,
      right: 0,
      child: Center(
        child: SizedBox(
          width: width * 0.45,
          child: CustomElevatedButton(
            onPressed: onPressed,
            borderRadius: 10.0,
            backgroundColor: EcoPointsColors.black,
            foregroundColor: EcoPointsColors.white,
            padding: EdgeInsets.symmetric(
              horizontal: width * 0.05,
              vertical: height * 0.012,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Icon(CupertinoIcons.qrcode),
                Text(
                  "Upload QR Code",
                  style: EcoPointsTextStyles.whiteTextStyle(
                    size: width * 0.0325,
                    weight: FontWeight.w500,
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
