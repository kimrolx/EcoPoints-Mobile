import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../../components/constants/colors/ecopoints_colors.dart';
import '../../../components/dialogs/loading_dialog.dart';
import '../../../controllers/auth_controller.dart';
import '../../../models/setting_option_model.dart';
import '../../../models/user_profile_model.dart';
import '../../../routes/router.dart';
import '../../../shared/services/user_profile_service.dart';
import '../profile-screen/profile_screen.dart';
import '../recycling-log-screen/recycling_log_screen.dart';
import 'widgets/edit_profile.dart';
import 'widgets/settings_menu.dart';

class AccountScreen extends StatefulWidget {
  static const String route = "/account";
  static const String path = "/account";
  static const String name = "AccountScreen";
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  final UserProfileService _userProfileService =
      GetIt.instance<UserProfileService>();

  late List<SettingOption> settingsOptions;

  @override
  void initState() {
    super.initState();
    initializeSettingsOptions();
  }

  void initializeSettingsOptions() {
    settingsOptions = [
      SettingOption(
        iconPath: 'assets/icons/recycle-icon.png',
        name: 'Recycling Log',
        onTap: onRecyclingLogClick,
      ),
      SettingOption(
        iconPath: 'assets/icons/deduct-icon.png',
        name: 'Transaction History',
        onTap: () {
          //TODO: add transaction history event handler here
          print('Transaction History tapped');
        },
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: EcoPointsColors.lightGray,
      body: SafeArea(
        child: Center(
          child: ValueListenableBuilder<UserProfileModel?>(
            valueListenable: _userProfileService.userProfileNotifier,
            builder: (context, userProfile, _) {
              if (userProfile == null) {
                //TODO: add shimmer loading
                return const CircularProgressIndicator();
              }

              String? displayName =
                  userProfile.displayName ?? "No Display Name";
              String photoURL = (userProfile.customPictureUrl ??
                  userProfile.originalPictureUrl)!;

              return Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: width * 0.08, vertical: height * 0.02),
                    child: EditProfileAccountScreen(
                      onTap: onEditProfileClick,
                      displayName: displayName,
                      photoURL: photoURL,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      left: width * 0.03,
                      right: width * 0.03,
                      bottom: height * 0.02,
                    ),
                    child: SettingsMenuAccountScreen(
                      settingsOptions: settingsOptions,
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

  onEditProfileClick() {
    GlobalRouter.I.router.push(EditProfileScreen.route);
  }

  void onRecyclingLogClick() {
    GlobalRouter.I.router
        .push('${AccountScreen.path}/${RecyclingLogScreen.route}');
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
