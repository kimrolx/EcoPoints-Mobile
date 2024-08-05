import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get_it/get_it.dart';

import '../../../../components/constants/text_style/ecopoints_themes.dart';
import '../../../../models/recycling_log_model.dart';
import '../../../../models/transaction_model.dart';
import '../../../../shared/services/recycling_log_service.dart';
import '../../../../shared/services/transaction_service.dart';
import '../../../../shared/services/user_profile_service.dart';
import '../../../../shared/utils/date_formatter_util.dart';

class TransactionsHomeScreen extends StatefulWidget {
  const TransactionsHomeScreen({super.key});

  @override
  State<TransactionsHomeScreen> createState() => _TransactionsHomeScreenState();
}

class _TransactionsHomeScreenState extends State<TransactionsHomeScreen>
    with TickerProviderStateMixin {
  final UserProfileService _userProfileService =
      GetIt.instance<UserProfileService>();
  final RecyclingLogService _recyclingLogService =
      GetIt.instance<RecyclingLogService>();
  final TransactionService _transactionService =
      GetIt.instance<TransactionService>();

  AnimationController? _animationController;

  @override
  void initState() {
    super.initState();
    _userProfileService.loadUserProfile();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 700),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: width * 0.04),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Transactions",
            style: EcoPointsTextStyles.blackTextStyle(
              size: width * 0.04,
              weight: FontWeight.w500,
            ),
          ),
          Gap(height * 0.02),
          _buildCombinedLogList(width, height),
          Gap(height * 0.02)
        ],
      ),
    );
  }

  Widget _buildCombinedLogList(double width, double height) {
    return StreamBuilder<List<RecyclingLogModel>>(
      stream: _recyclingLogService.getRecyclingLogs(),
      builder: (context, recyclingLogSnapshot) {
        return StreamBuilder<List<TransactionModel>>(
          stream: _transactionService.getUserTransactions(),
          builder: (context, transactionSnapshot) {
            if (recyclingLogSnapshot.hasError || transactionSnapshot.hasError) {
              print(
                  "Error loading data: ${recyclingLogSnapshot.error ?? transactionSnapshot.error}");
              return errorText(
                "Oh no! Something went wrong. Please try again later or contact support.",
                width,
              );
            } else if (!recyclingLogSnapshot.hasData ||
                !transactionSnapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            } else if (recyclingLogSnapshot.data!.isEmpty &&
                transactionSnapshot.data!.isEmpty) {
              return errorText(
                "It seems you don't have any transactions yet. Start recycling now!",
                width,
              );
            }

            final recyclingLogs = recyclingLogSnapshot.data!;
            final transactions = transactionSnapshot.data!;

            List<CombinedData> combinedList = [
              ...recyclingLogs.map((log) => CombinedData(log, log.dateTime)),
              ...transactions.map((transaction) =>
                  CombinedData(transaction, transaction.timeCreated))
            ];

            combinedList.sort((a, b) => b.date.compareTo(a.date));

            return ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              itemCount: combinedList.length,
              itemBuilder: (context, index) {
                final item = combinedList[index];

                int itemCount = combinedList.length;
                double baseDuration = 1.0 / itemCount;
                double start = index * baseDuration;
                double end = start + baseDuration;

                Animation<Offset> offsetAnimation = Tween<Offset>(
                  begin: const Offset(0, 1),
                  end: Offset.zero,
                ).animate(
                  CurvedAnimation(
                    parent: _animationController!,
                    curve: Interval(start, end, curve: Curves.easeOut),
                  ),
                );

                _animationController?.forward();

                return AnimatedBuilder(
                  animation: offsetAnimation,
                  builder: (context, child) {
                    return SlideTransition(
                      position: offsetAnimation,
                      child: Padding(
                        padding: EdgeInsets.only(bottom: height * 0.02),
                        child: child,
                      ),
                    );
                  },
                  child: item.data is RecyclingLogModel
                      ? _buildRecyclingLogRow(
                          item.data as RecyclingLogModel, context)
                      : _buildTransactionRow(
                          item.data as TransactionModel, context),
                );
              },
            );
          },
        );
      },
    );
  }

  Widget _buildRecyclingLogRow(RecyclingLogModel log, BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final formattedDate = DateFormatterUtil.formatDateWithTime(log.dateTime);

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          width: width * 0.1,
          height: height * 0.048,
          child: Image.asset(
            "assets/images/recycle-image.png",
            fit: BoxFit.cover,
          ),
        ),
        Gap(width * 0.03),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Points Received",
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
              "+${log.pointsGained.toStringAsFixed(2)}pts",
              style: EcoPointsTextStyles.lightGreenTextStyle(
                size: width * 0.035,
                weight: FontWeight.w600,
              ),
            ),
            Text(
              "${log.oldPoints.toStringAsFixed(2)}pts",
              style: EcoPointsTextStyles.grayTextStyle(
                size: width * 0.032,
                weight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildTransactionRow(
      TransactionModel transaction, BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final formattedDate =
        DateFormatterUtil.formatDateWithTime(transaction.timeCreated);

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          width: width * 0.1,
          height: height * 0.048,
          child: Image.asset(
            "assets/images/deduct-image.png",
            fit: BoxFit.cover,
          ),
        ),
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
    );
  }

  Widget errorText(String text, double width) {
    return Center(
      child: Text(
        text,
        style: EcoPointsTextStyles.grayTextStyle(
          size: width * 0.035,
          weight: FontWeight.w500,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}

class CombinedData {
  final dynamic data;
  final DateTime date;

  CombinedData(this.data, this.date);
}
