import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import '../../../../models/recycling_log_model.dart';
import '../../../../shared/services/recycling_log_service.dart';

class MobileScannerQRScreen extends StatefulWidget {
  final MobileScannerController controller;
  const MobileScannerQRScreen({super.key, required this.controller});

  @override
  State<MobileScannerQRScreen> createState() => _MobileScannerQRScreenState();
}

class _MobileScannerQRScreenState extends State<MobileScannerQRScreen> {
  bool _isProcessing = false;

  @override
  Widget build(BuildContext context) {
    return MobileScanner(
      controller: widget.controller,
      onDetect: (capture) async {
        if (_isProcessing) return;

        setState(() {
          _isProcessing = true;
        });

        final List<Barcode> barcodes = capture.barcodes;
        final Uint8List? image = capture.image;
        for (final barcode in barcodes) {
          print('Barcode found! ${barcode.rawValue}');
        }

        if (image != null) {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text(
                  barcodes.first.rawValue ?? "",
                ),
                content: Image(
                  image: MemoryImage(image),
                ),
              );
            },
          ).then((_) {
            Future.delayed(const Duration(seconds: 7), () {
              setState(() {
                _isProcessing = false;
              });
            });
          });
        } else {
          print("No image found");
          Future.delayed(const Duration(seconds: 7), () {
            setState(() {
              _isProcessing = false;
            });
          });
        }

        // Add points whenever a QR code is scanned
        RecyclingLogService recyclingLogService =
            GetIt.instance<RecyclingLogService>();

        RecyclingLogModel newLog = RecyclingLogModel(
          dateTime: DateTime.now(),
          bottlesRecycled: 10,
          pointsGained: 21.52,
        );

        await recyclingLogService.addRecyclingLog(newLog);
        print("Recycling log added and user points updated.");
      },
    );
  }
}
