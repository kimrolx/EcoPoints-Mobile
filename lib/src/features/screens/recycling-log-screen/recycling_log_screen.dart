import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get_it/get_it.dart';

import '../../../components/constants/colors/ecopoints_colors.dart';
import '../../../components/constants/text_style/ecopoints_themes.dart';
import '../../../components/misc/error_text.dart';
import '../../../models/recycling_log_model.dart';
import '../../../shared/services/recycling_log_service.dart';
import '../../../shared/services/user_profile_service.dart';
import '../../../shared/utils/date_formatter_util.dart';
import 'widgets/recycling_details_dialog.dart';

class RecyclingLogScreen extends StatefulWidget {
  static const String route = "recyclinglog";
  static const String path = "recyclinglog";
  static const String name = "RecyclingLogScreen";
  const RecyclingLogScreen({super.key});

  @override
  State<RecyclingLogScreen> createState() => _RecyclingLogScreenState();
}

class _RecyclingLogScreenState extends State<RecyclingLogScreen> {
  final RecyclingLogService _recyclingLogService =
      GetIt.instance<RecyclingLogService>();

  Future<void> _refreshRecyclingLogs() async {
    await _recyclingLogService.refreshRecyclingLogs();
  }

  void _showRecyclingLogDetails(
      BuildContext context, RecyclingLogModel log, String userName) {
    showDialog(
      context: context,
      builder: (context) => DetailedRecyclingLogDialog(
        log: log,
        userName: userName,
      ),
    );
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
      body: RefreshIndicator(
        onRefresh: _refreshRecyclingLogs,
        child: SingleChildScrollView(
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
                _buildRecyclingLogList(width, height),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRecyclingLogList(double width, double height) {
    return StreamBuilder<List<RecyclingLogModel>>(
      stream: _recyclingLogService.getRecyclingLogs(),
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
              text:
                  "It seems you don't have any recycling activity yet. Start recycling now!",
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

    final userName =
        GetIt.instance<UserProfileService>().userProfile?.displayName ??
            "Error getting user name";

    return GestureDetector(
      onTap: () => _showRecyclingLogDetails(context, log, userName),
      child: Container(
        color: Colors.transparent,
        child: Row(
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
                  "${log.pointsGained.toStringAsFixed(2)}pts",
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
        ),
      ),
    );
  }
}
