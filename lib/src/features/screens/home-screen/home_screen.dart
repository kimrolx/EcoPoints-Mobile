import 'package:ecopoints/src/components/constants/colors/ecopoints_colors.dart';
import 'package:ecopoints/src/features/screens/home-screen/widgets/points_indicator.dart';
import 'package:ecopoints/src/features/screens/home-screen/widgets/trashcan_background.dart';
import 'package:flutter/material.dart';

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
      body: SizedBox(
        height: height,
        width: width,
        child: const Stack(
          children: [
            TrashcanBackgroundHomeScreen(),
            PointsIndicatorHomeScreen(),
          ],
        ),
      ),
    );
  }
}
