import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get_it/get_it.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import '../../../../components/buttons/custom_elevated_button.dart';
import '../../../../components/constants/colors/ecopoints_colors.dart';
import '../../../../components/constants/text_style/ecopoints_themes.dart';
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
  bool _isShowingDialog = false;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return MobileScanner(
      controller: controller,
      onDetect: (capture) async {
        if (_isProcessing || _isShowingDialog) return;

        setState(() {
          _isProcessing = true;
        });

        final List<Barcode> barcodes = capture.barcodes;
        for (final barcode in barcodes) {
          print('Barcode found! ${barcode.rawValue}');
          if (barcode.rawValue != null) {
            try {
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
                  await Future.delayed(const Duration(milliseconds: 500));

                  GlobalRouter.I.router.goNamed(HomeScreen.name);

                  await recyclingLogService.addRecyclingLog(newLog);

                  showDialog(
                    context: GlobalRouter
                        .I.router.routerDelegate.navigatorKey.currentContext!,
                    barrierDismissible: false,
                    builder: (context) => SuccessfulScanDialog(
                      bottlesRecycled: data['bottles_recycled'],
                      pointsGained: data['points'],
                    ),
                  );

                  print("Recycling log added and user points updated.");
                }
              } else {
                _showErrorDialog(
                  context,
                  "The QR code is not supported by EcoPoints. Please scan a valid EcoPoints trashcan QR Code, or EcoPoints vendor QR code.",
                  width,
                  height,
                );
              }
            } catch (e) {
              _showErrorDialog(
                context,
                "The QR code is not supported by EcoPoints. Please scan a valid EcoPoints trashcan QR Code, or EcoPoints vendor QR code.",
                width,
                height,
              );
            }
          } else {
            _showErrorDialog(
              context,
              "The QR code is not supported by EcoPoints. Please scan a valid EcoPoints trashcan QR Code, or EcoPoints vendor QR code.",
              width,
              height,
            );
          }
        }

        if (mounted) {
          setState(() {
            _isProcessing = false;
          });
        }
      },
    );
  }

  void _showErrorDialog(
    BuildContext context,
    String message,
    double width,
    double height,
  ) {
    setState(() {
      _isShowingDialog = true;
    });

    showModalBottomSheet(
      context: context,
      isDismissible: false,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "QR code is not valid",
                style: EcoPointsTextStyles.redTextStyle(
                  size: width * 0.045,
                  weight: FontWeight.bold,
                ),
              ),
              Gap(height * 0.015),
              Text(
                message,
                style: EcoPointsTextStyles.blackTextStyle(
                  size: width * 0.035,
                  weight: FontWeight.normal,
                ),
              ),
              Gap(height * 0.015),
              Center(
                child: CustomElevatedButton(
                  width: width,
                  backgroundColor: EcoPointsColors.darkGreen,
                  borderRadius: 50,
                  onPressed: () async {
                    Navigator.of(context).pop();
                    setState(() {
                      _isProcessing = false;
                      _isShowingDialog = false;
                    });
                  },
                  child: Text(
                    "Okay",
                    style: EcoPointsTextStyles.whiteTextStyle(
                      size: width * 0.045,
                      weight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
