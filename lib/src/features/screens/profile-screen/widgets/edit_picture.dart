import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../components/constants/text_style/ecopoints_themes.dart';
import '../../../../components/dialogs/loading_dialog.dart';
import '../../../../shared/services/user_profile_service.dart';
import 'edit_picture_dialog.dart';
import 'preview_picture.dart';

class EditPictureProfileScreen extends StatefulWidget {
  final String? photoURL;
  const EditPictureProfileScreen({super.key, required this.photoURL});

  @override
  State<EditPictureProfileScreen> createState() =>
      _EditPictureProfileScreenState();
}

class _EditPictureProfileScreenState extends State<EditPictureProfileScreen> {
  final UserProfileService _userProfileService =
      GetIt.instance<UserProfileService>();

  Future<void> _chooseFromLibrary() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      _navigateToPreviewScreen(pickedFile);
    }
  }

  Future<void> _takePhoto() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      _navigateToPreviewScreen(pickedFile);
    }
  }

  _removeCurrentPicture() async {
    await WaitingDialog.show(
      context,
      future: Future.delayed(const Duration(seconds: 2)).then(
        (_) async {
          await _userProfileService.removeCurrentUserPicture();
        },
      ),
    );
  }

  void _navigateToPreviewScreen(XFile imageFile) {
    //TODO Change to gorouter
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PreviewPictureScreen(
          imageFile: imageFile,
          onTakePhoto: _takePhoto,
          onSave: () => onSave(context, imageFile),
        ),
      ),
    );
  }

  void _showEditPictureDialog() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return EditPictureBottomDialog(
          onChooseFromLibrary: _chooseFromLibrary,
          onTakePhoto: _takePhoto,
          onRemoveCurrentPicture: _removeCurrentPicture,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Column(
      children: [
        widget.photoURL != null && widget.photoURL!.isNotEmpty
            ? CircleAvatar(
                backgroundImage: NetworkImage(widget.photoURL!),
                backgroundColor: Colors.transparent,
                radius: width * 0.1,
              )
            : Text(
                "No profile picture",
                style: EcoPointsTextStyles.blackTextStyle(
                  size: width * 0.04,
                  weight: FontWeight.w500,
                ),
              ),
        Gap(height * 0.01),
        GestureDetector(
          onTap: () => _showEditPictureDialog(),
          child: Text(
            "Edit picture",
            style: EcoPointsTextStyles.darkGreenTextStyle(
              size: width * 0.035,
              weight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }

  onSave(BuildContext context, XFile imageFile) async {
    await WaitingDialog.show(
      context,
      future: Future.delayed(const Duration(seconds: 2)).then(
        (_) async {
          Navigator.pop(context);
          await _userProfileService.updateUserProfilePicture(imageFile.path);
        },
      ),
    );
  }
}
