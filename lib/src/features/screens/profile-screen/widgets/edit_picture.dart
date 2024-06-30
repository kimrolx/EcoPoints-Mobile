import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../../components/constants/text_style/ecopoints_themes.dart';

class EditPictureProfileScreen extends StatelessWidget {
  final String photoURL;
  const EditPictureProfileScreen({super.key, required this.photoURL});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Column(
      children: [
        CircleAvatar(
          backgroundImage: NetworkImage(photoURL),
          backgroundColor: Colors.transparent,
          radius: width * 0.1,
        ),
        Gap(height * 0.01),
        Text(
          "Edit picture",
          style: EcoPointsTextStyles.darkGreenTextStyle(
            size: width * 0.035,
            weight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
