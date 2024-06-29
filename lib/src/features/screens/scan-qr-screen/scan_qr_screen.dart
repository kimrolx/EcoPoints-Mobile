import 'package:ecopoints/src/components/constants/colors/ecopoints_colors.dart';
import 'package:flutter/material.dart';

class ScanQRScreen extends StatelessWidget {
  static const String route = "/scanqr";
  static const String path = "/scanqr";
  static const String name = "ScanQRScreen";
  const ScanQRScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: EcoPointsColors.lighGray,
      body: Center(
        child: Text("QR"),
      ),
    );
  }
}
