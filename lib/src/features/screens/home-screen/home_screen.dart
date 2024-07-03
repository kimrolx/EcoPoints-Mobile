import 'package:ecopoints/src/components/constants/text_style/ecopoints_themes.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get_it/get_it.dart';

import '../../../components/constants/colors/ecopoints_colors.dart';
import '../../../models/user_profile_model.dart';
import '../../../providers/bottom_sheet_provider.dart';
import '../../../shared/services/user_service.dart';
import 'widgets/goal_setter.dart';
import 'widgets/points_indicator.dart';
import 'widgets/target_points_date_row.dart';
import 'widgets/transactions.dart';
import 'widgets/trashcan_background.dart';

class HomeScreen extends StatefulWidget {
  static const String route = "/home";
  static const String path = "/home";
  static const String name = "HomeScreen";

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final UserFirestoreService _userService =
      GetIt.instance<UserFirestoreService>();

  double points = 0.0;
  double? targetPoints;
  DateTime? targetDate;

  @override
  void initState() {
    super.initState();
    loadUserProfile();
  }

  Future<void> loadUserProfile() async {
    UserProfileModel? userProfile = await _userService.getUserProfile();
    if (userProfile != null) {
      setState(() {
        points = userProfile.points;
        targetPoints = userProfile.targetPoints;
        targetDate = userProfile.targetDate;
      });
    }
  }

  void _updateTargets() {
    loadUserProfile();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    final bottomSheetProvider = BottomSheetProvider.of(context);

    return Scaffold(
      backgroundColor: EcoPointsColors.lightGray,
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                SizedBox(
                  height: height * 0.45,
                  width: width,
                ),
                const TrashcanBackgroundHomeScreen(),
                Positioned(
                  right: width * 0.05,
                  child: SafeArea(
                    child: InkWell(
                      onTap: () {
                        bottomSheetProvider?.showBottomSheet(context);
                      },
                      child: SizedBox(
                        width: 35,
                        height: 35,
                        child: Center(
                          child: Text(
                            "...",
                            style: EcoPointsTextStyles.whiteTextStyle(
                              size: width * 0.07,
                              weight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: height * 0.12,
                  left: width * 0.16,
                  right: width * 0.16,
                  child: PointsIndicatorHomeScreen(
                    points: points,
                    targetPoints: targetPoints,
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.03),
              child: targetPoints != null && targetPoints != 0
                  ? const TargetPointsDateHomeScreen()
                  : GoalSetterHomeScreen(
                      onUpdate: _updateTargets,
                      displayBottomSheet: () {
                        bottomSheetProvider?.showBottomSheet(context);
                      },
                    ),
            ),
            Gap(height * 0.025),
            const TransactionsHomeScreen(),
          ],
        ),
      ),
    );
  }
}
