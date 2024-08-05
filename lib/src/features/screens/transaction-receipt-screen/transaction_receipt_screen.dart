import 'package:ecopoints/src/features/screens/transaction-receipt-screen/widgets/transaction_details.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../components/constants/colors/ecopoints_colors.dart';
import '../../../models/transaction_model.dart';
import '../../../routes/router.dart';
import '../home-screen/home_screen.dart';
import 'widgets/close_receipt_button.dart';
import 'widgets/green_background.dart';
import 'widgets/header.dart';

class TransactionReceiptScreen extends StatelessWidget {
  final TransactionModel transaction;
  static const String route = "/transaction-receipt";
  static const String path = "/transaction-receipt";
  static const String name = "TransactionReceiptScreen";

  const TransactionReceiptScreen({super.key, required this.transaction});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: EcoPointsColors.white,
      body: Stack(
        children: [
          SizedBox(
            width: width,
            height: height,
          ),
          Container(height: height * 0.5, color: EcoPointsColors.white),
          Positioned(
            top: height * 0.5,
            left: 0,
            right: 0,
            child: const GreenBackgroundTransactionReceiptScreen(),
          ),
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CloseTransactionReceiptScreen(onPressed: onCloseClick),
                Gap(height * 0.03),
                const Center(
                  child: HeaderTransactionReceiptScreen(),
                ),
                Gap(height * 0.04),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: width * 0.08),
                  child: TransactionDetailsTransactionReceiptScreen(
                      transaction: transaction),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  onCloseClick() {
    GlobalRouter.I.router.go(HomeScreen.route);
  }
}
