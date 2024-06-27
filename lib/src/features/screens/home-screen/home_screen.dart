import 'package:ecopoints/src/components/constants/colors/ecopoints_colors.dart';
import 'package:ecopoints/src/features/screens/home-screen/widgets/goal_setter.dart';
import 'package:ecopoints/src/features/screens/home-screen/widgets/points_indicator.dart';
import 'package:ecopoints/src/features/screens/home-screen/widgets/transactions.dart';
import 'package:ecopoints/src/features/screens/home-screen/widgets/trashcan_background.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class HomeScreen extends StatelessWidget {
  static const String route = "/home";
  static const String path = "/home";
  static const String name = "Home Screen";

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: EcoPointsColors.lighGray,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: SizedBox(
          height: height,
          width: width,
          child: Stack(
            children: [
              const TrashcanBackgroundHomeScreen(),
              Positioned(
                top: height * 0.12,
                left: width * 0.16,
                right: width * 0.16,
                child: const PointsIndicatorHomeScreen(),
              ),
              Positioned(
                top: height * 0.45,
                left: 0,
                right: 0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: width * 0.03),
                      child: const GoalSetterHomeScreen(),
                    ),
                    Gap(height * 0.02),
                    const TransactionsHomeScreen()
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
