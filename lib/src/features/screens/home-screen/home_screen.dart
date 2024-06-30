import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get_it/get_it.dart';

import '../../../components/constants/colors/ecopoints_colors.dart';
import '../../../models/user_profile_model.dart';
import '../../../shared/services/user_service.dart';
import 'widgets/goal_setter.dart';
import 'widgets/points_indicator.dart';
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
  final UserService _userService = GetIt.instance<UserService>();
  double points = 0.0;

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
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

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
                  top: height * 0.12,
                  left: width * 0.16,
                  right: width * 0.16,
                  child: PointsIndicatorHomeScreen(
                    points: points,
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.03),
              child: const GoalSetterHomeScreen(),
            ),
            Gap(height * 0.025),
            const TransactionsHomeScreen(),
          ],
        ),
      ),
    );
  }
}
