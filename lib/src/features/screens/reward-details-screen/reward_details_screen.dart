import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../components/buttons/custom_elevated_button.dart';
import '../../../components/constants/colors/ecopoints_colors.dart';
import '../../../components/constants/text_style/ecopoints_themes.dart';
import '../../../models/reward_model.dart';
import '../../../models/transaction_model.dart';
import '../../../shared/utils/date_formatter_util.dart';
import 'widgets/confirm_claim_dialog.dart';
import 'widgets/picture_stack.dart';
import 'widgets/text_details.dart';

class RewardDetailsScreen extends StatefulWidget {
  final RewardModel reward;

  static const String route = "/reward-details";
  static const String path = "/reward-details";
  static const String name = "RewardDetailsScreen";

  const RewardDetailsScreen({super.key, required this.reward});

  @override
  State<RewardDetailsScreen> createState() => _RewardDetailsScreenState();
}

class _RewardDetailsScreenState extends State<RewardDetailsScreen> {
  int totalAmount = 1;
  String userName = '';

  @override
  void initState() {
    super.initState();
    _fetchUserName();
  }

  void _fetchUserName() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      setState(() {
        userName = user.displayName!;
      });
    }
  }

  void _showConfirmClaimDialog(
      BuildContext context, TransactionModel transaction) {
    showDialog(
      context: context,
      builder: (context) => ConfirmClaimDialog(transaction: transaction),
    );
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    String formattedExpiryDate =
        DateFormatterUtil.formatDateWithoutTime(widget.reward.expiryDate);

    return Scaffold(
      backgroundColor: EcoPointsColors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PictureStackRewardDetailsScreen(reward: widget.reward),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: width * 0.03, vertical: height * 0.01),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                      child: TextDetailsRewardDetailsScreen(
                          reward: widget.reward)),
                  Text(
                    "Expires: $formattedExpiryDate",
                    style: EcoPointsTextStyles.blackTextStyle(
                        size: width * 0.035, weight: FontWeight.normal),
                  ),
                  Gap(height * 0.03),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: CustomElevatedButton(
                      borderRadius: 7,
                      width: width * 0.8,
                      backgroundColor: EcoPointsColors.darkGreen,
                      onPressed: () {
                        final transaction = TransactionModel(
                          reward: widget.reward,
                          quantity: totalAmount,
                          totalPrice: widget.reward.requiredPoint * totalAmount,
                          timeCreated: DateTime.now(),
                          referenceId:
                              ReferenceIdGenerator.generateReferenceId(),
                          userName: userName,
                        );
                        _showConfirmClaimDialog(context, transaction);
                      },
                      child: Text(
                        "Claim Reward",
                        style: EcoPointsTextStyles.whiteTextStyle(
                            size: width * 0.04, weight: FontWeight.w600),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
