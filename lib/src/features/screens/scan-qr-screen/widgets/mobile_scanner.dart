import 'dart:convert';

import 'package:ecopoints/src/shared/services/qr_code_service.dart';
import 'package:ecopoints/src/shared/services/user_profile_service.dart';
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
import '../../../../shared/utils/debouncer.dart';
import '../../home-screen/home_screen.dart';

class MobileScannerQRScreen extends StatefulWidget {
  const MobileScannerQRScreen({super.key});

  @override
  State<MobileScannerQRScreen> createState() => _MobileScannerQRScreenState();
}

class _MobileScannerQRScreenState extends State<MobileScannerQRScreen> {
  final QrCodeService qrCodeService = GetIt.instance<QrCodeService>();
  final UserProfileService userProfileService =
      GetIt.instance<UserProfileService>();
  final MobileScannerController controller = MobileScannerController(
    detectionSpeed: DetectionSpeed.noDuplicates,
  );

  static final Debouncer debouncer = Debouncer(milliseconds: 1000);

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
                  data['bottles_recycled'] != null &&
                  data['uuid'] != null) {
                if (!mounted) return;

                bool isAlreadyScanned =
                    await qrCodeService.checkIfScanned(data['uuid']);

                if (isAlreadyScanned) {
                  if (debouncer.canExecute()) {
                    _showErrorDialog(
                      GlobalRouter
                          .I.router.routerDelegate.navigatorKey.currentContext!,
                      "This QR code has already been scanned.",
                      width,
                      height,
                    );
                  }
                } else {
                  RecyclingLogService recyclingLogService =
                      GetIt.instance<RecyclingLogService>();

                  RecyclingLogModel newLog = RecyclingLogModel(
                    dateTime: DateTime.now(),
                    bottlesRecycled: data['bottles_recycled'],
                    pointsGained: (data['points'] is int)
                        ? (data['points'] as int).toDouble()
                        : data['points'] as double,
                  );

                  await WaitingDialog.show(
                      GlobalRouter
                          .I.router.routerDelegate.navigatorKey.currentContext!,
                      future: Future.delayed(const Duration(seconds: 2)));

                  if (mounted) {
                    GlobalRouter.I.router.go(HomeScreen.route);
                    await recyclingLogService.addRecyclingLog(newLog);

                    await qrCodeService.flagQRCodeAsScanned(
                        data['points'],
                        data['bottles_recycled'],
                        userProfileService.userId!,
                        userProfileService.email!,
                        data['uuid'],
                        data['timestamp']);

                    if (debouncer.canExecute()) {
                      showDialog(
                        context: GlobalRouter.I.router.routerDelegate
                            .navigatorKey.currentContext!,
                        barrierDismissible: false,
                        builder: (context) => SuccessfulScanDialog(
                          bottlesRecycled: data['bottles_recycled'],
                          pointsGained: (data['points'] is int)
                              ? (data['points'] as int).toDouble()
                              : data['points'] as double,
                        ),
                      );
                    }

                    print("Recycling log added and user points updated.");
                  }
                }
              } else {
                if (debouncer.canExecute()) {
                  _showErrorDialog(
                    context,
                    "The QR code is not supported by EcoPoints. Please scan a valid EcoPoints trashcan QR Code, or EcoPoints vendor QR code.",
                    width,
                    height,
                  );
                }
              }
            } catch (e) {
              if (debouncer.canExecute()) {
                _showErrorDialog(
                  GlobalRouter
                      .I.router.routerDelegate.navigatorKey.currentContext!,
                  "Oh no! There was an error processing the QR code. Please try again or contact support.",
                  width,
                  height,
                );
              }
            }
          } else {
            if (debouncer.canExecute()) {
              _showErrorDialog(
                context,
                "This is an empty barcode. Please scan a valid EcoPoints trashcan QR Code, or EcoPoints vendor QR code.",
                width,
                height,
              );
            }
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
                textAlign: TextAlign.center,
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
