import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

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
      onDetect: (capture) {
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
            Future.delayed(const Duration(seconds: 5), () {
              setState(() {
                _isProcessing = false;
              });
            });
          });
        } else {
          print("No image found");
          Future.delayed(const Duration(seconds: 5), () {
            setState(() {
              _isProcessing = false;
            });
          });
        }
      },
    );
  }
}
