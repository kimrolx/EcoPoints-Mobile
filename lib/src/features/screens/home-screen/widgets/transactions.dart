import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get_it/get_it.dart';

import '../../../../components/constants/text_style/ecopoints_themes.dart';
import '../../../../models/recycling_log_model.dart';
import '../../../../shared/services/recycling_log_service.dart';
import '../../../../shared/utils/date_formatter_util.dart';

class TransactionsHomeScreen extends StatefulWidget {
  const TransactionsHomeScreen({super.key});

  @override
  State<TransactionsHomeScreen> createState() => _TransactionsHomeScreenState();
}

class _TransactionsHomeScreenState extends State<TransactionsHomeScreen> {
  final RecyclingLogService _recyclingLogService =
      GetIt.instance<RecyclingLogService>();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: width * 0.04),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Transactions",
            style: EcoPointsTextStyles.blackTextStyle(
              size: width * 0.04,
              weight: FontWeight.w500,
            ),
          ),
          _buildRecyclingLogList(width, height),
        ],
      ),
    );
  }

  Widget _buildRecyclingLogList(double width, double height) {
    return StreamBuilder<List<RecyclingLogModel>>(
      stream: _recyclingLogService.getRecyclingLogs(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text('Error loading recycling logs');
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No recycling logs found'));
        } else {
          final logs = snapshot.data!;
          return Padding(
            padding: EdgeInsets.only(
                left: width * 0.01, right: width * 0.01, top: height * 0.025),
            child: ListView.builder(
              padding: EdgeInsets.zero,
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: logs.length,
              itemBuilder: (context, index) {
                final log = logs[index];
                return Padding(
                  padding: EdgeInsets.only(bottom: height * 0.02),
                  child: _buildRecyclingLogRow(log, context),
                );
              },
            ),
          );
        }
      },
    );
  }

  Widget _buildRecyclingLogRow(RecyclingLogModel log, BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final formattedDate = DateFormatterUtil.formatDateWithTime(log.dateTime);

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Image.asset("assets/images/recycle-image.png"),
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
              '${log.pointsGained.toStringAsFixed(2)}pts',
              style: EcoPointsTextStyles.lightGreenTextStyle(
                size: width * 0.035,
                weight: FontWeight.w600,
              ),
            ),
            Text(
              '${log.oldPoints.toStringAsFixed(2)}pts',
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
}
