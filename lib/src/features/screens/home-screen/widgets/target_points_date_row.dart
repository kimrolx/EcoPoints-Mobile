import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../../../components/constants/text_style/ecopoints_themes.dart';
import '../../../../models/user_profile_model.dart';
import '../../../../shared/services/user_profile_service.dart';

class TargetPointsDateHomeScreen extends StatefulWidget {
  const TargetPointsDateHomeScreen({super.key});

  @override
  State<TargetPointsDateHomeScreen> createState() =>
      _TargetPointsDateHomeScreenState();
}

class _TargetPointsDateHomeScreenState
    extends State<TargetPointsDateHomeScreen> {
  final UserProfileService _userProfileService =
      GetIt.instance<UserProfileService>();

  @override
  void initState() {
    super.initState();
    _userProfileService.loadUserProfile();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return ValueListenableBuilder<UserProfileModel?>(
      valueListenable: _userProfileService.userProfileNotifier,
      builder: (context, userProfile, _) {
        if (userProfile == null) {
          return const Center(child: CircularProgressIndicator());
        }

        double points = userProfile.points ?? 0.00;
        double? targetPoints = userProfile.targetPoints;
        DateTime? targetDate = userProfile.targetDate;

        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            if (targetPoints != null && targetPoints != 0)
              Column(
                children: [
                  Image.asset("assets/images/target-points.png"),
                  Text(
                    "Target Points",
                    style: EcoPointsTextStyles.blackTextStyle(
                      size: width * 0.03,
                      weight: FontWeight.w400,
                    ),
                  ),
                  Text(
                    "${(targetPoints - points).toStringAsFixed(2)}pts left",
                    style: EcoPointsTextStyles.blackTextStyle(
                      size: width * 0.035,
                      weight: FontWeight.w600,
                    ),
                  )
                ],
              ),
            if (targetDate != null)
              Column(
                children: [
                  Image.asset("assets/images/target-date.png"),
                  Text(
                    "Target Date",
                    style: EcoPointsTextStyles.blackTextStyle(
                      size: width * 0.03,
                      weight: FontWeight.w400,
                    ),
                  ),
                  Text(
                    "${DateTime.now().difference(targetDate).inDays.abs()} days left",
                    style: EcoPointsTextStyles.blackTextStyle(
                      size: width * 0.035,
                      weight: FontWeight.w600,
                    ),
                  )
                ],
              ),
          ],
        );
      },
    );
  }
}
