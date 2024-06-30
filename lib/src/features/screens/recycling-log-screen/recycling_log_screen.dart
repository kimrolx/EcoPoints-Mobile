import 'package:flutter/material.dart';

import '../../../components/constants/colors/ecopoints_colors.dart';

class RecyclingLogScreen extends StatelessWidget {
  static const String route = "recycling-log";
  static const String path = "recycling-log";
  static const String name = "Recycling Log Screen";
  const RecyclingLogScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: EcoPointsColors.lightGray,
      body: Center(child: Text("Recycling Log")),
    );
  }
}
