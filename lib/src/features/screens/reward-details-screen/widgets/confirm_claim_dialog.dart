import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import '../../../../components/buttons/custom_elevated_button.dart';
import '../../../../components/constants/colors/ecopoints_colors.dart';
import '../../../../components/constants/text_style/ecopoints_themes.dart';
import '../../../../components/dialogs/loading_dialog.dart';
import '../../../../models/transaction_model.dart';
import '../../../../routes/router.dart';
import '../../../../shared/services/rewards_firestore_service.dart';
import '../../../../shared/services/transaction_service.dart';
import '../../../../shared/utils/debouncer.dart';
import '../../transaction-receipt-screen/transaction_receipt_screen.dart';

class ConfirmClaimDialog extends StatelessWidget {
  final TransactionModel transaction;
  const ConfirmClaimDialog({super.key, required this.transaction});

  static final Debouncer debouncer = Debouncer(milliseconds: 1000);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final TransactionService transactionService = TransactionService();
    final RewardsService rewardService = GetIt.instance<RewardsService>();

    return Dialog(
      child: Container(
        height: height * 0.4,
        width: width * 0.8,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: EcoPointsColors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset("assets/images/confirm-redeem-image.png"),
                    const Gap(10),
                    Text(
                      "Confirm Redeem?",
                      style: EcoPointsTextStyles.darkGreenTextStyle(
                        size: width * 0.05,
                        weight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const Gap(5),
                    Text(
                      "Points cannot be refunded once redeemed.",
                      style: EcoPointsTextStyles.blackTextStyle(
                        size: width * 0.035,
                        weight: FontWeight.normal,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CustomElevatedButton(
                  borderRadius: 50,
                  backgroundColor: EcoPointsColors.red,
                  onPressed: () {
                    context.pop();
                  },
                  child: Text(
                    "Cancel",
                    style: EcoPointsTextStyles.whiteTextStyle(
                      size: width * 0.04,
                      weight: FontWeight.w600,
                    ),
                  ),
                ),
                CustomElevatedButton(
                  borderRadius: 50,
                  backgroundColor: EcoPointsColors.darkGreen,
                  onPressed: () {
                    onConfirmClick(context, transaction, transactionService,
                        rewardService);
                  },
                  child: Text(
                    "Confirm",
                    style: EcoPointsTextStyles.whiteTextStyle(
                      size: width * 0.04,
                      weight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  onConfirmClick(
      BuildContext context,
      TransactionModel transaction,
      TransactionService transactionService,
      RewardsService rewardService) async {
    await WaitingDialog.show(
      context,
      future: Future.delayed(const Duration(seconds: 2)).then(
        (_) async {
          rewardService.updateRewardStock(
              transaction.reward.rewardID, transaction.quantity);
          rewardService.updateTimesClaimed(
              transaction.reward.rewardID, transaction.quantity);
          await transactionService.addTransaction(transaction);
          if (debouncer.canExecute()) {
            GlobalRouter.I.router
                .go(TransactionReceiptScreen.route, extra: transaction);
          }
        },
      ),
    );
  }
}
