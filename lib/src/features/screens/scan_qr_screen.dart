import 'package:flutter/material.dart';

class ScanQRScreen extends StatelessWidget {
  static const String route = "/scanQR";
  static const String path = "/scanQR";
  static const String name = "Scan QR Screen";
  const ScanQRScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("QR"),
      ),
    );
  }
}
