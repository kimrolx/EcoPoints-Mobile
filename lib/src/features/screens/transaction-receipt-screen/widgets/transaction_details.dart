import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../../components/constants/colors/ecopoints_colors.dart';
import '../../../../components/constants/text_style/ecopoints_themes.dart';
import '../../../../components/misc/receipt_separator.dart';
import '../../../../models/transaction_model.dart';
import '../../../../shared/utils/date_formatter_util.dart';

class TransactionDetailsTransactionReceiptScreen extends StatelessWidget {
  final TransactionModel transaction;
  const TransactionDetailsTransactionReceiptScreen(
      {super.key, required this.transaction});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    String formattedDate =
        DateFormatterUtil.formatDateWithTime(transaction.timeCreated);

    return Container(
      height: 390,
      decoration: BoxDecoration(
        color: EcoPointsColors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: EcoPointsColors.darkGray.withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                SizedBox(
                  height: 75,
                  width: 75,
                  child: ClipOval(
                    child: Image.network(
                      transaction.reward.rewardPicture,
                      fit: BoxFit.cover,
                      width: 75,
                      height: 75,
                    ),
                  ),
                ),
                Gap(width * 0.025),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        transaction.reward.rewardName,
                        style: EcoPointsTextStyles.blackTextStyle(
                            size: width * 0.055, weight: FontWeight.w500),
                      ),
                      Text(
                        transaction.reward.rewardDescription,
                        style: EcoPointsTextStyles.grayTextStyle(
                            size: width * 0.035, weight: FontWeight.normal),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Gap(height * 0.02),
            rowBuilder("Name", transaction.userName, width),
            Gap(height * 0.007),
            rowBuilder("Amount", "x${transaction.quantity}", width),
            Gap(height * 0.007),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Total Points",
                  style: EcoPointsTextStyles.blackTextStyle(
                      size: width * 0.04, weight: FontWeight.normal),
                ),
                Text(
                  "${transaction.totalPrice.toStringAsFixed(2)}pts",
                  style: EcoPointsTextStyles.lightGreenTextStyle(
                    size: width * 0.04,
                    weight: FontWeight.w600,
                    decoration: TextDecoration.underline,
                    decorationColor: EcoPointsColors.lightGreen,
                  ),
                ),
              ],
            ),
            Gap(height * 0.007),
            rowBuilder("Date and Time", formattedDate, width),
            Expanded(
              child: Center(
                child: Text(
                  "Claim at ${transaction.reward.stallName} - ${transaction.reward.campus} Campus",
                  textAlign: TextAlign.center,
                  style: EcoPointsTextStyles.blackTextStyle(
                      size: width * 0.04, weight: FontWeight.w500),
                ),
              ),
            ),
            const MySeparator(),
            Gap(height * 0.02),
            Center(
              child: Text(
                transaction.referenceId,
                textAlign: TextAlign.center,
                style: EcoPointsTextStyles.lightGreenTextStyle(
                    size: width * 0.1, weight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget rowBuilder(String title, String value, double width) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: Text(
            title,
            style: EcoPointsTextStyles.blackTextStyle(
                size: width * 0.038, weight: FontWeight.normal),
          ),
        ),
        Flexible(
          child: Text(
            value,
            style: EcoPointsTextStyles.blackTextStyle(
                size: width * 0.038, weight: FontWeight.normal),
            textAlign: TextAlign.end,
          ),
        ),
      ],
    );
  }
}
