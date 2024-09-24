import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../../components/constants/colors/ecopoints_colors.dart';
import '../../../models/setting_option_model.dart';
import '../../../models/user_profile_model.dart';
import '../../../routes/router.dart';
import '../../../shared/services/user_profile_service.dart';
import '../../../shared/utils/debouncer.dart';
import '../profile-screen/profile_screen.dart';
import '../recycling-log-screen/recycling_log_screen.dart';
import '../transaction-history-screen/transaction_history_screen.dart';
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

  static final Debouncer debouncer = Debouncer(milliseconds: 1000);

  late List<SettingOption> settingsOptions;

  @override
  void initState() {
    super.initState();
    initializeSettingsOptions();
  }

  void initializeSettingsOptions() {
    settingsOptions = [
      SettingOption(
        iconPath: "assets/icons/recycle-icon.png",
        name: "Recycling Log",
        onTap: onRecyclingLogClick,
      ),
      SettingOption(
        iconPath: "assets/icons/deduct-icon.png",
        name: "Transaction History",
        onTap: onTransactionHistoryClick,
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
                  userProfile.originalPictureUrl ??
                  "https://via.placeholder.com/150");

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
    if (debouncer.canExecute()) {
      GlobalRouter.I.router.push(EditProfileScreen.route);
    }
  }

  onRecyclingLogClick() {
    if (debouncer.canExecute()) {
      GlobalRouter.I.router
          .push("${AccountScreen.route}/${RecyclingLogScreen.route}");
    }
  }

  onTransactionHistoryClick() {
    if (debouncer.canExecute()) {
      GlobalRouter.I.router
          .push("${AccountScreen.route}/${TransactionHistoryScreen.route}");
    }
  }
}
