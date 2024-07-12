import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import '../../../../components/dialogs/loading_dialog.dart';
import '../../../../components/dialogs/successful_scan_dialog.dart';
import '../../../../models/recycling_log_model.dart';
import '../../../../routes/router.dart';
import '../../../../shared/services/recycling_log_service.dart';
import '../../home-screen/home_screen.dart';

class MobileScannerQRScreen extends StatefulWidget {
  const MobileScannerQRScreen({super.key});

  @override
  State<MobileScannerQRScreen> createState() => _MobileScannerQRScreenState();
}

class _MobileScannerQRScreenState extends State<MobileScannerQRScreen> {
  final MobileScannerController controller = MobileScannerController(
    detectionSpeed: DetectionSpeed.noDuplicates,
    returnImage: true,
  );

  @override
  void initState() {
    super.initState();
    controller.start();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  bool _isProcessing = false;

  @override
  Widget build(BuildContext context) {
    return MobileScanner(
      controller: controller,
      onDetect: (capture) async {
        if (_isProcessing) return;

        setState(() {
          _isProcessing = true;
        });

        final List<Barcode> barcodes = capture.barcodes;
        for (final barcode in barcodes) {
          print('Barcode found! ${barcode.rawValue}');
          //* Parse the QR code content (json)
          //TODO: implement backend logic to validate QR code and update user info appropriately
          if (barcode.rawValue != null) {
            final data = jsonDecode(barcode.rawValue!);

            if (data != null &&
                data['points'] != null &&
                data['bottles_recycled'] != null) {
              RecyclingLogService recyclingLogService =
                  GetIt.instance<RecyclingLogService>();

              RecyclingLogModel newLog = RecyclingLogModel(
                dateTime: DateTime.now(),
                bottlesRecycled: data['bottles_recycled'],
                pointsGained: data['points'],
              );

              await WaitingDialog.show(
                context,
                future: Future.delayed(const Duration(seconds: 2)),
              );

              if (mounted) {
                print("I AM MOUNTED");
                Navigator.of(context).pop();
                await Future.delayed(const Duration(milliseconds: 500));

                // Navigate to home screen and wait for it to complete
                GlobalRouter.I.router.goNamed(HomeScreen.name);

                // Add the log
                await recyclingLogService.addRecyclingLog(newLog);
                print("Recycling log added and user points updated.");

                // Showing the dialog after navigating to HomeScreen
                showDialog(
                  context: GlobalRouter
                      .I.router.routerDelegate.navigatorKey.currentContext!,
                  barrierDismissible: false,
                  builder: (context) => SuccessfulScanDialog(
                    bottlesRecycled: data['bottles_recycled'],
                    pointsGained: data['points'],
                  ),
                );
              }
            }
          }
        }

        Future.delayed(const Duration(seconds: 7), () {
          if (mounted) {
            setState(() {
              _isProcessing = false;
            });
          }
        });
      },
    );
  }
}
