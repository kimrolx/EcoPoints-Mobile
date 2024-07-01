import 'package:ecopoints/src/components/constants/text_style/ecopoints_themes.dart';
import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';

import '../../../../models/user_profile_model.dart';
import '../../../../shared/services/user_service.dart';

class TargetPointsDateHomeScreen extends StatefulWidget {
  const TargetPointsDateHomeScreen({super.key});

  @override
  State<TargetPointsDateHomeScreen> createState() =>
      _TargetPointsDateHomeScreenState();
}

class _TargetPointsDateHomeScreenState
    extends State<TargetPointsDateHomeScreen> {
  final UserFirestoreService _userService =
      GetIt.instance<UserFirestoreService>();

  UserProfileModel? userProfile;

  @override
  void initState() {
    super.initState();
    loadUserProfile();
  }

  Future<void> loadUserProfile() async {
    UserProfileModel? fetchedProfile = await _userService.getUserProfile();
    setState(() {
      userProfile = fetchedProfile;
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    double points = userProfile?.points ?? 0.0;
    double? targetPoints = userProfile?.targetPoints;
    DateTime? targetDate = userProfile?.targetDate;

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
  }
}
