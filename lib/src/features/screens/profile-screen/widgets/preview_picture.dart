import 'dart:io';
import 'package:ecopoints/src/components/buttons/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../components/constants/colors/ecopoints_colors.dart';
import '../../../../components/constants/text_style/ecopoints_themes.dart';

class PreviewPictureScreen extends StatelessWidget {
  final XFile imageFile;
  final VoidCallback onTakePhoto;
  final VoidCallback onSave;

  const PreviewPictureScreen({
    super.key,
    required this.imageFile,
    required this.onSave,
    required this.onTakePhoto,
  });

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: EcoPointsColors.white,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Text(
                      "Cancel",
                      style: EcoPointsTextStyles.redTextStyle(
                          size: width * 0.04, weight: FontWeight.w500),
                    ),
                  ),
                  Text(
                    "Preview",
                    style: EcoPointsTextStyles.blackTextStyle(
                        size: width * 0.04, weight: FontWeight.w500),
                  ),
                  GestureDetector(
                    onTap: () async {
                      onSave();
                    },
                    child: Text(
                      "Save",
                      style: EcoPointsTextStyles.lightGreenTextStyle(
                          size: width * 0.04, weight: FontWeight.w500),
                    ),
                  ),
                ],
              ),
            ),
            Image.file(
              File(imageFile.path),
              fit: BoxFit.contain,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: CustomElevatedButton(
                borderRadius: 20,
                onPressed: () {
                  onTakePhoto();
                  Navigator.pop(context);
                },
                child: Text(
                  "Retake?",
                  style: EcoPointsTextStyles.blackTextStyle(
                      size: width * 0.04, weight: FontWeight.w500),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
