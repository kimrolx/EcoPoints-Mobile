import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../components/constants/colors/ecopoints_colors.dart';
import 'mobile_scanner.dart';

class ScanQRScreen extends StatefulWidget {
  static const String route = "/scanqr";
  static const String path = "/scanqr";
  static const String name = "ScanQRScreen";
  const ScanQRScreen({super.key});

  @override
  State<ScanQRScreen> createState() => _ScanQRScreenState();
}

class _ScanQRScreenState extends State<ScanQRScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () => Navigator.pop,
            icon: const Icon(CupertinoIcons.back),
          ),
          title: const Text("Scan QR"),
          centerTitle: true,
        ),
        backgroundColor: EcoPointsColors.lightGray,
        body: const MobileScannerQRScreen());
  }
}
