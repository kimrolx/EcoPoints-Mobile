import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'widgets/color_filter_background.dart';
import 'widgets/instruction_text.dart';
import 'widgets/mobile_scanner.dart';
import 'widgets/upload_qr_code.dart';

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
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    double cutoutSize = width * 0.65;

    return Material(
      child: Stack(
        children: [
          const MobileScannerQRScreen(),
          ColorFilterBackgroundQRScreen(
            cutoutSize: cutoutSize,
            width: width,
          ),
          SafeArea(
            child: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(CupertinoIcons.xmark, color: Colors.white),
            ),
          ),
          InstructionTextQRScreen(
            width: width,
            height: height,
          ),
          UploadQRCodeScreen(
            width: width,
            height: height,
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
