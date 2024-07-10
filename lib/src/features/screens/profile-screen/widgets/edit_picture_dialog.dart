import 'package:flutter/material.dart';

import '../../../../components/constants/colors/ecopoints_colors.dart';
import '../../../../components/constants/text_style/ecopoints_themes.dart';

class EditPictureBottomDialog extends StatelessWidget {
  final VoidCallback onChooseFromLibrary;
  final VoidCallback onTakePhoto;
  final VoidCallback onRemoveCurrentPicture;

  const EditPictureBottomDialog({
    super.key,
    required this.onChooseFromLibrary,
    required this.onTakePhoto,
    required this.onRemoveCurrentPicture,
  });

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: EcoPointsColors.white,
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: width * 0.1,
            height: height * 0.005,
            decoration: BoxDecoration(
              color: EcoPointsColors.lightGray,
              borderRadius: BorderRadius.circular(50),
            ),
          ),
          Wrap(
            children: [
              ListTile(
                leading: Image.asset("assets/icons/photo-gallery-icon.png"),
                title: Text(
                  'Choose from Library',
                  style: EcoPointsTextStyles.blackTextStyle(
                    size: width * 0.04,
                    weight: FontWeight.w500,
                  ),
                ),
                onTap: () {
                  Navigator.of(context).pop();
                  onChooseFromLibrary();
                },
              ),
              ListTile(
                leading: Image.asset("assets/icons/camera-icon.png"),
                title: Text(
                  'Take a Photo',
                  style: EcoPointsTextStyles.blackTextStyle(
                    size: width * 0.04,
                    weight: FontWeight.w500,
                  ),
                ),
                onTap: () {
                  Navigator.of(context).pop();
                  onTakePhoto();
                },
              ),
              ListTile(
                leading: Image.asset("assets/icons/trashcan-icon.png"),
                title: Text(
                  'Remove Current Picture',
                  style: EcoPointsTextStyles.redTextStyle(
                    size: width * 0.04,
                    weight: FontWeight.w500,
                  ),
                ),
                onTap: () {
                  Navigator.of(context).pop();
                  onRemoveCurrentPicture();
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
