import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../../components/constants/colors/ecopoints_colors.dart';
import '../../../../components/constants/text_style/ecopoints_themes.dart';
import '../../../../components/dialogs/loading_dialog.dart';
import '../../../../controllers/auth_controller.dart';
import '../../../../models/setting_option_model.dart';

class SettingsMenuAccountScreen extends StatelessWidget {
  final List<SettingOption> settingsOptions;
  const SettingsMenuAccountScreen({super.key, required this.settingsOptions});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Container(
      width: width,
      height: height * 0.718,
      decoration: BoxDecoration(
        color: EcoPointsColors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Settings",
              style: EcoPointsTextStyles.blackTextStyle(
                size: width * 0.055,
                weight: FontWeight.w500,
              ),
            ),
            Gap(height * 0.02),
            Expanded(
              child: ListView.builder(
                itemCount: settingsOptions.length,
                itemBuilder: (context, index) {
                  final option = settingsOptions[index];
                  return Column(
                    children: [
                      InkWell(
                        onTap: option.onTap,
                        child: Row(
                          children: [
                            Image.asset(option.iconPath),
                            Gap(width * 0.035),
                            Text(
                              option.name,
                              style: EcoPointsTextStyles.blackTextStyle(
                                size: width * 0.045,
                                weight: FontWeight.normal,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Gap(height * 0.02),
                    ],
                  );
                },
              ),
            ),
            ElevatedButton(
              onPressed: () {
                onLogoutClick(context);
              },
              child: const Text("Log out"),
            ),
          ],
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
