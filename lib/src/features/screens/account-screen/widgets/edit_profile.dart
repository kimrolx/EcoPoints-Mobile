import 'package:ecopoints/src/components/constants/text_style/ecopoints_themes.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../../components/constants/colors/ecopoints_colors.dart';

class EditProfileAccountScreen extends StatelessWidget {
  final Function() onTap;
  final String displayName;
  final String photoURL;
  const EditProfileAccountScreen({
    super.key,
    required this.onTap,
    required this.displayName,
    required this.photoURL,
  });

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return InkWell(
      onTap: onTap,
      child: Container(
        width: width,
        height: height * 0.11,
        decoration: BoxDecoration(
          color: EcoPointsColors.darkGreen,
          borderRadius: BorderRadius.circular(50),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: width * 0.035,
            vertical: height * 0.011,
          ),
          child: Row(
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(photoURL),
                backgroundColor: Colors.transparent,
                radius: width * 0.09,
              ),
              Gap(height * 0.015),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                      child: Text(
                        displayName,
                        style: EcoPointsTextStyles.whiteTextStyle(
                          size: width * 0.05,
                          weight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Flexible(
                      child: Text(
                        "Edit Profile",
                        style: EcoPointsTextStyles.whiteTextStyle(
                          size: width * 0.035,
                          weight: FontWeight.normal,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
