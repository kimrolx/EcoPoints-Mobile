import 'package:ecopoints/src/components/misc/error_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get_it/get_it.dart';

import '../../../components/constants/colors/ecopoints_colors.dart';
import '../../../components/constants/text_style/ecopoints_themes.dart';
import '../../../models/transaction_model.dart';
import '../../../shared/services/transaction_service.dart';
import '../../../shared/utils/date_formatter_util.dart';
import 'widgets/transaction_details_dialog.dart';

class TransactionHistoryScreen extends StatefulWidget {
  static const String route = "transactionhistory";
  static const String path = "transactionhistory";
  static const String name = "TransactionHistoryScreen";
  const TransactionHistoryScreen({super.key});

  @override
  State<TransactionHistoryScreen> createState() =>
      _TransactionHistoryScreenState();
}

class _TransactionHistoryScreenState extends State<TransactionHistoryScreen> {
  final TransactionService _transactionService =
      GetIt.instance<TransactionService>();

  void _showTransactionDetailsDialog(
      BuildContext context, TransactionModel transaction) {
    showDialog(
        context: context,
        builder: (context) => TransactionDetailsDialogTransactionHistoryScreen(
            transaction: transaction));
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: EcoPointsColors.white,
      appBar: AppBar(
        backgroundColor: EcoPointsColors.darkGreen,
        centerTitle: true,
        title: Text(
          "Recycling Log",
          style: EcoPointsTextStyles.whiteTextStyle(
              size: width * 0.04, weight: FontWeight.w600),
        ),
        leading: IconButton(
          icon: const Icon(
            CupertinoIcons.back,
            color: EcoPointsColors.white,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Recent Recycling Activities",
                style: EcoPointsTextStyles.blackTextStyle(
                  size: width * 0.045,
                  weight: FontWeight.w500,
                ),
              ),
              _buildTransactionHistoryList(width, height),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTransactionHistoryList(double width, double height) {
    return StreamBuilder<List<TransactionModel>>(
      stream: _transactionService.getUserTransactions(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Padding(
            padding: const EdgeInsets.only(top: 20),
            child: ErrorText(
              width: width,
              text:
                  "Oh no! Something went wrong. Please try again later or contact support.",
            ),
          );
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Padding(
            padding: const EdgeInsets.only(top: 20),
            child: ErrorText(
              width: width,
              text: "It seems you don't have any transactions yet.",
            ),
          );
        } else {
          final logs = snapshot.data!;
          return Padding(
            padding: EdgeInsets.only(
              left: width * 0.01,
              right: width * 0.01,
              top: height * 0.025,
            ),
            child: ListView.builder(
              padding: EdgeInsets.zero,
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: logs.length,
              itemBuilder: (context, index) {
                final log = logs[index];
                return Padding(
                  padding: EdgeInsets.only(bottom: height * 0.02),
                  child: _buildTransactionRow(log, context),
                );
              },
            ),
          );
        }
      },
    );
  }

  Widget _buildTransactionRow(
      TransactionModel transaction, BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final formattedDate =
        DateFormatterUtil.formatDateWithTime(transaction.timeCreated);

    return GestureDetector(
      onTap: () => _showTransactionDetailsDialog(context, transaction),
      child: Container(
        color: Colors.transparent,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.asset("assets/images/deduct-image.png"),
            Gap(width * 0.03),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Points Deducted",
                  style: EcoPointsTextStyles.blackTextStyle(
                    size: width * 0.035,
                    weight: FontWeight.w500,
                  ),
                ),
                Text(
                  formattedDate,
                  style: EcoPointsTextStyles.grayTextStyle(
                    size: width * 0.032,
                    weight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            const Spacer(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  "-${transaction.totalPrice.toStringAsFixed(2)}pts",
                  style: EcoPointsTextStyles.redTextStyle(
                    size: width * 0.035,
                    weight: FontWeight.w600,
                  ),
                ),
                Text(
                  "${transaction.oldPoints.toStringAsFixed(2)}pts",
                  style: EcoPointsTextStyles.grayTextStyle(
                    size: width * 0.032,
                    weight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
