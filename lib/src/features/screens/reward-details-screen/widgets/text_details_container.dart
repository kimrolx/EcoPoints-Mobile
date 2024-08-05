import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../../components/buttons/custom_elevated_button.dart';
import '../../../../components/constants/colors/ecopoints_colors.dart';
import '../../../../components/constants/text_style/ecopoints_themes.dart';
import '../../../../models/reward_model.dart';
import '../../../../shared/utils/date_formatter_util.dart';

class TextDetailsContainerRewardDetailsScreen extends StatefulWidget {
  final RewardModel reward;
  final int totalAmount;
  final Function(int) onAmountChanged;
  final Function() onClaimPressed;
  const TextDetailsContainerRewardDetailsScreen(
      {super.key,
      required this.reward,
      required this.totalAmount,
      required this.onAmountChanged,
      required this.onClaimPressed});

  @override
  State<TextDetailsContainerRewardDetailsScreen> createState() =>
      _TextDetailsContainerRewardDetailsScreenState();
}

class _TextDetailsContainerRewardDetailsScreenState
    extends State<TextDetailsContainerRewardDetailsScreen> {
  late int _currentIntValue;

  @override
  void initState() {
    super.initState();
    _currentIntValue = widget.totalAmount;
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    String formattedExpiryDate =
        DateFormatterUtil.formatDateWithTime(widget.reward.expiryDate);

    return Container(
      height: height * 0.5,
      decoration: const BoxDecoration(
        color: EcoPointsColors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40),
        ),
      ),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: height * 0.5,
          ),
          child: IntrinsicHeight(
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: width * 0.08, vertical: height * 0.03),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  buildTextRow(context, width),
                  Gap(height * 0.01),
                  Text(
                    "Expires: $formattedExpiryDate",
                    style: EcoPointsTextStyles.grayTextStyle(
                        size: width * 0.035, weight: FontWeight.normal),
                  ),
                  Gap(height * 0.01),
                  const Divider(color: EcoPointsColors.lightGray),
                  Gap(height * 0.01),
                  buildStockAndAmountRow(context, width),
                  Gap(height * 0.01),
                  const Divider(color: EcoPointsColors.lightGray),
                  Gap(height * 0.01),
                  Text(
                    "Description",
                    style: EcoPointsTextStyles.blackTextStyle(
                        size: width * 0.045, weight: FontWeight.w500),
                  ),
                  Gap(height * 0.01),
                  Text(widget.reward.rewardDescription,
                      style: EcoPointsTextStyles.blackTextStyle(
                          size: width * 0.035, weight: FontWeight.normal)),
                  Gap(height * 0.01),
                  const Spacer(),
                  buildClaimButton(context, width, height),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildTextRow(BuildContext context, double width) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: Text(
            widget.reward.rewardName,
            style: EcoPointsTextStyles.blackTextStyle(
                size: width * 0.048, weight: FontWeight.w500),
          ),
        ),
        const Spacer(),
        Text(
          "${widget.reward.requiredPoint.toStringAsFixed(2)}pts",
          style: EcoPointsTextStyles.lightGreenTextStyle(
              size: width * 0.045, weight: FontWeight.w500),
        ),
      ],
    );
  }

  Widget buildStockAndAmountRow(BuildContext context, double width) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text("Stock: ${widget.reward.rewardStock}",
            style: EcoPointsTextStyles.grayTextStyle(
                size: width * 0.038, weight: FontWeight.normal)),
        Container(
          width: width * 0.32,
          decoration: BoxDecoration(
            color: EcoPointsColors.lightGreenShade,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: Icon(CupertinoIcons.minus, size: width * 0.038),
                onPressed: _currentIntValue > 1 ? () => adjustAmount(-1) : null,
              ),
              Text(
                "$_currentIntValue",
                style: EcoPointsTextStyles.blackTextStyle(
                    size: width * 0.038, weight: FontWeight.w500),
              ),
              IconButton(
                icon: Icon(CupertinoIcons.add, size: width * 0.038),
                onPressed: _currentIntValue < widget.reward.rewardStock
                    ? () => adjustAmount(1)
                    : null,
              ),
            ],
          ),
        ),
      ],
    );
  }

  void adjustAmount(int increment) {
    setState(() {
      _currentIntValue =
          (_currentIntValue + increment).clamp(1, widget.reward.rewardStock);
      widget.onAmountChanged(_currentIntValue);
    });
  }

  Widget buildClaimButton(BuildContext context, double width, double height) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: CustomElevatedButton(
        borderRadius: 50,
        height: height * 0.06,
        width: width,
        backgroundColor: EcoPointsColors.darkGreen,
        onPressed: widget.onClaimPressed,
        child: Text(
          "Claim Reward",
          style: EcoPointsTextStyles.whiteTextStyle(
              size: width * 0.04, weight: FontWeight.w600),
        ),
      ),
    );
  }
}
