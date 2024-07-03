import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class MobileScannerQRScreen extends StatefulWidget {
  const MobileScannerQRScreen({super.key});

  @override
  State<MobileScannerQRScreen> createState() => _MobileScannerQRScreenState();
}

class _MobileScannerQRScreenState extends State<MobileScannerQRScreen> {
  @override
  Widget build(BuildContext context) {
    return MobileScanner(
      controller: MobileScannerController(
        detectionSpeed: DetectionSpeed.noDuplicates,
      ),
      onDetect: (capture) {},
    );
  }
}
