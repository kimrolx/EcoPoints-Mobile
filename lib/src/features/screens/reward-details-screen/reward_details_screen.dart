import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../../components/constants/colors/ecopoints_colors.dart';
import '../../../models/reward_model.dart';
import '../../../models/transaction_model.dart';
import '../../../shared/services/user_profile_service.dart';
import 'widgets/confirm_claim_dialog.dart';
import 'widgets/insufficient_points_dialog.dart';
import 'widgets/picture_stack.dart';
import 'widgets/text_details_container.dart';

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
  final UserProfileService _userProfileService =
      GetIt.instance<UserProfileService>();

  late double totalPrice;
  int totalAmount = 1;
  String userName = '';

  @override
  void initState() {
    super.initState();
    _fetchUserName();
    _userProfileService.loadUserProfile();
    totalPrice = widget.reward.requiredPoint;
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

  void _showInsuffientPointsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => const InsufficientPointsDialogRewardDetailsScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: EcoPointsColors.white,
      body: Stack(
        children: [
          SizedBox(width: width, height: height),
          Container(
            height: height * 0.55,
            color: EcoPointsColors.red,
            child: PictureStackRewardDetailsScreen(
              reward: widget.reward,
            ),
          ),
          Positioned(
            top: height * 0.5,
            left: 0,
            right: 0,
            child: TextDetailsContainerRewardDetailsScreen(
              reward: widget.reward,
              totalAmount: totalAmount,
              onAmountChanged: (newAmount) {
                setState(() {
                  totalAmount = newAmount;
                  totalPrice = widget.reward.requiredPoint * totalAmount;
                });
              },
              onClaimPressed: onClaimPressed,
            ),
          ),
        ],
      ),
    );
  }

  onClaimPressed() {
    final transaction = TransactionModel(
      reward: widget.reward,
      quantity: totalAmount,
      totalPrice: totalPrice,
      timeCreated: DateTime.now(),
      referenceId: ReferenceIdGenerator.generateReferenceId(),
      userName: userName,
    );

    double userPoints = _userProfileService.userProfile?.points ?? 0.00;
    if (userPoints >= totalPrice) {
      _showConfirmClaimDialog(context, transaction);
    } else {
      _showInsuffientPointsDialog(context);
    }
  }
}
