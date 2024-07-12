import 'package:ecopoints/src/components/buttons/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

import '../../../../components/constants/colors/ecopoints_colors.dart';
import '../../../../components/constants/text_style/ecopoints_themes.dart';
import '../../../../models/recycling_log_model.dart';
import '../../../../shared/utils/date_formatter_util.dart';

class DetailedRecyclingLogDialog extends StatelessWidget {
  final String userName;
  final RecyclingLogModel log;

  const DetailedRecyclingLogDialog({
    super.key,
    required this.userName,
    required this.log,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final formattedDate = DateFormatterUtil.formatDateWithTime(log.dateTime);

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Container(
        width: width * 0.8,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: EcoPointsColors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Recycle Details",
              style: EcoPointsTextStyles.lightGreenTextStyle(
                size: width * 0.045,
                weight: FontWeight.w600,
              ),
            ),
            const Gap(10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Name",
                  style: EcoPointsTextStyles.grayTextStyle(
                    size: width * 0.037,
                    weight: FontWeight.normal,
                  ),
                ),
                Text(
                  userName,
                  style: EcoPointsTextStyles.blackTextStyle(
                    size: width * 0.037,
                    weight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            const Gap(10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Bottles Recycled",
                  style: EcoPointsTextStyles.grayTextStyle(
                    size: width * 0.037,
                    weight: FontWeight.normal,
                  ),
                ),
                Text(
                  "${log.bottlesRecycled}",
                  style: EcoPointsTextStyles.blackTextStyle(
                    size: width * 0.037,
                    weight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            const Gap(10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Points Received",
                  style: EcoPointsTextStyles.grayTextStyle(
                    size: width * 0.037,
                    weight: FontWeight.normal,
                  ),
                ),
                Text(
                  "${log.pointsGained.toStringAsFixed(2)}pts",
                  style: EcoPointsTextStyles.lightGreenTextStyle(
                    decoration: TextDecoration.underline,
                    decorationColor: EcoPointsColors.lightGreen,
                    size: width * 0.037,
                    weight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            const Gap(10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Date & Time",
                  style: EcoPointsTextStyles.grayTextStyle(
                    size: width * 0.037,
                    weight: FontWeight.normal,
                  ),
                ),
                Text(
                  formattedDate,
                  style: EcoPointsTextStyles.blackTextStyle(
                    size: width * 0.037,
                    weight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            Gap(height * 0.035),
            Align(
              alignment: Alignment.centerRight,
              child: CustomElevatedButton(
                borderRadius: 50,
                width: width,
                backgroundColor: EcoPointsColors.darkGreen,
                onPressed: () {
                  context.pop();
                },
                child: Text(
                  "Close",
                  style: EcoPointsTextStyles.whiteTextStyle(
                    size: width * 0.045,
                    weight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
