import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get_it/get_it.dart';

import '../../../components/constants/colors/ecopoints_colors.dart';
import '../../../components/constants/text_style/ecopoints_themes.dart';
import '../../../components/dialogs/loading_dialog.dart';
import '../../../controllers/auth_controller.dart';
import '../../../models/user_profile_model.dart';
import '../../../shared/services/user_service.dart';
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
  final UserService _userService = GetIt.instance<UserService>();
  late TextEditingController fieldDisplayName,
      fieldEmail,
      fieldGender,
      fieldNumber;
  User? user;
  String? photoURL;

  @override
  void initState() {
    super.initState();
    fieldDisplayName = TextEditingController();
    fieldEmail = TextEditingController();
    fieldGender = TextEditingController();
    fieldNumber = TextEditingController();
    getUserInfo();
  }

  void getUserInfo() async {
    user = _userService.getCurrentUser();
    photoURL = _userService.getCurrentUserPhotoURL();

    print("Current User: ${user?.uid}");
    print("Photo URL: $photoURL");

    UserProfile? userProfile = await _userService.getUserProfile();
    if (userProfile != null) {
      setState(() {
        fieldDisplayName.text = user?.displayName ?? "Name";
        fieldEmail.text = user?.email ?? "Email";
        fieldGender.text = userProfile.gender ?? "Gender";
        fieldNumber.text = userProfile.phoneNumber ?? "Phone Number";

        print("Name: ${fieldDisplayName.text}");
        print("Email: ${fieldEmail.text}");
        print("Gender: ${fieldGender.text}");
        print("Phone Number: ${fieldNumber.text}");
      });
    } else {
      print("UserProfile is null");
    }
  }

  @override
  void dispose() {
    fieldDisplayName.dispose();
    fieldEmail.dispose();
    fieldGender.dispose();
    fieldNumber.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: EcoPointsColors.lighGray,
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
          child: Column(
            children: [
              EditPictureProfileScreen(photoURL: photoURL ?? ""),
              const Divider(thickness: 0.5),
              Gap(height * 0.01),
              UserFieldsProfileScreen(
                displayName: fieldDisplayName,
                email: fieldEmail,
                gender: fieldGender,
                number: fieldNumber,
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
    );
  }
}