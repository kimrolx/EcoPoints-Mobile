import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../components/constants/colors/ecopoints_colors.dart';

class CloseTransactionReceiptScreen extends StatelessWidget {
  final Function() onPressed;
  const CloseTransactionReceiptScreen({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return IconButton(
      icon: Icon(
        CupertinoIcons.clear,
        size: width * 0.05,
        color: EcoPointsColors.darkGray,
      ),
      onPressed: onPressed,
    );
  }
}
