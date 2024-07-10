import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get_it/get_it.dart';

import '../../../components/constants/colors/ecopoints_colors.dart';
import '../../../components/constants/text_style/ecopoints_themes.dart';
import '../../../components/dialogs/loading_dialog.dart';
import '../../../controllers/auth_controller.dart';
import '../../../models/user_profile_model.dart';
import '../../../shared/services/user_profile_service.dart';
import 'widgets/edit_picture.dart';
import 'widgets/user_fields.dart';

class EditProfileScreen extends StatefulWidget {
  static const String route = "/edit-profile";
  static const String path = "/edit-profile";
  static const String name = "EditProfileScreen";
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final UserProfileService _userProfileService =
      GetIt.instance<UserProfileService>();
  late TextEditingController displayNameController,
      emailController,
      genderController,
      numberController;

  late FocusNode numberFn;

  @override
  void initState() {
    super.initState();
    displayNameController = TextEditingController();
    emailController = TextEditingController();
    genderController = TextEditingController();
    numberController = TextEditingController();
    numberFn = FocusNode();
    _userProfileService.loadUserProfile();
  }

  @override
  void dispose() {
    displayNameController.dispose();
    emailController.dispose();
    genderController.dispose();
    numberController.dispose();
    numberFn.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: EcoPointsColors.white,
      appBar: AppBar(
        backgroundColor: EcoPointsColors.darkGreen,
        leading: IconButton(
          icon: const Icon(CupertinoIcons.back),
          onPressed: () {
            Navigator.of(context).pop();
          },
          color: EcoPointsColors.white,
        ),
        title: Text(
          "Edit Profile",
          style: EcoPointsTextStyles.whiteTextStyle(
            size: width * 0.04,
            weight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.only(
          left: width * 0.03,
          right: width * 0.03,
          top: height * 0.02,
          bottom: height * 0.07,
        ),
        child: Center(
          child: ValueListenableBuilder<UserProfileModel?>(
            valueListenable: _userProfileService.userProfileNotifier,
            builder: (context, userProfile, _) {
              if (userProfile == null) {
                //TODO: Add shimmer loading
                return const CircularProgressIndicator();
              }

              displayNameController.text = userProfile.displayName ?? "";
              emailController.text = userProfile.email ?? "";
              genderController.text = userProfile.gender ?? "";
              numberController.text = userProfile.phoneNumber ?? "";
              String? photoURL = userProfile.customPictureUrl ??
                  userProfile.originalPictureUrl;

              return Column(
                children: [
                  EditPictureProfileScreen(photoURL: photoURL),
                  const Divider(thickness: 0.5, color: EcoPointsColors.black),
                  Gap(height * 0.01),
                  UserFieldsProfileScreen(
                    displayNameController: displayNameController,
                    emailController: emailController,
                    genderController: genderController,
                    numberController: numberController,
                    numberFn: numberFn,
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: InkWell(
                        onTap: () {
                          onLogoutClick(context);
                        },
                        child: Text(
                          "Log out",
                          style: EcoPointsTextStyles.redTextStyle(
                            size: width * 0.04,
                            weight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  void onLogoutClick(BuildContext context) {
    WaitingDialog.show(
      context,
      future: Future.delayed(const Duration(seconds: 1)).then((_) async {
        await AuthController.I.logout();
      }),
      prompt: "Logging out...",
    );
  }
}
